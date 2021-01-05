Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EF42EA32C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbhAECGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:06:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10543 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhAECGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:06:05 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D8wlx5p3xzMFGD;
        Tue,  5 Jan 2021 10:04:13 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 5 Jan 2021 10:05:06 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <nsaenzjulienne@suse.de>, <bcm-kernel-feedback-list@broadcom.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v3 -next] staging: vc04_services: use DEFINE_MUTEX() for mutex lock
Date:   Tue, 5 Jan 2021 10:05:47 +0800
Message-ID: <20210105020547.19042-1-zhengyongjun3@huawei.com>
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
 .../vc04_services/interface/vchiq_arm/vchiq_connected.c     | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index 79b75efa6868..938307f39b9c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -12,15 +12,13 @@ static   int                        g_connected;
 static   int                        g_num_deferred_callbacks;
 static   VCHIQ_CONNECTED_CALLBACK_T g_deferred_callback[MAX_CALLBACKS];
 static   int                        g_once_init;
-static   struct mutex               g_connected_mutex;
+static   DEFINE_MUTEX(g_connected_mutex);
 
 /* Function to initialize our lock */
 static void connected_init(void)
 {
-	if (!g_once_init) {
-		mutex_init(&g_connected_mutex);
+	if (!g_once_init)
 		g_once_init = 1;
-	}
 }
 
 /*
-- 
2.22.0

