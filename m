Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943542C11E0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbgKWRYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgKWRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:24:43 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3596EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 09:24:43 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id v12so15500253pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 09:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2yYDqQPMJ4/Ej4t++O02JPknf9YKcT/ImIiC3QyYahY=;
        b=Q8oZ7t9UaATsyMNOrNM4q7QJEr3I2huxlsrI9hNkGVtjJAZXZEejZDvGVSAuRxrpNk
         wmKcUQK4E475/y682gdSEe6Xbw3HtCVWrXx5iK0yq5UKPgZwH/SpJbQRmwVAVjkw8Jzg
         Td+Q8T8mQ/V2wgNhrD5V4etq7VDIKWigNNrviwxceDLpZd2RQTtMiffGk7jC2Akq8Eui
         /tMRCX0wdgHbUBD2vppijn/JHN5pU7hjgSCUdAqp3niWs7AIS3cHtBnOGSgQr5dRM3C4
         40qqtFXN1SDq9a6Z1cdK3L8NAdoOwfmiDCbCk6xzlaaC6Fre3iMnTti+IcN6VRM8OugX
         ViFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2yYDqQPMJ4/Ej4t++O02JPknf9YKcT/ImIiC3QyYahY=;
        b=TtSy/65Wwammkff9Tq5JGABxHiGiDbTCIlL4l4or7VJEA9m8K+4L6PPaFs391L/5qP
         G7SwCGeEUEXrbr9HlW+dqF6CxoMclVMWZSBz/4kt3lTOQNXrnZU3NUiR/Kk9TdeZbMEa
         tIqyuf9jmtWOqlIdMlhOBRmaLVjM9wogyGs3+cutQlrvcBEW2sDcRauyd4F0EjzGzxA6
         laz0ww46imdRFduCoB0dD+RAdbC3My415iSjzlz5NA2xL24YRlW/YdWtthbIA3d6UJyE
         0ceJ2/mzjH23GEe1ltjkMuwt9NjRVnMpEoeKjKPCMXtDIGKOjtEjRKrdMW0suHQailEO
         Vijw==
X-Gm-Message-State: AOAM532p7Z2iXNOFrPZMQ1PzwmzCqz079u++t4c1/rpGaR5HsI/o/0DK
        o8u0O2aLql7RwKlXZTQRWiU=
X-Google-Smtp-Source: ABdhPJyLRaUG72exY64XFZgIq0Ilx+BI0OXlv6FFv+vtoQmPYJsw4Qp8g54W8E0XXyCZmTwITJ6IRQ==
X-Received: by 2002:aa7:953c:0:b029:18b:bfb:9fa1 with SMTP id c28-20020aa7953c0000b029018b0bfb9fa1mr499944pfp.14.1606152282437;
        Mon, 23 Nov 2020 09:24:42 -0800 (PST)
Received: from localhost.localdomain ([2405:204:a68f:d31a:715e:8c1c:620e:4557])
        by smtp.googlemail.com with ESMTPSA id z12sm12722123pfg.123.2020.11.23.09.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 09:24:41 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     lukas.bulwahn@gmail.com
Cc:     yashsri421@gmail.com, joe@perches.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] checkpatch: add fix and improve warning msg for Non-standard signature
Date:   Mon, 23 Nov 2020 22:54:30 +0530
Message-Id: <20201123172430.12854-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAKXUXMx8siSm67jkBP_r+OKyKALfT2EDcX_SfX7JGBy3YisXcQ@mail.gmail.com>
References: <CAKXUXMx8siSm67jkBP_r+OKyKALfT2EDcX_SfX7JGBy3YisXcQ@mail.gmail.com>
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

changes in v4: modify rationale for certain suggestions

 scripts/checkpatch.pl | 101 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fdfd5ec09be6..b018deecec1a 100755
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

