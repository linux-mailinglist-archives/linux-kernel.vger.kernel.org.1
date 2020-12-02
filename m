Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F82CB984
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbgLBJo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388583AbgLBJon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:44:43 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F33EC061A53
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:44:15 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v1so704833pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFDUiEsizbJwRk40uj2Hkrxtol83gwE9Deu7VwozJVw=;
        b=TKAWWG7AhUD30Z6KbqUPdzYUjh8jLepc3fai+vHXiYkmzTx3LWs0F+fd22l06ffc1e
         IPGYlVv2kS/wW/HwLp4LjUcBcBFEwwVUJjmJCmMDiGBWctL/7k1eQTYmri0OrC6KeVov
         cgt5P+oSBUntOm6QrYR8jEkkii2aroh4YtmoHseazXzVhAhlsM0DGbpk8eVy4G78Q7ot
         uDRuwj8Nfqz17UDIDKvtEUQH9/M0nyLnflJICx5suj3YYj4T0bpzlebWreWvAS8jzurJ
         DVioaV3eFMGl9paIjPzZCBbB/qGxQ/8CJ/nDwMZ3xfwzsJ/Xcy6hYvvGxPCGI6RLLvnq
         0BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFDUiEsizbJwRk40uj2Hkrxtol83gwE9Deu7VwozJVw=;
        b=DcnoFdU2JD6jOlCJr5L7rwOnRA1RXsfq1r6/2CZWugcLFcn2z5cw+i/2S7ozTghp30
         36exc3B2NJmromRoiTTZerhWQ6FyVUxd+DKwpWBE4SyZjWvbEjHEnke9vCRLwGPTsnza
         aHWQd/lSbkZbmel1CpFgptnTWYTGtHB3TuI1gDFFcjLOi+S3ljhcDTfUFv9wX9lnsb4R
         YHm2QkhzgAN7eSVCPy0d4fsocdr9Cu1vFeWbToKoz9jXq3kK1ohdAZxfjBNsqPnrJEMO
         oykBqE7SASU81jtmQ6i/CjZbwZxmp5WYHt8d6dZ0uzc8ihull74OIT6hZBpIvF5Rwt7S
         mPig==
X-Gm-Message-State: AOAM532MPIGEmPPwvjJwMkMY3DlRvCnlg0pH406IN3yyFU+GOtULU6/W
        +tYGcNzSBqp+c/UZFkuDlOnU
X-Google-Smtp-Source: ABdhPJxyTxdZJ7OW2Ru/Ekbfqv8mXtmrllbPPQssLZKyHwxGeilnlT8ZiT3PKRJS16XCn5n5rXFOHw==
X-Received: by 2002:a17:90b:90f:: with SMTP id bo15mr1590769pjb.148.1606902254777;
        Wed, 02 Dec 2020 01:44:14 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:44:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 27/29] bus: mhi: core: Fix device hierarchy
Date:   Wed,  2 Dec 2020 15:11:57 +0530
Message-Id: <20201202094159.107075-28-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

This patch fixes the hierarchical structure of MHI devices. Indeed,
MHI client devices are directly 'enumerated' from the mhi controller
and therefore must be direct descendants/children of their mhi
controller device, in accordance with the Linux Device Model.

Today both MHI clients and controller devices are at the same level,
this patch ensures that MHI controller is parent of its client devices.

The hierarchy is especially important for power management (safe
suspend/resume order). It is also useful for userspace to determine
relationship between MHI client devices and controllers.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/debugfs.c |  4 +++-
 drivers/bus/mhi/core/init.c    | 10 +++++++++-
 drivers/bus/mhi/core/pm.c      |  4 ++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/core/debugfs.c b/drivers/bus/mhi/core/debugfs.c
index 3a48801e01f4..7d43138ce66d 100644
--- a/drivers/bus/mhi/core/debugfs.c
+++ b/drivers/bus/mhi/core/debugfs.c
@@ -159,7 +159,9 @@ static int mhi_debugfs_devices_show(struct seq_file *m, void *d)
 		return -ENODEV;
 	}
 
-	device_for_each_child(mhi_cntrl->cntrl_dev, m, mhi_device_info_show);
+	/* Show controller and client(s) info */
+	mhi_device_info_show(&mhi_cntrl->mhi_dev->dev, m);
+	device_for_each_child(&mhi_cntrl->mhi_dev->dev, m, mhi_device_info_show);
 
 	return 0;
 }
diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 1d6f7b6c1fcd..96cde9c0034c 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1144,7 +1144,15 @@ struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
 	device_initialize(dev);
 	dev->bus = &mhi_bus_type;
 	dev->release = mhi_release_device;
-	dev->parent = mhi_cntrl->cntrl_dev;
+
+	if (mhi_cntrl->mhi_dev) {
+		/* for MHI client devices, parent is the MHI controller device */
+		dev->parent = &mhi_cntrl->mhi_dev->dev;
+	} else {
+		/* for MHI controller device, parent is the bus device (e.g. pci device) */
+		dev->parent = mhi_cntrl->cntrl_dev;
+	}
+
 	mhi_dev->mhi_cntrl = mhi_cntrl;
 	mhi_dev->dev_wake = 0;
 
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index a671f585ce35..681960c72d2a 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -504,7 +504,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 	wake_up_all(&mhi_cntrl->state_event);
 
 	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
-	device_for_each_child(mhi_cntrl->cntrl_dev, NULL, mhi_destroy_device);
+	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
 
 	mutex_lock(&mhi_cntrl->pm_mutex);
 
@@ -637,7 +637,7 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 	wake_up_all(&mhi_cntrl->state_event);
 
 	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
-	device_for_each_child(mhi_cntrl->cntrl_dev, NULL, mhi_destroy_device);
+	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
 
 	mutex_lock(&mhi_cntrl->pm_mutex);
 
-- 
2.25.1

