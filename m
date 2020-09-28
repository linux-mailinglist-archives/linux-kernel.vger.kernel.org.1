Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95127A632
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgI1ELK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgI1ELH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:11:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A799AC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fa1so2824797pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y1HDeSf7eMJfSl6ZK/D9lqct6zJN8sO0bd/DmJuThzk=;
        b=GWmJumpQNYDpkW+si2fcpKk90e7hbuTjKyNSdHcpiMp7cEBlXKXGhvmL/JJrTTBPR4
         8lQckHiKQ3Io3UHTz9Gp3aeigNONs/l+P7+3pXxwYSbWNFAvoepYa7ZnSytuZKo9e7AU
         vz+l2KOOBr2hy0NE2PjXRaT1BydvQZGyo/klKGx0oL/ch6h6igLP7TtZg+XnnnFL/lkm
         8ILMpZ7/3d6uKABUgk48/M5b4iGkEuPIKiq4r7gCxcJgGfrFyIL52QUKksYqt5Fp7u6I
         rnhbxcxXgxwq+tZwQqyrGjjwCu+a/DY3Iy0IVoetyWtn97nOddAZWHlEAHKZMezpBWnU
         KdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1HDeSf7eMJfSl6ZK/D9lqct6zJN8sO0bd/DmJuThzk=;
        b=nrXyX3KWo0vQXlndSJrY9C6DvWBG6zBpPcGfhyMy0vZO3AKNkRx0rENVYsPO/RuyI6
         2m4AWRwBHwYk1xaouT9HNdT7xM07NBpmMCEiNG8exEmVzQ5+9sMZItkzmO+xDh0mb5n1
         f5GmWbEe+VYWrhHcIaA08nuNlD7ub2PyMGUfo2FV3mf5Q3bR70dFPpJIFA3RWitSZvmR
         JPIbbleFfm64+kqmwGzpJODEknCyYbMpoIQH+q9+plF6k6wAD/r9BTnVHWC2Z2DGUDsS
         KJpYnPGD9C0RA4nwPD/P5gtAALSMFj0UjgTnaYu/YrQsuwuYXpsDDAgEYUv0amyWYqIJ
         /qcQ==
X-Gm-Message-State: AOAM5338U6cS93LHyp1jIbV0N8lBhVNG+5GZxeF1DvXLuYrJXUemIAOb
        pAm2WLfn74zHpY9f0zyBsMw0
X-Google-Smtp-Source: ABdhPJx3Uzp+u6iVp2aTZdDvgZro+BN+JLXttA1Njr02Hi37JBxDdySbXYKvdzb0x1fOkjcTRLC0RQ==
X-Received: by 2002:a17:90a:c705:: with SMTP id o5mr7853978pjt.68.1601266266730;
        Sun, 27 Sep 2020 21:11:06 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:11:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 09/21] bus: mhi: core: Read and save device hardware information from BHI
Date:   Mon, 28 Sep 2020 09:39:39 +0530
Message-Id: <20200928040951.18207-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Device hardware specific information such as serial number and the OEM
PK hash can be read using BHI and saved on host to identify the
endpoint.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/boot.c | 17 ++++++++++++++++-
 include/linux/mhi.h         |  6 ++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 0b38014d040e..24422f5c3d80 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -392,13 +392,28 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	void *buf;
 	dma_addr_t dma_addr;
 	size_t size;
-	int ret;
+	int i, ret;
 
 	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		dev_err(dev, "Device MHI is not in valid state\n");
 		return;
 	}
 
+	/* save hardware info from BHI */
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_SERIALNU,
+			   &mhi_cntrl->serial_number);
+	if (ret)
+		dev_err(dev, "Could not capture serial number via BHI\n");
+
+	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++) {
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_OEMPKHASH(i),
+				   &mhi_cntrl->oem_pk_hash[i]);
+		if (ret) {
+			dev_err(dev, "Could not capture OEM PK HASH via BHI\n");
+			break;
+		}
+	}
+
 	/* If device is in pass through, do reset to ready state transition */
 	if (mhi_cntrl->ee == MHI_EE_PTHRU)
 		goto fw_load_ee_pthru;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index c56b4447a4e9..0c97f4bc5fae 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -16,6 +16,8 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
+#define MHI_MAX_OEM_PK_HASH_SEGMENTS 16
+
 struct mhi_chan;
 struct mhi_event;
 struct mhi_ctxt;
@@ -316,6 +318,8 @@ struct mhi_controller_config {
  * @device_number: MHI controller device number
  * @major_version: MHI controller major revision number
  * @minor_version: MHI controller minor revision number
+ * @serial_number: MHI controller serial number obtained from BHI
+ * @oem_pk_hash: MHI controller OEM PK Hash obtained from BHI
  * @mhi_event: MHI event ring configurations table
  * @mhi_cmd: MHI command ring configurations table
  * @mhi_ctxt: MHI device context, shared memory between host and device
@@ -394,6 +398,8 @@ struct mhi_controller {
 	u32 device_number;
 	u32 major_version;
 	u32 minor_version;
+	u32 serial_number;
+	u32 oem_pk_hash[MHI_MAX_OEM_PK_HASH_SEGMENTS];
 
 	struct mhi_event *mhi_event;
 	struct mhi_cmd *mhi_cmd;
-- 
2.17.1

