Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC5E297B92
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 11:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760363AbgJXJG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 05:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbgJXJG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 05:06:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC70C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 02:06:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h4so488023pjk.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gk2cFmlbMq/sinRoeLY+9r9e8FSdPc5N55kkSeL51tM=;
        b=NH6nXlGtCyHPOwHoToc2vFq67Mjkpgo195a5xL3nYoVJMP1QES7z0vlWXGR/NflJ7Y
         tMW+y3ckjtiM64PEUNkrJVEmDyI2XXaa3EVxBUP8RRHuzubugHgAGfNG3Rmowxm8iCeX
         eCpPxuYWYP2/ffoxgW4FgRZ5KlAyFyXacEvwuFhdsM/NDr/fM/TVmHGA59JiRspmGYba
         O37dmWwSNgW1JC5zvSTBEr3SvJpENMl/hOE7Ly4EnOHLvC1ztote49tAjGOvLHEKo8TX
         OXJ7nYv1V28EdClr/TIikUDZVaPIxRU4co4zbxAVuJXOh6VnNVxgJUtJX2GM4WcLqjux
         nPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gk2cFmlbMq/sinRoeLY+9r9e8FSdPc5N55kkSeL51tM=;
        b=IFwhe+6eLiNNgb0LQqN+X6l/QxU1QPgPLk4XJ3gXsC8xSLTV9vqlhYwTXwk/FiEAXW
         YtSGC5JFNMTBswoOflnw9BpPtdXBfLAPfUz/yxk3PCoA+g82GaEc2xbacnsFWLkhxAIx
         fUkwzanOlyPUCJzMleEcRu1VNiqpUptF1P9AByvG6VRaAtPwpMOJK5Snd5AzCHM3Vdh+
         cMe2VvjRuI7U9ur+gEtyvLPCnKiq1+LEDDnPgLatqNzgMl1EpuKobV2HO46ULJm9/tdA
         MJ3s9XgruA7nYf9KA3/59gTtVhHop1IOniexwT60MMTkRKLUlQGoXD+n9uE9Jg4/ClGC
         BK2Q==
X-Gm-Message-State: AOAM532f+5v3dS9scdN92mhG7i+jS1aNqkM3luTEnG2uy6uRlEoVJhlq
        GlExUsF+66axjGoZp064D7xlJC6PJuFU8BPK
X-Google-Smtp-Source: ABdhPJxCQmNfRB2M4zRNe5tfuUFzx1eRwFhxk/iHaXM6oxIhEvHdSZk5Hd+dly2J5/orcPpQRWYbIQ==
X-Received: by 2002:a17:902:b604:b029:d5:e2cd:5381 with SMTP id b4-20020a170902b604b02900d5e2cd5381mr3631673pls.75.1603530386170;
        Sat, 24 Oct 2020 02:06:26 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:683a:f9a0:a2:3868:eea])
        by smtp.gmail.com with ESMTPSA id a18sm4420082pgw.50.2020.10.24.02.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 02:06:25 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v3] checkpatch: extend attributes check to handle more patterns
Date:   Sat, 24 Oct 2020 14:35:57 +0530
Message-Id: <20201024090557.45092-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is generally preferred that the macros from
include/linux/compiler_attributes.h are used, unless there
is a reason not to.

checkpatch currently checks __attribute__ for each of
packed, aligned, printf, scanf, and weak. Other declarations
in compiler_attributes.h are not handled.

Add a generic test to check the presence of such attributes.
Some attributes require more specific handling and are kept
separate.

New attributes which are now handled are:

