Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4E27A634
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgI1ELO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgI1ELM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:11:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6501C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so2782188pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8QQquLL4oGKh6uhiaB6MoxZtKFnQbbrDA+3b3PoVuU=;
        b=wHCNDEXc26IQgoaQXav00ZFDq34qWtVx/rMNeAqTVCeEQn1jDIcUkssuKyMSFb8wo4
         GZZRpP8R3cHqKa/q2KYfUViMTiKKMUv9ZJK4Nl6H21T7kxlVs8ttkwScVYayrODPge4Y
         dEqx5z7JKjxt74LTIEDXRN8M7JQZTU4GtEGB/36bTgx8AypwrYQTZHgu/z2aBbYHyqHE
         U/4A56vQo2uvOkXY+nEimuOvffYXp5uCP8+CVO86+72i2SEHCsB+OrhLmTONM6nLlgpv
         wD6REPCmvirZur2bejFhNC1ZDjzVdKQszHT0gS6I1zpERM6BSWKV2lyKe/ykVjAvYFF0
         tksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8QQquLL4oGKh6uhiaB6MoxZtKFnQbbrDA+3b3PoVuU=;
        b=VrF1jPenbSEOee2AN7nVaTIpa7lBd3JtP8OEQ1uRbIDnTgPeUz0/7roBrwIeT0GMZS
         rU1yuqXHxPGTvNEFo/67G/bAP9X5yuv6YnYu8z338179F/mTxJ11i/BC2njyBMu9Xlz9
         N62/QWs9vo3Jktb6TcE0v2KPceMMMbREE184C9ojMglpq8Wz4eVbbBNIPg2HRikkqxEc
         aOzbzKjbpWH6S+g7b9ad9dz8BIcJE4YRCwt+EXDgIZPtgSI1A35Sr3+suEGeOgCYjEFF
         V3nPwJaDqyrpfstS15v6D15qJWPPngAAmIpdH5Gj2q57GxScsA+oomxJrFsTaDSQcYkD
         uZWA==
X-Gm-Message-State: AOAM532ZwaOUoJAkaq4mllIdR26ywZ05RYbkp/VivlTowC8T6h3PZmW5
        FuXGZIQJ3go0CxqbEbOgSEKIgYY0SWec
X-Google-Smtp-Source: ABdhPJyLIm54o21Pm7IrO14eOqYhVc2i0HrUBOlquw1kD5bFIE3B3HsVxXDQe/GnwqNf7FM6T+1Ugg==
X-Received: by 2002:a17:90b:693:: with SMTP id m19mr7496580pjz.111.1601266271389;
        Sun, 27 Sep 2020 21:11:11 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:11:10 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 10/21] bus: mhi: core: Introduce APIs to allocate and free the MHI controller
Date:   Mon, 28 Sep 2020 09:39:40 +0530
Message-Id: <20200928040951.18207-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
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

