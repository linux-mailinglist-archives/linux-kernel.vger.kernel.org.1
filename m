Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFBE2022A7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 10:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgFTIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 04:41:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbgFTIlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 04:41:22 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 71E1C5320015253F93A7;
        Sat, 20 Jun 2020 16:41:15 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 16:41:05 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <navid.emamdoost@gmail.com>, <linux-block@vger.kernel.org>,
        <nbd@other.debian.org>, <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH v2] nbd: Fix memory leak in nbd_add_socket
Date:   Sat, 20 Jun 2020 16:48:09 +0800
Message-ID: <20200620084809.126398-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we add first socket to nbd, config->socks is malloced but
num_connections does not update(nsock's allocation fail), the memory
is leaked. Cause in later nbd_config_put(), will only free config->socks
when num_connections is not 0.

Let nsock's allocation first to avoid this.

Fixes: 03bf73c315ed ("nbd: prevent memory leak")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---

v1->v2: modify comments

 drivers/block/nbd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a67..3e7709317b17 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1037,21 +1037,22 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		return -EBUSY;
 	}

+	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
+	if (!nsock) {
+		sockfd_put(sock);
+		return -ENOMEM;
+	}
+
 	socks = krealloc(config->socks, (config->num_connections + 1) *
 			 sizeof(struct nbd_sock *), GFP_KERNEL);
 	if (!socks) {
 		sockfd_put(sock);
+		kfree(nsock);
 		return -ENOMEM;
 	}

 	config->socks = socks;

-	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
-	if (!nsock) {
-		sockfd_put(sock);
-		return -ENOMEM;
-	}
-
 	nsock->fallback_index = -1;
 	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
--
2.26.0.106.g9fadedd

