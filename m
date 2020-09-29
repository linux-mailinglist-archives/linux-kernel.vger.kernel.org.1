Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3312A27D510
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgI2RxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgI2RxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:53:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F37EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:53:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so5309200pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y1HDeSf7eMJfSl6ZK/D9lqct6zJN8sO0bd/DmJuThzk=;
        b=VuuIe3Wtfr2EIlZlKLTeY2sJ2IfdF+t63kwOnjXC3MIwLv7u0IoUgfhPVIcolwW7mF
         HnonW/0dVJGEOIl9dPosA7jLQu2VwzJIQZsE7NFdZzEieSnIWzKzwjFTzKxNG034sxhm
         jaJRNnTpdeS225Bw0ef+EEEnayuYX0gsYS1F/ytIQexYk5GRDiWkXHh9JVTKfHYzoZe4
         GwHjPX5JO2SbyFJoRZ4ekOCoAYw+/C9g8PdmprqeNnxFlXO9mSRUH9yd9ayL8CDzUpDB
         NEFpG3vqWD5ItmmHTxRi+WbjEOfuFp/2rVEIWo5+MGk+hMqfQJSIHAuH9Aux4eVG5/WN
         NAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1HDeSf7eMJfSl6ZK/D9lqct6zJN8sO0bd/DmJuThzk=;
        b=qBY6B6HZ+bZoM9Cn2br5iUVwhHSSZGFYgsxK3YLclhsNUT3+E5vLcgm43uaL/gxd3I
         kXcLuwqUec3SRI8/k+TsLXzUOKhDfh3wTGL/O0vrhDgWPEqxuD8IlaSfVslNocp71OZo
         NXuxqQmpekxDvnqRcxtoup22iXQABGFEL0alOqHt2KVdUDWX470hkHcI+/Lyze0DgOD/
         c8+V9OD9r+5tKM1eAJc1/JpHqVVwYnfkeAdzucQGJ3gHU0TfEr24gn7WVn8IF2OYCgd+
         +eFLjtlY6yUfY6XQ4LUSGhy7lBOVP8cewm5YqMkyO5IIUUfPDYkV859rIk99W6VZ21OV
         fRdw==
X-Gm-Message-State: AOAM5316nM1DVdCW4vGR0AX4ZDr3QfoMazW9q9J95R06pWxGogIsDUWj
        QnC4whYj8a7KCrZG7bjhLdE/2Dgq42BnvRg=
X-Google-Smtp-Source: ABdhPJyxZwS4UjRxdX7l1ElQMUC769Y1++Fz7aDKgJTkBJJ+52cCdZDDUfF4B4/3/EZZBbgEmNtKbg==
X-Received: by 2002:a17:902:be0c:b029:d2:8ceb:f39c with SMTP id r12-20020a170902be0cb02900d28cebf39cmr5645119pls.71.1601401986990;
        Tue, 29 Sep 2020 10:53:06 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:53:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 09/19] bus: mhi: core: Read and save device hardware information from BHI
Date:   Tue, 29 Sep 2020 23:22:08 +0530
Message-Id: <20200929175218.8178-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
References: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
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

