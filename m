Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F361327372A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgIVAK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgIVAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:10:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B8C0613D7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y1so10444639pgk.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1V7VaXNtFFXe8hlbSXGaT097In9oJAOqPbj32nqcpU=;
        b=AIUvhMEJFjOVuta1N6sc8KE/xp8ukyZ6sIWYmrGd7iBrO3I2DJuZHCdgPrzdozjFUT
         nvlAxDD3Ieu5ZfG2EIuJiwwmMiUlHqTX0A4KRL2XWWzCmgsPCnC3EzSSvWiY2J0KYJYf
         VHWcRtolWIh3vZkVH0m3NfFmqdhwrrl+t6aaQypqjWqogvHwV09camR9HFtpUWuNnyUj
         EfKwgtRht6A3plnwII76X3UJaO1Fmwjkr8fSB28zFZNHUlbyP3tsXzJcN0wRCGpJU9G0
         qXlNMSrRjsj4UGa/Zkfzy6C35Wko9nnGZ3MySojdhRFrUFKJsDA61n5rUcLX6zAw+yrk
         5Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1V7VaXNtFFXe8hlbSXGaT097In9oJAOqPbj32nqcpU=;
        b=kQc5nFa7u47neeaKMRihNrPoMbrhyo8maJs7t1yQs/9ACKHo9hmTCvzocR6avCOAzC
         tlR/8qvG7jnVkr4CL4dobynTlThBdyjg8DpIKSzDFr1BxzQhvlmTq37v5IPoo9+/jiGd
         s6zTd8BxOWntH3/M0CTAjqlFjB3eJ3PQtJMQP7Jcg6aDfP711rgYX2daMA6rjAVcBzTz
         zkjFoXPpTd5RQwYMFGte8obZwgsYfuH3aFTKSij4Mck+7eBB8tJ1mBD3DLRZK1411y9k
         qqZdnA/hBN1kUl4uIREKnyrpLLC9WN+9kuBkyDKlYJgHVwZ3R5UzRgUF6Fsol2m6XE2Y
         FPKg==
X-Gm-Message-State: AOAM530w3e27g7uJ0Uxf3qQhkGeXOpvoPae6ActAsXb0TGrgOFUmkYcG
        xSyxNgpriy23lRcOwwyz1BQpVZpFyDaIDQ==
X-Google-Smtp-Source: ABdhPJxe247RM3m9j5Pu5KP/uAEbO0zFKdsKId6FIMQNcersUYg4lHDF9IwODr0fP3JB1K6iEZWwZw==
X-Received: by 2002:a63:7d5a:: with SMTP id m26mr1498809pgn.373.1600733411751;
        Mon, 21 Sep 2020 17:10:11 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c9sm12807953pfn.78.2020.09.21.17.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 17:10:11 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        guennadi.liakhovetski@linux.intel.com
Cc:     loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] rpmsg: core: Add RPMSG byte conversion operations
Date:   Mon, 21 Sep 2020 18:09:58 -0600
Message-Id: <20200922001000.899956-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922001000.899956-1-mathieu.poirier@linaro.org>
References: <20200922001000.899956-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPMSG device specific byte conversion operations as a first
step to separate the RPMSG name space service from the virtIO
transport layer.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c     | 51 ++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h | 12 ++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 50a835eaf1ba..66ad5b5f1e87 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -20,6 +20,57 @@
 
 #include "rpmsg_internal.h"
 
+/**
+ * rpmsg{16|32}_to_cpu()
+ * cpu_to_rpmsg[16|32}() - rpmsg device specific byte conversion functions to
+ *			   perform byte conversion between rpmsg device and the
+ *			   transport layer it is operating on.
+ */
+
+u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, u16 val)
+{
+	if (WARN_ON(!rpdev))
+		return -EINVAL;
+	if (!rpdev->ops || !rpdev->ops->transport16_to_cpu)
+		return -EPERM;
+
+	return rpdev->ops->transport16_to_cpu(rpdev, val);
+}
+EXPORT_SYMBOL(rpmsg16_to_cpu);
+
+u16 cpu_to_rpmsg16(struct rpmsg_device *rpdev, u16 val)
+{
+	if (WARN_ON(!rpdev))
+		return -EINVAL;
+	if (!rpdev->ops || !rpdev->ops->cpu_to_transport16)
+		return -EPERM;
+
+	return rpdev->ops->cpu_to_transport16(rpdev, val);
+}
+EXPORT_SYMBOL(cpu_to_rpmsg16);
+
+u32 rpmsg32_to_cpu(struct rpmsg_device *rpdev, u32 val)
+{
+	if (WARN_ON(!rpdev))
+		return -EINVAL;
+	if (!rpdev->ops || !rpdev->ops->transport32_to_cpu)
+		return -EPERM;
+
+	return rpdev->ops->transport32_to_cpu(rpdev, val);
+}
+EXPORT_SYMBOL(rpmsg32_to_cpu);
+
+u32 cpu_to_rpmsg32(struct rpmsg_device *rpdev, u32 val)
+{
+	if (WARN_ON(!rpdev))
+		return -EINVAL;
+	if (!rpdev->ops || !rpdev->ops->cpu_to_transport32)
+		return -EPERM;
+
+	return rpdev->ops->cpu_to_transport32(rpdev, val);
+}
+EXPORT_SYMBOL(cpu_to_rpmsg32);
+
 /**
  * rpmsg_create_channel() - create a new rpmsg channel
  * using its name and address info.
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 2e65386f191e..2f0ad1a52698 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -81,6 +81,8 @@ struct virtio_rpmsg_channel {
 
 /**
  * struct rpmsg_device_ops - indirection table for the rpmsg_device operations
+ * @transport{16|32}_to_cpu: byte conversion from rpmsg device to transport layer
+ * @cpu_to_transport{16|32}: byte conversion from transport layer to rpmsg device
  * @create_channel:	create backend-specific channel, optional
  * @release_channel:	release backend-specific channel, optional
  * @create_ept:		create backend-specific endpoint, required
@@ -92,6 +94,10 @@ struct virtio_rpmsg_channel {
  * advertise new channels implicitly by creating the endpoints.
  */
 struct rpmsg_device_ops {
+	u16 (*transport16_to_cpu)(struct rpmsg_device *rpdev, u16 val);
+	u16 (*cpu_to_transport16)(struct rpmsg_device *rpdev, u16 val);
+	u32 (*transport32_to_cpu)(struct rpmsg_device *rpdev, u32 val);
+	u32 (*cpu_to_transport32)(struct rpmsg_device *rpdev, u32 val);
 	struct rpmsg_device *(*create_channel)(struct rpmsg_device *rpdev,
 					     struct rpmsg_channel_info *chinfo);
 	int (*release_channel)(struct rpmsg_device *rpdev,
@@ -148,6 +154,12 @@ rpmsg_create_channel(struct rpmsg_device *rpdev,
 		     struct rpmsg_channel_info *chinfo);
 int rpmsg_release_channel(struct rpmsg_device *rpdev,
 			  struct rpmsg_channel_info *chinfo);
+
+u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, u16 val);
+u16 cpu_to_rpmsg16(struct rpmsg_device *rpdev, u16 val);
+u32 rpmsg32_to_cpu(struct rpmsg_device *rpdev, u32 val);
+u32 cpu_to_rpmsg32(struct rpmsg_device *rpdev, u32 val);
+
 /**
  * rpmsg_chrdev_register_device() - register chrdev device based on rpdev
  * @rpdev:	prepared rpdev to be used for creating endpoints
-- 
2.25.1

