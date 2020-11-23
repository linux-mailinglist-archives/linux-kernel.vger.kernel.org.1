Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3242C0E67
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389335AbgKWPEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgKWPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:04:41 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BB3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:04:41 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x24so2869856pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9GeUDe+xnJKsGx/qdJGPyMAJKtjNn5EQmMLLNrNDZA4=;
        b=T4KmNxMpEXkQdIOcWZcQgxxaRoZwg7XSatqLnTSF27N92I7FzqsJwQn9p2TmP6jEyK
         RB58PDlXb4OLzobZvLpUnkIL0gykdL/zcEWF85Hi2ZXGIvM0dFqMrAnZCZnAUTGHjsfO
         A3gn7+N5yZEERptQ6amEu5mIhL8MkNs+47n+WVAMA605rP3c9n4r3kwXsPu90QRulUe7
         xb45ZkLDbeQ/qsj5U82j/EDBOWzKfcLa1KDOlyFYi5P5ynUYsAq+opImW1+OTmCl8WUc
         EuGEz4Woo+uYwbizHh1YONYcvR70+XnwH/eJoZaVE9fmU0je7ifksmwL0JqYQ+lMlkVf
         4iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9GeUDe+xnJKsGx/qdJGPyMAJKtjNn5EQmMLLNrNDZA4=;
        b=pC+4oDXc8e/XM3hHZG0XicXE40PAaRUo4thb5mV6QFziOpHRaF8eHOvaJk5zDqS72A
         3vc3IrPjsVVM9s53rNQuhiTwJWpk/roy9yknVr7Ez+TXUinFGw6IH+Q+xUEiSU8MgvEL
         0jfl8nTJ6IRVGhtlrSPVOV+e1GUNLR4mjpw7zjnHrQB79FExKvKqhkDMrvVxICfBOZa3
         9hX7SPwsDFNuBJ99fFAd0b1NdcPiCGIEIPfl7K+ejWS3FGrszhjZkH5w9rSCxUP2RaTy
         91tH5jRG/JqlekPJR3ZeNfj054tVW0lygRgCH8Llj/E+RnGlIBWJlDt6o+zRyNdkcXQ+
         stOw==
X-Gm-Message-State: AOAM532ZRhpOxwuc7IvS9OeJQ8lRzERmHJ2mPqiXPoBRT28ZKfYnUYZL
        /PP9UynDqvErAlrv4cSens3Haf5JrcqmIw==
X-Google-Smtp-Source: ABdhPJycrDqMFCPFXAXhycXgCA7KGW9CCF/3QrmjZFMxMCwirJZunb7QAOBHXT6TQLHrRZxHa/RbaA==
X-Received: by 2002:a63:4a02:: with SMTP id x2mr28240942pga.313.1606143880701;
        Mon, 23 Nov 2020 07:04:40 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:434:b4c0:715e:8c1c:620e:4557])
        by smtp.googlemail.com with ESMTPSA id kb12sm14302337pjb.2.2020.11.23.07.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 07:04:39 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] checkpatch: add fix and improve warning msg for Non-standard signature
Date:   Mon, 23 Nov 2020 20:34:30 +0530
Message-Id: <20201123150430.7985-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checkpatch.pl warns for BAD_SIGN_OFF on non-standard signature
styles.

This warning occurs because of incorrect use of signature tags,
e.g. an evaluation on v4.13..v5.8 showed the use of following incorrect
signature tags, which may seem correct, but are not standard:

1) Requested-by (count: 48) => Suggested-by
Rationale: In an open-source project, there are no 'requests', just
'suggestions' to convince a maintainer to accept your patch

2) Co-authored-by (count: 43) => Co-developed-by
Rationale: Co-developed-by and Co-authored-by are synonyms

3) Analyzed-by (count: 22) / Analysed-by (count: 5) => Co-developed-by
Rationale: Analyzing is a part of Software Development, so
'Co-developed-by' is perfectly fine, even if contributor did not create
code

4) Improvements-by (count: 19) => Co-developed-by

5) Noticed-by (count: 11) => Reported-by

6) Inspired-by (count: 11) => Suggested-by

7) Verified-by (count: 8) => Tested-by
Rationale: Used by a single user. On reading mailing list, it seems
Tested-by might be a suitable alternative

8) Okay-ished-by (count: 8) => Acked-by
Rationale: Used by a single user. On reading mailing list, it seems
Acked-by must be suitable alternative

9) Acked-for-MFD-by (count: 6) => Acked-by

10) Reviewed-off-by (count: 5) => Reviewed-by

11) Proposed-by (count: 5) => Suggested-by
Rationale: On observing the mailing list, this tag is always used for a
maintainer. It seems that the changes might have been suggested by them
and the tag is used as acknowledgment for the same

12) Fixed-by (count: 3) => Co-developed-by
Rationale: Fixing bug is a part of Software Development, so
'Co-developed-by' is perfectly fine, even if contributor did not create
code

13) Pointed-out-by (count: 3) / Pointed-at-by (count: 2) => Suggested-by
Rationale: The tags are used for maintainers. It seems that the changes
might have been suggested by them and the tag is used as acknowledgment
for the same
E.g., Pointed-at-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

14) Suggestions-by (count: 3) => Suggested-by

15) Generated-by (count: 17) => remove the tag
On observing the mailing list, this tag is always used for quoting the
tool or script, which might have been used to generate the patch.
E.g. Generated-by: scripts/coccinelle/api/alloc/kzalloc-simple.cocci

16) Celebrated-by (count: 3) => remove the tag
This tag was used for only one commit. On observing mailing list, it seem
like the celebration for a particular patch and changes.

