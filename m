Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25AE2C09F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgKWNOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:14:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8016 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733168AbgKWNOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:14:48 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cfng64Fw3zhf28;
        Mon, 23 Nov 2020 21:14:26 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 23 Nov 2020
 21:14:39 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <akpm@linux-foundation.org>, <keescook@chromium.org>,
        <mingo@kernel.org>, <peterz@infradead.org>, <mcgrof@kernel.org>,
        <huyue2@yulong.com>, <yangtiezhu@loongson.cn>, <will@kernel.org>,
        <aquini@redhat.com>, <gpiccoli@canonical.com>,
        <xuqiang36@huawei.com>, <aik@ozlabs.ru>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] panic: complete the flush of the hard deadlock log messages to the serial port
Date:   Mon, 23 Nov 2020 13:13:59 +0000
Message-ID: <20201123131359.34600-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when hardlockup_all_cpu_backtrace is on, and there are
a large number of cores in the system, it takes
a long time to output the hard deadlock logs of all cores
to the serial port. When the console_flush_on_panic function
in panic is executed, console_locked is still held.
As a result, garbled characters are displayed in the serial port log.

To solve this problem, wait for a maximum of 10s for the serial port
to be released before console_flush_on_panic.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 kernel/panic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 332736a72a58..0014788e8141 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -301,6 +301,14 @@ void panic(const char *fmt, ...)
 	 * panic() is not being callled from OOPS.
 	 */
 	debug_locks_off();
+
+	/* Wait for all CPUs to complete console_unlock */
+	for (i = 0; i < 10 * 1000; i++) {
+		if (console_trylock())
+			break;
+		mdelay(1);
+	}
+
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
 	panic_print_sys_info();
-- 
2.25.0

