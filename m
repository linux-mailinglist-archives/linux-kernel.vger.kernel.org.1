Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0612773B4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIXOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:12:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727982AbgIXOMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:12:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 86A2948D9CD1426027F9;
        Thu, 24 Sep 2020 22:12:50 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 22:12:47 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: typec: Remove set but not used variable
Date:   Thu, 24 Sep 2020 22:12:47 +0800
Message-ID: <1600956767-10427-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/usb/typec/tcpm/tcpm.c:1620:39: warning:
‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 9280654..1542eaa 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1617,12 +1617,6 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
 	return 0;
 }

-static const struct typec_altmode_ops tcpm_altmode_ops = {
-	.enter = tcpm_altmode_enter,
-	.exit = tcpm_altmode_exit,
-	.vdm = tcpm_altmode_vdm,
-};
-
 /*
  * PD (data, control) command handling functions
  */
--
2.7.4

