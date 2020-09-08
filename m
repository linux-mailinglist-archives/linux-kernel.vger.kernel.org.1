Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10E261837
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 19:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgIHRua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 13:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731617AbgIHQN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51F9248E0;
        Tue,  8 Sep 2020 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580377;
        bh=SlflZwfzLGm1NFeN72JoU45rJ298TLBZ6Fy5S6Z/YG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zS9//ggMQqfFUIADbIBa7kOgG1R7RonZtI4bRe7YQRc0nIUHjiZJ7pHjPzXX2CBDd
         FhEpc3hEqgDUFHeHwxVgP+WOtXwZWGt44JwUyb3BtjpJEKnNPJKro++mDNLYztkx7W
         eUI93eTNXVGkHpYgnqjgQ1F6EvNcLV9f63zcS6tE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 22/65] net: systemport: Fix memleak in bcm_sysport_probe
Date:   Tue,  8 Sep 2020 17:26:07 +0200
Message-Id: <20200908152218.172158675@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 7ef1fc57301f3cef7201497aa27e89ccb91737fe ]

When devm_kcalloc() fails, dev should be freed just
like what we've done in the subsequent error paths.

Fixes: 7b78be48a8eb6 ("net: systemport: Dynamically allocate number of TX rings")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 123ee5c11bc0c..11eb393497a2a 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2087,8 +2087,10 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 	priv->tx_rings = devm_kcalloc(&pdev->dev, txq,
 				      sizeof(struct bcm_sysport_tx_ring),
 				      GFP_KERNEL);
-	if (!priv->tx_rings)
-		return -ENOMEM;
+	if (!priv->tx_rings) {
+		ret = -ENOMEM;
+		goto err_free_netdev;
+	}
 
 	priv->is_lite = params->is_lite;
 	priv->num_rx_desc_words = params->num_rx_desc_words;
-- 
2.25.1



