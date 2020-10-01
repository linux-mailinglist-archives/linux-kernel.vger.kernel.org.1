Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E55280500
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbgJARTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgJARTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:19:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB291C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:19:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so4518285pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrTCyTN1+2ixfks7s00Aw0ElOFGBGCF6ZaKZi3egmQI=;
        b=OdtQstUMwE24TphYEOw1H7nu2GsKA5sCbLvSGiNUK43tG7xYt+gvxxu23RnupG6Z4N
         XSzEdgvQjVII0O2weDvixUxxGKBO/bu4kgLs4k8txhbsvVINpfeyq9ZYd7M21MmQb57L
         I0Yf5CAVEY2SzF9frgbislitvq7HuMvI2bjLZYEeilN6iT+66KkvLkRQ7g6K7xzcPq53
         nOVfh5hBnNkK2EAGRzIb3+EIoeKKOumTfZ3g1pHMJUjFvgbrilldT4SzC2eUWLk1qT80
         PqGNTfg7JulDtyBcyfXuSOCJgc4S3uDJIush2WXMA0Prc4r9Avd8eAglC5XMmW9ppnCH
         /CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrTCyTN1+2ixfks7s00Aw0ElOFGBGCF6ZaKZi3egmQI=;
        b=SCunTgQ+93fXmXh7ispOb+0igJAo2i23i1MPE1rtXTwXTcf+faBYFbJ5GxaCd2M65j
         xuBvw4LQsMeJw/4lReBSx/HRz8Y7Tvru2Xw6XInAl4XsIANoJH2kJ1dN9uKNDYMFIPjW
         yuEhtyn5XfaP4w22UCe8orP1PE0cK5NjOVEnkyzgdn6Zqyr2+50NIZBIuuTl/Y3R0bTG
         hqR2JN13CRbPeT/4kkcOoBA4BHguK7R3zKTb9oCEERQqAnyUakXiz25SEIgTkDbs5zRH
         Kjt6KOJjwQUNnw3+j+VMBmaT5tJb2gbYBmAiIRPPAax3WMfQI5PFfyr09Qv3LaLORzjA
         UYdg==
X-Gm-Message-State: AOAM532Vy3WJUME1jdPRkUs3W3dEsRY2mLZvPBRxlQIGo8n1Z8+rbMrk
        2ctnFXx8TBdldxLZY9scFUs=
X-Google-Smtp-Source: ABdhPJwj+CliAxLfbR8GghOZ89pOMm6NrYJ7r2bkcxnFQM6/UC76RoA882XypGG6XvUYSr1ObiXaqA==
X-Received: by 2002:a17:902:bccb:b029:d3:89e2:7a21 with SMTP id o11-20020a170902bccbb02900d389e27a21mr4381730pls.30.1601572785159;
        Thu, 01 Oct 2020 10:19:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6895:98fa:b2ef:d209:c1d4])
        by smtp.gmail.com with ESMTPSA id b11sm6799796pfd.33.2020.10.01.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:19:44 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: fix multi-statement macro checks for while blocks.
Date:   Thu,  1 Oct 2020 22:49:03 +0530
Message-Id: <20201001171903.312021-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch.pl doesn't have a check for excluding while (...) {...}
blocks from MULTISTATEMENT_MACRO_USE_DO_WHILE error.

For example, running checkpatch.pl on the file mm/maccess.c in the
kernel generates the following error:

ERROR: Macros with complex values should be enclosed in parentheses
+#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)  \
+       while (len >= sizeof(type)) {                                   \
+               __get_kernel_nofault(dst, src, type, err_label);        \
+               dst += sizeof(type);                                    \
+               src += sizeof(type);                                    \
+               len -= sizeof(type);                                    \
+       }

The error is misleading for this case. Enclosing it in parentheses
doesn't make any sense.

Checkpatch already has an exception list for such common macro types.
Added a new exception for while (...) {...} style blocks to the same.

In addition, the brace flatten logic was modified by changing the
substitution characters from "1" to "1u". This was done to ensure that
macros in the form "#define foo(bar) while(bar){bar--;}" were also
correctly procecssed.

Link: https://lore.kernel.org/linux-kernel-mentees/dc985938aa3986702815a0bd68dfca8a03c85447.camel@perches.com/

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9e65d21456f1..31624bbb342e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5299,9 +5299,9 @@ sub process {
 			$dstat =~ s/\s*$//s;
 
 			# Flatten any parentheses and braces
-			while ($dstat =~ s/\([^\(\)]*\)/1/ ||
-			       $dstat =~ s/\{[^\{\}]*\}/1/ ||
-			       $dstat =~ s/.\[[^\[\]]*\]/1/)
+			while ($dstat =~ s/\([^\(\)]*\)/1u/ ||
+			       $dstat =~ s/\{[^\{\}]*\}/1u/ ||
+			       $dstat =~ s/.\[[^\[\]]*\]/1u/)
 			{
 			}
 
@@ -5342,6 +5342,7 @@ sub process {
 			    $dstat !~ /^\.$Ident\s*=/ &&				# .foo =
 			    $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&		# stringification #foo
 			    $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&	# do {...} while (...); // do {...} while (...)
+			    $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&		# while (...) {...}
 			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
 			    $dstat !~ /^for\s*$Constant\s+(?:$Ident|-?$Constant)$/ &&	# for (...) bar()
 			    $dstat !~ /^do\s*{/ &&					# do {...
-- 
2.27.0

