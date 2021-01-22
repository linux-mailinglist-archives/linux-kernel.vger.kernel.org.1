Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E649530095D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbhAVRM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbhAVQ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:59:08 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FB3C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:58:22 -0800 (PST)
Received: from dslb-188-097-208-144.188.097.pools.vodafone-ip.de ([188.97.208.144] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1l2zlG-00050T-Jw; Fri, 22 Jan 2021 17:58:14 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: rtl8188eu: fix rtw_xmit_entry's return value
Date:   Fri, 22 Jan 2021 17:57:49 +0100
Message-Id: <20210122165749.29467-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A netdev xmit function should return NETDEV_TX_OK or NETDEV_TX_BUSY.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index c22ddeb9a56b..b0efa2eb705e 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -205,5 +205,5 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 		 ("%s: drop, tx_drop=%d\n", __func__, (u32)pxmitpriv->tx_drop));
 
 exit:
-	return 0;
+	return NETDEV_TX_OK;
 }
-- 
2.20.1

