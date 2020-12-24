Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EAD2E273B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgLXNX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:23:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9683 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgLXNX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:23:28 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1rMJ4BhYzkvQJ;
        Thu, 24 Dec 2020 21:21:48 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 21:22:36 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <alexander.shishkin@linux.intel.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] hwtracing: stm: use DEFINE_MUTEX() for mutex lock
Date:   Thu, 24 Dec 2020 21:23:13 +0800
Message-ID: <20201224132313.31070-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/hwtracing/stm/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 2712e699ba08..84c4af6c6dd6 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -367,7 +367,7 @@ static int major_match(struct device *dev, const void *data)
  * with the STM class framework.
  */
 static struct list_head stm_pdrv_head;
-static struct mutex stm_pdrv_mutex;
+static DEFINE_MUTEX(stm_pdrv_mutex);
 
 struct stm_pdrv_entry {
 	struct list_head			entry;
@@ -1326,7 +1326,6 @@ static int __init stm_core_init(void)
 
 	init_srcu_struct(&stm_source_srcu);
 	INIT_LIST_HEAD(&stm_pdrv_head);
-	mutex_init(&stm_pdrv_mutex);
 
 	/*
 	 * So as to not confuse existing users with a requirement
-- 
2.22.0

