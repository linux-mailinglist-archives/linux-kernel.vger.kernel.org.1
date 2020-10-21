Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B329294902
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501951AbgJUHj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:39:27 -0400
Received: from m15113.mail.126.com ([220.181.15.113]:51084 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407994AbgJUHj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=eictmf52OPpcOGd4A4
        gKYbSSk3VTWSCn1R/rLn4YWto=; b=bTX9WY6KSp2t06HVeMHrgPpATnXcUUnrOc
        7ottvMdPn/wji017UXfNsAFKZJgiUVApxMohfrDwBHw2YJr4Hlfgr9gMwxQyZ9Gj
        GmNA1POCoVAFdXNjbC5Q6m1yZOERtyq5mG7aYmknWKeIqKGahmfF2ScPO8Ra2u1O
        nJjrzPGeQ=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp3 (Coremail) with SMTP id DcmowABXXwNu5Y9f+Lt5Kw--.7611S2;
        Wed, 21 Oct 2020 15:38:22 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     siva.kallam@broadcom.com
Cc:     prashant@broadcom.com, mchan@broadcom.com, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Defang Bo <bodefang@126.com>
Subject: [PATCH v3] tg3: Avoid NULL pointer dereference in netif_device_attach()
Date:   Wed, 21 Oct 2020 15:38:09 +0800
Message-Id: <1603265889-8967-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: DcmowABXXwNu5Y9f+Lt5Kw--.7611S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF17trW7Jw17GFy5Kr1xZrb_yoW3CFX_KF
        1UZrZ3Gr4UGry2kr4Ykr43Ar98Kan0vayF9F1Iv3yaqrZF9r1UJFWkZryfArnrWrWUtF9r
        tr13tFWfGw4jkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Z0eJUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbi6w7E11pD87d0pgAAs5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<1b0ff89852d7>("tg3: Avoid NULL pointer dereference in tg3_io_error_detected()")
This patch avoids NULL pointer dereference add a check for netdev being NULL on tg3_resume().

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index ae756dd..345c6aa 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18099,7 +18099,7 @@ static int tg3_resume(struct device *device)
 
 	rtnl_lock();
 
-	if (!netdev || !netif_running(dev))
+	if (!dev || !netif_running(dev))
 		goto unlock;
 
 	netif_device_attach(dev);
-- 
1.9.1

