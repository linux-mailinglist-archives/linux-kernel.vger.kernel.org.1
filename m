Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62D62B7DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKRMlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgKRMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:41:09 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D04C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 04:41:09 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t37so1031848pga.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 04:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=it8JzRhie4ZUZLNrhDYP/725kiF3kapQrNtAIJC5Ezw=;
        b=Lk39PCW2Rt/u0byVo7x6YnlDdBC15Pfp9XGL9tutSco5CmQ93zghMz1yRcue05DmfG
         mKtW3ZmgJXrKf91XsKThDWq96gHNuUKqT+IF9y+L7hoDSXmNJLAfRH/6UmwI3WIj34oe
         EWv3RHrwxQYj+Z+G88RVMsbLnHj1X5oSkgr9pTBFKA4cLMHr7cxRyMmERXJPl5XL+73w
         B0fyi5KcKu8rQt0jYtk/8ZvF/ZbX17chs8j5t1GyHI+7jEV7GnoKrGvqU69YYERfayWk
         lpdgAN+o1ssXR+gfhbEMPIPM6VkGp0rYAQHSO9p0isoU0p6nqIDG3Z+OV2axthyPrh/3
         oxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=it8JzRhie4ZUZLNrhDYP/725kiF3kapQrNtAIJC5Ezw=;
        b=AtLlzcNTvF+OR066HyZe1v/mFx9G31mruK8b4gbUWTPH1AEeJ3r/wEkbrGIwtHuOuJ
         fBH2GiizbE/bU2zFhYQrbnNjenX1VNsCrQ3+RRrW4oMGvPXirfV5bY6MNH5EmP8T9DC6
         xOzfrdRceEf40XRfJ8pNMv9hCKKCTcr7/vwsAP/VoNQnyfKOZpNiqqRBqTnFN6rrGPMd
         L22Ia9zwOcN/1fdB0VlT1ed+jSBeGdiyDGvYDSAOh93UTHm3+GLkwEG8d2CgWLI8WASk
         0R4NIZy/h3R4q5luUiBjLxy7M+krK+g7eZt/qVAKvLVuFvOluwN9wFYufyQCwxY5XzpA
         Fncg==
X-Gm-Message-State: AOAM530gQCZHlht62NpBKQC1Lwu/p8bY/9g4GrBvhDGGsGieMwDtvmez
        2CkRnL/GUjTDop2cV0vAvUZucbSwwTVTp6KV
X-Google-Smtp-Source: ABdhPJzi62EIey9sFgKBK860naW9spg0El00ZDAKcIl5hGwL9SVF9A4kDy1T0OHPWzNPGkONXF/jiw==
X-Received: by 2002:a63:4c5:: with SMTP id 188mr7942080pge.339.1605703268734;
        Wed, 18 Nov 2020 04:41:08 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6067:4f82:1cca:da0c:606c])
        by smtp.gmail.com with ESMTPSA id d7sm3428045pfd.214.2020.11.18.04.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 04:41:07 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: add --fix option for OPEN_BRACE issues
Date:   Wed, 18 Nov 2020 18:10:35 +0530
Message-Id: <20201118124035.96976-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brace style misuses of the following types are now
corrected:

int foo(int bar,
        int baz) { bar++;
    return bar + baz;
}

int foo(int bar,
        int baz) {
    return bar + baz;
}

if (bar &&
    baz)
{   bar++;
    baz++;
}

if (bar &&
    baz)
{
    bar++;
    baz++;
}

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0da6422cd0fd..8da6cde20c68 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3937,9 +3937,23 @@ sub process {
 			#print "pre<$pre_ctx>\nline<$line>\nctx<$ctx>\nnext<$lines[$ctx_ln - 1]>\n";
 
 			if ($ctx !~ /{\s*/ && defined($lines[$ctx_ln - 1]) && $lines[$ctx_ln - 1] =~ /^\+\s*{/) {
-				ERROR("OPEN_BRACE",
-				      "that open brace { should be on the previous line\n" .
-					"$here\n$ctx\n$rawlines[$ctx_ln - 1]\n");
+				if (ERROR("OPEN_BRACE",
+					  "that open brace { should be on the previous line\n" .
+						"$here\n$ctx\n$rawlines[$ctx_ln - 1]\n") &&
+				    $fix) {
+					my $line1 = $rawlines[$ctx_ln - 2];
+					my $line2 = $rawlines[$ctx_ln - 1];
+					fix_delete_line($ctx_ln - 2, $line1);
+					fix_delete_line($ctx_ln - 1, $line2);
+
+					my $fixedline = rtrim($line1) . " {";
+					fix_insert_line($ctx_ln - 1, $fixedline);
+					$fixedline = $line2;
+					$fixedline =~ s/^(.\s*)\{\s*/$1\t/;
+					if ($fixedline !~ /^\+\s*$/) {
+						fix_insert_line($ctx_ln - 1, $fixedline);
+					}
+				}
 			}
 			if ($level == 0 && $pre_ctx !~ /}\s*while\s*\($/ &&
 			    $ctx =~ /\)\s*\;\s*$/ &&
@@ -6659,16 +6673,30 @@ sub process {
 			my $ok = 0;
 			my $cnt = statement_rawlines($stat);
 			my $herectx = $here . "\n";
+			my $cur_ln = $linenr - 1;
 			for (my $n = 0; $n < $cnt; $n++) {
 				my $rl = raw_line($linenr, $n);
 				$herectx .=  $rl . "\n";
 				$ok = 1 if ($rl =~ /^[ \+]\{/);
 				$ok = 1 if ($rl =~ /\{/ && $n == 0);
 				last if $rl =~ /^[ \+].*\{/;
+				$cur_ln++;
 			}
 			if (!$ok) {
-				ERROR("OPEN_BRACE",
-				      "open brace '{' following function definitions go on the next line\n" . $herectx);
+				if (ERROR("OPEN_BRACE",
+					  "open brace '{' following function definitions go on the next line\n" . $herectx) &&
+				    $fix && $rawlines[$cur_ln] =~ /^\+/) {
+					fix_delete_line($cur_ln, $rawlines[$cur_ln]);
+					my $fixed_line = $rawlines[$cur_ln];
+					$fixed_line =~ /(^.*\)\s*)\{(.*)$/;
+					my $line1 = rtrim($1);
+					my $line2 = $2;
+					fix_insert_line($cur_ln, $line1);
+					fix_insert_line($cur_ln, "\+{");
+					if ($line2 !~ /^\s*$/) {
+						fix_insert_line($cur_ln, "\+\t" . trim($line2));
+					}
+				}
 			}
 		}
 
-- 
2.27.0

