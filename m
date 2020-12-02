Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CFC2CB982
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbgLBJoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388601AbgLBJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:44:46 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B0AC061A55
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:44:19 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id r9so696368pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlX6/dUBp4V7NccOfxayBKu6ql0r7Sno2otMyRjZDtk=;
        b=fxoWoJ6XnyCFTBwICbKaSS3cycg5+uuhPrznurEyFI86CB+6r+lRiKhkX1gpxwbCP1
         OcRzqoFF7bpCs+vuAHL3NtTnOste9oD4Nk5ZB4IJtrTo1HmHKJxEvLv93tm32YG/IAgR
         k2LHFDDAgAtY9rd7P0xFvZKKT+QyAHbBpWrKNK5AAT2qPKAUb1gRxAHiqJTbLARIWDgU
         GYzPQfNH0HqTyfD2qLDg3qjD4Tx+o+h16VH5jeHsnIYWM9zl2A47zHZ3PbA7mUWFe3uZ
         v8I5NVJ81DXy6dGlbEDRiTeqICiHue3z/jZw+wfFaFMGMOLnx1XCkKm2R+ME8vkV4T/N
         /KYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlX6/dUBp4V7NccOfxayBKu6ql0r7Sno2otMyRjZDtk=;
        b=Zu5Q0vRbM5hvIAuEfp5kyzmoZCZzd4NJ705XU0OU8EMfeThBaIa1xzTUR7wRUKQXV7
         gQYxlbqyB5g9mqGOWXBtV7j9zCQybfEXMCBki3+Cy+jcdTgxgiek7+gnvGnnyIZ6Yprt
         ObPUP0o5qrU9hW+YtLS5fszaxWPtr9+ACTZrr6TMmrvm/K6KsUBjCli+ZoGtO67KeCBD
         v6QdB554imHGbz0S8iX5JNkVIMUFh5lz7B69y3PR6IS3phUu0PBXSdiNicpMSRZzLSV7
         RaSdsSiSi/ErRdMJWBIm5GlXS3E9FKYr31cTZUkIJYAqxD3NRAqm5zBL8TPRKmclIXyU
         cNIA==
X-Gm-Message-State: AOAM530J8C0kcjVIZiRvKzLbRIWph/sGOVmTvlALLo27u5P6pQW6s5YP
        G47vyP2WgqFxUbYwYwTalKFB
X-Google-Smtp-Source: ABdhPJxZ5r6xoQLjrn+7C1TcMCPMd+z0BINEZ9nt8PnsrMxGjmTqt8aEBIh45KpBXYTP1GC/dd1dEA==
X-Received: by 2002:a17:90a:9e5:: with SMTP id 92mr1645248pjo.176.1606902259173;
        Wed, 02 Dec 2020 01:44:19 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:44:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 28/29] bus: mhi: core: Fix error handling in mhi_register_controller()
Date:   Wed,  2 Dec 2020 15:11:58 +0530
Message-Id: <20201202094159.107075-29-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

There are a few problems with the error handling in this function.  They
mostly center around the alloc_ordered_workqueue() allocation.
1) If that allocation fails or if the kcalloc() prior to it fails then
it leads to a NULL dereference when we call
destroy_workqueue(mhi_cntrl->hiprio_wq).
2) The error code is not set.
3) The "mhi_cntrl->mhi_cmd" allocation is not freed.

The error handling was slightly confusing and I re-ordered it to be in
the exact mirror/reverse order of how things were allocated.  I changed
the label names to say what the goto does instead of describing where
the goto comes from.

Fixes: 8f7039787687 ("bus: mhi: core: Move to using high priority workqueue")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 96cde9c0034c..f0697f433c2f 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -871,7 +871,7 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 				     sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
 	if (!mhi_cntrl->mhi_cmd) {
 		ret = -ENOMEM;
-		goto error_alloc_cmd;
+		goto err_free_event;
 	}
 
 	INIT_LIST_HEAD(&mhi_cntrl->transition_list);
@@ -886,7 +886,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 				("mhi_hiprio_wq", WQ_MEM_RECLAIM | WQ_HIGHPRI);
 	if (!mhi_cntrl->hiprio_wq) {
 		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate workqueue\n");
-		goto error_alloc_cmd;
+		ret = -ENOMEM;
+		goto err_free_cmd;
 	}
 
 	mhi_cmd = mhi_cntrl->mhi_cmd;
@@ -932,7 +933,7 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs,
 			   SOC_HW_VERSION_OFFS, &soc_info);
 	if (ret)
-		goto error_alloc_dev;
+		goto err_destroy_wq;
 
 	mhi_cntrl->family_number = (soc_info & SOC_HW_VERSION_FAM_NUM_BMSK) >>
 					SOC_HW_VERSION_FAM_NUM_SHFT;
@@ -946,7 +947,7 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	mhi_cntrl->index = ida_alloc(&mhi_controller_ida, GFP_KERNEL);
 	if (mhi_cntrl->index < 0) {
 		ret = mhi_cntrl->index;
-		goto error_ida_alloc;
+		goto err_destroy_wq;
 	}
 
 	/* Register controller with MHI bus */
@@ -954,7 +955,7 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	if (IS_ERR(mhi_dev)) {
 		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate MHI device\n");
 		ret = PTR_ERR(mhi_dev);
-		goto error_alloc_dev;
+		goto err_ida_free;
 	}
 
 	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
@@ -967,7 +968,7 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 
 	ret = device_add(&mhi_dev->dev);
 	if (ret)
-		goto error_add_dev;
+		goto err_release_dev;
 
 	mhi_cntrl->mhi_dev = mhi_dev;
 
@@ -975,19 +976,17 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 
 	return 0;
 
-error_add_dev:
+err_release_dev:
 	put_device(&mhi_dev->dev);
-
-error_alloc_dev:
+err_ida_free:
 	ida_free(&mhi_controller_ida, mhi_cntrl->index);
-
-error_ida_alloc:
+err_destroy_wq:
+	destroy_workqueue(mhi_cntrl->hiprio_wq);
+err_free_cmd:
 	kfree(mhi_cntrl->mhi_cmd);
-
-error_alloc_cmd:
-	vfree(mhi_cntrl->mhi_chan);
+err_free_event:
 	kfree(mhi_cntrl->mhi_event);
-	destroy_workqueue(mhi_cntrl->hiprio_wq);
+	vfree(mhi_cntrl->mhi_chan);
 
 	return ret;
 }
-- 
2.25.1

