Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7133D2F1BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbhAKRJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389250AbhAKRJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:09:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9DBC0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:08:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w5so492815wrm.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hzqb7q+hCD/lNO+yAqM3iVZkO0rtWj2v+FJjuf+pTrs=;
        b=n5asBGstU7SJV1zKKQa9RZDbEIGxdI5F/fXnQqUbttw35z188FHKmNqqdmIarHjCcB
         Z4LULLoxUTuw9C9/z8hQOXB4GpSOZTfeYuWFaDlksFt/+NlJ3ihamr4rx2oUUL9k5pcZ
         Tka4tmxH+9wvGElhMhMvk6mnJ6oKzlMW8QBmeVhGJ2L1ER37wHa/S63vSHr+M2u+dt4C
         yCOJ+PtieXF6DURYB7SIS27+4qrz8cMe3FOqL5HPo7Yc0HvbTkftpQLnegCh59AnED3W
         SX0k6z5yBKehYatWHeKAlZib6KCBUmSLdp3kC2fkDgky+fo0RagBXHYlbJpE/izMD90j
         4IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hzqb7q+hCD/lNO+yAqM3iVZkO0rtWj2v+FJjuf+pTrs=;
        b=s+bBanuQOCiMVPBG5JixXmKb8f2Jyx+rAakPNy3KbTAsZ7m9JbwUFtntc4FZ0oZCa7
         Yq757ydzY94Qp4XsxUJiHxaNeHugBoYuM8PApA+zPFiNIUy2EJaIffqJQty4IFBd/hKT
         ammyjiR//U3ZI9W1UeUqc0VmkbwMaUbkRzHGr2Uh///SGS7qSra07OtzOj3UWEIAbrL/
         Vo8GakmF+XD72aqdPEjBSa+RbNJTHnln+0+KsOk81x1UeN1VZr9rMIT+lx3Wvxx9HFUp
         DjmsiBG3KjGzIyyVvwEajkGc7UVOMJyFsN6sqq8Mc3faSegRVGKs9iaYHnpGhX1DA4dz
         3eeQ==
X-Gm-Message-State: AOAM531+/wQx+R34K80Q8UH9u+nN9Mn9UflLqeP92oOK0zlQfprGs9rK
        vUJol6yPrOibekZvly2LXvlAcw==
X-Google-Smtp-Source: ABdhPJytTjtq6G520n2KatbvJ0m+IJcZ2fNY1td6FekScZBE8TmbXAaa73GAfZPZQpZkEsIpHQdwHQ==
X-Received: by 2002:adf:e552:: with SMTP id z18mr115853wrm.29.1610384924867;
        Mon, 11 Jan 2021 09:08:44 -0800 (PST)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id i18sm279364wrp.74.2021.01.11.09.08.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 09:08:44 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kuba@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        manivannan.sadhasivam@linaro.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH net-next 2/3] net: mhi: Get RX queue size from MHI core
Date:   Mon, 11 Jan 2021 18:16:18 +0100
Message-Id: <1610385379-15140-2-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610385379-15140-1-git-send-email-loic.poulain@linaro.org>
References: <1610385379-15140-1-git-send-email-loic.poulain@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RX queue size can be determined at runtime by retrieving the
number of available transfer descriptors.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/mhi_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index b7f7f2e..3da820b 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -257,9 +257,6 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
 	mhi_netdev->mdev = mhi_dev;
 	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
 
-	/* All MHI net channels have 128 ring elements (at least for now) */
-	mhi_netdev->rx_queue_sz = 128;
-
 	INIT_DELAYED_WORK(&mhi_netdev->rx_refill, mhi_net_rx_refill_work);
 	u64_stats_init(&mhi_netdev->stats.rx_syncp);
 	u64_stats_init(&mhi_netdev->stats.tx_syncp);
@@ -269,6 +266,9 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
 	if (err)
 		goto out_err;
 
+	/* Number of transfer descriptors determines size of the queue */
+	mhi_netdev->rx_queue_sz = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
+
 	err = register_netdev(ndev);
 	if (err)
 		goto out_err;
-- 
2.7.4

