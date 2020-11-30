Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032C82C80AC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgK3JLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3JLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:11:32 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8202EC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:10:52 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b6so9992215pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vp1UjA5b9iBMvCva/GTPQT8GBuBUjUwESyb+0XNUQHk=;
        b=vUsFZJkjljQRsf9VNi2Ik/OOCnpFaA9u+T+dZ3uLQxbig+bKcH8QHlpPjMdRkRsfxd
         uY+XECfpydm0V5nzLb3LPKqPejeCdi3SqQ1eMxhyTbDVp12O8my2yaI6S1xk/F62gG+z
         cLnKUmG/GIa6sE6PiraFvPdBIOn94olLZESrADS5XL20qKNMnB8ptlq8xGjAHU9B7XF9
         fq+4TZgC1hY89HS46clIWjLZKAXMBJMc2VyNV0i1pi0KRmou0MHdeaYJ/qNVrKgeCU4K
         u9xMoWxwjAtOcsBnxXikWChGpGJP7wHXhYsc/9tdDV+VwHYDmQdoLYB3/yk9en/sENx1
         HBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vp1UjA5b9iBMvCva/GTPQT8GBuBUjUwESyb+0XNUQHk=;
        b=fn+HjE7tVMuZB+K7qUaxT2I/OAMxKMZLZNdRoPl0EdUOa5R5KcgT/oTTbhVs7j1uws
         x9pvoi//b03dpAcTvcJ0RCQpBui64wRI7Yn3eVNGT4gpneijz9x0xz8qZ1DT3ZhQNIuh
         qO7FOcnocBsXKl8/C2sHi3e4W4UBebqHVXgGvWaS7sovaIqJT6WnA6M0qCzr3KkWFzB2
         TGAueDJLtlresxtkE7l9JcGUH79TQp4f+rgpc/Mc2L8468e1+h+3VfuALCvNbnUDd7pg
         C2Z/MBCtFc8SYa+w/ZVARfzsFNLWLdxwLkjeVxpqYp2MJPzov6ck2G8xNp6Y2mpQ15k4
         jQtw==
X-Gm-Message-State: AOAM532telXfDcRZ0f2yoJyd7nI+rBJ7MIdrzJsvckg+1US42fMcu5ra
        6V7p1brbNGVJBa/tj7Nbeb4=
X-Google-Smtp-Source: ABdhPJzQl1jY6Z9l133uc1HNol3T7kcSrpSQR4y0UOJo2FSrlKImdeFFgyjdXofTzMKR/N+dirFEsw==
X-Received: by 2002:aa7:8dc1:0:b029:197:5d15:279d with SMTP id j1-20020aa78dc10000b02901975d15279dmr17245610pfr.71.1606727451760;
        Mon, 30 Nov 2020 01:10:51 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:419:6b90:c59c:7043:caf9:832d])
        by smtp.googlemail.com with ESMTPSA id y188sm15852589pfy.98.2020.11.30.01.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 01:10:51 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] Currently checkpatch warns us if there is no 'Signed-off-by' line for the patch.
Date:   Mon, 30 Nov 2020 14:40:42 +0530
Message-Id: <20201130091042.14987-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <21acc492ab37acc42390abffb61aed370a22118.camel@perches.com>
References: <21acc492ab37acc42390abffb61aed370a22118.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E.g., running checkpatch on commit 9ac060a708e0 ("leaking_addresses:
Completely remove --version flag") reports this error:

ERROR: Missing Signed-off-by: line(s)

Provide a fix by adding a Signed-off-by line corresponding to the author
of the patch before the patch separator line.

Also, avoid this fix with the Non-standard signature warning, as the
missing sign off is most likely because of typo.

E.g. for commit 8cde5d5f7361 ("bus: ti-sysc: Detect omap4 type timers
for quirk") we get missing sign off as well as bad sign off warnings for:

Siganed-off-by: Tony Lindgren <tony@atomide.com>

Here it is probably best to fix the typo with BAD_SIGN_OFF warning and
avoid adding an additional signoff.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
applies over next-20201120 and my last changes at:https://lore.kernel.org/linux-kernel-mentees/db1195235752685fc85fb52ecb1b1af3f35b5394.camel@perches.com/T/#u

Changes in v2:
  Add space after 'if'
  Add check for $patch_separator_linenr to be greater than 0

Changes in v3:
  Give MISSING_SIGN_OFF warning irrespective of the value of $non_standard_signature, add check with fix option instead
  Modify commit message accordingly

 scripts/checkpatch.pl | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4a026926139f..3abf34bb9b00 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2462,6 +2462,8 @@ sub process {
 
 	my $last_blank_line = 0;
 	my $last_coalesced_string_linenr = -1;
+	my $patch_separator_linenr = 0;
+	my $non_standard_signature = 0;
 
 	our @report = ();
 	our $cnt_lines = 0;
@@ -2813,6 +2815,10 @@ sub process {
 		if ($line =~ /^---$/) {
 			$has_patch_separator = 1;
 			$in_commit_log = 0;
+			# to add missing signed-off-by line before diff(s)
+			if ($patch_separator_linenr == 0) {
+				$patch_separator_linenr = $linenr;
+			}
 		}
 
 # Check if MAINTAINERS is being updated.  If so, there's probably no need to
@@ -2842,6 +2848,7 @@ sub process {
 						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
 					}
 				}
+				$non_standard_signature = 1;
 			}
 			if (defined $space_before && $space_before ne "") {
 				if (WARN("BAD_SIGN_OFF",
@@ -7188,8 +7195,11 @@ sub process {
 	}
 	if ($is_patch && $has_commit_log && $chk_signoff) {
 		if ($signoff == 0) {
-			ERROR("MISSING_SIGN_OFF",
-			      "Missing Signed-off-by: line(s)\n");
+			if (ERROR("MISSING_SIGN_OFF",
+				  "Missing Signed-off-by: line(s)\n") &&
+			    $fix && !$non_standard_signature && $patch_separator_linenr > 0) {
+				fix_insert_line($patch_separator_linenr - 1, "Signed-off-by: $author");
+			}
 		} elsif ($authorsignoff != 1) {
 			# authorsignoff values:
 			# 0 -> missing sign off
-- 
2.17.1

