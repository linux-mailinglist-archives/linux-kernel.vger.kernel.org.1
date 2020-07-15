Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636F9220274
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 04:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgGOCmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 22:42:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbgGOCmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:42:13 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FE87DB7290F13A164A8;
        Wed, 15 Jul 2020 10:42:11 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 10:42:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <edumazet@google.com>, <davem@davemloft.net>,
        <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] netpoll: Remove unused inline function netpoll_netdev_init()
Date:   Wed, 15 Jul 2020 10:41:23 +0800
Message-ID: <20200715024123.34288-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d565b0a1a9b6 ("net: Add Generic Receive Offload infrastructure")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/netpoll.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f47af135bd56..e6a2d72e0dc7 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -102,9 +102,6 @@ static inline void *netpoll_poll_lock(struct napi_struct *napi)
 static inline void netpoll_poll_unlock(void *have)
 {
 }
-static inline void netpoll_netdev_init(struct net_device *dev)
-{
-}
 static inline bool netpoll_tx_running(struct net_device *dev)
 {
 	return false;
-- 
2.17.1


