Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8491CBF1C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 10:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgEIIfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 04:35:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbgEIIfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:35:23 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 401BF4BFEB9BD8BEEB06;
        Sat,  9 May 2020 16:35:22 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 16:35:14 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jiri Kosina <trivial@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH trivial] bootconfig: Fixup one typo
Date:   Sat, 9 May 2020 16:33:55 +0800
Message-ID: <1589013235-56363-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up one typo: CONFIG_BOOTCONFIG -> CONFIG_BOOT_CONFIG

Cc: Jiri Kosina <trivial@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 1a5da2c2660c..8369ba173ad8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -460,7 +460,7 @@ static void __init setup_boot_config(const char *cmdline)
 
 static int __init warn_bootconfig(char *str)
 {
-	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set.\n");
+	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOT_CONFIG is not set.\n");
 	return 0;
 }
 early_param("bootconfig", warn_bootconfig);
-- 
2.7.4

