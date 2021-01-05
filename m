Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2C2EA8C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbhAEKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbhAEKbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:31:36 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 02:30:55 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n7so21028605pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 02:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SOojekCLE+4Atuf8MN71Y5EpXTyBJ2znW4hlDZL8IH4=;
        b=bKm0vL6L1Ve9NQJdR7LY/I+t1icUkSlPpuDCJ68FFziNnxO3wL5KGt1oHSpr9/NvhK
         EuCp1xDs9/8i5XvMCY4PXlqwMFdKmM5g4wJMu9WykpzGbla6Th+Duh0GnKP5FGHrGT/A
         L/MX/ft3iIQIuvytT6O5uGRSKnsJ2oHFQ4fyLFyfJTa6P6Qc7B33nKUXXSXDb1SYz6Rg
         2uhILMYWi6XzeEfCMdAaCmpn5FtY9lgWGr09youhHJ/mrbwMlas9oNPqcSzsmTrjUiN/
         EVQckCuc0hSxSSxbZI1KrD9VtNg03GF5PPWMa282c8rxFQfw7Br0we2h2uezCcFJ06w8
         BwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SOojekCLE+4Atuf8MN71Y5EpXTyBJ2znW4hlDZL8IH4=;
        b=mh7nzM2sgGbneszoqUVe1iSmtRKAZ0OV6VkOJG/Jb5Z+mhCmUqSSz8tZJ/HImhg6JQ
         EEBP5G4w8//C20hTFJ5QhhpGJCg2u9Y9Wc9yGp9yIuSUtyNwsk1hDRmH2y6kP4na58cw
         sxulE9RyUEPE5VKPRSnePuvLmwfN/CKe+DkmN2z7tV+AT6ar1qNTt3cwu14KZeLYCxCq
         2cmH/IdgGBaX9O0gnQrwJdsho7h3FPJYmIlYOb1XeTcJpAgcHgcHNi24dHJflCZAWVpe
         dZ5P4BcFVeG2GyK0CMLzewn7zIoVJYBjbPZPko70/YGdUW1GjmDiKvaejfTeVtsZo7Yn
         XYYQ==
X-Gm-Message-State: AOAM530cLyZDCS3dRvPw+vjkXUQSQHnW1w49xlxNh6ohfqxq8LSSK2tJ
        GmyRHMVjV92vE/far2Rb1QC89FouT4lu2+7I
X-Google-Smtp-Source: ABdhPJwRcUvo+0ys1WB5CPikSOVzKFkWviWPT9C4p/hsmhIVroDtu2zJNL8mMsCwgUtnS0YboZRiqw==
X-Received: by 2002:aa7:8811:0:b029:1ab:9e4f:b8ea with SMTP id c17-20020aa788110000b02901ab9e4fb8eamr65734067pfo.78.1609842655141;
        Tue, 05 Jan 2021 02:30:55 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6064:97d:44da:5ae4:7c76])
        by smtp.gmail.com with ESMTPSA id w1sm2284345pjt.23.2021.01.05.02.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 02:30:54 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     dwaipayanray1@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: trivial style fixes
Date:   Tue,  5 Jan 2021 16:00:44 +0530
Message-Id: <20210105103044.40282-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indentations should use tabs wherever possible.
Replace spaces by tabs for indents.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e6857bdfcb2d..7a323ca8a177 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2974,7 +2974,7 @@ sub process {
 				}
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_SIGN_OFF",
-                                             "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline);
+					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline);
 				} elsif ($rawlines[$linenr] !~ /^\s*signed-off-by:\s*(.*)/i) {
 					WARN("BAD_SIGN_OFF",
 					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
@@ -2997,8 +2997,8 @@ sub process {
 			if (ERROR("GERRIT_CHANGE_ID",
 			          "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr) &&
 			    $fix) {
-                                fix_delete_line($fixlinenr, $rawline);
-                        }
+				fix_delete_line($fixlinenr, $rawline);
+			}
 		}
 
 # Check if the commit log is in a possible stack dump
@@ -3240,10 +3240,10 @@ sub process {
 				next if ($start_char =~ /^\S$/);
 				next if (index(" \t.,;?!", $end_char) == -1);
 
-                                # avoid repeating hex occurrences like 'ff ff fe 09 ...'
-                                if ($first =~ /\b[0-9a-f]{2,}\b/i) {
-                                        next if (!exists($allow_repeated_words{lc($first)}));
-                                }
+				# avoid repeating hex occurrences like 'ff ff fe 09 ...'
+				if ($first =~ /\b[0-9a-f]{2,}\b/i) {
+					next if (!exists($allow_repeated_words{lc($first)}));
+				}
 
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
@@ -4432,7 +4432,7 @@ sub process {
 			WARN("STATIC_CONST_CHAR_ARRAY",
 			     "char * array declaration might be better as static const\n" .
 				$herecurr);
-               }
+		}
 
 # check for sizeof(foo)/sizeof(foo[0]) that could be ARRAY_SIZE(foo)
 		if ($line =~ m@\bsizeof\s*\(\s*($Lval)\s*\)@) {
@@ -5285,7 +5285,7 @@ sub process {
 		    $lines[$linenr - 3] !~ /^[ +]\s*$Ident\s*:/) {
 			WARN("RETURN_VOID",
 			     "void function return statements are not generally useful\n" . $hereprev);
-               }
+		}
 
 # if statements using unnecessary parentheses - ie: if ((foo == bar))
 		if ($perl_version_ok &&
-- 
2.27.0

