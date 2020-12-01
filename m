Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3132CA15B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgLALaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgLALaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:30:20 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75667C0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 03:29:40 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v1so1048977pjr.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 03:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TS+3fVneoUuH+hm5MHZo0zkzlD0j2tcaZ5mc/Sr81ns=;
        b=A/7VKq71IbL8AnJdZqn7IutK7oq9056ibkaBYXI6bf0zc0+3s08Tq+ntVU3qyBA4dy
         QKS7dzmTxIouokmQf0bdol+/fx8o68xri1SGB1kn/RYKsrZlVZTyRRmg9m3MzOj8hZcf
         OkBs+rzAdvDaksbSZQSJ3nmA+Fe3i8R9W616ObtKYC+w7IhTbxE1x9QIizQtlL8OwNqF
         OLXsR8jE1Z3f8byXaSXE5TnOw79UQaUJxBEiYL5Z9BFkuwFjPTX0C9HwpaG5aEpSIUqI
         0G+11fBdJqTjKIM4aH3EM2zf1SWozVyELtPFp+com7y0uwjQXGiolLgMN3vUCyVV64Zz
         6F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TS+3fVneoUuH+hm5MHZo0zkzlD0j2tcaZ5mc/Sr81ns=;
        b=CCY7yteo4TGYQyEvPqkz0l4Lo/mW4sGPANc8ucH104K4tou1VeqTOUNFO4phLzqNLT
         PslKJDrHn7VNTkZK5Lzypn8iroEZrtqnGczFfj8IQuKogegqT1gzePDVWogToIwUgezZ
         uOVugfUshasbytKWwfEt5ck0CWS2WduuYfd+jhDby1S/TTTOkLPQ2qtXSLYkTVlPr6Yu
         7ZVjj4CpoFuEssvsE/PI3PemXK4h26fNU7KEDGplLeJJyeTGGdMXrZc2U4MPR8kRgvgK
         +di+ei8uAdG2FBgEIP2iUEatvJdDdm9sn3tIju0Xp0PaV4TyAamMMLixxMLVx5zT/1H9
         gEjw==
X-Gm-Message-State: AOAM531gTwMEYF5SV1MbOXumb7ELuJXqU8CIlDLcmG61gxVvz/N7Jln7
        6VKhtAwnRQGg07/vLj3GE+/NXIgss+2tZw==
X-Google-Smtp-Source: ABdhPJwu8PgSjiSaHq7fxAmAU+eLS9HntvSOFj080RHoM6l9yNHts496NggNitEakF8B8gJBrqPhxQ==
X-Received: by 2002:a17:90a:2e8c:: with SMTP id r12mr2237397pjd.101.1606822179802;
        Tue, 01 Dec 2020 03:29:39 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:42a:f496:5078:6ca4:d183:62ef])
        by smtp.googlemail.com with ESMTPSA id a16sm2451584pfl.125.2020.12.01.03.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 03:29:39 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v5] checkpatch: add fix and improve warning msg for Non-standard signature
Date:   Tue,  1 Dec 2020 16:59:31 +0530
Message-Id: <20201201112931.11192-1-yashsri421@gmail.com>
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

Provide a fix by replacing the non-standard signature with its standard
equivalent.

Also, improve warning messages correspondingly, providing suitable
rationale to the user for the suggestion made.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
applies on next-20201120 and my last patch at Link: https://lore.kernel.org/linux-kernel-mentees/db1195235752685fc85fb52ecb1b1af3f35b5394.camel@perches.com/T/#u

changes in v2: replace commit specific example with brief evaluation

changes in v3: provide rationale to users for every signature tag suggestion;
modify commit message describing arrival to conclusion in a structured way

changes in v4: modify rationale for certain suggestions

changes in v5: remove the tag deletion suggestions, ie "Generated-by" and "Celebrated-by"; rebase on last accepted changes; modify commit message

 scripts/checkpatch.pl | 73 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4a026926139f..d0c2f189272f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -563,6 +563,72 @@ sub find_standard_signature {
 
 	return "";
 }
+our %standard_signature_fix = (
+	"Requested-by:" => {
+		suggestion => "Suggested-by:",
+		rationale => "In an open-source project, there are no 'requests', just 'suggestions' to convince a maintainer to accept your patch",
+	},
+	"Co-authored-by:" => {
+		suggestion => "Co-developed-by:",
+		rationale => "Co-developed-by is the standard signature tag to attribute multiple authors for a patch",
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
+		rationale => "Reported-by is the standard signature tag for acknowledging user who noticed or reported any bug(s)",
+	},
+	"Inspired-by:" => {
+		suggestion => "Suggested-by:",
+		rationale => "Suggested-by is the standard signature tag for acknowledging user for their suggestions",
+	},
+	"Verified-by:" => {
+		suggestion => "Tested-by:",
+		rationale => "Tested-by is the standard signature tag to attribute user for verifying/testing the patch",
+	},
+	"Okay-ished-by:" => {
+		suggestion => "Acked-by:",
+		rationale => "Acked-by is the standard signature tag for recording one's approval",
+	},
+	"Acked-for-MFD-by:" => {
+		suggestion => "Acked-by:",
+		rationale => "Acked-by is the standard signature tag for recording one's approval",
+	},
+	"Reviewed-off-by:" => {
+		suggestion => "Reviewed-by:",
+		rationale => "Reviewed-by is the standard signature tag to indicate that the patch has been reviewed",
+	},
+	"Proposed-by:" => {
+		suggestion => "Suggested-by:",
+		rationale => "Suggested-by is the standard signature tag for acknowledging user for their suggestions",
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
+);
 
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
@@ -2832,12 +2898,17 @@ sub process {
 
 			if ($sign_off !~ /$signature_tags/) {
 				my $suggested_signature = find_standard_signature($sign_off);
+				my $rationale = "";
+				if (exists($standard_signature_fix{$sign_off})) {
+					$suggested_signature = $standard_signature_fix{$sign_off}{'suggestion'};
+					$rationale = $standard_signature_fix{$sign_off}{'rationale'};
+				}
 				if ($suggested_signature eq "") {
 					WARN("BAD_SIGN_OFF",
 					     "Non-standard signature: $sign_off\n" . $herecurr);
 				} else {
 					if (WARN("BAD_SIGN_OFF",
-						 "Non-standard signature: '$sign_off' - perhaps '$suggested_signature'?\n" . $herecurr) &&
+						 "Non-standard signature: '$sign_off' - perhaps '$suggested_signature'? $rationale\n" . $herecurr) &&
 					    $fix) {
 						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
 					}
-- 
2.17.1

