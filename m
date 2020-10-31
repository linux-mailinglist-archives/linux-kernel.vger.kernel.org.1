Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984932A14FE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgJaJzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:55:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:7001 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgJaJze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:55:34 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CNZLF2kq2zhZlP;
        Sat, 31 Oct 2020 17:55:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 17:55:23 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <Al.Grant@arm.com>, <mike.leach@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
Subject: [PATCH] Description: coresight: funnel: Remove unnecessary .owner of static funnel driver
Date:   Sat, 31 Oct 2020 17:53:58 +0800
Message-ID: <1604138038-44761-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As driver.owner has been set in platform_driver_register(), it is
unnecessary to set it in static funnel driver, so remove it from
struct static_funnel_driver.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index af40814..07bc203 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -356,7 +356,6 @@ static struct platform_driver static_funnel_driver = {
 	.remove          = static_funnel_remove,
 	.driver         = {
 		.name   = "coresight-static-funnel",
-		.owner	= THIS_MODULE,
 		.of_match_table = static_funnel_match,
 		.acpi_match_table = ACPI_PTR(static_funnel_ids),
 		.pm	= &funnel_dev_pm_ops,
--
2.8.1

