Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DD21B1C10
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 04:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgDUCmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 22:42:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34460 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbgDUCmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:42:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 379CB910E53135906621;
        Tue, 21 Apr 2020 10:42:20 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 10:42:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <hariprasad.kelam@gmail.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtl8723bs: remove unused variable 'pregistrypriv'
Date:   Tue, 21 Apr 2020 10:41:45 +0800
Message-ID: <20200421024145.43576-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function HalRxAggr8723BSdio:
drivers/staging/rtl8723bs/hal/sdio_halinit.c:547:24: warning: variable pregistrypriv set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 7853af53051d..e42d8c18e1ae 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -544,13 +544,9 @@ static void _InitRetryFunction(struct adapter *padapter)
 
 static void HalRxAggr8723BSdio(struct adapter *padapter)
 {
-	struct registry_priv *pregistrypriv;
 	u8 valueDMATimeout;
 	u8 valueDMAPageCount;
 
-
-	pregistrypriv = &padapter->registrypriv;
-
 	valueDMATimeout = 0x06;
 	valueDMAPageCount = 0x06;
 
-- 
2.17.1