Provide a fix by:
1) replacing the non-standard signature with its standard equivalent
2) removing the signature if it is not required

Also, improve warning messages correspondingly, providing users
suggestions to either replace or remove the signature. Also provide
suitable rationale to the user for the suggestion made.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
changes in v2: replace commit specific example with brief evaluation

changes in v3: provide rationale to users for every signature tag suggestion;
modify commit message describing arrival to conclusion in a structured way

 scripts/checkpatch.pl | 101 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fdfd5ec09be6..f402c9c3958f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -506,6 +506,81 @@ our $signature_tags = qr{(?xi:
 	Cc:
 )};
 
+our %standard_signature_fix = (
+	"Requested-by:" => {
+		suggestion => "Suggested-by:",
+		rationale => "In an open-source project, there are no 'requests', just 'suggestions' to convince a maintainer to accept your patch",
+	},
+	"Co-authored-by:" => {
+		suggestion => "Co-developed-by:",
+		rationale => "Co-developed-by and Co-authored-by are synonyms",
+	},
+	"Analyzed-by:" => {
+		suggestion => "Co-developed-by:",
+		rationale => "Analyzing is a part of Software Development, so 'Co-developed-by' is perfectly fine, even if contributor did not create code",
+	},
+	"Analysed-by:" => {
+		suggestion => "Co-developed-by:",
+		rationale => "Analysing is a part of Software Development, so 'Co-developed-by' is perfectly fine, even if contributor did not create code",
+	},
+	"Improvements-by:" => {
+		suggestion => "Co-developed-by:",
+		rationale => "Performing improvements are a part of Software Development, so 'Co-developed-by' is perfectly fine, even if contributor did not create code",
+	},
+	"Noticed-by:" => {
+		suggestion => "Reported-by:",
+		rationale => "Reported-by and Noticed-by are synonyms",
+	},
+	"Inspired-by:" => {
+		suggestion => "Suggested-by:",
+		rationale => "Suggested-by is the standard signature tag for acknowledging user for their suggestions",
+	},
+	"Verified-by:" => {
+		suggestion => "Tested-by:",
+		rationale => "Tested-by and Verified-by are synonyms",
+	},
+	"Okay-ished-by:" => {
+		suggestion => "Acked-by:",
+		rationale => "Acked-by is the standard signature tag for recording your approval",
+	},
+	"Acked-for-MFD-by:" => {
+		suggestion => "Acked-by:",
+		rationale => "Acked-by is the standard signature tag for recording your approval",
+	},
+	"Reviewed-off-by:" => {
+		suggestion => "Reviewed-by:",
+		rationale => "Reviewed-by is the standard signature tag for recording your approval",
+	},
+	"Proposed-by:" => {
+		suggestion => "Suggested-by:",
+		rationale => "Proposing changes is same as suggesting changes, so Suggested-by seems perfectly fine",
+	},
+	"Fixed-by:" => {
+		suggestion => "Co-developed-by:",
+		rationale => "Fixing bug is a part of Software Development, so 'Co-developed-by' is perfectly fine, even if contributor did not create code",
+	},
+	"Pointed-out-by:" => {
+		suggestion => "Suggested-by:",
+		rationale => "Pointing out certain changes is synonymous to suggesting changes, so Suggested-by seems perfectly fine",
+	},
+	"Pointed-at-by:" => {
+		suggestion => "Suggested-by:",
+		rationale => "Pointing at certain changes is synonymous to suggesting changes, so Suggested-by seems perfectly fine",
+	},
+	"Suggestions-by:" => {
+		suggestion => "Suggested-by:",
+		rationale => "Suggested-by is the standard signature tag for acknowledging user for their suggestions",
+	},
+	"Generated-by:" => {
+		suggestion => "remove",
+		rationale => "Signature tags are used to acknowledge users for their contributions. It is advised to describe about tools in commit description instead",
+	},
+	"Celebrated-by:" => {
+		suggestion => "remove",
+		rationale => "Signature tags are used to acknowledge users for their contributions. This tag may not be required at all",
+	},
+);
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -2773,8 +2848,30 @@ sub process {
 			my $ucfirst_sign_off = ucfirst(lc($sign_off));
 
 			if ($sign_off !~ /$signature_tags/) {
-				WARN("BAD_SIGN_OFF",
-				     "Non-standard signature: $sign_off\n" . $herecurr);
+				my $suggested_signature = "";
+				my $rationale = "";
+				if (exists($standard_signature_fix{$sign_off})) {
+					$suggested_signature = $standard_signature_fix{$sign_off}{'suggestion'};
+					$rationale = $standard_signature_fix{$sign_off}{'rationale'};
+				}
+				if ($suggested_signature eq "") {
+					WARN("BAD_SIGN_OFF",
+					     "Non-standard signature: $sign_off\n" . $herecurr);
+				}
+				elsif ($suggested_signature eq "remove") {
+					if (WARN("BAD_SIGN_OFF",
+						"Non-standard signature: $sign_off. Please consider removing this signature tag. $rationale\n" . $herecurr) &&
+					$fix) {
+						fix_delete_line($fixlinenr, $rawline);
+					}
+				}
+				else {
+					if (WARN("BAD_SIGN_OFF",
+						"Non-standard signature: $sign_off. Please use '$suggested_signature' instead. $rationale\n" . $herecurr) &&
+					$fix) {
+						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
+					}
+				}
 			}
 			if (defined $space_before && $space_before ne "") {
 				if (WARN("BAD_SIGN_OFF",
-- 
2.17.1

