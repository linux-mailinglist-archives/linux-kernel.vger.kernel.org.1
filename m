Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16070298360
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 20:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418537AbgJYTbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 15:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416759AbgJYTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 15:31:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA1C061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 12:31:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v22so3626659ply.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bw7Y/6Dgm4OYeBVasv5zxdWpIx2iMbuxYOG+poUDizA=;
        b=Dt/6OmggmVain+OMmgWnDGmts50vmpoONv/GXrQSVmwwqflhWG3Pstnv60aSeqxKer
         +AU0JOpQ4rjj3hdUclYPJQw09rbLzulYyHTAH2a6QxFx92onHsIk1XDEPtb/SdLLdVBC
         6HlyNPtY3SFIXnO7uCa2c/XKushWCbcIpFCD5HPsAQNkrUwVAkJWGTHgph0bvJJNxO2T
         rq7qTRFuBdd9qQow36WA67YBgT5Eg+jMgFuNcBDbgjWZ658effWIP2ePWwa5m/ZBU/oX
         ndRy6e1WQ0U9hYNf4A4f/hb8R00HwOjfpwrPM77XWxb72WQr62uqoEe7dU3Ke16R8sIV
         9v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bw7Y/6Dgm4OYeBVasv5zxdWpIx2iMbuxYOG+poUDizA=;
        b=Wyz6XAkeByP3kezRBMO9lhIpq9qy7eFEWlIMhga/YqtpjmBV998DoyuWEzK0q2XySA
         tI0cgHma05A5gQOdyYLzMf7BJxlWc/bUF89w+16BaRO1M8UE33Y4tt5sNmxPXu7XXvQW
         JK4XFd3GO430au6TgcLBAaKNbe53jq67zURL9MSg4d6zEonIc5RvL83DWUjjWvBUrQqg
         FxV0yFnt0Y3INP6S0SJ6TkGE0FpNnKWBL30mVgxr9Mu4TVNKjMVcRLCZr8LLUrmv3v+g
         5bDWYgEOreT+KJEa68XMZbJz5wpWJpUquz82Gu5Gf8FWNDxi29EDvuONDt+Znccc8/zr
         lIlQ==
X-Gm-Message-State: AOAM532jsTcI2ye561RsizGi+OIbKaRE4YCibIXG+WA3295gyIkyUCiL
        eRfbNdfYkHhleNZWI/OKZZ0=
X-Google-Smtp-Source: ABdhPJw1e3wt23zR+nz/7Q1vklcBM98Xwp9KKXavRanVu+EjWmn5U3NpqvaicRAN7cc0Orz2UiDA9g==
X-Received: by 2002:a17:90a:ee98:: with SMTP id i24mr7772849pjz.205.1603654297944;
        Sun, 25 Oct 2020 12:31:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:60a7:4fb7:1d05:966d:919e])
        by smtp.gmail.com with ESMTPSA id j5sm9939228pjb.56.2020.10.25.12.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 12:31:37 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v6] checkpatch: extend attributes check to handle more patterns
Date:   Mon, 26 Oct 2020 01:01:03 +0530
Message-Id: <20201025193103.23223-1-dwaipayanray1@gmail.com>
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
packed, aligned, section, printf, scanf, and weak. Other
declarations in compiler_attributes.h are not handled.

Add a generic test to check the presence of such attributes.
Some attributes require more specific handling and are kept
separate.

Also add fixes to the generic attributes check to substitute
the correct conversions.

New attributes which are now handled are:

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

Declarations which contain multiple attributes like
__attribute__((__packed__, __cold__)) are also handled except
when proper conversions for one or more attributes of the list
cannot be determined.

Link: https://lore.kernel.org/linux-kernel-mentees/3ec15b41754b01666d94b76ce51b9832c2dd577a.camel@perches.com/
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 109 +++++++++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 38 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7e505688257a..eeebd8149be9 100755
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
-
-# Check for __attribute__ aligned, prefer __aligned
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*aligned/) {
-			WARN("PREFER_ALIGNED",
-			     "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
-		}
-
-# Check for __attribute__ section, prefer __section
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
-			my $old = substr($rawline, $-[1], $+[1] - $-[1]);
-			my $new = substr($old, 1, -1);
-			if (WARN("PREFER_SECTION",
-				 "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
-			    $fix) {
-				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)\s*\)/__section($new)/;
+		    $rawline =~ /\b__attribute__\s*\(\s*($balanced_parens)\s*\)/) {
+			my $attr = $1;
+			$attr =~ s/\s*\(\s*(.*)\)\s*/$1/;
+
+			my %attr_list = (
+				"aligned"			=> "__aligned",
+				"always_inline"			=> "__always_inline",
+				"assume_aligned"		=> "__assume_aligned",
+				"cold"				=> "__cold",
+				"const"				=> "__attribute_const__",
+				"copy"				=> "__copy",
+				"designated_init"		=> "__designated_init",
+				"externally_visible"		=> "__visible",
+				"format"			=> "printf|scanf",
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
+			my @conv_array = ();
+			my $conv_possible = 1;
+
+			while ($attr =~ /\s*(\w+)\s*(${balanced_parens})?/g) {
+				my $curr_attr = $1;
+				my $params = '';
+				$params = $2 if defined($2);
+				$curr_attr =~ s/^[\s_]+|[\s_]+$//g;
+
+				if (exists($attr_list{$curr_attr})) {
+					if ($curr_attr eq "format" && $params) {
+						$params =~ /^\s*\(\s*(\w+)\s*,\s*(.*)/;
+						push(@conv_array, "__$1\($2");
+					} else {
+						my $new = $attr_list{$curr_attr};
+						push(@conv_array, "$new$params");
+					}
+				} else {
+					$conv_possible = 0;
+					last;
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
+			if (scalar @conv_array > 0 && $conv_possible == 1) {
+				my $replace = join(' ', @conv_array);
+				if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+				         "$replace is preferred over __attribute__(($attr))\n" . $herecurr) &&
+					$fix) {
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*\Q$attr\E\s*\)\s*\)/$replace/;
+					$fixed[$fixlinenr] =~ s/\}\Q$replace\E/} $replace/;
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

