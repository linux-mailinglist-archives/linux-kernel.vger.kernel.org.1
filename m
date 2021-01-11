Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AF72F1BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbhAKRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbhAKRJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:09:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB533C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:08:44 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 3so565267wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i5vkZMIp6m8L5GT9AIEfOu/P1P8j2pgSz4aGREmv2dc=;
        b=kUW5CqEQs9SETIKZTrB6N2/ELutK/EqnMQN/CwzHvXbjSgIhpYzHwh9zCbi0+Luhy7
         tYmM0jU+B0uuE+o2EX+2zjJMkzLBrfsIX0oCT672GTS3OV4NKAQoPIoHXFj1iSNPet/Y
         VF+baHMUY9F52SRfoRdK4YZ+qKpHTt5L+iybZYBHErnglzKbSBXxdFqyn58KPn7U6th4
         SPcyY8NldxtYldlfa+tbHAwzRAI/GI9L15gow1kuMlZijAtNBJqCvb/zhi+SfzlinZgb
         0zrdVAhWVtARgDPsEvK1wanyDHcsIvu9FHMWf73IH+Pq3HNX/IHPwkTlF47dgfo/sPoN
         KhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i5vkZMIp6m8L5GT9AIEfOu/P1P8j2pgSz4aGREmv2dc=;
        b=QBc6d6H77g7o63UD6CKaP74sZNtwK8WDgkP6S8pEiVrM/uvZPFhomkZfYLM/ehRKw4
         sJYUU5U3nbEZz06kwwY6Zv/HwfOXp8fgp9rUSG7L7SaA+k6EzswHBJk5wFO2USSmcrjH
         c/0fkXAl8kwomNi9EkeTfgmQOMCYzPOmXrofLOzJypJwpPV0AC67bGH03FRWPEBp7+sy
         49S22f421yNbpDe1v5FqIw8q/repyex8mOYoeT1mE7BbxfZkhmEMMC0js/KYqM+phTBo
         1lWEuItCIgLnVmn7wOVyCn3evSci9MOP3aJBkCnr3lmxJm2lMMKw++KLbIa8IrUxqWHi
         5OVQ==
X-Gm-Message-State: AOAM5308PhBGCvNBZ1K8yp70QI1CwDapUjsZXt2SiUB6pY8o4ae+OCvT
        Am6LqSQdV+b8nhM9nAW0rYm+Buh0Nsq41Q==
X-Google-Smtp-Source: ABdhPJxKcsnJpydeJtHimyzkRunoAt6GAuH0KHCT7PJ7n2dP9Y+jpgbQzE+OwibTtA83gevJRKDPXA==
X-Received: by 2002:a1c:6506:: with SMTP id z6mr596622wmb.55.1610384923659;
        Mon, 11 Jan 2021 09:08:43 -0800 (PST)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id i18sm279364wrp.74.2021.01.11.09.08.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 09:08:43 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kuba@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        manivannan.sadhasivam@linaro.org,
        Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH net-next 1/3] bus: mhi: core: Add helper API to return number of free TREs
Date:   Mon, 11 Jan 2021 18:16:17 +0100
Message-Id: <1610385379-15140-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

Introduce mhi_get_free_desc_count() API to return number
of TREs available to queue buffer. MHI clients can use this
API to know before hand if ring is full without calling queue
API.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 12 ++++++++++++
 include/linux/mhi.h         |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 3db1108..4e31f4f 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -309,6 +309,18 @@ int mhi_destroy_device(struct device *dev, void *data)
 	return 0;
 }
 
+int mhi_get_free_desc_count(struct mhi_device *mhi_dev,
+				enum dma_data_direction dir)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ?
+		mhi_dev->ul_chan : mhi_dev->dl_chan;
+	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+
+	return get_nr_avail_ring_elements(mhi_cntrl, tre_ring);
+}
+EXPORT_SYMBOL_GPL(mhi_get_free_desc_count);
+
 void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason)
 {
 	struct mhi_driver *mhi_drv;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index cd571ad..62da830 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -614,6 +614,15 @@ void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl,
 void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason);
 
 /**
+ * mhi_get_free_desc_count - Get transfer ring length
+ * Get # of TD available to queue buffers
+ * @mhi_dev: Device associated with the channels
+ * @dir: Direction of the channel
+ */
+int mhi_get_free_desc_count(struct mhi_device *mhi_dev,
+				enum dma_data_direction dir);
+
+/**
  * mhi_prepare_for_power_up - Do pre-initialization before power up.
  *                            This is optional, call this before power up if
  *                            the controller does not want bus framework to
-- 
2.7.4

