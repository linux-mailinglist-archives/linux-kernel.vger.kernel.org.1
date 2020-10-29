Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD38229EF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgJ2PLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:11:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32977 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgJ2PLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:11:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kY9Zv-0008Eg-Uh; Thu, 29 Oct 2020 15:11:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] sched/debug: fix memory corruption caused by multiple small reads of flags
Date:   Thu, 29 Oct 2020 15:11:03 +0000
Message-Id: <20201029151103.373410-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Reading /proc/sys/kernel/sched_domain/cpu*/domain0/flags mutliple times
with small reads causes oopses with slub corruption issues because the kfree is
free'ing an offset from a previous allocation. Fix this by adding in a new
pointer 'buf' for the allocation and kfree and use the temporary pointer tmp
to handle memory copies of the buf offsets.

Detected by running 'stress-ng --procfs 0' on 5.10-rc1; example splat:

[  984.137351] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-128' (offset 127, size 3)!
[  984.148917] ------------[ cut here ]------------
[  984.154089] kernel BUG at mm/usercopy.c:99!
[  984.158813] invalid opcode: 0000 [#1] SMP PTI
[  984.163771] CPU: 0 PID: 3031471 Comm: stress-ng-procf Tainted: G          I       5.10.0-rc1 #1
[  984.173483] Hardware name: IBM IBM System X3250 M4 -[2583AC1]-/00D3729, BIOS -[JQE158AUS-1.05]- 07/23/2013
[  984.184260] RIP: 0010:usercopy_abort+0x74/0x76
[  984.189219] Code: 67 5c 8b 51 48 0f 45 d6 49 c7 c3 73 f7 5f 8b 4c 89 d1 57 48 c7 c6 68 57 5e 8b 48 c7 c7 38 f8 5f 8b 49 0f 45 f3 e8 13 71 ff ff <0f> 0b 4c 89 e1 49 89 d8 44 89 ea 31 f6 48 29 c1 48 c7 c7 b5 f7 5f
[  984.210177] RSP: 0018:ffff9c1f007b3dc0 EFLAGS: 00010286
[  984.216000] RAX: 0000000000000066 RBX: 0000000000000003 RCX: 0000000000000000
[  984.223965] RDX: ffff911f37c27e20 RSI: ffff911f37c19050 RDI: ffff911f37c19050
[  984.231929] RBP: ffff911e04cd1f82 R08: 0000000000000000 R09: 0000000000000000
[  984.239893] R10: ffff9c1f007b3bf8 R11: ffffffff8bd711a8 R12: ffff911e04cd1f7f
[  984.247857] R13: 0000000000000001 R14: 0000000000000003 R15: ffff911e009b19c0
[  984.255821] FS:  00007fbabb42b180(0000) GS:ffff911f37c00000(0000) knlGS:0000000000000000
[  984.264915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  984.271520] CR2: 00007fbabb7ef000 CR3: 000000014e296001 CR4: 00000000001706f0
[  984.279683] Call Trace:
[  984.282581]  __check_heap_object+0xe0/0x110
[  984.287405]  __check_object_size+0x136/0x150
[  984.292347]  proc_sys_call_handler+0x167/0x250
[  984.297565]  new_sync_read+0x108/0x180
[  984.302082]  vfs_read+0x174/0x1d0
[  984.306126]  ksys_read+0x58/0xd0
[  984.310022]  do_syscall_64+0x33/0x40
[  984.314277]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  984.320201] RIP: 0033:0x7fbabb6099ac
[  984.324514] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 89 fc ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 bf fc ff ff 48
[  984.346368] RSP: 002b:00007fff47397340 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  984.355402] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbabb6099ac
[  984.363971] RDX: 0000000000000060 RSI: 00007fff47397390 RDI: 0000000000000006
[  984.372583] RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000000000
[  984.381093] R10: 00000000000fa2b4 R11: 0000000000000246 R12: 0000000000000003
[  984.389577] R13: 00007fff473a3630 R14: 0000000000001000 R15: 0000000000000060
[  984.398087] Modules linked in: binfmt_misc rfkill sunrpc intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal mgag200 intel_powerclamp iTCO_wdt i2c_algo_bit coretemp intel_pmc_bxt cdc_ether gpio_ich drm_kms_helper iTCO_vendor_support usbnet mii cec rapl ipmi_ssif i2c_i801 intel_cstate e1000e intel_uncore ie31200_edac pcspkr ipmi_si i2c_smbus lpc_ich ipmi_devintf ipmi_msghandler drm ip_tables xfs crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ata_generic pata_acpi wmi
[  984.449316] ---[ end trace d44739bb135b1e63 ]---

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209919
Reported-by: Jeff Bastian <jbastian@redhat.com>
Fixes: 5b9f8ff7b320 ("sched/debug: Output SD flag names rather than their values")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/sched/debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0655524..2357921 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -251,7 +251,7 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
 	unsigned long flags = *(unsigned long *)table->data;
 	size_t data_size = 0;
 	size_t len = 0;
-	char *tmp;
+	char *tmp, *buf;
 	int idx;
 
 	if (write)
@@ -269,17 +269,17 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
 		return 0;
 	}
 
-	tmp = kcalloc(data_size + 1, sizeof(*tmp), GFP_KERNEL);
-	if (!tmp)
+	buf = kcalloc(data_size + 1, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
 	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
 		char *name = sd_flag_debug[idx].name;
 
-		len += snprintf(tmp + len, strlen(name) + 2, "%s ", name);
+		len += snprintf(buf + len, strlen(name) + 2, "%s ", name);
 	}
 
-	tmp += *ppos;
+	tmp = buf + *ppos;
 	len -= *ppos;
 
 	if (len > *lenp)
@@ -294,7 +294,7 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
 	*lenp = len;
 	*ppos += len;
 
-	kfree(tmp);
+	kfree(buf);
 
 	return 0;
 }
-- 
2.7.4

