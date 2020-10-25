Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC29529809A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 07:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767711AbgJYGwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 02:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1767703AbgJYGwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 02:52:23 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A66EC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 23:52:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f38so4203087pgm.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCPmgUWprMxajeTKkhQ9CgmDvrrA7j8uD3bhsde/MbU=;
        b=IYwDecotTzxO2siq7u3wM71/vTJC+82XhIraXU+X7MEVjhMhWY1zditCoDJL0LVf6C
         iPsnH4ygRIQyLL40JAZ8z5OK954c8XiTIcLVIArD3zeOAnLaCjYZ98keJnqARfHp78Dg
         y2+6gUQh26OxSihYEh0Weim56uZeGxmmgyI6fFTsabkJKhIA+Wd1EHRtuVTHEEXMIS7F
         4IJQlNDUIYhkm+AyCyNCirKTN54EiyaPDFTqUBNTCebFbnSf+b1PnotRXzsdn9Ki6A2q
         M/HRcyDfMacG/qtS+Nn/jRGcSf5Xeu9rOZ0fcgm30GxZrvONlJAcb82o1AV5bp8xcs3J
         FrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCPmgUWprMxajeTKkhQ9CgmDvrrA7j8uD3bhsde/MbU=;
        b=UpueZm6vT935gOOk2LwV/tE4wwn0FS54lGH1OMBekbsVxi77Da4sfxuRgQmS5A0dXJ
         PezjYvjUEzPK0ibWcdIkFpczjK/3GwnUBSi36elcD13hXpX1vx4jedTrwmwPtgUzntCw
         751wxNsaQXWZekuhq0fjouR/Q7xa4ocGo56ugCtI3R24qZXJ8kUO2YE4GzYbEAlWxv9g
         uoJ9dnb5HSc2d5VFeoFy/Tj1eJadATEE2CkZPppXME7l626DTFEKxSu38bmtICeclbR2
         G3kSWQBZ6P51N3XPSM9wtuGFfvV+ZoqM0MsxBepmBec+577qFsnswathCa6bze0My9qA
         d2rA==
X-Gm-Message-State: AOAM530P8aOki3x+8bTTqPE1NK/umozMYwZXUS5M1NTGwZAReTz8wt7B
        ak/rT6IZrG7hoah1doHFZqo=
X-Google-Smtp-Source: ABdhPJyv9shsaS1JzUANl3TORQcoxGd3nAbEcQlwQbgr9dbsVm4Lcse/yfT9icwU5/P0H4cdt42Keg==
X-Received: by 2002:a63:180f:: with SMTP id y15mr8629523pgl.324.1603608722873;
        Sat, 24 Oct 2020 23:52:02 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:60a7:4fb7:1d05:966d:919e])
        by smtp.gmail.com with ESMTPSA id o15sm8326691pfd.16.2020.10.24.23.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 23:52:02 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v4] checkpatch: extend attributes check to handle more patterns
Date:   Sun, 25 Oct 2020 12:21:34 +0530
Message-Id: <20201025065134.21737-1-dwaipayanray1@gmail.com>
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
__noinline__
__nonstring__
__noreturn__
__pure__
__unused__
__used__

Also add fixes for the generic attributes check.

Link: https://lore.kernel.org/linux-kernel-mentees/3ec15b41754b01666d94b76ce51b9832c2dd577a.camel@perches.com/
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 107 ++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 36 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7e505688257a..1b736e9042d2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6155,50 +6155,85 @@ sub process {
 			}
 		}
 
-# Check for __attribute__ packed, prefer __packed
+# Check for compiler attributes
 		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*\bpacked\b/) {
-			WARN("PREFER_PACKED",
-			     "__packed is preferred over __attribute__((packed))\n" . $herecurr);
-		}
+		    $rawline =~ /\b__attribute__\s*\(\s*($balanced_parens)\s*\)/) {
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
+					if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+					         "$new$params is preferred over __attribute__(($attr))\n" . $herecurr) &&
+						$fix) {
+						$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*\Q$attr\E\s*\)\s*\)/$new$params/;
+					}
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
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*format_*\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;
 
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
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*format_*\s*\(\s*scanf\s*,\s*(.*)\)\s*\)\s*\)/"__scanf(" . trim($1) . ")"/ex;
+				}
+			}
 
+			# Check for __attribute__ section, prefer __section
+			if ($attr =~ /^_*section_*\s*\(\s*("[^"]*")/) {
+				my $old = substr($attr, $-[1], $+[1] - $-[1]);
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

