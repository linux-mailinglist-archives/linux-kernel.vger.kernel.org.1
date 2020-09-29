Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DB427D511
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgI2RxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgI2RxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:53:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ABEC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:53:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w7so5321390pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8QQquLL4oGKh6uhiaB6MoxZtKFnQbbrDA+3b3PoVuU=;
        b=w+L+sbwyRqd/kUR4yOGRGKdcsW/vsqagEE4b5dBd+YZKGnvdQsXZIBd9wcC/ybuR9j
         T7xFQt1xsUbYCz6dxITSbJakrbbfwg2yt9unakKKSuoKQMy1GZVgxjwaBMavfEw3i4Tr
         NAVXHpX/AC9aIGapsZW9STs+y+0B+nydyTceAKIzdjNjN7rbitqaaa39jv/LriDADxOV
         B6aytMZypc8wlDkBQNAk6DFmC8bh/tqG9Cbtmz7IwF6+7wR5dM0hkUuSIhqCM/f84Mle
         nvTVPOwkFfK6KEEGSt5gWB25g3UPqYFyYV7Z6pNumelyFgweCgn5uFCVthcy5Jom+UIG
         eESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8QQquLL4oGKh6uhiaB6MoxZtKFnQbbrDA+3b3PoVuU=;
        b=c14eQl5mr/jESbU/GtlUWuqH5VHrrALzSSyiN9oJ9GYPT9pKdLL74eun49v4sOF6QQ
         QuDHARspXISWVLvqGzrAj4IcmRsf8zpKIHO+bHhbdclR3sTh1dg8P8UTdOGPeFAxGD4y
         NTxOFh9zY4HhlAUJgLefYIhVsEi3gkDD9FqJtcbPT8H9ZnMDSM9Xu1bKpqbVT1RWfXHu
         Nnf5K1Yg6NKWhlRw0Bn5r9uiPG+fPLTae3d8wpbtw2EerH76Ts/loSUsGCeud+FuTA6a
         0mjxiEQ16Ri87dTfS8jFqs+HxTXJoKeRjhMLh8jIxnt4ENmLg+ZUJJx3EzJFUv9rCKKt
         ZDrQ==
X-Gm-Message-State: AOAM531UdSlwGdRj6rSHtN8ot/zTe8Yvq78DJDRUUDE2YZOJcoUHxoGe
        zTiDJQMmdXxT13XklxwacjUM
X-Google-Smtp-Source: ABdhPJzXApVxJD/OdfawaQJ6lvpnhJEEL/Vu27J/Mxk/eyfZZxlBsNg5eOebe+WoBS9z3WuVZsiAUA==
X-Received: by 2002:a65:4642:: with SMTP id k2mr3992637pgr.41.1601401991461;
        Tue, 29 Sep 2020 10:53:11 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:53:10 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 10/19] bus: mhi: core: Introduce APIs to allocate and free the MHI controller
Date:   Tue, 29 Sep 2020 23:22:09 +0530
Message-Id: <20200929175218.8178-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
References: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Client devices should use the APIs provided to allocate and free
the MHI controller structure. This will help ensure that the
structure is zero-initialized and there are no false positives
with respect to reading any values such as the serial number or
the OEM PK hash.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 16 ++++++++++++++++
 include/linux/mhi.h         | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index e2011ec46b92..f69a2f3d039d 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -954,6 +954,22 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
 }
 EXPORT_SYMBOL_GPL(mhi_unregister_controller);
 
+struct mhi_controller *mhi_alloc_controller(void)
+{
+	struct mhi_controller *mhi_cntrl;
+
+	mhi_cntrl = kzalloc(sizeof(*mhi_cntrl), GFP_KERNEL);
+
+	return mhi_cntrl;
+}
+EXPORT_SYMBOL_GPL(mhi_alloc_controller);
+
+void mhi_free_controller(struct mhi_controller *mhi_cntrl)
+{
+	kfree(mhi_cntrl);
+}
+EXPORT_SYMBOL_GPL(mhi_free_controller);
+
 int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 0c97f4bc5fae..6b987e8cc438 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -527,6 +527,18 @@ struct mhi_driver {
 #define to_mhi_driver(drv) container_of(drv, struct mhi_driver, driver)
 #define to_mhi_device(dev) container_of(dev, struct mhi_device, dev)
 
+/**
+ * mhi_alloc_controller - Allocate the MHI Controller structure
+ * Allocate the mhi_controller structure using zero initialized memory
+ */
+struct mhi_controller *mhi_alloc_controller(void);
+
+/**
+ * mhi_free_controller - Free the MHI Controller structure
+ * Free the mhi_controller structure which was previously allocated
+ */
+void mhi_free_controller(struct mhi_controller *mhi_cntrl);
+
 /**
  * mhi_register_controller - Register MHI controller
  * @mhi_cntrl: MHI controller to register
-- 
2.17.1

