Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C8B2ADF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgKJTGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:06:12 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F527C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:06:12 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f38so11068798pgm.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7dY7jjSH3EzVEpolI5Znb3T2ESiJfVzrs/9o3c81CzY=;
        b=p6EWMAtM3paOpSMmw8jESAGCXvHyPhayUlLoivbH1QX4/n21FkjSUSZx81CgrRta73
         HfBmZaWY2r0kwSEciOXdvSlW483IbCR/d+R4Ga6nNMULmA+22uHl5vL4894kNkGlE3KA
         aGIm71DnomflW/L7iZWe/a5QwJiWnixyI04a/y97lPkFHkYOryfjnhp+ZVZGqMT/8iYa
         GW73SocBla4dzuB5oK6tNa6aLmHCar4TIf0LL8VD+feZSUu1rWrKxy2NV/lUKQjgHMwH
         pDp9fdvwj2nd3Cth5OFli4H3TnP+7Kr/Hs8INWyvGQmXEWu2R5adIF+APRJLIhuX6QZ7
         yBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7dY7jjSH3EzVEpolI5Znb3T2ESiJfVzrs/9o3c81CzY=;
        b=ud4JscagiFlsKUY1hEtVBsCKl+5socdPllxA/CqlcGUyFcGgZx7NrDCaQREYQm4gzG
         BpTB8sjM0SycX9jJC1zpDnyQReBp/WGCBC5SYuW56e9HTb2mJR6AK7HGUfOPltbouVAL
         3tIOO8G1eHwGwUR2oQ7vvFBIOSAJKZXo/0hy9YrhhygRRY/Wv2VUQQ5jqGc74txbvS8N
         AVovSfxLDLDTM88/mucZrMWMmmPr7IUejhxWWu149lwlso0TEI+6zoeqrH2yIqEv0Kc/
         vId2+hSROLbdpEDtc48Io39WP4sPaTk+zo96A4kqziIohjkWflLt2uTHtuIA4JCV241C
         yrLg==
X-Gm-Message-State: AOAM533I86/19E4lka1hyG2cQ8ooaH5Teyhw5zoMeKg8PlOwV2CYKC1X
        lAl7BI46IfUTXzfnamic/zg=
X-Google-Smtp-Source: ABdhPJz/c5C+ILiWszd+FDifZetc4DCvDqTFaKi1uT9ILpKRnYHVPpTAKS5So1zOivBZ16nLwC0ZRg==
X-Received: by 2002:a05:6a00:78d:b029:18b:f46:5262 with SMTP id g13-20020a056a00078db029018b0f465262mr20009768pfu.74.1605035171775;
        Tue, 10 Nov 2020 11:06:11 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:413:8adf:79d0:1679:313c:70a2])
        by smtp.googlemail.com with ESMTPSA id z3sm13530549pgl.73.2020.11.10.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:06:11 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: add fix option for MISSING_SIGN_OFF
Date:   Wed, 11 Nov 2020 00:36:03 +0530
Message-Id: <20201110190603.2193-1-yashsri421@gmail.com>
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
 scripts/checkpatch.pl | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cb46288127ac..2deffd0c091b 100755
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
+			if($patch_separator_linenr == 0) {
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
+			    $fix) {
+				fix_insert_line($patch_separator_linenr - 1, "Signed-off-by: $author");
+			}
 		} elsif ($authorsignoff != 1) {
 			# authorsignoff values:
 			# 0 -> missing sign off
-- 
2.17.1

