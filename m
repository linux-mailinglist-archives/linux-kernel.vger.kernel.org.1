Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C29A290F37
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411695AbgJQFaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411648AbgJQF3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:29:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCF0C05110E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 22:23:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so2663219pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 22:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46Kt70r/bDYHJDe+zcQ3TtYjzSLIU+e5WRMsBr0lX/E=;
        b=n5WACNV9WxTHG+MStnGGcYxyNlN1WbK8pALro7h7tZmxIsAtwbbh71K5u3nVAZtiTT
         a/06ueRYTcsoUp2f4kqoLnnUeJOvLVVORtbikIfRNERyDkjeOceu6D7wV9M0LQ/aPLur
         cPyQSdy/NRYDkim2xQhpVKKwzmDX7C9rwKotJSlCFd1F8CyY5JL+bSyiNHNhIWqyJvPe
         oSKRQiw4gsS0zoVCesJnEXuldCcJMPpW533h/tirkqakcxBm0O6OfqZaYo1qZN8IcQQu
         LNA4H2L17xct1c7s9q2KWR4itTcPThn4TtztPNPxVZiMNzTsznxPrVjDrXPFCW80wAlR
         bxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46Kt70r/bDYHJDe+zcQ3TtYjzSLIU+e5WRMsBr0lX/E=;
        b=VN2uoJka9SnxSe0d+nNOedj+T6l6is7eSUZVvOsXEN01K53B8YC24lXcAUDIf9XnNG
         kuORnUX13NLoT8+SjXStfrPqhTjpLS4s7I6i2066NluMP3xxUYMV1ax9w6aoHi50qip4
         je3yOpA1S0Z4wBN9eGC6YU51paoMNAittkNpTHu9jcjKT4pnras/H+RcKsLMAQ6iVnJo
         e/3J85PQCtQ4t1nAErybVxIdMO9Jrz2MUQmh6GK/lX8fsH90GYkQrdtBKIcbRSdN69ul
         WepEtYyffoCfXou+iT8Kkj9megrxbry3o7+6wC/5uGKlTfYCdR9F+wrLC8i7kIaGG06U
         rYzw==
X-Gm-Message-State: AOAM531IYNGPJUJuqpd2rBtiREA0RDI+t7PI+Yx0ATcaK5XG578Wm3Zq
        uBylIp4qJTbAbcOKWZlmvdQ=
X-Google-Smtp-Source: ABdhPJxieGBqB4KXv5IPVX+eo5Ha7V47PYjzIhvlIsMgdTyoBAe6wepK+bNX6niGtsHq0u07KzglJQ==
X-Received: by 2002:a63:f14:: with SMTP id e20mr6207523pgl.52.1602912191025;
        Fri, 16 Oct 2020 22:23:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:68e2:46b7:2869:5094:8e3e])
        by smtp.gmail.com with ESMTPSA id q2sm4172191pfu.193.2020.10.16.22.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 22:23:10 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v3] checkpatch: add new exception to repeated word check
Date:   Sat, 17 Oct 2020 10:52:43 +0530
Message-Id: <20201017052243.17095-1-dwaipayanray1@gmail.com>
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
 scripts/checkpatch.pl | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f1a4e61917eb..89430dfd6652 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -595,6 +595,7 @@ our @mode_permission_funcs = (
 );
 
 my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
+my $exclude_chars = '[^\.\,\+\s]';
 
 #Create a search pattern for all these functions to speed up a loop below
 our $mode_perms_search = "";
@@ -3056,15 +3057,27 @@ sub process {
 
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
+				$start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > 0);
+				$end_char = substr($rawline, $end_pos, 1) if ($end_pos <= length($rawline));
+
+				if ($start_char =~ /^$exclude_chars$/ ||
+				    $end_char =~ /^$exclude_chars$/) {
+					next;
+				}
+
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
 				    $fix) {
-- 
2.27.0

