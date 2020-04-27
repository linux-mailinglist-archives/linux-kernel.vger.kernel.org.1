Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D791B956D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 05:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgD0DYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 23:24:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbgD0DY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:24:26 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 98EA533ABB677BD946E9;
        Mon, 27 Apr 2020 11:24:24 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 11:24:17 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <wambui.karugax@gmail.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 2/7] staging: rtl8723bs: os_dep: remove set but not used 'size'
Date:   Mon, 27 Apr 2020 11:23:37 +0800
Message-ID: <20200427032342.27211-3-yanaijie@huawei.com>
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

And also remove the NULL check before kfree() because kfree() can handle
NULL pointers correctly.

Fix the following gcc warning:

drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:157:6: warning:
variable ‘size’ set but not used [-Wunused-but-set-variable]
  u32 size = 0;
      ^~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 1ba85a43f05a..b037868fbf22 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -154,17 +154,6 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
 
 static void rtw_spt_band_free(struct ieee80211_supported_band *spt_band)
 {
-	u32 size = 0;
-
-	if (!spt_band)
-		return;
-
-	if (spt_band->band == NL80211_BAND_2GHZ)
-	{
-		size = sizeof(struct ieee80211_supported_band)
-			+ sizeof(struct ieee80211_channel)*RTW_2G_CHANNELS_NUM
-			+ sizeof(struct ieee80211_rate)*RTW_G_RATES_NUM;
-	}
 	kfree(spt_band);
 }
 
-- 
2.21.1