__alias__(#symbol)
__always_inline__
__assume_aligned__(a, ## __VA_ARGS__)
__cold__
__const__
__copy__(symbol)
__designated_init__
__externally_visible__
__gnu_inline__
__malloc__
__mode__(x)
__no_caller_saved_registers__
__noclone__
__fallthrough__
__noinline__
__nonstring__
__noreturn__
__pure__
__unused__
__used__

Link: https://lore.kernel.org/linux-kernel-mentees/3ec15b41754b01666d94b76ce51b9832c2dd577a.camel@perches.com/
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 105 +++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 36 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7e505688257a..01d83d345b4c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6155,50 +6155,83 @@ sub process {
 			}
 		}
 
-# Check for __attribute__ packed, prefer __packed
+# Check for compiler attributes
 		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*\bpacked\b/) {
-			WARN("PREFER_PACKED",
-			     "__packed is preferred over __attribute__((packed))\n" . $herecurr);
-		}
+		    $line =~ /__attribute__\s*\(\s*($balanced_parens)\s*\)/) {
+			my $attr = $1;
+			$attr =~ s/\s*\(\s*(.*)\)\s*/$1/;
+
+			my %attr_list = (
+				"alias"				=> "__alias",
+				"aligned"			=> "__aligned",
+				"always_inline"			=> "__always_inline",
+				"assume_aligned"		=> "__assume_aligned",
+				"cold"				=> "__cold",
+				"const"				=> "__const",
+				"copy"				=> "__copy",
+				"designated_init"		=> "__designated_init",
+				"externally_visible"		=> "__visible",
+				"fallthrough"			=> "fallthrough",
+				"gnu_inline"			=> "__gnu_inline",
+				"malloc"			=> "__malloc",
+				"mode"				=> "__mode",
+				"no_caller_saved_registers"	=> "__no_caller_saved_registers",
+				"noclone"			=> "__noclone",
+				"noinline"			=> "noinline",
+				"nonstring"			=> "__nonstring",
+				"noreturn"			=> "__noreturn",
+				"packed"			=> "__packed",
+				"pure"				=> "__pure",
+				"used"				=> "__used"
+			);
+
+			if ($attr =~ /^(\w+)\s*(${balanced_parens})?/) {
+				my $curr_attr = $1;
+				my $params = '';
+				$params = $2 if defined($2);
+				$curr_attr =~ s/^[\s_]+|[\s_]+$//g;
+
+				if (exists($attr_list{$curr_attr})) {
+					my $new = $attr_list{$curr_attr};
+					WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+					     "$new$params is preffered over __attribute__(($attr))\n" . $herecurr);
+				}
+			}
 
-# Check for __attribute__ aligned, prefer __aligned
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*aligned/) {
-			WARN("PREFER_ALIGNED",
-			     "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
-		}
+			# Check for __attribute__ format(printf, prefer __printf
+			if ($attr =~ /^_*format_*\s*\(\s*printf/) {
+				if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+				         "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr) &&
+					$fix) {
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;
 
-# Check for __attribute__ section, prefer __section
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
-			my $old = substr($rawline, $-[1], $+[1] - $-[1]);
-			my $new = substr($old, 1, -1);
-			if (WARN("PREFER_SECTION",
-				 "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
-			    $fix) {
-				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)\s*\)/__section($new)/;
+				}
 			}
-		}
 
-# Check for __attribute__ format(printf, prefer __printf
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf/) {
-			if (WARN("PREFER_PRINTF",
-				 "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr) &&
-			    $fix) {
-				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;
+			# Check for __attribute__ format(scanf, prefer __scanf
+			if ($attr =~ /^_*format_*\s*\(\s*scanf\b/) {
+				if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+				         "__scanf(string-index, first-to-check) is preferred over __attribute__((format(scanf, string-index, first-to-check)))\n" . $herecurr) &&
+					$fix) {
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\s*,\s*(.*)\)\s*\)\s*\)/"__scanf(" . trim($1) . ")"/ex;
+				}
+			}
 
+			# Check for __attribute__ section, prefer __section
+			if ($attr =~ /^_*section_*\s*\(\s*("[^"]*")/) {
+				my $old = substr($rawline, $-[1], $+[1] - $-[1]);
+				my $new = substr($old, 1, -1);
+				if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+				         "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
+					$fix) {
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)\s*\)/__section($new)/;
+				}
 			}
-		}
 
-# Check for __attribute__ format(scanf, prefer __scanf
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\b/) {
-			if (WARN("PREFER_SCANF",
-				 "__scanf(string-index, first-to-check) is preferred over __attribute__((format(scanf, string-index, first-to-check)))\n" . $herecurr) &&
-			    $fix) {
-				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\s*,\s*(.*)\)\s*\)\s*\)/"__scanf(" . trim($1) . ")"/ex;
+			# Check for __attribute__ unused, prefer __always_unused or __maybe_unused
+			if ($attr =~ /^_*unused/) {
+				WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+				     "__always_unused or __maybe_unused is preferred over __attribute__((__unused__))\n" . $herecurr);
 			}
 		}
 
-- 
2.27.0

