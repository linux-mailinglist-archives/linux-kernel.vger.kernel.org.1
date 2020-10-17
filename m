Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B5D29109A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437518AbgJQHv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408914AbgJQHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:51:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1CAC061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 00:51:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o3so2795549pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieRlNgPHBAGbi6ikKKJ3AXzMP9jjGJKj6Jv32R1alc0=;
        b=OXsrb1bmQxi4DbWtQdmiqD7RPR5zIb6GBKE765xITMw3lNXoCDAZC/4YyXtI2Pz121
         hDvE87Yiyv5xwFsDmfl1iPnu5yo8PaiwnPG6e9+x+z6OfrRziL/UWEj707U3sEtrlA+F
         YcooKsaQ1qKJejPnSa2HkmDYeZizrQNxRSbQargzJxwS0PVIpadlVsi35PJ2xhPPr3HX
         3kBssc7Bdk4hG8kSYdLx6/ON/cpgE/5pS3m0/266rH1XpF63KLLswqsL5lbysIlBOKLZ
         l5FXGIqmbQmdGt9qRhwLwvuAuifC8yXYFoKi/YmKMGKwA+KUYccHqvDQ/K64YytEy4oQ
         UEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieRlNgPHBAGbi6ikKKJ3AXzMP9jjGJKj6Jv32R1alc0=;
        b=txcyP2XUiHyqQygCrHi5U7VsZQcD6XGP9QeSSDyCTGeUBw3gJ8ZwFa2sz5Y38RZO+X
         v+HBddR4bHJEvPe3RXcGItrmTO17dCKK9RgkwKb32Zb7yT0u017mYLIEcQssCc2TU2cl
         350+/Lz8O9t/DANktJoqdhx9qPSdCUfc9J5ZWywlFK12GB8rra46NSZcU1SNa0rCNBtC
         /PIHIEPpiqI9gPozL+oqR1DEuEbbulocu8imzOB8S3QBhhiVN9l3V7okNvs4DwBXBykS
         DolQ5Y7YX0YqNm8SHOzItn+N7e/wVDJdBGc88cf54fjPEpVHC6mfn8NK6vnmUN3O1uQB
         XYRQ==
X-Gm-Message-State: AOAM530aFESfxDWh+zuRN+w/ZogXp6pbDzYrOX0slgP/W97tVUzYGRRr
        qeHPyWg+hoxfAftqjaWAbzlR5lj03RIY0XYR
X-Google-Smtp-Source: ABdhPJzofSdFAL+b24AjD7ILZ385ACUFzCnYfzbnhkskuCrjG81yb+qPa0HDOo2DX1Wvfo3UuoM2Cg==
X-Received: by 2002:a63:b348:: with SMTP id x8mr6531478pgt.207.1602921116555;
        Sat, 17 Oct 2020 00:51:56 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:68e2:46b7:2869:5094:8e3e])
        by smtp.gmail.com with ESMTPSA id s186sm5131335pfs.51.2020.10.17.00.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 00:51:55 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v4] checkpatch: add new exception to repeated word check
Date:   Sat, 17 Oct 2020 13:21:31 +0530
Message-Id: <20201017075131.47566-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
moved the repeated word test to check for more file types. But after
this, if checkpatch.pl is run on MAINTAINERS, it generates several
new warnings of the type:

WARNING: Possible repeated word: 'git'

For example:
WARNING: Possible repeated word: 'git'
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git

So, the pattern "git git://..." is a false positive in this case.

There are several other combinations which may produce a wrong
warning message, such as "@size size", ":Begin begin", etc.

Extend repeated word check to compare the characters before and
after the word matches. If the preceding or succeeding character
belongs to the exception list, the warning is avoided.

Link: https://lore.kernel.org/linux-kernel-mentees/81b6a0bb2c7b9256361573f7a13201ebcd4876f1.camel@perches.com/
Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f1a4e61917eb..5dc5bf75c6e7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3052,19 +3052,30 @@ sub process {
 
 # check for repeated words separated by a single space
 		if ($rawline =~ /^\+/ || $in_commit_log) {
+			pos($rawline) = 1 if (!$in_commit_log);
 			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
 
 				my $first = $1;
 				my $second = $2;
-
+				my $start_pos = $-[1];
+				my $end_pos = $+[2];
 				if ($first =~ /(?:struct|union|enum)/) {
 					pos($rawline) += length($first) + length($second) + 1;
 					next;
 				}
 
-				next if ($first ne $second);
+				next if (lc($first) ne lc($second));
 				next if ($first eq 'long');
 
+				# check for character before and after the word matches
+				my $start_char = '';
+				my $end_char = '';
+				$start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > ($in_commit_log? 0 : 1));
+				$end_char = substr($rawline, $end_pos, 1) if ($end_pos < length($rawline));
+
+				next if ($start_char =~ /^\S$/);
+				next if ($end_char !~ /^[\.\,\;\?\!\s]?$/);
+
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
 				    $fix) {
-- 
2.27.0

