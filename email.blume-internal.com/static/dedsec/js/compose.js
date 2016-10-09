$(function () {
	$.dedsec.prevent("#mail_form");
	var notRecent = $.dedsec.glassIfNotRecent("dedsecm3");
	var emailCounter = 0,
		emails = [
			{"from": '"Blume Milpitas Data Center" <milpitas@datacenters.blume.net>', "subject": "URGENT! Milpitas Data Center Breach", "message" : "Du\u0161an,\nWe need you to IMMEDIATELY come to Milpitas. It looks like DedSec introduced a worm into this data center. We're going to need your help to fix it.\n\nSee you soon.\n-Blume Data Center Security, Milpitas"},
			{"from": '"Walter Bhatia" <wbhatia@blume.com>', "subject": "Notice of Termination, Du\u0161an Nemec", "message" : "Dear Du\u0161an,\n\nThis letter is to confirm your employment will terminate from Blume, effective immediately. This is due to continued underperformance. \n\nEvelynn McSalle will be in touch with you about any outstanding information regarding paychecks, accrued vacation, medical and dental, as well as COBRA coverage.\n\nSecurity will meet you on the Blume campus to ensure the return of your cellphone, laptop, badge, and any Blume proprietary devices.\n\nThank you for your time and service at Blume. If you have further questions concerning this letter, please contact our CEO.\n\nSincerely,\nWalter Bhatia\nSenior Vice President, People Operations"},
			{"from": '"Jenny Nguyen" <jenny.nguyen3@sfgov.org>', "subject": "re: ctOS 2.0 Deployment Checkin Meeting", "message" : "Dusan, where are you? We've been waiting on the conference call for fifteen minutes. --Jenny\n\nSent with my thumbs. Please excuse any typos."},
			{"from": '"Corporate Accounting Compliance" <accounting-complaince@blume.com>', "subject": "Du\u0161an Nemec [B01192910] - Expense Report Error - Accounting Compliance (Task #0982-USDOD-GSA-AUDIT)", "message" : "Du\u0161an--\nIn preparation for our upcoming U.S. DoD contract, the GSA required a full audit of our executives spending, to ensure compliance with SOX/FCPA.\n\nUnfortunately, this audit has exposed numerous errors in your expenses. To ensure we get the contract, we must ask you to resubmit your previous three (3) years of expense reports. In total this appears to be seventy-two (72) reports.\n\nPlease ensure these are submitted by Friday EOB.\n\nP Please consider the environment before printing this email.\n\nTHIS IS AN AUTOMATED EMAIL DO NOT RESPOND\nTHIS INBOX IS NOT MONITORED\n\n"}
		];
	function newEmail () {
		email = emails[emailCounter];
		$("#to").val('"Du\u0161an Numec" <dnumec@blume.com>').prop("readonly", "readonly");
		$("#from").val(email.from).prop("readonly", "readonly");
		$("#subject").val(email.subject);
		$("#message").val(email.message);
		emailCounter += 1;
		if(emailCounter == emails.length) emailCounter = 0;
	};
	function shuffle(a) {
	    var j, x, i;
	    for (i = a.length; i; i--) {
	        j = Math.floor(Math.random() * i);
	        x = a[i - 1];
	        a[i - 1] = a[j];
	        a[j] = x;
	    }
	}
	shuffle(emails);
	$.dedsec.popup("Here's our chance to pwn Du\u0160an! Before he worked at Blume, he created a virtual assitant, jEEvs, for himself. He still uses it today, but he had to hack it to work with Blume's software. We can exploit this.");
	$(window).on("popdown.m3.p1", function () {
		setTimeout(function () {
			if(notRecent) {
				$.dedsec.glass();
			}
		}, 0);
		$.dedsec.popup("jEEvs immediately reads all of Du\u0160an's email and sorts it for him. Maybe you can take control of jEEvs and fuck with Du\u0160an at the same time. I'll write an email for you.");
		newEmail();
		$(window).off("popdown.m3.p1");
	});
	$("#mail_form").on("message", function (e) {
		$("#to").prop("readonly", "readonly");
		$("#from").prop("readonly", "readonly");
	});
	$("#mail_form").on("sent",function (e) {
		newEmail();
	});
});
