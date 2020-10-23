Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE2C296C48
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461634AbgJWJnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461520AbgJWJnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:43:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1FC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:43:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w11so555206pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UngXBlnnjkw1Wqy0iVM1SCifmatRfaaY7ktN8yajVH8=;
        b=hsKdJZljvb949NMcBwXlzAFMzOnQO0E0d345EHHx2ybHwi6fBEaftmadcUBDnkrAW1
         p5DR2YFUdKsUgl3uaJNyi8CD+tlNzEG2WoTga60H61CQS1rjY0iboX503QP20EST9MW+
         tNGA5mQlaKD2CVTpXHI9O3ngF/C2W1oMrIFeTLJTmXiTKjRn+HRCXwGo2YnjNIwnadSj
         D3YJm/oELielGv0+d8QB3faYNG8wxcUo6L3z5MI6aFUrGLrX55l7RfMO3pyFETnQ4flb
         90kuhrsF2rhZgyP+wiNO37D8nXaNh1N7B9xHbHHe9i9WPdp7ch189a+4hBTMCby78V1h
         Tn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UngXBlnnjkw1Wqy0iVM1SCifmatRfaaY7ktN8yajVH8=;
        b=WGtTJxAWPtjg9QvJOx/iDsh7qe3tYjl2J8MuJaioRBa218citIh/LPSRKE64VVjDba
         pR0WkHaLc08ZOdgUXo7EtxoYjy+3wchUzw95C204vUCLJ0QxkgSYjA5qBnlWjdmzJvxM
         c+lvm9W9DBEknJIsdSVwXU+++iDZS7K7eyWL/PL2y/kVKm8qrs7qDZfShnKzBte86wL8
         7FLhKFNbbE9bWLX6YFIfGSgBa8HxQe4wK/Z2VAXHX9iiC3oL9ValvfJZ7XQy1S8flpoW
         o9zXDxm5AtvTqBvgAMJJ3C/zstgmZV2EYN0OB3zu73qEo7TZuWovDnIFhG38EF4vwY7r
         xw6g==
X-Gm-Message-State: AOAM531V7MKdy7W/MMLFj/g1PHA8FpN646pABZG8LUaGR7tQeC8BoU9w
        PJhHE6JG+kqXrB+b51MXtRbiK66LuvxaU0hS
X-Google-Smtp-Source: ABdhPJxzmYn1mKMJ6BRjBP3kJxc+8BMvcD6T6TZUD/0ODubNTlQ0ryH8aPRUEa/BZsrAvdRpJD5IoQ==
X-Received: by 2002:a17:902:7c0d:b029:d3:de09:a3 with SMTP id x13-20020a1709027c0db02900d3de0900a3mr1639764pll.52.1603446212846;
        Fri, 23 Oct 2020 02:43:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6890:ae4b:a0f8:1bbb:ec51])
        by smtp.gmail.com with ESMTPSA id bx24sm1756775pjb.20.2020.10.23.02.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:43:32 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH RFC v2] checkpatch: extend attributes check to handle more patterns
Date:   Fri, 23 Oct 2020 15:13:07 +0530
Message-Id: <20201023094307.20820-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is generally preferred that the macros from
include/linux/compiler_attributes.h are used, unless there
is a reason not to.

Checkpatch currently checks __attribute__ for each of
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
 scripts/checkpatch.pl | 130 ++++++++++++++++++++++++++++++------------
 1 file changed, 94 insertions(+), 36 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7e505688257a..69324c2e55d6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6155,50 +6155,108 @@ sub process {
 			}
 		}
 
-# Check for __attribute__ packed, prefer __packed
+# Check for compiler attributes
 		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*\bpacked\b/) {
-			WARN("PREFER_PACKED",
-			     "__packed is preferred over __attribute__((packed))\n" . $herecurr);
-		}
+		    $line =~ /\b__attribute__\s*\(\s*\((.*)\)\s*\)/) {
+			my $attr = trim($1);
+
+			my $attr_list = qr {
+				__alias__|
+				__aligned__$|
+				__aligned__\(.*\)|
+				__always_inline__|
+				__assume_aligned__\(.*\)|
+				__cold__|
+				__const__|
+				__copy__\(.*\)|
+				__designated_init__|
+				__externally_visible__|
+				__fallthrough__|
+				__gnu_inline__|
+				__malloc__|
+				__mode__\(.*\)|
+				__no_caller_saved_registers__|
+				__noclone__|
+				__noinline__|
+				__nonstring__|
+				__noreturn__|
+				__packed__|
+				__pure__|
+				__used__
+			}x;
 
-# Check for __attribute__ aligned, prefer __aligned
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*aligned/) {
-			WARN("PREFER_ALIGNED",
-			     "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
-		}
+			my %attr_replace = (
+				"__alias__"			=> "__alias",
+				"__aligned__"		=> "__aligned_largest",
+				"__aligned__("		=> "__aligned",
+				"__always_inline__" 	=> "__always_inline",
+				"__assume_aligned__("	=> "__assume_aligned",
+				"__cold__"			=> "__cold",
+				"__const__"			=> "__const",
+				"__copy__("			=> "__copy",
+				"__designated_init__"		=> "__designated_init",
+				"__externally_visible__"	=> "__visible",
+				"__fallthrough__"		=> "fallthrough",
+				"__gnu_inline__"		=> "__gnu_inline",
+				"__malloc__"		=> "__malloc",
+				"__mode__("			=> "__mode",
+				"__no_caller_saved_registers__" => "__no_caller_saved_registers",
+				"__noclone__"		=> "__noclone",
+				"__noinline__"		=> "noinline",
+				"__nonstring__"		=> "__nonstring",
+				"__noreturn__"		=> "__noreturn",
+				"__packed__"		=> "__packed",
+				"__pure__"			=> "__pure",
+				"__used__"			=> "__used"
+			);
+
+			if ($attr =~/^($attr_list)/) {
+				my $old = $1;
+				if ($old =~ /^(__.+__\()(.*)\)/) {
+					my $new = $attr_replace{$1};
+					WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+					     "$new($2) is preffered over __attribute__(($old))\n" . $herecurr);
+				} else {
+					my $new = $attr_replace{$old};
+					WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+					     "$new is preffered over __attribute__(($old))\n" . $herecurr);
+				}
+			}
 
-# Check for __attribute__ section, prefer __section
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
-			my $old = substr($rawline, $-[1], $+[1] - $-[1]);
-			my $new = substr($old, 1, -1);
-			if (WARN("PREFER_SECTION",
-				 "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
-			    $fix) {
-				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)\s*\)/__section($new)/;
+			# Check for __attribute__ format(printf, prefer __printf
+			if ($attr =~ /^_*format_*\s*\(\s*printf/) {
+				if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+				         "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr) &&
+					$fix) {
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;
+
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
+			if ($attr =~ /^_*unused_*/) {
+				WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+				     "__always_unused or __maybe_unused is preferred over __attribute__((__unused__))\n" . $herecurr);
 			}
 		}
 
-- 
2.27.0

