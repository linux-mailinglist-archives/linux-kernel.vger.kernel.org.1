Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2245296130
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368272AbgJVOxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368253AbgJVOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:52:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972ACC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:52:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c17so1159625pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bv5yiDNe8/8CyNfAZjm0BoVVo9NTx85vrS2GwtAOsP0=;
        b=bcENCs9kiCqMTKu2G/991hVrtjxhGjLR6BLQp7YoRGN5bUkAqtx/h+Csc2vRsuIukM
         gMsp7e5Sspc6K19DTy8dA7jicZlDVaq+rbX7nAuxgPlFC2IXYgpk8SbImxPoTqDGOCeD
         BOPTgGDp0Kb55q2MqoKPcO13DnL0sdZmcOMkyUCSG0ouFnLZvVC0sQi2v+wCykPIt5IJ
         wRlGg6X75M6gIvTVZqDwSJy1EarnJ32ydrgrDBoR4abRArVkDM1GUZjj0Uwf/TW5XxD8
         l9gSP4y6piivOEWHh69h+CSrCSkQz3nSceCwWd9PYCjMweYmHt07o8Vm/dZlyshmGP+i
         nZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bv5yiDNe8/8CyNfAZjm0BoVVo9NTx85vrS2GwtAOsP0=;
        b=rVsfarihUpC0BZvOTvvUGNt1Nu9D575LRiPK0glUxRH61QIbiFU/rm76DDUcbaknM2
         lEB97JRi7+vCCyDvQBLpvmAUQtNHbjL9PIFJFomXglfomRaP4rZB1R59ljKeK7YGxqUV
         /4SVk332bgEglztv/VOYLZ+TOuDb8OmZ9PxRVSYDPaRnMmkY7v2CWFj8Gb6zp1+SBAbw
         9OW+iYj0PPfdz4KF4JnTbBfK25eMARqLLSTko1NlhWqTE42OuXuVx65olRQ3w9e3MtH0
         V7eDZ8AkjS7sswWNQVeolDH+o8gZ2UWmJn4HrID6Fgk3fal4bWjPOAf/GFckkNtkjS8s
         LHXQ==
X-Gm-Message-State: AOAM533Sk6kullrno308qABBUnDzP/ZDzmvH4glzu/3SQH9aLyfZMiPT
        1Z6ccV6bvzaFWahFy5hsxS4=
X-Google-Smtp-Source: ABdhPJzAf0p4Y2HpuCRbfFFtcnktlznnmN4Aj2NPZMFStCMTm8+DybA3NFf7+Fkqsb5oD2vfUrAEuA==
X-Received: by 2002:a17:90a:1f45:: with SMTP id y5mr2502810pjy.16.1603378372960;
        Thu, 22 Oct 2020 07:52:52 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:68cc:70a3:ea5f:217b:100f])
        by smtp.gmail.com with ESMTPSA id b15sm2211571pju.16.2020.10.22.07.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:52:52 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH RFC] checkpatch: extend attributes check to handle more patterns
Date:   Thu, 22 Oct 2020 20:22:23 +0530
Message-Id: <20201022145224.645538-1-dwaipayanray1@gmail.com>
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

