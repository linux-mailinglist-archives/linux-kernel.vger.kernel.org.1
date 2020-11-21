Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69F2BC233
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 22:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgKUVEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 16:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 16:04:53 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBDAC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 13:04:52 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so11245098pfp.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 13:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GbxAeOvJk7Tb/1c/SoKJjtp//xhRkqyZpZjDLBwDuU8=;
        b=d/4PPvJnTT35ihukdVwL1ye3WWxs6SkZzriQulEtZ1jdu8SwZPkCDXrCiej90IV2fk
         AmPb8dFqqWRfXLUlnHhG2+wC+HQEdhJJjtpS6oTZ7RDRHthu3Tf5AXxVlYTm8w9hfqyZ
         clLKl5+X9fentMD7xJX+ROtTgMij9kPihoiTGynETRBiI+KY60sFzBey6lL66Pk/l+NZ
         VbN5u+yg2ztSTP28Ae4haXaxJAfARSxaGSDkOHGwDPgLffosJaLvNJq1kp9pnsuY+w2i
         Cz6NmEVCT/M2sB3fH3M/P8ERnVjuQkZnWuHjfMNZvOrOsZDU5Y8Gd0MGEddQk1Kiii7A
         h39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GbxAeOvJk7Tb/1c/SoKJjtp//xhRkqyZpZjDLBwDuU8=;
        b=rCOJhk7RnkapOWVEHdrlcsDEabhxOV0rFgfcBrDy92i1y83G4avaLaw89tC09kdpl1
         ycsC95+YXCQenEwK8zT+Js/ifGG/4iKoNV/8RiecAfFOQAKRx7jH0cW88uZcprq6M8Mx
         pEqwk36+HgNJbVzzXsUpUtfUg+Jk3jcuSFPDg4DeS31h78tgfjf8qeb2Kn7RsfND2cxD
         pMBu52GiA/HiqQguekoB63K7P9R96IhnqXlbghICO8zo3lgQIs+LaGJQup2OTd1fC5jL
         cao9fjnaoPlSUKt2dpFAb+16mCH1zryJJu8aFfpSrO0d9tPUG2kHM1lVRB08AyAY+Bu/
         HPmg==
X-Gm-Message-State: AOAM531e+i+wHWLJOdBC6nLNsjklLdqdWOE3IsSxZJ4KWSBaoBczE6se
        /Gq7eV3RJ3ZY2u4azEtTeNlFjicgHkX5Ug==
X-Google-Smtp-Source: ABdhPJzbTQvMZtXDyxVO8ULs7sEADU6xQe7jmnrOCwhUae5ucdkpIlQgqMYhXK22H9Y8+R2lqCWBFQ==
X-Received: by 2002:a62:3381:0:b029:196:31a5:c2d4 with SMTP id z123-20020a6233810000b029019631a5c2d4mr19249675pfz.29.1605992691445;
        Sat, 21 Nov 2020 13:04:51 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:43c:d362:ed91:20bf:333c:1bc4])
        by smtp.googlemail.com with ESMTPSA id 84sm7817851pfu.53.2020.11.21.13.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 13:04:50 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] checkpatch: add fix option for LOGICAL_CONTINUATIONS
Date:   Sun, 22 Nov 2020 02:34:42 +0530
Message-Id: <20201121210442.17299-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a6ee46ce01747627196478ff2a965d48dd4eed73.camel@perches.com>
References: <a6ee46ce01747627196478ff2a965d48dd4eed73.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checkpatch warns if logical continuations are placed at the
start of a line and not at the end of previous line.

E.g., running checkpatch on commit 3485507fc272 ("staging:
bcm2835-camera: Reduce length of enum names") reports:

CHECK:LOGICAL_CONTINUATIONS: Logical continuations should be on the
previous line
+	if (!ret
+	    && camera_port ==

Provide a simple fix by adding logical operator at the end of previous
line and removing from current line, if both the lines are additions
(ie start with '+')

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
changes in v2: quote $operator at substitution

changes in v3: add a check for previous line ending with comment;
If so, insert $operator at the last non-comment, non-whitespace char of the previous line

changes in v4: improve the matching mechanism by matching line termination at comment or white space;
insert the operator before comments (if any) separated by a whitespace;
append the comment and its pre-whitespace after the inserted operator (if comment was present),
ie if no comment was present nothing will be inserted after the operator

 scripts/checkpatch.pl | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b1a5a65e69a..43a05519665d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3553,8 +3553,19 @@ sub process {
 
 # check for && or || at the start of a line
 		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
-			CHK("LOGICAL_CONTINUATIONS",
-			    "Logical continuations should be on the previous line\n" . $hereprev);
+			my $operator = $1;
+			if (CHK("LOGICAL_CONTINUATIONS",
+				"Logical continuations should be on the previous line\n" . $hereprev) &&
+			    $fix && $prevrawline =~ /^\+/) {
+				# add logical operator to the previous line, remove from current line
+				# match line termination at comment or whitespace
+				if ($prevrawline =~ /(\s*(?:\/\/.*)*)$/) {
+					my $match = $1;
+					$fixed[$fixlinenr - 1] =~ s/$match//;
+					$fixed[$fixlinenr - 1] .= " $operator$match";
+				}
+				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
+			}
 		}
 
 # check indentation starts on a tab stop
-- 
2.17.1

