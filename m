Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790442E2749
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgLXNZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:25:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9684 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgLXNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:25:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1rPX2lRyzkvPW;
        Thu, 24 Dec 2020 21:23:44 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 21:24:33 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <bleung@chromium.org>, <enric.balletbo@collabora.com>,
        <linux-kernel@vger.kernel.org>
CC:     <groeck@chromium.org>, Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] platform: chrome: use DEFINE_MUTEX() for mutex lock
Date:   Thu, 24 Dec 2020 21:25:10 +0800
Message-ID: <20201224132510.31450-1-zhengyongjun3@huawei.com>
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
 drivers/platform/chrome/cros_ec_lpc_mec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index 9035b17e8c86..bbc2884f5e2f 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -14,7 +14,7 @@
  * This mutex must be held while accessing the EMI unit. We can't rely on the
  * EC mutex because memmap data may be accessed without it being held.
  */
-static struct mutex io_mutex;
+static DEFINE_MUTEX(io_mutex);
 static u16 mec_emi_base, mec_emi_end;
 
 /**
@@ -142,7 +142,6 @@ EXPORT_SYMBOL(cros_ec_lpc_io_bytes_mec);
 
 void cros_ec_lpc_mec_init(unsigned int base, unsigned int end)
 {
-	mutex_init(&io_mutex);
 	mec_emi_base = base;
 	mec_emi_end = end;
 }
-- 
2.22.0

