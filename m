Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33442255C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 04:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGTCKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 22:10:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33928 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTCKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:10:10 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 47382CF4D255012AAD7D;
        Mon, 20 Jul 2020 10:10:08 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 10:10:02 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <minyard@acm.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] ipmi/watchdog: add missing newlines when printing parameters by sysfs
Date:   Mon, 20 Jul 2020 10:03:25 +0800
Message-ID: <1595210605-27888-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I cat some ipmi_watchdog parameters by sysfs, it displays as
follows. It's better to add a newline for easy reading.

root@(none):/# cat /sys/module/ipmi_watchdog/parameters/action
resetroot@(none):/# cat /sys/module/ipmi_watchdog/parameters/preaction
pre_noneroot@(none):/# cat /sys/module/ipmi_watchdog/parameters/preop
preop_noneroot@(none):/#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/char/ipmi/ipmi_watchdog.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 55986e1..3e05a1d 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -232,12 +232,16 @@ static int set_param_str(const char *val, const struct kernel_param *kp)
 static int get_param_str(char *buffer, const struct kernel_param *kp)
 {
 	action_fn fn = (action_fn) kp->arg;
-	int       rv;
+	int rv, len;
 
 	rv = fn(NULL, buffer);
 	if (rv)
 		return rv;
-	return strlen(buffer);
+
+	len = strlen(buffer);
+	len += sprintf(buffer + len, "\n");
+
+	return len;
 }
 
 
-- 
1.7.12.4

