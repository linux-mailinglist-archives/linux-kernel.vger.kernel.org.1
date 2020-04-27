Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B71B9569
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 05:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgD0DY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 23:24:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbgD0DY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:24:26 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9514C640622D3E290034;
        Mon, 27 Apr 2020 11:24:24 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 11:24:16 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <wambui.karugax@gmail.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 1/7] staging: rtl8723bs: os_dep: remove set but not used 'uintRet'
Date:   Mon, 27 Apr 2020 11:23:36 +0800
Message-ID: <20200427032342.27211-2-yanaijie@huawei.com>
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

drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2564:22: warning:
variable ‘uintRet’ set but not used [-Wunused-but-set-variable]
         unsigned int uintRet = 0;
                      ^~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 5059b874080e..902ac8169948 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2561,14 +2561,16 @@ static int rtw_wps_start(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct iw_point *pdata = &wrqu->data;
 	u32   u32wps_start = 0;
-        unsigned int uintRet = 0;
 
 	if ((true == padapter->bDriverStopped) || (true == padapter->bSurpriseRemoved) || (NULL == pdata)) {
 		ret = -EINVAL;
 		goto exit;
 	}
 
-	uintRet = copy_from_user((void *)&u32wps_start, pdata->pointer, 4);
+	if (copy_from_user((void *)&u32wps_start, pdata->pointer, 4)) {
+		ret = -EFAULT;
+		goto exit;
+	}
 	if (u32wps_start == 0)
 		u32wps_start = *extra;
 
-- 
2.21.1

