Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129EC2AEC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKKJB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKKJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:01:54 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF5BC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:01:52 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id m13so1037032pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZvE414n0h/SmbnlBo0DI3+dcCiuwLX2TAnqhW16Qji4=;
        b=Dp8Mbx7dscApf3G52JFH1lkb+gNXx9FmiGHYXQ07t87qoFgVfSmJG2Z9Ky3KOuAugk
         lAp5oUhDFBIMStnb8+ZG5J1r4yTzpd050BRieOTOmnnbC3x4i+IsvlVCfCy5N9fm1EgS
         PY05bb2qAHCeQ0PG313qloVs7Ryfu8qlcIztbroU7EsBIZCGzRrqk9rbgkPgfMvOFhBm
         R++bvH1NMhSznuslyTvEmRhwWZ/ArdNnIb6ZDkTf/HvHg4mt+BvSeFsF/N9XgcpixrJ/
         LHF1PgqcuJjCQ98Ze8ZFaTSlPpXZvl+0/Hz6ZZYuuMkGXQQnrdOBzFRul2fzpAqGWQi/
         fYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZvE414n0h/SmbnlBo0DI3+dcCiuwLX2TAnqhW16Qji4=;
        b=Z0ceNTz1mTRcMcjqenuc8iy3dZwfiYKBkHKSOUU5EbqpzEetl1f5QqUZtr1EX1umrB
         GARn1EkFMI/f0qZNlPQIPV9L/uIsZ6StNie5EnhYE2SF3cBOZMJrdlSH+dp8htRd+Pff
         XHKZAX+lyc3K6ELZ1u7hswJC9SOCtia9QYiw3IkKyzFgfk58jFzCYh8QEVYZZNi8rIv3
         juorT9yQJXUMtaZSQCbJGgVOEIzCB7uR+Mv0liYZ7bHlHe9hXSueRBrv8HWsHa+t4aZh
         6UTXpqZIBW7QQ8gCzh/YYWRXLz+ofBdlymXinybwXP4A5iEcc0KuPssRnluiv3ywB9Cm
         kYMw==
X-Gm-Message-State: AOAM532ADAN72VQ8467sS4ZgfdbT5SSQn81XScq1ESomsWwxxrTyGwsl
        E3maW9Zu+q4UvxSMLmTt2vfftHBmwIGRd7A6
X-Google-Smtp-Source: ABdhPJwar0e1mqK2loFZz/NZNHzxXWeeS/A27pWx17sJ2XOD7kDS+IQgi5cN6S4NrdKGMMB/t/F40g==
X-Received: by 2002:aa7:9903:0:b029:18b:9271:a468 with SMTP id z3-20020aa799030000b029018b9271a468mr22324477pff.11.1605085311951;
        Wed, 11 Nov 2020 01:01:51 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:41c:a166:90d7:ac69:6d50:789e])
        by smtp.googlemail.com with ESMTPSA id ji2sm1682914pjb.35.2020.11.11.01.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:01:51 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: add fix option for MISSING_SIGN_OFF
Date:   Wed, 11 Nov 2020 14:31:43 +0530
Message-Id: <20201111090143.9230-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch warns us if there is no 'Signed-off-by' line
for the patch.

E.g., running checkpatch on commit 9ac060a708e0 ("leaking_addresses:
Completely remove --version flag") reports this error:

ERROR: Missing Signed-off-by: line(s)

Provide a fix by adding a Signed-off-by line corresponding to the author
of the patch before the patch separator line. Also avoid this error for
the commits where some typo is present in the sign off.

E.g. for commit 8cde5d5f7361 ("bus: ti-sysc: Detect omap4 type timers
for quirk") we get missing sign off as well as bad sign off for:

Siganed-off-by: Tony Lindgren <tony@atomide.com>

Here it is probably best to give BAD_SIGN_OFF warning for Non-standard
signature and avoid MISSING_SIGN_OFF

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
Add space after 'if'
Add check for $patch_separator_linenr to be greater than 0

 scripts/checkpatch.pl | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cb46288127ac..ac7e5ac80b58 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2404,6 +2404,8 @@ sub process {
 
 	my $last_blank_line = 0;
 	my $last_coalesced_string_linenr = -1;
+	my $patch_separator_linenr = 0;
+	my $non_standard_signature = 0;
 
 	our @report = ();
 	our $cnt_lines = 0;
@@ -2755,6 +2757,10 @@ sub process {
 		if ($line =~ /^---$/) {
 			$has_patch_separator = 1;
 			$in_commit_log = 0;
+			# to add missing sign off line before diff(s)
+			if ($patch_separator_linenr == 0) {
+				$patch_separator_linenr = $linenr;
+			}
 		}
 
 # Check if MAINTAINERS is being updated.  If so, there's probably no need to
@@ -2775,6 +2781,9 @@ sub process {
 			if ($sign_off !~ /$signature_tags/) {
 				WARN("BAD_SIGN_OFF",
 				     "Non-standard signature: $sign_off\n" . $herecurr);
+
+				# to avoid missing_sign_off error as it most probably is just a typo
+				$non_standard_signature = 1;
 			}
 			if (defined $space_before && $space_before ne "") {
 				if (WARN("BAD_SIGN_OFF",
@@ -7118,9 +7127,12 @@ sub process {
 		      "Does not appear to be a unified-diff format patch\n");
 	}
 	if ($is_patch && $has_commit_log && $chk_signoff) {
-		if ($signoff == 0) {
-			ERROR("MISSING_SIGN_OFF",
-			      "Missing Signed-off-by: line(s)\n");
+		if ($signoff == 0 && !$non_standard_signature) {
+			if (ERROR("MISSING_SIGN_OFF",
+				  "Missing Signed-off-by: line(s)\n") &&
+			    $fix && $patch_separator_linenr > 0) {
+				fix_insert_line($patch_separator_linenr - 1, "Signed-off-by: $author");
+			}
 		} elsif ($authorsignoff != 1) {
 			# authorsignoff values:
 			# 0 -> missing sign off
-- 
2.17.1

