Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AE2DFCE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 15:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgLUOfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 09:35:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9907 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgLUOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 09:35:37 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D026F6PYCz7JFZ;
        Mon, 21 Dec 2020 22:34:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 21 Dec 2020 22:34:44 +0800
From:   John Garry <john.garry@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <maz@kernel.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <dan.carpenter@oracle.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] Driver core: platform: Add extra error check in devm_platform_get_irqs_affinity()
Date:   Mon, 21 Dec 2020 22:30:55 +0800
Message-ID: <1608561055-231244-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current check of nvec < minvec for nvec returned from
platform_irq_count() will not detect a negative error code in nvec.

This is because minvec is unsigned, and, as such, nvec is promoted to
unsigned in that check, which will make it a huge number (if it contained
-EPROBE_DEFER).

In practice, an error should not occur in nvec for the only in-tree
user, but add a check anyway.

Fixes: e15f2fa959f2 ("driver core: platform: Add devm_platform_get_irqs_affinity()")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
I hope that this can go through either irqchip or driver/core trees, thanks!

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 95fd1549f87d..8456d8384ac8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -366,6 +366,8 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
 		return -ERANGE;
 
 	nvec = platform_irq_count(dev);
+	if (nvec < 0)
+		return nvec;
 
 	if (nvec < minvec)
 		return -ENOSPC;
-- 
2.26.2

