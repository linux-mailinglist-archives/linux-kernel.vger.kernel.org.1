Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C9729D5D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgJ1WI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:08:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7079 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbgJ1WHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:07:13 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CLjTC0PJJzLpYf;
        Wed, 28 Oct 2020 17:10:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 17:09:55 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] powerpc: sysdev: add missing iounmap() on error in mpic_msgr_probe()
Date:   Wed, 28 Oct 2020 17:15:51 +0800
Message-ID: <20201028091551.136400-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that iounmap() of msgr_block_addr before return from
mpic_msgr_probe() in the error handling case is missing. So use
devm_ioremap() instead of just ioremap() when remapping the message
register block, so the mapping will be automatically released on
probe failure.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 arch/powerpc/sysdev/mpic_msgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
index f6b253e2b..36ec0bdd8 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -191,7 +191,7 @@ static int mpic_msgr_probe(struct platform_device *dev)
 
 	/* IO map the message register block. */
 	of_address_to_resource(np, 0, &rsrc);
-	msgr_block_addr = ioremap(rsrc.start, resource_size(&rsrc));
+	msgr_block_addr = devm_ioremap(&dev->dev, rsrc.start, resource_size(&rsrc));
 	if (!msgr_block_addr) {
 		dev_err(&dev->dev, "Failed to iomap MPIC message registers");
 		return -EFAULT;
-- 
2.23.0

