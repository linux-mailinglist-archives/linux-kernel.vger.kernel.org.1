Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC83B248420
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHRLrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 07:47:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgHRLrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:47:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 94109DC9F60DB53D44F6;
        Tue, 18 Aug 2020 19:47:31 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 19:47:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] phy: ti: j721e-wiz: Remove duplicate include
Date:   Tue, 18 Aug 2020 19:47:21 +0800
Message-ID: <20200818114721.55464-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate include file

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 33c4cf0105a4..c9cfafe89cbf 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -20,7 +20,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
-#include <dt-bindings/phy/phy.h>
 
 #define WIZ_SERDES_CTRL		0x404
 #define WIZ_SERDES_TOP_CTRL	0x408
-- 
2.17.1