Add more definitions to the attribute check.
The following patterns are added:

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
 scripts/checkpatch.pl | 199 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 163 insertions(+), 36 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7e505688257a..968adcb15793 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6155,50 +6155,177 @@ sub process {
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
 
-# Check for __attribute__ aligned, prefer __aligned
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*aligned/) {
-			WARN("PREFER_ALIGNED",
-			     "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
-		}
+			# Check for __attribute__ alias, prefer __alias
+			if ($attr =~/^_*alias_*/) {
+				WARN("PREFER_ALIAS",
+				     "__alias(symbol) is preferred over __attribute__((alias(#symbol)))\n" . $herecurr);
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
+			# Check for __attribute__ aligned(size), prefer __aligned(size)
+			if ($attr =~/^_*aligned_*\(/) {
+				WARN("PREFER_ALIGNED",
+				     "__aligned(size) is preferred over __attribute__((__aligned__(size)))\n" . $herecurr);
 			}
-		}
 
-# Check for __attribute__ format(printf, prefer __printf
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf/) {
-			if (WARN("PREFER_PRINTF",
-				 "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr) &&
-			    $fix) {
-				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;
+			# Check for __attribute__ aligned, prefer __aligned_largest
+			if ($attr =~/^_*aligned_*$/) {
+				WARN("PREFER_ALIGNED_LARGEST",
+				     "__aligned_largest is preferred over __attribute__((__aligned__))\n" . $herecurr);
+			}
 
+			# Check for __attribute__ always_inline, prefer __always_inline
+			if ($attr =~/^_*always_inline_*/) {
+				WARN("PREFER_ALWAYS_INLINE",
+				     "__always_inline is preferred over __attribute__((__always_inline__))\n" . $herecurr);
 			}
-		}
 
-# Check for __attribute__ format(scanf, prefer __scanf
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\b/) {
-			if (WARN("PREFER_SCANF",
-				 "__scanf(string-index, first-to-check) is preferred over __attribute__((format(scanf, string-index, first-to-check)))\n" . $herecurr) &&
-			    $fix) {
-				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\s*,\s*(.*)\)\s*\)\s*\)/"__scanf(" . trim($1) . ")"/ex;
+			# Check for __attribute__ assume_aligned, prefer __assume_aligned
+			if ($attr =~/^_*assume_aligned_*/) {
+				WARN("PREFER_ASSUME_ALIGNED",
+				     "__asume_aligned(a, ...) is preferred over __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ cold, prefer __cold
+			if ($attr =~ /^_*cold_*/) {
+				WARN("PREFER_COLD",
+				     "__cold is preferred over __attribute__((__cold__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ const, prefer __attribute_const
+			if ($attr =~ /^_*const_*/) {
+				WARN("PREFER_CONST",
+				     "__attribute_const is preferred over __attribute__((__const__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ copy, prefer __copy
+			if ($attr =~ /^_*copy_*/) {
+				WARN("PREFER_COPY",
+				     "__copy(symbol) is preferred over __attribute__((__copy__(symbol)))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ desginated_init, prefer __designated_init
+			if ($attr =~ /^_*designated_init_*/) {
+				WARN("PREFER_DESIGNATED_INIT",
+				     "__designated_init is preferred over __attribute__((__designated_init__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ externally_visible, prefer __visible
+			if ($attr =~ /^_*externally_visible_*/) {
+				WARN("PREFER_VISIBLE",
+				     "__visible is preferred over __attribute__((__externally_visible__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ format(printf, prefer __printf
+			if ($attr =~ /^_*format_*\s*\(\s*printf/) {
+				if (WARN("PREFER_PRINTF",
+				         "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr) &&
+					$fix) {
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;
+
+				}
+			}
+
+			# Check for __attribute__ format(scanf, prefer __scanf
+			if ($attr =~ /^_*format_*\s*\(\s*scanf\b/) {
+				if (WARN("PREFER_SCANF",
+				         "__scanf(string-index, first-to-check) is preferred over __attribute__((format(scanf, string-index, first-to-check)))\n" . $herecurr) &&
+					$fix) {
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\s*,\s*(.*)\)\s*\)\s*\)/"__scanf(" . trim($1) . ")"/ex;
+				}
+			}
+
+			# Check for __attribute__ gnu_inline, prefer __gnu_inline
+			if ($attr =~ /^_*gnu_inline_*/) {
+				WARN("PREFER_GNU_INLINE",
+				     "__gnu_inline is preferred over __attribute__((__gnu_inline__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ malloc, prefer __malloc
+			if ($attr =~ /^_*malloc_*/) {
+				WARN("PREFER_MALLOC",
+				     "__malloc is preferred over __attribute__((__malloc__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ mode, prefer __mode
+			if ($attr =~ /^_*mode_*/) {
+				WARN("PREFER_MODE",
+				     "__mode(x) is preferred over __attribute__((__mode__(x)))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ no_caller_saved_registers, prefer __no_caller_saved_registers
+			if ($attr =~ /^_*no_caller_saved_registers_*/) {
+				WARN("PREFER_NO_CALLER_SAVED_REGISTERS",
+				     "__no_caller_saved_registers is preferred over __attribute__((__no_caller_saved_registers__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ noclone, prefer __noclone
+			if ($attr =~ /^_*noclone_*/) {
+				WARN("PREFER_NOCLONE",
+				     "__noclone is preferred over __attribute__((__noclone__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ fallthrough, prefer fallthrough
+			if ($attr =~ /^_*fallthrough_*/) {
+				WARN("PREFER_FALLTHROUGH",
+				     "fallthrough is preferred over __attribute__((__fallthrough__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ noinline, prefer noinline
+			if ($attr =~ /^_*noinline_*/) {
+				WARN("PREFER_NOINLINE",
+				     "noinline is preferred over __attribute__((__noinline__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ nonstring, prefer __nonstring
+			if ($attr =~ /^_*nonstring_*/) {
+				WARN("PREFER_NONSTRING",
+				     "__nonstring is preferred over __attribute__((__nonstring__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ noreturn, prefer __noreturn
+			if ($attr =~ /^_*noreturn_*/) {
+				WARN("PREFER_NORETURN",
+				     "__noreturn is preferred over __attribute__((__noreturn__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ packed, prefer __packed
+			if ($attr =~ /^_*packed_*/) {
+				WARN("PREFER_PACKED",
+				     "__packed is preferred over __attribute__((__packed__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ pure, prefer __pure
+			if ($attr =~ /^_*pure_*/) {
+				WARN("PREFER_PURE",
+				     "__pure is preferred over __attribute__((__pure__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ section, prefer __section
+			if ($attr =~ /^_*section_*\s*\(\s*("[^"]*")/) {
+				my $old = substr($rawline, $-[1], $+[1] - $-[1]);
+				my $new = substr($old, 1, -1);
+				if (WARN("PREFER_SECTION",
+				         "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
+					$fix) {
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)\s*\)/__section($new)/;
+				}
+			}
+
+			# Check for __attribute__ unused, prefer __always_unused or __maybe_unused
+			if ($attr =~ /^_*unused_*/) {
+				WARN("PREFER_UNUSED",
+				     "__always_unused or __maybe_unused is preferred over __attribute__((__unused__))\n" . $herecurr);
+			}
+
+			# Check for __attribute__ used, prefer __used
+			if ($attr =~ /^_*used_*/) {
+				WARN("PREFER_USED",
+				     "__used is preferred over __attribute__((__used__))\n" . $herecurr);
 			}
 		}
 
-- 
2.27.0

