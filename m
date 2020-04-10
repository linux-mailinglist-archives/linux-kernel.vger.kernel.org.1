Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0E01A4600
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 13:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDJLzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 07:55:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbgDJLzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:55:31 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 66CABBA4FA78403941D0;
        Fri, 10 Apr 2020 19:55:26 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 19:55:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mfd: stpmic1: Make stpmic1_regmap_config static
Date:   Fri, 10 Apr 2020 19:55:14 +0800
Message-ID: <20200410115514.41916-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/mfd/stpmic1.c:62:28: warning:
 symbol 'stpmic1_regmap_config' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mfd/stpmic1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 7dfbe8906cb8..eb3da558c3fb 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -59,7 +59,7 @@ static const struct regmap_access_table stpmic1_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(stpmic1_volatile_ranges),
 };
 
-const struct regmap_config stpmic1_regmap_config = {
+static const struct regmap_config stpmic1_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.cache_type = REGCACHE_RBTREE,
-- 
2.17.1


