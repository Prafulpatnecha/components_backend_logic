

if(chiefVerificationCheck is String){
    if(chiefVerificationCheck=="error"){

    }
  }else if(chiefVerificationCheck is List){
    if(chiefVerificationCheck.isNotEmpty){
      
    }
  }


  if (snapshot.data is Map) {
    print("Ye Map hai");
  } else if (snapshot.data is List) {
    print("Ye List hai");
  } else if (snapshot.data is String) {
    print("Ye String hai");
  } else {
    print("Unknown Type");
  }