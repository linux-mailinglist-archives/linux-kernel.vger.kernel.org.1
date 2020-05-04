Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE071C3829
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 13:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgEDLdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 07:33:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbgEDLdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:33:39 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85D99CE2747AD275C5FC;
        Mon,  4 May 2020 19:33:36 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 4 May 2020
 19:33:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] staging: rtl8723bs: remove conversion to bool in halbtcoutsrc_Get()
Date:   Mon, 4 May 2020 19:32:51 +0800
Message-ID: <20200504113251.40791-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/staging/rtl8723bs/hal/hal_btcoex.c:410:59-64: WARNING:
conversion to bool not needed here

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index a6ed1bb9945e..3705a60a0546 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -407,7 +407,7 @@ static u8 halbtcoutsrc_Get(void *pBtcContext, u8 getType, void *pOutBuf)
 		break;
 
 	case BTC_GET_BL_WIFI_ENABLE_ENCRYPTION:
-		*pu8 = padapter->securitypriv.dot11PrivacyAlgrthm == 0 ? false : true;
+		*pu8 = padapter->securitypriv.dot11PrivacyAlgrthm != 0;
 		break;
 
 	case BTC_GET_BL_WIFI_UNDER_B_MODE:
-- 
2.21.1

