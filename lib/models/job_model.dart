// To parse this JSON data, do
//
//     final job = jobFromMap(jsonString);

import 'dart:convert';

Job jobFromMap(String str) => Job.fromMap(json.decode(str));

String jobToMap(Job data) => json.encode(data.toMap());

class Job {
    Job({
        this.jobs,
    });

    List<JobElement> jobs;

    factory Job.fromMap(Map<String, dynamic> json) => Job(
        jobs: List<JobElement>.from(json["jobs"].map((x) => JobElement.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "jobs": List<dynamic>.from(jobs.map((x) => x.toMap())),
    };
}

class JobElement {
    JobElement({
        this.id,
        this.postByU,
        this.title,
        this.typeJob,
        this.experience,
        this.category,
        this.description,
        this.salary,
        this.name,
        this.email,
        this.address,
        this.location,
        this.phone,
        this.website,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    String postByU;
    String title;
    TypeJob typeJob;
    Experience experience;
    String category;
    String description;
    String salary;
    String name;
    String email;
    Address address;
    String location;
    Phone phone;
    String website;
    String image;
    DateTime createdAt;
    DateTime updatedAt;

    factory JobElement.fromMap(Map<String, dynamic> json) => JobElement(
        id: json["id"],
        postByU: json["post_by_u"],
        title: json["title"],
        typeJob: typeJobValues.map[json["type_job"]],
        experience: experienceValues.map[json["experience"]],
        category: json["category"],
        description: json["description"],
        salary: json["salary"],
        name: json["name"],
        email: json["email"],
        address: addressValues.map[json["address"]],
        location: json["location"],
        phone: phoneValues.map[json["phone"]],
        website: json["website"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "post_by_u": postByU,
        "title": title,
        "type_job": typeJobValues.reverse[typeJob],
        "experience": experienceValues.reverse[experience],
        "category": category,
        "description": description,
        "salary": salary,
        "name": name,
        "email": email,
        "address": addressValues.reverse[address],
        "location": location,
        "phone": phoneValues.reverse[phone],
        "website": website,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

enum Address { NO, EMPTY, CHBAR_ORM_POV, KOM_PONG_SORM }

final addressValues = EnumValues({
    "chbar orm pov": Address.CHBAR_ORM_POV,
    "ទួលពង្រ": Address.EMPTY,
    "Kom pong sorm": Address.KOM_PONG_SORM,
    "No": Address.NO
});

enum Experience { THE_3_YEAR, THE_2_YEAR, THE_4_YEAR, THE_1_YEAR, THE_0_YEAR }

final experienceValues = EnumValues({
    "0 year": Experience.THE_0_YEAR,
    "1 year +": Experience.THE_1_YEAR,
    "2 year +": Experience.THE_2_YEAR,
    "3 year +": Experience.THE_3_YEAR,
    "4 year +": Experience.THE_4_YEAR
});

enum Phone { THE_01254879, THE_098848846, THE_01561161, THE_0489891811, THE_08946574646, THE_08946574, THE_855921351616 }

final phoneValues = EnumValues({
    "01254879": Phone.THE_01254879,
    "01561161": Phone.THE_01561161,
    "0489891811": Phone.THE_0489891811,
    "08946574": Phone.THE_08946574,
    "08946574646": Phone.THE_08946574646,
    "098848846": Phone.THE_098848846,
    "+855 921351616***": Phone.THE_855921351616
});

enum TypeJob { FULL_TIME, PART_TIME, INTERNSHIPS, FREELANCE, VOLUNTEER, CONTRACT }

final typeJobValues = EnumValues({
    "Contract": TypeJob.CONTRACT,
    "Freelance": TypeJob.FREELANCE,
    "Full Time": TypeJob.FULL_TIME,
    "Internships": TypeJob.INTERNSHIPS,
    "Part Time": TypeJob.PART_TIME,
    "Volunteer": TypeJob.VOLUNTEER
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
