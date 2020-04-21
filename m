Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC391B1CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 05:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgDUDk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 23:40:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbgDUDk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:40:27 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E619CF38668279082537;
        Tue, 21 Apr 2020 11:40:22 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 11:40:15 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jannh@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] usb/early: remove unused including <linux/version.h>
Date:   Tue, 21 Apr 2020 11:39:45 +0800
Message-ID: <20200421033945.27703-1-yanaijie@huawei.com>
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

Fix the following versioncheck warning:

drivers/usb/early/xhci-dbc.c:21:1: unused including <linux/version.h>

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/usb/early/xhci-dbc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index 171280c80228..04ba11fff0ed 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -18,7 +18,6 @@
 #include <asm/fixmap.h>
 #include <linux/bcd.h>
 #include <linux/export.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
-- 
2.21.1

