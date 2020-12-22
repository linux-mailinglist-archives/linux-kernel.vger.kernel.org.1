Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F70E2E0C40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgLVO5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgLVO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:57:09 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26801C061248
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:56:13 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id w5so8523217pgj.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV7x9UfdRuqA/iQmTdVUBNaIN/CPGomT0d2jg4MjDb8=;
        b=regWSKkn/ylSxvlVizL+gK8gYy2DbuoMZ8kDvc/2cQylNuMnWCfLyAQeAsFF9W87hE
         XBZSVPKsKwiwjqECdTB9r/b7dDKE2aayvG2beyo9S4F+Yed8UdYJR5376HFeSAEws/xW
         J9u5qdrfWN2AJaMejC7ZnNrKLZveuEBktoRH0AGpXk7OJjlNPsfhE5wcIDmiaIvLybxU
         mWardfmCBWZ8SZS+xoTVjZshznfSfMhQXHsq8t8YlNoUtBEb4mCHp0UNskWtdEdow0Ha
         Tvvn0t+SqVNF4Jz58GxRsu8BG7vvBOVcM8oW6mdQa9tpipFGV8kWBFJVUDbMvJiEZrFm
         /XOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV7x9UfdRuqA/iQmTdVUBNaIN/CPGomT0d2jg4MjDb8=;
        b=YktkFKWEFAtV4CVRl/MXlSSMrqqhCuGeTWP78HcF2tBcPJBJdii93EWeV1AOmE5MNM
         4W/f1fPpy3ZFuaRRa9nxUBonaQLC5i6wkkWl5yYnQ3rrEFnz+ShkZMB9HtTpgpMBh5eq
         SSQjW0j2iF9/ttVEbcjQ2XXc0GeO/ZcR0eNXzCNhlM945kVvubBwzubBrGjRjs6fHity
         FEKYdoKjlKOptD7SciweiadGnzVWGbggtH/Z2e1wIcKzW615QGcVhUMq+C7VCfwnanZl
         L45Jcbx9hAAvbySaRpD76RRDn+RxVwwESQIsYSiVsQPVy2x9CkFrFJs4pPI+sD1Cbpjh
         n8Vw==
X-Gm-Message-State: AOAM533+onKK32k3C21uW8Qm5YJwKP1eWydaUfiynEeLDCLTId6ZZ94T
        gQZy8b0PzZvm7raTWIFFNiQ=
X-Google-Smtp-Source: ABdhPJzAfYgTB2acEP+ERN90ZC9VOBebWGN7Ivs5cj6/3dE8QBNJdlWRSnEI+/BH0lXAxxSaEUFQJA==
X-Received: by 2002:a63:3648:: with SMTP id d69mr20201786pga.155.1608648972788;
        Tue, 22 Dec 2020 06:56:12 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id k15sm21340349pfp.115.2020.12.22.06.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:56:12 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     linux-arm-kernel@lists.infradead.org (open list:SYSTEM CONTROL &
        POWER/MANAGEMENT INTERFACE Mes...),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/2] firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt
Date:   Tue, 22 Dec 2020 09:56:03 -0500
Message-Id: <20201222145603.40192-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222145603.40192-1-jim2101024@gmail.com>
References: <20201222145603.40192-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
message to be indicated by an interrupt rather than the return of the smc
call.  This accommodates the existing behavior of the BrcmSTB SCMI
"platform" whose SW is already out in the field and cannot be changed.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
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

