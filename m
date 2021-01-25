Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCAA303648
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbhAZGJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:09:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11493 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbhAYMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:54:20 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPTlt2PZpzjCd2;
        Mon, 25 Jan 2021 20:32:42 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 20:33:45 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <andreyknvl@google.com>,
        <dvyukov@google.com>, <allen.lkml@gmail.com>,
        <stern@rowland.harvard.edu>, <sashal@kernel.org>,
        <gustavoars@kernel.org>, <a.darwish@linutronix.de>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] usb: core: Remove unused including <linux/version.h>
Date:   Mon, 25 Jan 2021 20:44:48 +0800
Message-ID: <1611578688-43256-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following versioncheck warning:

drivers/usb/core/hcd.c:14:1: unused including <linux/version.h>

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/usb/core/hcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 3f03813..53bc93d 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -11,7 +11,6 @@
 
 #include <linux/bcd.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/sched/task_stack.h>
 #include <linux/slab.h>
-- 
2.6.2

