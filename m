Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3304D2B8BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKSHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:04:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7951 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKSHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:04:14 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cc9dS0srczhdH9;
        Thu, 19 Nov 2020 15:03:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 15:03:57 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] ipmi: msghandler: Suppress suspicious RCU usage warning
Date:   Thu, 19 Nov 2020 15:08:39 +0800
Message-ID: <20201119070839.381-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

while running ipmi, ipmi_smi_watcher_register() caused
a suspicious RCU usage warning.

-----

=============================
WARNING: suspicious RCU usage
5.10.0-rc3+ #1 Not tainted
-----------------------------
drivers/char/ipmi/ipmi_msghandler.c:750 RCU-list traversed in non-reader section!!
other info that might help us debug this:
rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor.0/4254:
stack backtrace:
CPU: 0 PID: 4254 Comm: syz-executor.0 Not tainted 5.10.0-rc3+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/ 01/2014
Call Trace:
dump_stack+0x19d/0x200
ipmi_smi_watcher_register+0x2d3/0x340 [ipmi_msghandler]
acpi_ipmi_init+0xb1/0x1000 [acpi_ipmi]
do_one_initcall+0x149/0x7e0
do_init_module+0x1ef/0x700
load_module+0x3467/0x4140
__do_sys_finit_module+0x10d/0x1a0
do_syscall_64+0x34/0x80
entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x468ded

-----

It is safe because smi_watchers_mutex is locked and srcu_read_lock
has been used, so simply pass lockdep_is_held() to the
list_for_each_entry_rcu() to suppress this warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 8774a3b8f..c44ad1846 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -747,7 +747,8 @@ int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
 	list_add(&watcher->link, &smi_watchers);
 
 	index = srcu_read_lock(&ipmi_interfaces_srcu);
-	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link,
+			lockdep_is_held(&smi_watchers_mutex)) {
 		int intf_num = READ_ONCE(intf->intf_num);
 
 		if (intf_num == -1)
-- 
2.23.0

