Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6A273BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgIVH1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgIVH1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:27:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A85AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:27:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so11626207pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PohIKHFK8kNViEgt/D+xrQCt40xHvnwTaUyMochPjiM=;
        b=Euve4fXlh9cyeH4Ff9DCJxOOPH9F63SIu0bUv82qLKMoyBBGD69x/Kn0F44dBBUH7o
         bQPRQy82rd6xOsHN778t+ENhRZPEsZ2kE7T4h4TGyuPJnSjGxGniHM0VRAZk4R9yB/ct
         jPs42Un//+VKA5Ic7nAybVWTmLyx0q6O/X9Dvmxk6dT7U/eeX338/9RnkbMnkz74MhYi
         uOqhDXosBo1/ctyr86FplhOXLnyQLcC4T22Q1PFwMWaPh1I9cuWWfZq1cjy0gMI5MWYJ
         e+rDvR0Rj+Lm6lPqpsYiRtRGmLL4rL/AUko4BmYd71j/PamVkpvnsFTb6v6g3jG8n+rG
         QOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PohIKHFK8kNViEgt/D+xrQCt40xHvnwTaUyMochPjiM=;
        b=p1upWEbBBNJD1oUjMf038g9bXRG4r3me50BPYi1yLwNHyxLqVlifcCYnl2PduyPBM2
         +RCDxcI+Eo/aDvwLBgT/cjAgt5vTOTM2TkEos0kW5Wd/IOdkVZyyShOX7AwKucUyFtTe
         YusCB6J+oPVANmtsa1UL2hCTJ9xhn+VhaMgdYopXA2GIUvd7EuYepsbZ4JirqgFChAkI
         OmC5XWBv3OThjWdg3D4SdUKvS1XCQYew7Y8a9htS7t6iIFATp5qpRXoxtEs60Z3jaUfK
         pzMuD2fuC49+taNgGGD9YMMphtOlbOLiDAEMpfFrGsPBsg85lGtb3eB/LWCZWjRPXjlD
         Ws4A==
X-Gm-Message-State: AOAM5317agbhctVm0ecHGSqjN1s0kXR9eUs3K7uOvQJSJKBNagCW9ZpV
        0au8DjY++fSqyn0e+RBzVM8=
X-Google-Smtp-Source: ABdhPJwkZuIjLkHxAB9H6R1apOtg0S0HDLm4nUz7zGVbohLhQNp+Jq7Dt3br7y0CvdRfrwij6ryrvw==
X-Received: by 2002:a63:b44f:: with SMTP id n15mr2564965pgu.282.1600759666612;
        Tue, 22 Sep 2020 00:27:46 -0700 (PDT)
Received: from localhost ([2409:4050:2e9a:cd41:aceb:49c:d6fb:ea72])
        by smtp.gmail.com with ESMTPSA id ih12sm1428926pjb.24.2020.09.22.00.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 00:27:45 -0700 (PDT)
From:   Piyush Goyal <piyushgoyaliit@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] stress-shm-sysv: exercise shmat with all possible flags
Date:   Tue, 22 Sep 2020 12:57:29 +0530
Message-Id: <20200922072730.68911-2-piyushgoyaliit@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922072730.68911-1-piyushgoyaliit@gmail.com>
References: <20200922072730.68911-1-piyushgoyaliit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exercise shmat syscall with all possible flags resulting in more kernel
coverage.

Signed-off-by: Piyush Goyal <piyushgoyaliit@gmail.com>
---
 stress-shm-sysv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/stress-shm-sysv.c b/stress-shm-sysv.c
index 5a3e0cc1..9efaa091 100644
--- a/stress-shm-sysv.c
+++ b/stress-shm-sysv.c
@@ -139,6 +139,16 @@ static void exercise_shmat(int shm_id)
 	/* Exercise shmat syscall with invalid flags */
 	addr = shmat(shm_id, NULL, ~0);
 	(void)addr;
+
+	/* Exercise shmat with all possible values of flags */
+	addr = shmat(shm_id, NULL, SHM_RDONLY);
+	(void)addr;
+
+	addr = shmat(shm_id, NULL, SHM_EXEC);
+	(void)addr;
+
+	addr = shmat(shm_id, NULL, SHM_RND);
+	(void)addr;
 }
 
 #if defined(__linux__)
-- 
2.25.1

