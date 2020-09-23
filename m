Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F26027549D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWJg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:36:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgIWJg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:36:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 70B9F4AB2FB939EC5AFB;
        Wed, 23 Sep 2020 17:36:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 23 Sep 2020 17:36:42 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <zhangshaokun@hisilicon.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] drivers/perf: hisi: Fix typo in HiSilicon DDRC driver
Date:   Wed, 23 Sep 2020 17:35:29 +0800
Message-ID: <1600853729-37985-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up typo in function hisi_ddrc_pmu_write_evtype(), and the whitespace
in function hisi_ddrc_pmu_module_exit()

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 5e3645c..e6fe4b8 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -93,7 +93,7 @@ static void hisi_ddrc_pmu_write_counter(struct hisi_pmu *ddrc_pmu,
  * For DDRC PMU, event has been mapped to fixed-purpose counter by hardware,
  * so there is no need to write event type.
  */
-static void hisi_ddrc_pmu_write_evtype(struct hisi_pmu *hha_pmu, int idx,
+static void hisi_ddrc_pmu_write_evtype(struct hisi_pmu *ddrc_pmu, int idx,
 				       u32 type)
 {
 }
@@ -450,7 +450,6 @@ static void __exit hisi_ddrc_pmu_module_exit(void)
 {
 	platform_driver_unregister(&hisi_ddrc_pmu_driver);
 	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE);
-
 }
 module_exit(hisi_ddrc_pmu_module_exit);

--
2.8.1

