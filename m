Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7622E8F50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 03:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbhADCAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 21:00:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9950 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbhADCAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 21:00:19 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D8JhF39Nzzj1CZ;
        Mon,  4 Jan 2021 09:58:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 4 Jan 2021 09:59:33 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <linux@dominikbrodowski.net>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] pcmcia: Switch to using the new API kobj_to_dev()
Date:   Mon, 4 Jan 2021 09:59:30 +0800
Message-ID: <1609725570-11433-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following coccicheck:
drivers/pcmcia/cistpl.c:1557:54-55: WARNING opportunity for kobj_to_dev()
drivers/pcmcia/cistpl.c:1584:53-54: WARNING opportunity for kobj_to_dev()

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/pcmcia/cistpl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index cf109d9..e693910 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1554,7 +1554,7 @@ static ssize_t pccard_show_cis(struct file *filp, struct kobject *kobj,
 		if (off + count > size)
 			count = size - off;
 
-		s = to_socket(container_of(kobj, struct device, kobj));
+		s = to_socket(kobj_to_dev(kobj));
 
 		if (!(s->state & SOCKET_PRESENT))
 			return -ENODEV;
@@ -1581,7 +1581,7 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	if (error)
 		return error;
 
-	s = to_socket(container_of(kobj, struct device, kobj));
+	s = to_socket(kobj_to_dev(kobj));
 
 	if (off)
 		return -EINVAL;
-- 
2.7.4

