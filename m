Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B91B956A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 05:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgD0DY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 23:24:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbgD0DY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:24:26 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 917957C97F2E8E0CBAB9;
        Mon, 27 Apr 2020 11:24:24 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 11:24:18 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <wambui.karugax@gmail.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 3/7] Staging: rtl8723bs: core: remove set but not used 'ptxservq'
Date:   Mon, 27 Apr 2020 11:23:38 +0800
Message-ID: <20200427032342.27211-4-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427032342.27211-1-yanaijie@huawei.com>
References: <20200427032342.27211-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/staging/rtl8723bs/core/rtw_sta_mgt.c:556:19: warning: variable
‘ptxservq’ set but not used [-Wunused-but-set-variable]
  struct tx_servq *ptxservq;
                   ^~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 09d2ca30d653..e3f56c6cc882 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -553,7 +553,6 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 {
 
 	struct sta_info *psta;
-	struct tx_servq	*ptxservq;
 	u32 res = _SUCCESS;
 	NDIS_802_11_MAC_ADDRESS	bcast_addr = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
@@ -571,7 +570,6 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 	/*  default broadcast & multicast use macid 1 */
 	psta->mac_id = 1;
 
-	ptxservq = &(psta->sta_xmitpriv.be_q);
 exit:
 	return _SUCCESS;
 }
-- 
2.21.1

