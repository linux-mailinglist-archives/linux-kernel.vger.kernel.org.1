Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5D2FCB79
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbhATH0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbhATH0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:26:39 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83EC061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:25:59 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x18so12039384pln.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WlLbPCtA5zX530YpM9Rqf78MCKfOyhRy2nl/un5gf4Y=;
        b=KOE6EmQvvvEAZSvv/7MDpGtLd4BDooRQucvauDCbrLW42m9e3IcwrFIgSkLqBMIbBq
         v+WmH1EwsuJLHnRbARfIuVCMAqfSNZBI3kjCo2UC6GG60owEN8cEYi9rV2jGQ2Wq9Oqy
         bvAejENnpxT6ekUPqfEwCOfauCfo7mnCEeJfNf0vvw9YdQHWRzApCTjg1Xi9HXZ+Ro5Y
         bceqiBvDMOWrlFvbT3EUIPyxhG0Lo1U8BM5WqFmihj7nxAEhQiX+Cvo0i4M0BZX1CKdt
         xy6p3chXpuuprReXoZvglpOoMPWJpy3tULXLZBJJ93qwrHW0bdCte8vaN/y49w4/qvvN
         Y4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WlLbPCtA5zX530YpM9Rqf78MCKfOyhRy2nl/un5gf4Y=;
        b=YL1ADVSUORUoYLDrKTnOF/FsR7TUoryYYr4CDGQMk0gvJN3yyLpBrogce1usBAynxq
         SQp0WAvH7C2fDSOD/oB07v1JuMWcTCD6tppdsxusGxqavPgkYPaUDn8NS5sN1zaKHcde
         8hxw0WD9dYRjlfVKsVJxCYe8a4rvW84is+FtQeNgpvtkhye7BeL1gsVoSoM3fmcOSl0o
         boFUpHF/HNAciGyRN6pZUTefrQJPjccUxN3sAU2XwCH8/eCRAYySlXiiIWvJ9RdYyXl8
         cRIR7a/8Grl01lCJjPOQmJRlLA3UMNTXLlOz+dgWifbnMoemu37TR/8VArXQq0JCRyMx
         5p7w==
X-Gm-Message-State: AOAM530sPfhqRHAlkpCji4r8U/tEtPLWrtDFjCkdW4SoCZsMCeUNU31X
        8BwIpCRF75pxOEtfvcWTbE5Fx/cD5iNRZQ==
X-Google-Smtp-Source: ABdhPJzQ+nuPF9L38pDYw5xhJmJDWz5tiY/BflYGMnNp1cSNMrt68gG0BN7hoZMwKDyZRAsV3Wpb3A==
X-Received: by 2002:a17:90a:a10e:: with SMTP id s14mr4103098pjp.133.1611127558777;
        Tue, 19 Jan 2021 23:25:58 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:7054:d78f:3538:6af3])
        by smtp.googlemail.com with ESMTPSA id 192sm1199519pfv.209.2021.01.19.23.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 23:25:58 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        dwaipayanray1@gmail.com, broonie@kernel.org, joe@perches.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] checkpatch: add warning for avoiding .L prefix symbols in assembly files
Date:   Wed, 20 Jan 2021 12:55:47 +0530
Message-Id: <20210120072547.10221-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local symbols prefixed with '.L' do not emit symbol table entries, as
they have special meaning for the assembler.

'.L' prefixed symbols can be used within a code region, but should be
avoided for denoting a range of code via 'SYM_*_START/END' annotations.

Add a new check to emit a warning on finding the usage of '.L' symbols
in '.S' files, if it lies within SYM_*_START/END annotation pair.

Suggested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/lkml/20210112210154.GI4646@sirena.org.uk/
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7030c4d6d126..858b5def61e9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2501,6 +2501,9 @@ sub process {
 
 	my $checklicenseline = 1;
 
+	# record SYM_*_START/END annotation pair count, for AVOID_L_PREFIX
+	my $sym_start_block = 0;
+
 	sanitise_line_reset();
 	my $line;
 	foreach my $rawline (@rawlines) {
@@ -3590,6 +3593,25 @@ sub process {
 			}
 		}
 
+# check for .L prefix local symbols in .S files
+		if ($realfile =~ /\.S$/) {
+			if ($line =~ /SYM_.*_START/ ||
+			    (defined $context_function && $context_function =~ /SYM_.*_START/)) {
+				$sym_start_block++;
+			}
+
+			if ($line=~ /\.L\S+/ &&		# line contains .L prefixed local symbol
+			    $sym_start_block > 0) {	# lies between SYM_*_START and SYM_*_END pair
+				WARN("AVOID_L_PREFIX",
+					"Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
+			}
+
+			if ($line =~ /SYM_.*_END/ ||
+			    (defined $context_function && $context_function =~ /SYM_.*_END/)) {
+				$sym_start_block--;
+			}
+		}
+
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
-- 
2.17.1

