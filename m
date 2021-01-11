Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD642F1BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbhAKRJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389263AbhAKRJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:09:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C65BC061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:08:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q18so564151wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o6VGoAvdQqK2Elm/WglYXBR1TIROqoxTQR1mS7lNbWE=;
        b=BWU/SEFPIck4zioPf/MjB1c3E14E2wQ77QB1wK1rV5VbqIEk+Ywe2+atuulJO+wW3m
         vtduhuEmz7FHB4XI4TwfxX9DGK0xNlhlseajdNovbabtYHRZ/xa4wrFAMpYeqd4dsIs+
         7YBS2z7TgpuK1IUWIv/SCOiwC3a5LUy5PLhIrTxKSWRjdITeFIWUUlRtcp0IOJdhYAmW
         s48wrsyGH2/+HSmel+ptHRJbOUj8O1V7bwEvUy/vSuepaqbZzpQYYKVgpO/ILeFWdew+
         hYJ2LNpt+CaNd/zor4hI2N5d5ITfaH7YbHu145Hvf9LBP1GlOuE/YGAhhzoOK9Zstw7x
         JNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o6VGoAvdQqK2Elm/WglYXBR1TIROqoxTQR1mS7lNbWE=;
        b=Uknfsj1e3ur7RJ6PEYLn4dUTQ87WXOnlISt4nqbUEqZH7Yb3nwK4H3SP38wFfvKi80
         8+upZm0leiBV/M3eLR756nKwgm1YnDP5oDn0sK10KmirZw9UwFqGbjHcYKvUn8PqIIJS
         vbIHrqYc8hPXfdk/yWjVRsNoSvT1K6uSk4DB9Dj5NqNRl9uyEmElC2OP2JNs8y/KCz5m
         xYi3JUGuWedZ6YXmnfLvRvcf/CIQEV01+yuec0PxMBtRVlXhUyFAicARKD/Y2rNUOHGF
         s6gXt+wMdv894iBnSxS1XsYeTiYdZY+AihZFQ4do5GNjjcJtZu5k4AKhJZVxy+Ye3Jgd
         4c9w==
X-Gm-Message-State: AOAM531HYWV8rBawuzBXhTn0VjPLzN0KCcdLlsLrAGHbtvPtC7lUT9Ns
        pbv66twwz5H8m2VmmqNZLHe7ypp6GLTpBg==
X-Google-Smtp-Source: ABdhPJx2Im8L8LNObE+AD4rZ0V8DpQESSpAx8j0i9rMoGUY1sQ1m9aJQxCi1VkD1wIunI6LiiXKQ1Q==
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr76324wrv.427.1610384926104;
        Mon, 11 Jan 2021 09:08:46 -0800 (PST)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id i18sm279364wrp.74.2021.01.11.09.08.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 09:08:45 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kuba@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        manivannan.sadhasivam@linaro.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH net-next 3/3] net: mhi: Get rid of local rx queue count
Date:   Mon, 11 Jan 2021 18:16:19 +0100
Message-Id: <1610385379-15140-3-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610385379-15140-1-git-send-email-loic.poulain@linaro.org>
References: <1610385379-15140-1-git-send-email-loic.poulain@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mhi_get_free_desc_count helper to track queue usage
instead of relying on the locally maintained rx_queued count.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/mhi_net.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index 3da820b..f83562d 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -25,7 +25,6 @@ struct mhi_net_stats {
 	u64_stats_t tx_bytes;
 	u64_stats_t tx_errors;
 	u64_stats_t tx_dropped;
-	atomic_t rx_queued;
 	struct u64_stats_sync tx_syncp;
 	struct u64_stats_sync rx_syncp;
 };
@@ -138,9 +137,9 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
 {
 	struct mhi_net_dev *mhi_netdev = dev_get_drvdata(&mhi_dev->dev);
 	struct sk_buff *skb = mhi_res->buf_addr;
-	int remaining;
+	int free_desc_count;
 
-	remaining = atomic_dec_return(&mhi_netdev->stats.rx_queued);
+	free_desc_count = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
 
 	if (unlikely(mhi_res->transaction_status)) {
 		dev_kfree_skb_any(skb);
@@ -164,7 +163,7 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
 	}
 
 	/* Refill if RX buffers queue becomes low */
-	if (remaining <= mhi_netdev->rx_queue_sz / 2)
+	if (free_desc_count >= mhi_netdev->rx_queue_sz / 2)
 		schedule_delayed_work(&mhi_netdev->rx_refill, 0);
 }
 
@@ -211,7 +210,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 	struct sk_buff *skb;
 	int err;
 
-	while (atomic_read(&mhi_netdev->stats.rx_queued) < mhi_netdev->rx_queue_sz) {
+	while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
 		skb = netdev_alloc_skb(ndev, size);
 		if (unlikely(!skb))
 			break;
@@ -224,8 +223,6 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 			break;
 		}
 
-		atomic_inc(&mhi_netdev->stats.rx_queued);
-
 		/* Do not hog the CPU if rx buffers are consumed faster than
 		 * queued (unlikely).
 		 */
@@ -233,7 +230,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 	}
 
 	/* If we're still starved of rx buffers, reschedule later */
-	if (unlikely(!atomic_read(&mhi_netdev->stats.rx_queued)))
+	if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) == mhi_netdev->rx_queue_sz)
 		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
 }
 
-- 
2.7.4

