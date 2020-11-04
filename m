Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA122A601E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgKDJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKDJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:06:29 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3FC0401C2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 01:06:27 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w14so21151926wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 01:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c5eEvJlIJ9dRxH14TAwIWUTdkS+IjrVsnIh7Q0ggT08=;
        b=brnfN0ua+I8Gz0uH1YV2F5yGMa1nzKtE/fciwy9jk3b9rq5I0aNfgD4mZJzX8y7I1E
         v3JDs7pEobe4Yi8iYBQ40zxZ8nXthK8OcVOLr67uk0SAcc/ubdXmUKHvE0/AK1rMDu01
         yrRiiolMV4YiWRm8HrWgQJ0JQAFJoqCM0yyfQZqUrnR9NiJ8SwrEv5+7kDefd5+Gi3cq
         gaPUm3pKb2M6ijdOnMD5xlQYyoNvOCtnC5vEOz1OroBw8vK3P6Lcw338vkw3+ONJXbDj
         vbiyjSwa39RI1uguEompiCmYj46eiYl+u75lYB12uxNu8llPEM5POY4oMBpriKxwoZcs
         6iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5eEvJlIJ9dRxH14TAwIWUTdkS+IjrVsnIh7Q0ggT08=;
        b=siHf93/HRA4wUwWoC1cFgocpIfgYB5k1lgX8oLJ+Njxk+GWe+1qqj83lXCgWjrDG/x
         UIJYcHHymlFtg0YVdKsoXd6b0euxUXSgDKNKrzXxBFDFCgEEAcK0TX+ncZBr5vK0Vj0G
         cYqbRLRoM1fMUnc/TFsTXlWSk0Q6sMBtNdslr/Q1zxpWoStGvAYge4FaviNhNUCbvxeo
         BW+nfctuNn9clE6Q2cwTql9iGw7TRHmwFe14g8V8LnW3qNL8MRjMGTUNZlUTxr7Kk6K8
         ASp7vwHWgvapVztYa6dntAOOFZybC2s0yfHLJxG7MkCd/KgaLj/E/OXEDQgO1R+wxKpt
         etYg==
X-Gm-Message-State: AOAM532cH/yO2IytwlkjgcpdjrdEFv0Q7TD/Gg9j+rIHCq6+lM3Mibz+
        cgYDlVHYiWjJqmMfJOrVIvFt7w==
X-Google-Smtp-Source: ABdhPJym7Q/2k10PIfoqJtwM+8PymTLRCc0LKxW4WlS6/PkC+bMauBuh5tweYNKAWOXSj133iHyE3w==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr29760015wrx.18.1604480785876;
        Wed, 04 Nov 2020 01:06:25 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id e25sm1607823wrc.76.2020.11.04.01.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:06:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Dustin McIntire <dustin@sensoria.com>, netdev@vger.kernel.org
Subject: [PATCH 02/12] net: ethernet: smsc: smc911x: Mark 'status' as __maybe_unused
Date:   Wed,  4 Nov 2020 09:06:00 +0000
Message-Id: <20201104090610.1446616-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104090610.1446616-1-lee.jones@linaro.org>
References: <20201104090610.1446616-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'status' is used to interact with a hardware register.  It might not
be safe to remove it entirely.  Mark it as __maybe_unused instead.

Fixes the following W=1 kernel build warning(s):

 drivers/net/ethernet/smsc/smc911x.c: In function ‘smc911x_phy_configure’:
 drivers/net/ethernet/smsc/smc911x.c:882:6: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]
 drivers/net/ethernet/smsc/smc911x.c: In function ‘smc911x_phy_interrupt’:
 drivers/net/ethernet/smsc/smc911x.c:976:6: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]
 drivers/net/ethernet/smsc/smc911x.c: In function ‘smc911x_timeout’:
 drivers/net/ethernet/smsc/smc911x.c:1251:6: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Dustin McIntire <dustin@sensoria.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ethernet/smsc/smc911x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index 01069dfaf75c9..552953c376fe3 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -879,7 +879,7 @@ static void smc911x_phy_configure(struct work_struct *work)
 	int phyaddr = lp->mii.phy_id;
 	int my_phy_caps; /* My PHY capabilities */
 	int my_ad_caps; /* My Advertised capabilities */
-	int status;
+	int __maybe_unused status;
 	unsigned long flags;
 
 	DBG(SMC_DEBUG_FUNC, dev, "--> %s()\n", __func__);
@@ -973,7 +973,7 @@ static void smc911x_phy_interrupt(struct net_device *dev)
 {
 	struct smc911x_local *lp = netdev_priv(dev);
 	int phyaddr = lp->mii.phy_id;
-	int status;
+	int __maybe_unused status;
 
 	DBG(SMC_DEBUG_FUNC, dev, "--> %s\n", __func__);
 
@@ -1248,7 +1248,7 @@ static void smc911x_poll_controller(struct net_device *dev)
 static void smc911x_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct smc911x_local *lp = netdev_priv(dev);
-	int status, mask;
+	int __maybe_unused status, mask;
 	unsigned long flags;
 
 	DBG(SMC_DEBUG_FUNC, dev, "--> %s\n", __func__);
-- 
2.25.1

