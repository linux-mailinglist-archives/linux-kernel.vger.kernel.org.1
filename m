Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CF2C1E91
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgKXHBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:01:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7972 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXHBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:01:03 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CgFKT5rJMzhf2r;
        Tue, 24 Nov 2020 15:00:45 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Nov 2020 15:00:52 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Olof Johansson <olof@lixom.net>
CC:     <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>
Subject: [PATCH] drivers/pcmcia: Fix error return code in electra_cf_probe()
Date:   Tue, 24 Nov 2020 15:00:40 +0800
Message-ID: <20201124070040.3583-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it fails to call of_get_property(), it just jumps to 'fail1',
while the 'status' which will be returned is not updated.

Fixes: 2b571a066a2f ("pcmcia: CompactFlash driver for PA Semi Electra boards")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 drivers/pcmcia/electra_cf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 35158cfd9c1a..0570758e3fa8 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -228,6 +228,7 @@ static int electra_cf_probe(struct platform_device *ofdev)
 	}
 
 	cf->socket.pci_irq = cf->irq;
+	status = -ENODEV;
 
 	prop = of_get_property(np, "card-detect-gpio", NULL);
 	if (!prop)
-- 
2.17.1

