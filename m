Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83282FDC44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbhATWPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732553AbhATWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:05:52 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5364C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:04:08 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e22so81834iog.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBNzWrwjXuW0OAZcNNJPMhiWPrYSOE7uMer+o1tBWxs=;
        b=EopezSHSVJS84vNTnBHTbyonlclmvUvfJvafozzWmFDq8oERl7Rd97ZWIBpgxCUVaH
         FshlYUyQijgsnIG0dw7TV5JiBXErk4Nd4nhJzHix2Y7y+R+jawVu0DfUwZbNo1fBELzh
         I3ODwK7clViV6d2nW8Zgk5oLWMKOL02X6RPsWVipC1SLcsuWCrIPi6pZIsMU0x+4V6bs
         5FgAFo8qdCdu5Wv1zM1H7ac9qNXz7aysQs0gfzZjBMXx2L9XE22BAGDCyCZ4bsX6kkDc
         N+MGkp9MajWZ3iH2jt7ui2xPHBOHq2W+GHgAdoPmSenGO9RJLEcBTUtDPd3wvtzENQKs
         K7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBNzWrwjXuW0OAZcNNJPMhiWPrYSOE7uMer+o1tBWxs=;
        b=gCyXcfnd7KINSAledPFizDfm8Dn3wKl0JqkM+Ho3ts2sgT1R53kwoD+7SKXYJtubrf
         rGXxokuku6zj8CU2sFehYp8J5KDg1rOPUX3rcAj4ASVCudpzoyZPvV7DeUQqtXLKBnrf
         ma0qbWmjXxHmU4Ii3sXns2Vw25+/SX1Fyn/ZOiApEZ8/8rU5R6kt5gZ9LlE6Ca88aXRo
         NMfcNCpiu2wOniGv/xiCz7kth7n5HD20ajpkdIpikLR/9XjTdnTKrogyVpu+JUg/cKv2
         aksRrD4Mem8Sml12Vb8QAYxyBHq2GsBaUUQwrZ6NcGZMOTBID7h/xeRlMDGunJzsoDIQ
         0AJQ==
X-Gm-Message-State: AOAM5321eyFceg6V+pMobFpIH9QcGxYgEWDoeW7QDMGadtseVUQxpHV9
        AHiX8puFaLH6tn6sUoHi2IZkFg==
X-Google-Smtp-Source: ABdhPJyXk/yZF5rrvpZFab/sAJ1PvNzVK3kfc6OYJ58TgTzoBF5PRQZzH3Hdlo1ayutQoxeNo97vGw==
X-Received: by 2002:a02:52c8:: with SMTP id d191mr9443168jab.59.1611180248061;
        Wed, 20 Jan 2021 14:04:08 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id e5sm1651712ilu.27.2021.01.20.14.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:04:07 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] net: ipa: have gsi_channel_update() return a value
Date:   Wed, 20 Jan 2021 16:03:59 -0600
Message-Id: <20210120220401.10713-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120220401.10713-1-elder@linaro.org>
References: <20210120220401.10713-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have gsi_channel_update() return the first transaction in the
updated completed transaction list, or NULL if no new transactions
have been added.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 634f514e861e7..5b98003263710 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1452,7 +1452,7 @@ void gsi_channel_doorbell(struct gsi_channel *channel)
 }
 
 /* Consult hardware, move any newly completed transactions to completed list */
-static void gsi_channel_update(struct gsi_channel *channel)
+struct gsi_trans *gsi_channel_update(struct gsi_channel *channel)
 {
 	u32 evt_ring_id = channel->evt_ring_id;
 	struct gsi *gsi = channel->gsi;
@@ -1471,7 +1471,7 @@ static void gsi_channel_update(struct gsi_channel *channel)
 	offset = GSI_EV_CH_E_CNTXT_4_OFFSET(evt_ring_id);
 	index = gsi_ring_index(ring, ioread32(gsi->virt + offset));
 	if (index == ring->index % ring->count)
-		return;
+		return NULL;
 
 	/* Get the transaction for the latest completed event.  Take a
 	 * reference to keep it from completing before we give the events
@@ -1496,6 +1496,8 @@ static void gsi_channel_update(struct gsi_channel *channel)
 	gsi_evt_ring_doorbell(channel->gsi, channel->evt_ring_id, index);
 
 	gsi_trans_free(trans);
+
+	return gsi_channel_trans_complete(channel);
 }
 
 /**
@@ -1516,11 +1518,8 @@ static struct gsi_trans *gsi_channel_poll_one(struct gsi_channel *channel)
 
 	/* Get the first transaction from the completed list */
 	trans = gsi_channel_trans_complete(channel);
-	if (!trans) {
-		/* List is empty; see if there's more to do */
-		gsi_channel_update(channel);
-		trans = gsi_channel_trans_complete(channel);
-	}
+	if (!trans)	/* List is empty; see if there's more to do */
+		trans = gsi_channel_update(channel);
 
 	if (trans)
 		gsi_trans_move_polled(trans);
-- 
2.20.1

