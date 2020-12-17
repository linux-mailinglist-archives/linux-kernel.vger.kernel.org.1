Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92502DD425
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgLQP1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgLQP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:27:40 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C230C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 07:27:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c133so5893298wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 07:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FpwqRQis6Vf9P/4W2+zf8SCJvCqJXOw/njLhajH/6oI=;
        b=KprFXpNC2T8eUp0wQmOLhDpk36Dk/vY5Y+EhGX2OrrYqMfuxXWNWw26WEOJFHh8kDH
         BHxy3nmamtUQeDlwWnJB5OXtyXtVct+GliUJtiAJp/7eE+Zkpmg+s2gEWG6Uwn0CmsqX
         BZaGzLB+lub1DiP3gDlnQBOzn5GSRjUW1zwkjVn7KWJJRiYZyXAJda0/M65bCfMfTZYy
         u1iCpPEhFe8JGBErWAsmKicaIkqcsgj2d9ZPl4pLYLZkDjNQ6zW5hOIKxFRV6u9tBvc3
         irL/TwuZcyQukOUA2dOsIlAHucM6FPL8k0zEBaJr//r1xrEKrzKzmR6e4EDdoRiO/MJY
         thTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FpwqRQis6Vf9P/4W2+zf8SCJvCqJXOw/njLhajH/6oI=;
        b=gyoNtvALPUPKiMVRB+qpXolHPZp+uf51yEd5RYobR1cwtmR66raVPfR79OFeOdrfVw
         xsFL1VX5zswuuNz8+sw4Ts1Jjlx8bNEKthJmJWZowX9FzPra8heree/Demk4AuG/aq+R
         eCO6Lw5tnzTFEfSDjhEM34D5DnHNr1ZPeHxHNSpWI8QIMOoDAmCSDf/3cC87xReOoleE
         isGCxM9cf19cSwuBatGI9rfYHCgcfQv0mzuCtTcknEXQ9vixZ8ob5OrAu6x/QRxQL1Vf
         nOrXXiHcLfxHzYNcuv5HwieqMhmkT9ANEwI6H2i5E2kLE4HOtkyTgbijDK5UelNW/q0U
         omMA==
X-Gm-Message-State: AOAM532Th7AwKninKEpkDsooiQL1lI+x5c9ZFZKFrjoljg4FKtFCpH6J
        9gl9jjUVQXpfgUiknOgjpo2gVw==
X-Google-Smtp-Source: ABdhPJza3OjwOGwKZhnUlqdTi4PUeKu9VZ1W0rVJHKDCV3OFXjRdT3NSBLxhDieySmYSf0Lx9lPS9w==
X-Received: by 2002:a1c:e1c6:: with SMTP id y189mr8926265wmg.172.1608218818974;
        Thu, 17 Dec 2020 07:26:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:490:8730:327d:25b5:5911:5f95])
        by smtp.gmail.com with ESMTPSA id i11sm8200903wmd.47.2020.12.17.07.26.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:26:58 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kuba@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2] net: mhi: Add raw IP mode support
Date:   Thu, 17 Dec 2020 16:34:09 +0100
Message-Id: <1608219249-6297-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MHI net is protocol agnostic, the payload protocol depends on the modem
configuration, which can be either RMNET (IP muxing and aggregation) or
raw IP. This patch adds support for incomming IPv4/IPv6 packets, that
was previously unconditionnaly reported as RMNET packets.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: - mhi-net rebase
     - Set device type to RAWIP

 drivers/net/mhi_net.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index e3f9c0d..478e78f 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -121,7 +121,7 @@ static const struct net_device_ops mhi_netdev_ops = {
 static void mhi_net_setup(struct net_device *ndev)
 {
 	ndev->header_ops = NULL;  /* No header */
-	ndev->type = ARPHRD_NONE; /* QMAP... */
+	ndev->type = ARPHRD_RAWIP;
 	ndev->hard_header_len = 0;
 	ndev->addr_len = 0;
 	ndev->flags = IFF_POINTOPOINT | IFF_NOARP;
@@ -157,7 +157,18 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
 		u64_stats_add(&mhi_netdev->stats.rx_bytes, mhi_res->bytes_xferd);
 		u64_stats_update_end(&mhi_netdev->stats.rx_syncp);
 
-		skb->protocol = htons(ETH_P_MAP);
+		switch (skb->data[0] & 0xf0) {
+		case 0x40:
+			skb->protocol = htons(ETH_P_IP);
+			break;
+		case 0x60:
+			skb->protocol = htons(ETH_P_IPV6);
+			break;
+		default:
+			skb->protocol = htons(ETH_P_MAP);
+			break;
+		}
+
 		skb_put(skb, mhi_res->bytes_xferd);
 		netif_rx(skb);
 	}
-- 
2.7.4

