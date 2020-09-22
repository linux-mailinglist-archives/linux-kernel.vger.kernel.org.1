Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E9F273BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgIVH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgIVH1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:27:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E928C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:27:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so1060023pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCA247ShbpRZ1a1b45l38fFZLtGfn793+mZHctzrR2s=;
        b=pevB0rJqRxFzG5mcV3HwhUpMG9k8wYCHBZSbVEhbk67cwbAeU2Jk1AYyRATEs/FBQi
         SHHK7z8n5tdoYgdfeHsoy2ZymuZ47kJXf5ylxzROmJ1Ia5l1nZTo5oOSddjxRJ5z0/Dd
         lvwOyEdt/BRnRBQhQp6lhycwYPSgPt+3w6zLZbQerMM/As7xVhPCozU6ni/UtALry6ya
         mnDirJVGr07uIUimK+gldhMG5CSrfKlhlHmQXTsqqaXm82hCNW9DD1HSEbjnZjBjqu/8
         cC6YA+gOVeomsKyj8ej8qHyh3nbjtFODv2D2zskTw04rar7CQbF0QmpipcJih9Lum96S
         hBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCA247ShbpRZ1a1b45l38fFZLtGfn793+mZHctzrR2s=;
        b=nVvNtGoDV8wjBddev2WW+e6Um5KK2Aiw5gE2/Nb7mgonUklMdvYqpZRTANG0a7TedS
         KzQRY0KLM+9CBOpi1Dl11o9bISC1kcAJa3QOlt91rgwSe8N1phBqhXnW2Xli4kzEITLj
         Uh0v9WQc4v9T3mFhKdAuXXbLSlGyuurrxtkvA5MfHrC55a627Xgy+6EwwhJoZnW15OZ5
         wgoJYoQL64zfvKOZ4bov688Ta2yv83+mn1v/j0QfSKkFWnR0Gx55m/9nSTnpJy9whyXf
         smQ9z5ewpvuaca7zzFYFPLCJ8JhI9+xFYxzW6Xdt3V42HvCbjsyguET1tcXC8o/saVdQ
         xBbA==
X-Gm-Message-State: AOAM530W8KvSezT0JGUJN0Am4YOUNX+7VJx2jX6LGbMV+hJudDcxPIWc
        ksGN2zWNv6vPMaGfLOFzbic=
X-Google-Smtp-Source: ABdhPJwwogNbojzybdhoPYW4owwtmCDx/oXe375OKk7BBYv9zNzzPan3N5yovp469BSPE9PgGKAsVw==
X-Received: by 2002:a17:90b:8a:: with SMTP id bb10mr2687470pjb.108.1600759672854;
        Tue, 22 Sep 2020 00:27:52 -0700 (PDT)
Received: from localhost ([2409:4050:2e9a:cd41:aceb:49c:d6fb:ea72])
        by smtp.gmail.com with ESMTPSA id e17sm13690983pff.6.2020.09.22.00.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 00:27:52 -0700 (PDT)
From:   Piyush Goyal <piyushgoyaliit@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] stress-shmsysv: exercise shmat with SHM_REMAP flag on NULL address
Date:   Tue, 22 Sep 2020 12:57:30 +0530
Message-Id: <20200922072730.68911-3-piyushgoyaliit@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922072730.68911-1-piyushgoyaliit@gmail.com>
References: <20200922072730.68911-1-piyushgoyaliit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exercise shmat syscall with SHM_REMAP flag on NULL address resulting
in EINVAL error and more kernel coverage.

Signed-off-by: Piyush Goyal <piyushgoyaliit@gmail.com>
---
 stress-shm-sysv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/stress-shm-sysv.c b/stress-shm-sysv.c
index 9efaa091..e2aff788 100644
--- a/stress-shm-sysv.c
+++ b/stress-shm-sysv.c
@@ -149,6 +149,10 @@ static void exercise_shmat(int shm_id)
 
 	addr = shmat(shm_id, NULL, SHM_RND);
 	(void)addr;
+
+	/* Exercise shmat with SHM_REMAP flag on NULL address */
+	addr = shmat(shm_id, NULL, SHM_REMAP);
+	(void)addr;
 }
 
 #if defined(__linux__)
-- 
2.25.1

