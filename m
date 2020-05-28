Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E31E648E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 16:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403775AbgE1OvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 10:51:14 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42614 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgE1OvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:51:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 2C5DA803083A;
        Thu, 28 May 2020 14:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KL80_MTOXDx5; Thu, 28 May 2020 17:50:58 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Olof Johansson <olof@lixom.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <soc@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] bus: bt1-apb: Use PTR_ERR_OR_ZERO to return from request-regs method
Date:   Thu, 28 May 2020 17:50:47 +0300
Message-ID: <20200528145050.5203-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200528145050.5203-1-Sergey.Semin@baikalelectronics.ru>
References: <20200528145050.5203-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed it's more optimal to use the PTR_ERR_OR_ZERO() macro there instead
of having two return points.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Olof Johansson <olof@lixom.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: soc@kernel.org
---
 drivers/bus/bt1-apb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index 59ec5e7077e8..7e57fc2af745 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -164,12 +164,10 @@ static int bt1_apb_request_regs(struct bt1_apb *apb)
 	}
 
 	apb->res = devm_platform_ioremap_resource_byname(pdev, "nodev");
-	if (IS_ERR(apb->res)) {
+	if (IS_ERR(apb->res))
 		dev_err(apb->dev, "Couldn't map reserved region\n");
-		return PTR_ERR(apb->res);
-	}
 
-	return 0;
+	return PTR_ERR_OR_ZERO(apb->res);
 }
 
 static int bt1_apb_request_rst(struct bt1_apb *apb)
-- 
2.26.2

