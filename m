Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D481E648C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403763AbgE1OvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 10:51:07 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42602 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbgE1OvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:51:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8A8D58030839;
        Thu, 28 May 2020 14:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d34vhtuaL0fr; Thu, 28 May 2020 17:50:58 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Olof Johansson <olof@lixom.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <soc@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] bus: bt1-apb: Fix show/store callback identations
Date:   Thu, 28 May 2020 17:50:46 +0300
Message-ID: <20200528145050.5203-2-Sergey.Semin@baikalelectronics.ru>
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

After fixing the sysfs calback return value the functions argumnets
identations have been left as before the fix. That made the
argments declarations being unaligned with respect to the space
surrounded by the parentheses.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Olof Johansson <olof@lixom.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: soc@kernel.org
---
 drivers/bus/bt1-apb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index 839f1add2236..59ec5e7077e8 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -311,15 +311,15 @@ static ssize_t timeout_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(timeout);
 
-static ssize_t inject_error_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t inject_error_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	return scnprintf(buf, PAGE_SIZE, "Error injection: nodev irq\n");
 }
 
 static ssize_t inject_error_store(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *data, size_t count)
+				  struct device_attribute *attr,
+				  const char *data, size_t count)
 {
 	struct bt1_apb *apb = dev_get_drvdata(dev);
 
-- 
2.26.2

