Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC5A29812A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 11:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415100AbgJYKQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 06:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415093AbgJYKQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 06:16:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F79C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 03:16:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b6so674965pju.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QPSTlDOBL+sewSTMO/Hzqh/YIYntFzYxn48Pwl1Y/WM=;
        b=QLGvKGXBsodvvGL3JW/SD523viu5p9m8Ot7Iq6oeN+IrTwo2WHddmgbjRd7hOWgcTJ
         OKtaa/gsyqden7BGKZpugSigJApKFwaEprmAssCHtL4rqNlaBwYJ3VWeRT0Z3S6frL3e
         QThrBCiJfNsfa3h0ySRZm18TBmQKDAgyo+fCofIpXZuHKlYfncjLrz8CPmTSSLUSCo6g
         FvmVOHIOyaf80/TqYz8NBg+ApPaI4ACNKkZPTTAH2b+rWSsij8juZ1Pnth/tQDd7UQuS
         plSywnYVU4odqkH8TSvZD6MCjYyjQiq0sU6woS6CS18ddk9t/r8lmtU6qGNtaJ7lDTyF
         9DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QPSTlDOBL+sewSTMO/Hzqh/YIYntFzYxn48Pwl1Y/WM=;
        b=PBzSXsOdLtp913HCIE1GHdRDBNMkrO4ddjxFSWvb3QjDgp9/PgXRVzU+uuexyYNZOQ
         G99JtIHiuSwcKlwHwWk44y0qaRGQa5cWHWoRq8SkRhkCkmz8ZLGEEaqVsuaYHA4sF9I7
         xzcUDdHvOkF7TznfDmrhLitWDK4c3mtgVeekTySt6jheL/qOfCn5AYaNw/6lVzV160TK
         qb5nSQvHZeclpHUtn1cU+qq2ELSo84B59t3gZsP8ZB2wrj28DbPXaQyEvDkXacxznk9i
         cPNGVoB54H3gm/eXcjCKgg6vp40zGP/YxleikyyMyn4x6UVEDRaVRUsBQXYxT3ykHLoB
         a2Cg==
X-Gm-Message-State: AOAM533OWl5z8vzHv/9eK8FXPgEpYQXSoHAJOh3xq3PvXmixxRLM/SDO
        DF085Zf3G4iNb5hwo/j4CthNgnmYqAXZb6BJ
X-Google-Smtp-Source: ABdhPJz6nTAju9kJMzxCsSsyzazjgDeFMBzdGpJF2vaenKb/SqVHop/Za8ULhD3wo5LR9EwTfBN1HQ==
X-Received: by 2002:a17:90a:4e0d:: with SMTP id n13mr4638300pjh.95.1603620964285;
        Sun, 25 Oct 2020 03:16:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:60a7:4fb7:1d05:966d:919e])
        by smtp.gmail.com with ESMTPSA id y124sm8490692pfy.28.2020.10.25.03.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 03:16:03 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v5] checkpatch: extend attributes check to handle more patterns
Date:   Sun, 25 Oct 2020 15:45:37 +0530
Message-Id: <20201025101537.59133-1-dwaipayanray1@gmail.com>
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
 scripts/checkpatch.pl | 117 +++++++++++++++++++++++++++++-------------
 1 file changed, 81 insertions(+), 36 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7e505688257a..e3437948883b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6155,50 +6155,95 @@ sub process {
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
+					my $new = $attr_list{$curr_attr};
+					push(@conv_array, "$new$params");
+				} else {
+					$conv_possible = 0;
+					last;
+				}
+			}
 
-# Check for __attribute__ aligned, prefer __aligned
-		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b__attribute__\s*\(\s*\(.*aligned/) {
-			WARN("PREFER_ALIGNED",
-			     "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
-		}
+			if (scalar @conv_array > 0 && $conv_possible == 1) {
+				my $replace = join(' ', @conv_array);
+				if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+				         "$replace is preferred over __attribute__(($attr))\n" . $herecurr) &&
+					$fix) {
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*\Q$attr\E\s*\)\s*\)/$replace/;
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
+					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*format_*\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;
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

