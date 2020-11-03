Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD94C2A462A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgKCNX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:23:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7042 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgKCNX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:23:27 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQVpg09mjzhgJV;
        Tue,  3 Nov 2020 21:23:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 21:23:13 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
Subject: [PATCH] coresight: Remove unnecessary THIS_MODULE of funnel and replicator driver
Date:   Tue, 3 Nov 2020 21:21:48 +0800
Message-ID: <1604409708-12400-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As THIS_MODULE has been set in platform_driver_register(), so remove it
from static funnel driver and static replicator driver to avoid set it
twice.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c     | 2 +-
 drivers/hwtracing/coresight/coresight-replicator.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index af40814..39be46b 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -356,7 +356,7 @@ static struct platform_driver static_funnel_driver = {
 	.remove          = static_funnel_remove,
 	.driver         = {
 		.name   = "coresight-static-funnel",
-		.owner	= THIS_MODULE,
+		/* THIS_MODULE is taken care of by platform_driver_register() */
 		.of_match_table = static_funnel_match,
 		.acpi_match_table = ACPI_PTR(static_funnel_ids),
 		.pm	= &funnel_dev_pm_ops,
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 62afdde..6772f23 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -374,7 +374,7 @@ static struct platform_driver static_replicator_driver = {
 	.remove         = static_replicator_remove,
 	.driver         = {
 		.name   = "coresight-static-replicator",
-		.owner	= THIS_MODULE,
+		/* THIS_MODULE is taken care of by platform_driver_register() */
 		.of_match_table = of_match_ptr(static_replicator_match),
 		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
 		.pm	= &replicator_dev_pm_ops,
--
2.8.1

