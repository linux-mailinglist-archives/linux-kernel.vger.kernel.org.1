Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E41BACC9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 20:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgD0Scy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 14:32:54 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:23853 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbgD0Scd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:32:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588012353; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=9ajINjyxVnZz0xrqD52l756TPDsznJMo9dg0aqFR6yM=; b=fnrx+/s93+aiiOK+aEhj8RDCL727uAZW5p+m/tyMxIN/4TBDHoucV01Ulnl1Yxeq2UCcwfC+
 9d+jw3Bfku96IB7wdG0AGSvjqs/UEwIKLgyBnYOYCERD0wSUOPVwMQfX38b77NiFdhGTzERH
 IdOKCxon+xpI7dBxXzVTrtrOJF4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7253e.7fda293b85e0-smtp-out-n03;
 Mon, 27 Apr 2020 18:32:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A53E6C43637; Mon, 27 Apr 2020 18:32:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84D38C433D2;
        Mon, 27 Apr 2020 18:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84D38C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org
Subject: [PATCH v1 1/8] bus: mhi: core: Cache intmod from mhi event to mhi channel
Date:   Mon, 27 Apr 2020 11:32:15 -0700
Message-Id: <1588012342-4995-2-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588012342-4995-1-git-send-email-bbhatt@codeaurora.org>
References: <1588012342-4995-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

Driver is using zero initialized intmod value from mhi channel when
configuring TRE for bei field. This prevents interrupt moderation to
take effect in case it is supported by an event ring. Fix this by
copying intmod value from associated event ring to mhi channel upon
registering mhi controller.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/init.c | 4 ++++
 drivers/bus/mhi/core/main.c | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index b38359c..4dc7f22 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -864,6 +864,10 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 		mutex_init(&mhi_chan->mutex);
 		init_completion(&mhi_chan->completion);
 		rwlock_init(&mhi_chan->lock);
+
+		/* used in setting bei field of TRE */
+		mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+		mhi_chan->intmod = mhi_event->intmod;
 	}
 
 	if (mhi_cntrl->bounce_buf) {
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index eb4256b..23154f1 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -929,7 +929,7 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	struct mhi_ring *buf_ring = &mhi_chan->buf_ring;
 	struct mhi_buf_info *buf_info;
 	struct mhi_tre *mhi_tre;
-	int ret;
+	int ret, bei;
 
 	/* If MHI host pre-allocates buffers then client drivers cannot queue */
 	if (mhi_chan->pre_alloc)
@@ -966,10 +966,11 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 		goto map_error;
 
 	mhi_tre = tre_ring->wp;
+	bei = !!(mhi_chan->intmod);
 
 	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
 	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_info->len);
-	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(1, 1, 0, 0);
+	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, 1, 0, 0);
 
 	/* increment WP */
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
@@ -1006,6 +1007,7 @@ int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	struct mhi_ring *buf_ring = &mhi_chan->buf_ring;
 	struct mhi_buf_info *buf_info;
 	struct mhi_tre *mhi_tre;
+	int bei;
 
 	/* If MHI host pre-allocates buffers then client drivers cannot queue */
 	if (mhi_chan->pre_alloc)
@@ -1043,10 +1045,11 @@ int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	buf_info->len = len;
 
 	mhi_tre = tre_ring->wp;
+	bei = !!(mhi_chan->intmod);
 
 	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
 	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_info->len);
-	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(1, 1, 0, 0);
+	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, 1, 0, 0);
 
 	/* increment WP */
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
