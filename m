Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63142B1E84
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKMPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgKMPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:23:56 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E94C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:23:56 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q5so7878981pfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WeHfKsKBskJF//nV0gHHSqUsCVNd9uwrdvRUtYIsCQ=;
        b=UiGMlYnf46lTNVE2g7F/8bxf+FZ4CYFKFxahm7UkJvKVQOlJ3uurv0goMXp5a+dzOL
         9mExWR637tkf/ZSZWPTzU7CZ6ulwsQa2yhfgZczAeanP3tgZov5w16XSTV0EDpEMZJCZ
         2lQ8oPHduXeGnYdlZcb4JHdWJFRwxoePaPueQPKTZj35q1q0SCBii0idpJQDGZtiXj9F
         SF92pFRVlfI2aaCGcKRAx2Dg/JcMsBdFcBsHzkfSG/jsDzQxvxpiIexDrY7+3Xhvs7Yy
         5+pG6dHXvXPOPC3D84p0bpNqRcGpvjH5BDMP4hiIywErjIaV0uJDIW8G0Th5WDCwGfH1
         uFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WeHfKsKBskJF//nV0gHHSqUsCVNd9uwrdvRUtYIsCQ=;
        b=lLikNpSuj3gIhQndljouGthhowJKEVz7IWr8M0cnNqItyYq5xzKAhQ1i1XUarR4Kb5
         S33TvGqHDwmtOIUzu6flfcsk+V8d1uIWu55nTXi/ECaayAG7j9a8aBJXYbHYWsfEyuUV
         xbb/0N7zwn1loy+R9LpSOazRbplEb5JBzQrirQ/aKEogYng7Gqquk5Cdv99FzbDwXpcX
         ajR/1Mx1MjENu8FXEjLxIwpvopNCf++1TELvg03n7cRyPed5G585Y8w5BLbr51D0wSn7
         LNISj0CA3hBJLZdPjVhkx9223aM/aYwC0TCCH6ZiFDvC6JE8BJ/9Yby/YnI1JVKiPm8Y
         oYwA==
X-Gm-Message-State: AOAM533nTizmUKW3i4aCF8EJhrpvIGmQu+AMmqDX8I+0Uio09DZ1DDmQ
        F2Fb3DCbp+yN//FeixK1Ein9fGhvpadzSIjo
X-Google-Smtp-Source: ABdhPJyuYXKPkYLe0VYEYJ5+xB/uMeGHM5J3tb1rSBKR0Y7i8gDSbmSLndBvONsZ/MFhs4DkODNgYQ==
X-Received: by 2002:a63:c945:: with SMTP id y5mr2490173pgg.118.1605281030623;
        Fri, 13 Nov 2020 07:23:50 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6819:f451:9e0a:873f:ed68])
        by smtp.gmail.com with ESMTPSA id a17sm9391408pga.56.2020.11.13.07.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:23:49 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH V3] checkpatch: Fix spelling errors and remove repeated word
Date:   Fri, 13 Nov 2020 20:53:16 +0530
Message-Id: <20201113152316.62975-1-dwaipayanray1@gmail.com>
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
Changes in V3:
- Change subject line
Changes in V2:
- Add correction for falsly

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

