Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57452B1CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgKMN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgKMN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:58:07 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:58:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v12so7648118pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vTnsverZoGzLekH1zBmdh7TzAPle0ubBo5+gTweQfA=;
        b=Dp6zxRbXMqegXAhGPbxdglMuJR1k93K1FEsMyluCXpNYX968qprlhGjT1ui4oSFvLD
         t/EwjOwyziznw6x3td07nrFR1dpN4VYnZyambrJ/zSwBtn+egDE4wVkW8TMNNaLN4RVB
         R13/4RPSSPzJiXvbN4C7s2VGwpxZor8/EhCJf0yuu8Ds6jZ40NOGsWrWsRkehtAaHsjn
         9jKpS5XlzcZCKgEGfvfiNLCmSlfxSdOLAHPDfOIpKsRcU+3Hv0FpHY9qf+QulWLU8pwy
         oyCczicKfYkLEG/XZceegbbOrDqXefGQjTzxrBQVy9cmMyh9Jo9qKxGxnMVcvyTR6Wc4
         wAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vTnsverZoGzLekH1zBmdh7TzAPle0ubBo5+gTweQfA=;
        b=bLTMWCaakBWpV96Z/xGm00+gQdBydyDIjRIb996bwYxH/TcjJa2mhDClHnvLXKrq65
         f+rQHWxSnshkes7HOoONtF6hNfaglrNP8uoDgGQ8ey63IWPlKUpJuSSBk3S/9TpxAr5S
         ChX9loc2SXAwcZUSzqe8hMhXI542zw8G4dSdCZFp/NSfr1Ujw/tAJE4+gMkIrrYYj3vZ
         ueKCDWk+pqTRpehReFaJc1gshBGGwGGFSV97sy3gfpkn/+OpbcvxEgny1XpDZ5PmKJB/
         Bt7cOrqdOJ8rCg8/iG0V1ejYMply9WKD4sB2VRkDGu9UDbYp2aYJ/kiqhXyual+w+MeO
         UqeQ==
X-Gm-Message-State: AOAM530MLun1jRHh8bqM8rmFkT6zDhDg/RiOxz4EJluGiLpEz35hfQbR
        QaO4z1X2hhJ40yaTpsyCvw+imsEfwuLVAEa6
X-Google-Smtp-Source: ABdhPJwhVQmLyDRRjbaZXdhrHtxVXl2LeaJC7RjdFj5fMvnBU/Nf1v+RbFZw+uy/mvAJvbZR0UIXvA==
X-Received: by 2002:a17:90a:cb08:: with SMTP id z8mr2940899pjt.152.1605275886547;
        Fri, 13 Nov 2020 05:58:06 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6819:f451:9e0a:873f:ed68])
        by smtp.gmail.com with ESMTPSA id v23sm10609956pjh.46.2020.11.13.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:58:05 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: fix typo and remove duplicate word
Date:   Fri, 13 Nov 2020 19:27:39 +0530
Message-Id: <20201113135739.46776-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete repeated word in scripts/checkpatch.pl:
"are are" -> "are"

Fix typos:
"commments" -> "comments"
"falsly" -> "falsely"

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2749f32dffe9..041b82f6669e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2841,7 +2841,7 @@ sub process {
 
 
 				# stable@vger.kernel.org or stable@kernel.org shouldn't
-				# have an email name. In addition commments should strictly
+				# have an email name. In addition comments should strictly
 				# begin with a #
 				if ($email =~ /^.*stable\@(?:vger\.)?kernel\.org/i) {
 					if (($comment ne "" && $comment !~ /^#.+/) ||
@@ -5000,7 +5000,7 @@ sub process {
 ## 		    $line !~ /^.\s*$Type\s+$Ident(?:\s*=[^,{]*)?\s*,\s*$Type\s*$Ident.*/) {
 ##
 ## 			# Remove any bracketed sections to ensure we do not
-## 			# falsly report the parameters of functions.
+## 			# falsely report the parameters of functions.
 ## 			my $ln = $line;
 ## 			while ($ln =~ s/\([^\(\)]*\)//g) {
 ## 			}
@@ -7109,7 +7109,7 @@ sub process {
 		exit(0);
 	}
 
-	# This is not a patch, and we are are in 'no-patch' mode so
+	# This is not a patch, and we are in 'no-patch' mode so
 	# just keep quiet.
 	if (!$chk_patch && !$is_patch) {
 		exit(0);
-- 
2.27.0

