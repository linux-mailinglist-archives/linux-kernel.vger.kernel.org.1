Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136902CA0DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgLALE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:04:58 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8900 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbgLALE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:04:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ClfNk1VgXz72gb;
        Tue,  1 Dec 2020 19:03:50 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 19:04:04 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <michal.simek@xilinx.com>, <rajan.vaja@xilinx.com>,
        <gregkh@linuxfoundation.org>, <jolly.shah@xilinx.com>,
        <tejas.patel@xilinx.com>, <manish.narani@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] firmware: xilinx: Mark pm_api_features_map with static keyword
Date:   Tue, 1 Dec 2020 19:15:43 +0800
Message-ID: <1606821343-121199-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/firmware/xilinx/zynqmp.c:32:1: warning: symbol 'pm_api_features_map' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/firmware/xilinx/zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index d08ac82..943c2ac5 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -29,7 +29,7 @@
 #define PM_API_FEATURE_CHECK_MAX_ORDER  7
 
 static bool feature_check_enabled;
-DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
+static EFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
 
 /**
  * struct pm_api_feature_data - PM API Feature data
-- 
2.6.2

