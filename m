Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BC0273BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgIVH1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgIVH1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:27:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:27:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b124so11607173pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9doUA7v3qgCprpOcOB0ioz4IxnVKUZWjoWvI1uixCX0=;
        b=pjg8SERKuYSJJ25UqckO0hTCikNkE4ZF+cnAq5b3rQ7jvSSztxE69QYZQ/umNDDhnj
         ytcqw4BDtW7xLXS4gB0aeUMDRD45T5k2Clp6yP6kA/LPjHEMcmJrodqnAyI3qcDhUKlB
         FaqL45m6IrFpdFsLqa3iUCXXYEu1HGiwtEHlOFZE91palgXQ0qaWwuPTfxXUYnYZnhyP
         Yc+uyUGyIX1mRxh7f4Cy9yDaX6JKlFHNoA3u7SZBV8V09ZENgoV0sbRqeVR0u9aVHKwW
         ah+PrcV+X7Kig7OHyLjkEYbXd3KhKP8VQ89P19xFQOSKr+AvNZxXn2LcJP0vqIo8/Dxz
         AcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9doUA7v3qgCprpOcOB0ioz4IxnVKUZWjoWvI1uixCX0=;
        b=sOeFY4z7ydbaQl5qDJ+RNo/80x4nYgickDbbiVo9E1OgWpRmmqN2FRE9jn8gjhzGG1
         x8CbieJZuKfy9O0czJ523GEMoQyHS7RyvjxiJHTdQEem3gFwBk7GFVDcn7dO4oLeqA4g
         hu7+OKRy1ysRHEaxPJrBE1FPgraPaPIFqhYIT+Mwqv8m0rJS7JoQDG1IDAhVTUGQCa+j
         YQwRsQR2h4O8eczX1KnKP3lAtcp7vmhpWyEtk/FjziXSh8QarVVEMOjPCRU1JLQjkfKF
         e+/VKBU/7cRLtvAJl6nF0I2RhQQdjDIwO+C5SkCYklbWaSzaW9fK2egNkCwF4ZG1g1HR
         Mt/A==
X-Gm-Message-State: AOAM53018B3n2zTeblhS4PY74bXyRkthi8bqzPwKRLhPfv0oY8u65mPT
        EwV4XQqxgPzBQPPViF4NnaA=
X-Google-Smtp-Source: ABdhPJzYZ3x5I+xzxFOQEOvKxMFlSEVLE3xNIlNFJOgSUp2WJ1PLZRU3uLM9KADfhFEY8K284vWaoQ==
X-Received: by 2002:a05:6a00:84e:b029:142:2501:35e1 with SMTP id q14-20020a056a00084eb0290142250135e1mr3117666pfk.65.1600759660698;
        Tue, 22 Sep 2020 00:27:40 -0700 (PDT)
Received: from localhost ([2409:4050:2e9a:cd41:aceb:49c:d6fb:ea72])
        by smtp.gmail.com with ESMTPSA id q15sm4252157pgr.27.2020.09.22.00.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 00:27:39 -0700 (PDT)
From:   Piyush Goyal <piyushgoyaliit@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] stress-shm-sysv: exercise shmat with invalid flags
Date:   Tue, 22 Sep 2020 12:57:28 +0530
Message-Id: <20200922072730.68911-1-piyushgoyaliit@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exercise shmat syscall with invalid flags resulting in more kernel
coverage.

Signed-off-by: Piyush Goyal <piyushgoyaliit@gmail.com>
---
 stress-shm-sysv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/stress-shm-sysv.c b/stress-shm-sysv.c
index aa03d718..5a3e0cc1 100644
--- a/stress-shm-sysv.c
+++ b/stress-shm-sysv.c
@@ -128,6 +128,19 @@ static int stress_shm_sysv_check(
 	return 0;
 }
 
+/*
+ *  exercise_shmat()
+ *	exercise shmat syscall with all possible values of arguments
+ */
+static void exercise_shmat(int shm_id)
+{
+	void *addr;
+
+	/* Exercise shmat syscall with invalid flags */
+	addr = shmat(shm_id, NULL, ~0);
+	(void)addr;
+}
+
 #if defined(__linux__)
 /*
  *  stress_shm_get_procinfo()
@@ -337,6 +350,7 @@ static int stress_shm_sysv_child(
 				goto reap;
 			}
 
+			exercise_shmat(shm_id);
 			addr = shmat(shm_id, NULL, 0);
 			if (addr == (char *) -1) {
 				ok = false;
-- 
2.25.1

