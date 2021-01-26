Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671A9303DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392322AbhAZM5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404042AbhAZMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D59C0698C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p15so9656916wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9Mu8Bh1YY8EtsX22yToiGMh//B01t5LgpZPGaTQ+Bo=;
        b=i0VO5mhW8uoKItgQm7dfy12wJVs5GTBAslNT7PWgwS7TuwlhdcxUEdQqzki08qZkQC
         YjgRfy3KrKwCInmXbDIeaD7G/dXs93oEphzBYGQUSygA36QZETV9s7KptEBUt6S0JNZu
         M6+xxyrs4nOFtD8+Imix14sya8zsehfGTyJ2XK1S8X8nW3zaYs9bwmVUQI0o2GeXnHKC
         rg/C/EKYFIsSHkFpHEuOuytKfxlsQGXqph8v6UwaSx+oAIvah6CGkuAvDoIudoy0ltnB
         ZJkrtDCYpdtu1tDrILXOYyq3NtO7A/E0hE8k8U+PntWoFwMM8QYxyL+D/qvpm12l8bRe
         8B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9Mu8Bh1YY8EtsX22yToiGMh//B01t5LgpZPGaTQ+Bo=;
        b=lEArWVPqBU8qGZoak2UZONesZvqrZ2i2LRX6xEtKwzAfAwfVjszyzziWkERWguNd96
         Z5cGRsUHsK0YLfW7z7XuWVWQ6KfEl/7DLeFWJNLiqmkawscBJAvfBmPr8soCFkeqx9ph
         8ZlMoIl8QWV1QFHEc+9tMOAKbR33C6sZvTbYbJPxIX3/lVQXVSILngjCms0c1E9+Qqfz
         mE1Lp66k2O9J8HTNATB/XL5PC0cgJ5AEmng2nP0BGm1LrBcH0pFLpkdfshILVr1ouAP1
         Gi19lujSohlL3UqLdfBSZ6p/JZmDqF22f6rr4jmjkwKAl5zXfg0sp3xdh8SQtFwuresF
         OMQw==
X-Gm-Message-State: AOAM533FqCYiQxVuiGArO1LBw78wI5qFgqxQCppTieAWZj6wY8LzwBVz
        Udgi5qTdd25zqjIGx6KYcLFtXE+j0rreTmAq
X-Google-Smtp-Source: ABdhPJw9ITUWt0EJXUR9dYh1AQKI+wsUulyl960WAdsqnnB/If5INkjPbVIRAIdpsX0AEOHvSxbPzQ==
X-Received: by 2002:adf:e610:: with SMTP id p16mr5840983wrm.169.1611665259013;
        Tue, 26 Jan 2021 04:47:39 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 03/20] RDMA/hw/hfi1/iowait: Demote half-completed kernel-doc and fix formatting issue in another
Date:   Tue, 26 Jan 2021 12:47:15 +0000
Message-Id: <20210126124732.3320971-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/iowait.c:52: warning: Function parameter or member 'tidfunc' not described in 'iowait_init'
 drivers/infiniband/hw/hfi1/iowait.c:52: warning: Function parameter or member 'wakeup' not described in 'iowait_init'
 drivers/infiniband/hw/hfi1/iowait.c:52: warning: Function parameter or member 'sdma_drained' not described in 'iowait_init'
 drivers/infiniband/hw/hfi1/iowait.c:52: warning: Function parameter or member 'init_priority' not described in 'iowait_init'
 drivers/infiniband/hw/hfi1/iowait.c:52: warning: Excess function parameter 'resume' description in 'iowait_init'
 drivers/infiniband/hw/hfi1/iowait.c:94: warning: Function parameter or member 'w' not described in 'iowait_set_work_flag'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/iowait.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/iowait.c b/drivers/infiniband/hw/hfi1/iowait.c
index 5836fe7b28177..1114898026140 100644
--- a/drivers/infiniband/hw/hfi1/iowait.c
+++ b/drivers/infiniband/hw/hfi1/iowait.c
@@ -26,7 +26,7 @@ inline void iowait_clear_flag(struct iowait *wait, u32 flag)
 	clear_bit(flag, &wait->flags);
 }
 
-/**
+/*
  * iowait_init() - initialize wait structure
  * @wait: wait struct to initialize
  * @tx_limit: limit for overflow queuing
@@ -88,7 +88,7 @@ void iowait_cancel_work(struct iowait *w)
 
 /**
  * iowait_set_work_flag - set work flag based on leg
- * @w - the iowait work struct
+ * @w: the iowait work struct
  */
 int iowait_set_work_flag(struct iowait_work *w)
 {
-- 
2.25.1

