Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8312722027B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 04:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgGOCrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 22:47:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbgGOCrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:47:49 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5E0021359E7F3911B2C4;
        Wed, 15 Jul 2020 10:47:47 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 10:47:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <sudeep.holla@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soc: integrator: Drop pointless static qualifier in integrator_soc_init()
Date:   Wed, 15 Jul 2020 10:47:01 +0800
Message-ID: <20200715024701.28356-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the 'struct regmap *syscon_regmap' variable
static since new value always be assigned before use it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soc/versatile/soc-integrator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/versatile/soc-integrator.c b/drivers/soc/versatile/soc-integrator.c
index 7dcf77ccd31e..bab4ad87aa75 100644
--- a/drivers/soc/versatile/soc-integrator.c
+++ b/drivers/soc/versatile/soc-integrator.c
@@ -100,7 +100,7 @@ ATTRIBUTE_GROUPS(integrator);
 
 static int __init integrator_soc_init(void)
 {
-	static struct regmap *syscon_regmap;
+	struct regmap *syscon_regmap;
 	struct soc_device *soc_dev;
 	struct soc_device_attribute *soc_dev_attr;
 	struct device_node *np;
-- 
2.17.1


