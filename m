Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59B52DC80F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgLPU7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgLPU7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:59:12 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E9BC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 12:58:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b5so2386642pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 12:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P9R+cWBGvXHezZdHxcab5kbkTY0ATaT6KbnH/O3ZSWI=;
        b=RSMrxpzgREVFEv0pTiylxvMLgVwmE62E4mt64HQ9ZUptz2T49QJ8gapfQUWC//xGpN
         TWeHw3JFn0sNarDvjdTT65NawA/DA9nZOjMUe7ilruh5SHnS0c7jilWAAOCzC5TS1m0p
         4CzFMmMYRDE2DDEPPMTP3bFZ6r6o2YRZY8FKfiFibniYcbMkNjgXC+bVU6Mmeqgjo+W+
         zLJYhQPymCPp0BsR5JxYfXZniJ+jgWBOJfISfid7/Za4MVWZ1b/+bFASQXusPECDlPbU
         vq8H0chTJsbPE05fjNE80BEieHsWicVSi4dtLF0Nn2Oj7tJ3Hvx2uJTkyRwPMJuUEyHB
         1SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P9R+cWBGvXHezZdHxcab5kbkTY0ATaT6KbnH/O3ZSWI=;
        b=ltomYHhPiDRjuwo8QgcIReC+33A4S2NevYtVYCadNVuiz1P3e4MZ/DlUxW0O62uLBz
         ZOiekbHrfpgNREsD+zuN2yP5PeTtSacStwFU1Dm5KInml1MQVReUipwM/YVmuyZ/JNwG
         k5MUsBuAjLP4H82aS8pc8V9/9GXG1fZIdBVKm14klzJk9IEziOEA5plhPs0lCjuJoqbE
         a/qOQdC1AuS2o7gEt/ctOuqjPsHpRa5BNALPq0amZiQuE8ZevwXQiSiLmclHZomqvu0p
         uqI3MLoG0xS1atfuqGyeJCjdh4fFKmgedxHoO8zRKz1jyjuqcsIQjOAT+ume48wTVqKY
         fEJQ==
X-Gm-Message-State: AOAM5337Yqw/IowpYo/e6V0CPlbKTQQyyHAqovnuGpXCzhsQjdxFJmuP
        av/sm5yu+XcHumnZ1i7sqOM67M+0q2YsSw==
X-Google-Smtp-Source: ABdhPJwWnLyEJeiH1c3tVylNxd4b+1CwINcuiUCtznkRYUcDx+kLyBH6vGNllQTBjtudsYHSTs8OxA==
X-Received: by 2002:a17:90a:bf05:: with SMTP id c5mr4583531pjs.95.1608152312289;
        Wed, 16 Dec 2020 12:58:32 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id fs12sm2866598pjb.49.2020.12.16.12.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:58:31 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
X-Google-Original-From: Jim Quinlan <james.quinlan@broadcom.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt
Date:   Wed, 16 Dec 2020 15:58:02 -0500
Message-Id: <20201216205805.4221-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216205805.4221-1-james.quinlan@broadcom.com>
References: <20201216205805.4221-1-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
message to be indicated by an interrupt rather than the return of the smc
call.  This accommodates the existing behavior of the BrcmSTB SCMI
"platform" whose SW is already out in the field and cannot be changed.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/firmware/arm_scmi/smc.c | 38 ++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 82a82a5dc86a..fd41d436e34b 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -9,9 +9,11 @@
 #include <linux/arm-smccc.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/slab.h>
 
 #include "common.h"
@@ -23,6 +25,8 @@
  * @shmem: Transmit/Receive shared memory area
  * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
  * @func_id: smc/hvc call function id
+ * @irq: Optional; employed when platforms indicates msg completion by intr.
+ * @tx_complete: Optional, employed only when irq is valid.
  */
 
 struct scmi_smc {
@@ -30,8 +34,19 @@ struct scmi_smc {
 	struct scmi_shared_mem __iomem *shmem;
 	struct mutex shmem_lock;
 	u32 func_id;
+	int irq;
+	struct completion tx_complete;
 };
 
+static irqreturn_t smc_msg_done_isr(int irq, void *data)
+{
+	struct scmi_smc *scmi_info = data;
+
+	complete(&scmi_info->tx_complete);
+
+	return IRQ_HANDLED;
+}
+
 static bool smc_chan_available(struct device *dev, int idx)
 {
 	struct device_node *np = of_parse_phandle(dev->of_node, "shmem", 0);
@@ -51,7 +66,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	struct resource res;
 	struct device_node *np;
 	u32 func_id;
-	int ret;
+	int ret, irq = 0;
 
 	if (!tx)
 		return -ENODEV;
@@ -79,10 +94,29 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * If there is an interrupt named "a2p", then the
+	 * service and completion of a message is signaled by an interrupt
+	 * rather than by the return of the SMC call.
+	 */
+	ret = of_irq_get_byname(cdev->of_node, "a2p");
+	if (ret > 0) {
+		irq = ret;
+		ret = devm_request_irq(dev, irq, smc_msg_done_isr,
+				       IRQF_NO_SUSPEND,
+				       dev_name(dev),
+				       scmi_info);
+		if (ret) {
+			dev_err(dev, "failed to setup SCMI smc irq\n");
+			return ret;
+		}
+		init_completion(&scmi_info->tx_complete);
+	}
 	scmi_info->func_id = func_id;
 	scmi_info->cinfo = cinfo;
 	mutex_init(&scmi_info->shmem_lock);
 	cinfo->transport_info = scmi_info;
+	scmi_info->irq = irq;
 
 	return 0;
 }
@@ -111,6 +145,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	shmem_tx_prepare(scmi_info->shmem, xfer);
 
 	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (scmi_info->irq)
+		wait_for_completion(&scmi_info->tx_complete);
 	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
 
 	mutex_unlock(&scmi_info->shmem_lock);
-- 
2.17.1

