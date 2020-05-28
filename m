Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1464B1E648B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgE1OvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 10:51:02 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42582 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgE1OvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:51:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3289880307C0;
        Thu, 28 May 2020 14:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oi3CD9VmS7XJ; Thu, 28 May 2020 17:50:57 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Olof Johansson <olof@lixom.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <soc@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] bus: bt1-apb: Include linux/io.h
Date:   Thu, 28 May 2020 17:50:45 +0300
Message-ID: <20200528145050.5203-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It must be included since we are using readl() method here.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Olof Johansson <olof@lixom.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: soc@kernel.org
---
 drivers/bus/bt1-apb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index abccd1dfc544..839f1add2236 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -15,6 +15,7 @@
 #include <linux/atomic.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/nmi.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
-- 
2.26.2

