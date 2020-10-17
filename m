Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AD829132D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 18:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438107AbgJQQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437807AbgJQQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 12:27:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11302C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:27:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c20so3327262pfr.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ncjr9V8hWhASX7GIOyrLkyJY1TQp2fFEJrqAO+qOGx4=;
        b=t4z/pDT8KwU7vYU8K5+n3ABCnTdw1fFu21Uk8SkdzEqKRA+ORmoUzfZx4Hzv3QDIhp
         YLkjvzt+rxcRTvhqktscJEaqy6ARVD12SVNLj12qA2WZIDgf7SLlvxkXePhYVNUmZEiR
         6NKY0Sq/FNX/QJgXvwWQR5f4jsmveVsfDBUj6Yw9rFsS46G+h62PdyayIkOwVNKuoudj
         x912tBnYvb8tzD60qyFOPcOn0p+C+wYQrDD1DU497JYf6SV19M6MtLp5YIIwvPAdm1ei
         XuwCIa9iCuTfbN8wxlva28zzPq3FG7STlfCNA5Gme3KIRxNDmxaTG7ARULLU2XKgxBl1
         Tljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ncjr9V8hWhASX7GIOyrLkyJY1TQp2fFEJrqAO+qOGx4=;
        b=czl5J+xSFzM+9Ifm7QeFvAy3/8KjV8Ka2bNHCVHnBTGdiS13WlhU/eQtv7svNz1bUA
         tL6Fgvdg5NT8cLOFWjLvxZdEyhnNwjpWS85IkJ5VisUTcXTnreae1WrSjsc+ISgddsew
         oUUFQiFtvQBN7MJYl9Kstu4lfZsYtbf4rGfZk8ztosqUrmEQ5NACpP8qU9+L24BFjTsd
         V8Xul5viEI2lEivbQTsI50b/1LUPSsrrNQWCKThcHiSc9Yg/7keRy3ALqTm8c7/LvEs1
         tmDDpJcrMTklPc03+svNyXg/hqNQUWaKDZlFrjrBNuwVE3rdks6rSOlHjhanoMmRgX0J
         5dog==
X-Gm-Message-State: AOAM530Ptjg7oDENywwZWgOKDQwNbX3QBg7k1n0HLigc/iTzWbNorZKh
        +IdgIzBD9su8+jQDJba13ok=
X-Google-Smtp-Source: ABdhPJz0m0fZ3zExVkIbuYDYHHUh2usPfKeQI2OToi64nJGxjOhdCp2nIp6PMtoQGw/5Qg7Q3zGxRA==
X-Received: by 2002:a62:cd46:0:b029:150:ddeb:646b with SMTP id o67-20020a62cd460000b0290150ddeb646bmr8834755pfg.27.1602952077354;
        Sat, 17 Oct 2020 09:27:57 -0700 (PDT)
Received: from localhost.localdomain ([49.37.87.35])
        by smtp.gmail.com with ESMTPSA id b10sm5850496pgm.64.2020.10.17.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 09:27:56 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v5] checkpatch: add new exception to repeated word check
Date:   Sat, 17 Oct 2020 21:57:32 +0530
Message-Id: <20201017162732.152351-1-dwaipayanray1@gmail.com>
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
after the word matches.

If there is a non whitespace character before the first word or a
non whitespace character excluding punctuation characters after
the second word, then the check is skipped and the warning is avoided.

Also add case insensitive word matching to the repeated word check.

Link: https://lore.kernel.org/linux-kernel-mentees/81b6a0bb2c7b9256361573f7a13201ebcd4876f1.camel@perches.com/
Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f1a4e61917eb..ec380626bebc 100755
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
+				$start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > ($in_commit_log ? 0 : 1));
+				$end_char = substr($rawline, $end_pos, 1) if ($end_pos < length($rawline));
+
+				next if ($start_char =~ /^\S$/);
+				next if (index(" \t.,;?!", $end_char) == -1);
+
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
 				    $fix) {
-- 
2.27.0

