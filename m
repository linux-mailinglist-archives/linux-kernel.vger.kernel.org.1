Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0801F2CE99C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgLDIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:30:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8645 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgLDIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:30:47 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnQqP3FbXz15XKk;
        Fri,  4 Dec 2020 16:29:37 +0800 (CST)
Received: from compute.localdomain (10.175.112.70) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 4 Dec 2020 16:29:56 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Zhang Changzhong <zhangchangzhong@huawei.com>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM: AVS: rockchip-io: Fix error return code in rockchip_iodomain_probe()
Date:   Fri, 4 Dec 2020 16:33:25 +0800
Message-ID: <1607070805-33038-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: e943c43b32ce ("PM: AVS: rockchip-io: Move the driver to the rockchip specific drivers")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/soc/rockchip/io-domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
index eece97f..b29e829 100644
--- a/drivers/soc/rockchip/io-domain.c
+++ b/drivers/soc/rockchip/io-domain.c
@@ -547,6 +547,7 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 		if (uV < 0) {
 			dev_err(iod->dev, "Can't determine voltage: %s\n",
 				supply_name);
+			ret = uV;
 			goto unreg_notify;
 		}
 
-- 
2.9.5

