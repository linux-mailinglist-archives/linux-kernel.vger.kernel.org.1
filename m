Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4004E2B1BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKMNLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgKMNLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:11:34 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F8C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:11:33 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so7575508pfr.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75K9Xmj3ZL7JIJFabT0ZlYsUmd1/U2W+UwNPqr8ITUk=;
        b=BB+/B/u5IVnXmkQY6+YYyzJeRo23kPVXakF1637xp99uBaVHXhH9r3kWBh020Tq94u
         t/d6cAZcQLPC0BO+llThD7BsS7eDpJy6JI6FN3mxn8iaNR42q1qLqtUNXvccvxamC5GW
         iIgEUGAgidux1rgKf+ETBNnZ9X0FE+eweR45chSMcgK/hqbp7lRmihUTQV0E5DoRFKPi
         0QIZaMSvqhutdCK8ny/f5OO3cvRSuqjYzh5QJSVmIzp1tEpRHqA91ARCKsDUsXg7mPEo
         GOWyaIGRAIorj6Q2e6tltuE63OAc4tKHaxBlKEvpvSbD4Wa5PWU+vMkxLuUn+sfGo1Hf
         /XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75K9Xmj3ZL7JIJFabT0ZlYsUmd1/U2W+UwNPqr8ITUk=;
        b=BgY+LIAhyd681qJtx3th5h9+nXYwtIM+ZAjn9GjTrGHttdItJax/Idl38TjqFZ8eC3
         9+XzZ5IRkJocb/Gs7DkkO+1c422WLTnAOJtXATMcZRvX379CtbvT6o4w4798KOkRSenc
         KkzjkHtx/rBx5Jlo90T3zyAkqj8SwxqYsVcGvlte3P2gM2RMw4o1fz3zdr0LF7k377kU
         juUDQxClF2mno97NOSoLMHk0uoRaCyFVaS+9nPHxjsQIfF8S6lHpaP+aRsy0r9z7HGYX
         MsEShBywHUdcratRZ+kih9Au9+aXBYn2zAdFuvgO9CircURpRCWJxxI17aK464YxR+lP
         iCyg==
X-Gm-Message-State: AOAM530IY3tkhuaA79q0BftNk1bFb4UWZ+J8b4YSNJuB4zFH3g93xH+p
        /xezqBfaVGEOw98Thj+4h9Q=
X-Google-Smtp-Source: ABdhPJzZHmYbT7BNBCHwmxpfa0iqfKje97CetxC81cErMlPi+mlnRx3EKEWnN0XJc9ZCJ4yWX5gxEw==
X-Received: by 2002:a17:90a:448a:: with SMTP id t10mr2883633pjg.38.1605273093372;
        Fri, 13 Nov 2020 05:11:33 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6819:f451:9e0a:873f:ed68])
        by smtp.gmail.com with ESMTPSA id gm12sm10533302pjb.28.2020.11.13.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:11:32 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: fix typo and remove duplicate word
Date:   Fri, 13 Nov 2020 18:40:37 +0530
Message-Id: <20201113131037.37519-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete repeated word in scripts/checkpatch.pl.
"are are" -> "are"

Fix typo "commments" -> "comments"

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2749f32dffe9..e7fd2d6279cf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2841,7 +2841,7 @@ sub process {
 
 
 				# stable@vger.kernel.org or stable@kernel.org shouldn't
-				# have an email name. In addition commments should strictly
+				# have an email name. In addition comments should strictly
 				# begin with a #
 				if ($email =~ /^.*stable\@(?:vger\.)?kernel\.org/i) {
 					if (($comment ne "" && $comment !~ /^#.+/) ||
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

