Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCCD2652CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgIJVYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:24:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11794 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731021AbgIJOXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:23:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1FBAC8F1436392567198;
        Thu, 10 Sep 2020 22:06:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 22:06:02 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <linux@dominikbrodowski.net>, <gustavoars@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] pcmcia: db1xxx_ss: remove unneeded semicolon
Date:   Thu, 10 Sep 2020 22:05:24 +0800
Message-ID: <20200910140524.1191003-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:

drivers/pcmcia/db1xxx_ss.c:455:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/pcmcia/db1xxx_ss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index a7c7c7cd2326..a6fbc709913e 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -452,7 +452,7 @@ static int db1x_pcmcia_socket_probe(struct platform_device *pdev)
 		printk(KERN_INFO "db1xxx-ss: unknown board %d!\n", bid);
 		ret = -ENODEV;
 		goto out0;
-	};
+	}
 
 	/*
 	 * gather resources necessary and optional nice-to-haves to
-- 
2.25.4

