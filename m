Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC742E274B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgLXNZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:25:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9922 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgLXNZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:25:49 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D1rQL5R4Tzhs4k;
        Thu, 24 Dec 2020 21:24:26 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 21:24:51 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <nsaenzjulienne@suse.de>, <bcm-kernel-feedback-list@broadcom.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] staging: vc04_services: use DEFINE_MUTEX() for mutex lock
Date:   Thu, 24 Dec 2020 21:25:28 +0800
Message-ID: <20201224132528.31558-1-zhengyongjun3@huawei.com>
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
 .../vc04_services/interface/vchiq_arm/vchiq_connected.c        | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index 79b75efa6868..864253866155 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -12,13 +12,12 @@ static   int                        g_connected;
 static   int                        g_num_deferred_callbacks;
 static   VCHIQ_CONNECTED_CALLBACK_T g_deferred_callback[MAX_CALLBACKS];
 static   int                        g_once_init;
-static   struct mutex               g_connected_mutex;
+static   DEFINE_MUTEX(g_connected_mutex);
 
 /* Function to initialize our lock */
 static void connected_init(void)
 {
 	if (!g_once_init) {
-		mutex_init(&g_connected_mutex);
 		g_once_init = 1;
 	}
 }
-- 
2.22.0

