Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AAA2FEC56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbhAUNwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:52:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27670 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbhAUNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611237112; x=1642773112;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=CHc4DEvelflg/MytPwX5B8s39rVBNQFolitPXdcvRr0=;
  b=m4P0WRgyn2pe7KPbo5G1EzpVcaBpo96/KSEELb0vQgOly1Xku8oiu4pF
   TXQGOACKbEk1+PgoDiSIsDOfJ1E4vc+yLR1KGFfAMrnoyPJTJhne5CeoS
   FBLEkJJmBlIWUKjXKSFwttUs6SYS01pQkNJHFilbK6X5b/5ExsVo/W7Be
   8Vq+Z4uHKNqBrYzG8w9lCvGxQ8DqFRsfy5mXNi0GQZSGfcmH6ZP0j0atH
   EecrprKXX3eJ81q+rirMeBZvhSPOUQSCYa24P3ZBIvsOLOQTam5fOBdOD
   HgBDZmYwQKQ83F/yp8Gnvu5mqGw5eJ9lwm5HK3vbsHNJaNL/8A/NFbIp+
   A==;
IronPort-SDR: aGBo3nQtCXOvarCU2EF+mRnxRlnGxC8riQcApytIoloJRnAA1vzhlJGSY4V0xDfzRhy7JKWsxP
 l83VIhNMznBXDMlyfy5qiYOz+w/a2CXpx+WusTOLRnlNT2y7AWkljjePY+NKJN7jDgkuiVqPAu
 fG2Dh9PWybkYs6rMtgWwXqQWSJcikus4/P+DUP8in3cI+yAYxp0Dj4waYE6uMrMQ9M74Zw0HJk
 hbOgPSWFZw4uXP/6gzVM1DiDAVyLHGPNjRdaIrqhJgbxSWJz/rknjAX7cfLgLS7btY6z0N1x13
 u/0=
X-IronPort-AV: E=Sophos;i="5.79,364,1602518400"; 
   d="scan'208";a="268322848"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2021 21:50:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvQXJCltsG35iTWOaBWIgbRWZGqGf6wYd6AhYCzlG6DcgZtEYj+mpVaFL9NUzw3Ppav6FYsKOLlZh+qh+15MmFIbk8/QNelxZPefCAEy73qLjOMASv58Hgu8CkrvyIPtveuA9qXSZtpudedm0N9nQkPY/IChktDWSiJzgtwczjLGGhQj/Jy+fHyaLn3lexQKBAHmXhqLBec05yeAE2wyLySg6ZYAiy23J6bkZsPqJ/AB6daYNad6F3W2kXspoCE8uwSsZA2wnUHEFo9ZMcZPxpZJ77Ta36iHDsU7TdVdYaYXA8BzdW8MDRlNTY3KHzbOQ1i54oxCxfMVcFKp6cMztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFWPaPXGqrjWxDVuWCtQUbgrZujO09lMv5JwpLaPwcg=;
 b=OxoftdWHUally1ICdhP8hAs57Ee8soWgX4jQWZEiOv5LwBkdIj1AoJQajPMA/ultk0wHXumLKpR4y0flznYrD8lWEiF+jMZs3Wb99VHQNrnqeceF+yFNFnVj1MCX8kI1J4feK/MTOB0tdnN8keKqNL2pedGebIOHrcmGG2cjRB0sqbB1V8iJyWF3Nz+PyvM7VWbmLJfafdJpmFEzY2sTH67I0UbQuLBaHEQN4aAERES7IdBsmQB+XR27FBvb/g7giMXEaDZ0+MqtcImZhEYZWUmnTnFXyRY3GwwgajzMwsXSFSWxb+hz8ZEgYOVgngAOk0YVxZrLi2THf6hbCAUK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFWPaPXGqrjWxDVuWCtQUbgrZujO09lMv5JwpLaPwcg=;
 b=abbbKOdJRJyHtENDI3oOtb4TuDTfeEo5bgqN1zQ+VhoqIuyzWRXMM6bpR3y2vSDmbN8gR5Ul2RPDwnR6UY+3CMMk+yXazVGcBSBhhICiDnXioKPdRPdwVxcJYUxzbGa/gGV6XRSzeQPVzJzZsh0mv0IPfXiWcsfWNPNWrIaOmZQ=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0346.namprd04.prod.outlook.com (2603:10b6:3:6f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Thu, 21 Jan 2021 13:50:41 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::2513:b200:bdc8:b97]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::2513:b200:bdc8:b97%5]) with mapi id 15.20.3784.013; Thu, 21 Jan 2021
 13:50:41 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v4] RISC-V: Implement ASID allocator
Date:   Thu, 21 Jan 2021 19:20:16 +0530
Message-Id: <20210121135016.34718-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.119.192]
X-ClientProxiedBy: MAXPR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::22) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.119.192) by MAXPR01CA0104.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 13:50:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 675cb1d8-4866-46de-d3ac-08d8be138a6e
X-MS-TrafficTypeDiagnostic: DM5PR04MB0346:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB034670185009F0991B8623118DA19@DM5PR04MB0346.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jKU1zvIDHkWP22HZs3+X0+9Z6WaYQcR1vLYwnz69qhc6b3oRX1xKc1lIWkDvNHF3cW1HWzXfVI4eIZbCezWlYR+/h15aM4QZxqYoxI5HzOo8WmRSjYMSB8IuQRGGITrMlIJcSiW0WX+g1KTl/h1NCXFcVM6/LzWO3oTeK1sxFBkpAHrvbi52+ywlacoDsoRGdWpGKjXMQUIpL5kEfToLiG6AZplgkcwvN3UYpL0vSmRCuXnJUORMo2F1OUf+3wyPwida9OH/Dv9ryRtyHA4Yaq04sb/LWpu/E8AOOWuWF0Mvc3eK4q7YtUOvml+qPUseHGg9ABUPrNpCRUiA68Qk/Xh3rujqTtXkA0KyOQ+sriFLiyC7sKX7vkA39xJ/PQ6xyhkmS7ah0nG/6/rT4uwtgBz3OFqZUc6C4MuaX08/Hk4QgtD0NMjplDq1lBEaz/4lLb3YiV54dU7E8o08hrfKlnF3Xb9YgE6yTMg97MaKR8K2kzoxlU1sHglWGOtachgJy8B9dPatyw/dKpcV6H1zueO7rTHMpK5beT1XHg/BzneESG+NmyekVWZAwY7j9FPmsref6jqht/cac4z6Cw8N+CVyAQQzsY9xSby/a6s8EA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(478600001)(966005)(8676002)(956004)(2616005)(7696005)(8886007)(8936002)(44832011)(52116002)(6666004)(4326008)(316002)(83380400001)(1076003)(110136005)(54906003)(26005)(16526019)(36756003)(186003)(66476007)(55016002)(2906002)(30864003)(66556008)(66946007)(86362001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7unowUlNZKb0EKnNnCGm0lhMtAB7pMDEwmHWh9THavNWU55sEyQ18wElklYs?=
 =?us-ascii?Q?bBC2Bh1SEVSUzqNNyLjjns08cm//Lc2wwyVyfgoS6W5ayWp2YJdU/Zck3PC4?=
 =?us-ascii?Q?Cv3/55NHx/Vz1Yaf8SEJiTwRK0UIEnWlaLd/Eo1Hmu0inbMnmgfmiFLDOYsJ?=
 =?us-ascii?Q?Hh6pvz0q0O5iWy5n+5vd3kmfMUa7zv9dtMAuBJzkeV+SXw03qYptd90xSFT9?=
 =?us-ascii?Q?RRXOFd1R2dXe/HdE9V2GVKBbaQXVcouUw3Twe/AbOp+mLTYNRnTMow6Pnpwl?=
 =?us-ascii?Q?caPTTabpVyQfQCN9vYsn9ZC31CcECnAp+Q4p0rbpIcV81zw7mr09lUai27ta?=
 =?us-ascii?Q?SpzY/AfQsR4NR2mWESMoMW3aAc7A2dU2j+IuHkks4ts9BYXlQoOgg6eU5FOM?=
 =?us-ascii?Q?gTZwprpD0/rlW5RcGgsdEzoL8+sjbeZOQLX54UTrkoyBU88w5wVpLx2S4rhu?=
 =?us-ascii?Q?VlFl96juojisnKMMVEWbiTray/p8L9nRnboeWkMMQcNz9qYvmK50TB0ZdRON?=
 =?us-ascii?Q?O0CQs0sbPfLfgASzIaQfW5M7hwp8L8uabOLwvl8OoFn5tccGcGjj//IXleUG?=
 =?us-ascii?Q?7HNrJH8ooTKJ9O5C6NZpAdVQVbUcJgEuYjURCcKABf6wp9HSAvfNYdVhTMy6?=
 =?us-ascii?Q?vjcNoUg/7Hj0jVkx90sVfly0wBiTvrva3Za9tEC7qCFjYjIUbc4WgcodxDht?=
 =?us-ascii?Q?Ys3Z5ith5JSfKn+SdkhJZYfzxGHFA62zMUX+sJcJBqyLl4pwWqEiLcnYqP7R?=
 =?us-ascii?Q?G8rL8IV2TFveJpQEYL6Xa3BCgS/vTAP8ViAu/KLbyZW9Pa/av0pd6W00tTX5?=
 =?us-ascii?Q?tAub8jUmrexSbzk4ViFzMlrkjFQeMHEc1fKdIelPt5tTBukZkI6ldweos4CV?=
 =?us-ascii?Q?q0mCzk2Y+yaIS1YRgwzPGiNh1r1ctpoaQCHRd7MbiAy44XKQSL+4x3JNf5+q?=
 =?us-ascii?Q?51+nimYf83vbkiVXbVc+RJ+g3TJdyr0KcuUx2pMEbar3mYpGcClKKpJYyWdh?=
 =?us-ascii?Q?YRgf?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675cb1d8-4866-46de-d3ac-08d8be138a6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 13:50:41.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+I2oUaVkVT0wTWGjyTRhQj1Aje39Po3NVWYaVk8qfirQSjjdy5CC8ZcPdSb8iZJV2nzqnhyf26ARmjCiACmsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0346
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we do local TLB flush on every MM switch. This is very harsh on
performance because we are forcing page table walks after every MM switch.

This patch implements ASID allocator for assigning an ASID to a MM context.
The number of ASIDs are limited in HW so we create a logical entity named
CONTEXTID for assigning to MM context. The lower bits of CONTEXTID are ASID
and upper bits are VERSION number. The number of usable ASID bits supported
by HW are detected at boot-time by writing 1s to ASID bits in SATP CSR.

We allocate new CONTEXTID on first MM switch for a MM context where the
ASID is allocated from an ASID bitmap and VERSION is provide by an atomic
counter. At time of allocating new CONTEXTID, if we run out of available
ASIDs then:
1. We flush the ASID bitmap
2. Increment current VERSION atomic counter
3. Re-allocate ASID from ASID bitmap
4. Flush TLB on all CPUs
5. Try CONTEXTID re-assignment on all CPUs

Please note that we don't use ASID #0 because it is used at boot-time by
all CPUs for initial MM context. Also, newly created context is always
assigned CONTEXTID #0 (i.e. VERSION #0 and ASID #0) which is an invalid
context in our implementation.

Using above approach, we have virtually infinite CONTEXTIDs on-top-of
limited number of HW ASIDs. This approach is inspired from ASID allocator
used for Linux ARM/ARM64 but we have adapted it for RISC-V. Overall, this
ASID allocator helps us reduce rate of local TLB flushes on every CPU
thereby increasing performance.

This patch is tested on QEMU virt machine, Spike and SiFive Unleashed
board. On QEMU virt machine, we see some (3-5% approx) performance
improvement with SW emulated TLBs provided by QEMU. Unfortunately,
the ASID bits of the SATP CSR are not implemented on Spike and SiFive
Unleashed board so we don't see any change in performance. On real
HW having all ASID bits implemented, the performance gains will be
much more due improved sharing of TLB among different processes.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
Changes since v3:
- Rebased on Linux-5.11-rc4. The previous v3 patch (almost 2 years back)
  was basd on Linux-5.1-rc2
- Updated implementation to consider NoMMU kernel
- Converted use_asid_allocator boolean flag into static key
- Improved boot-time print in asids_init() to show number of ASID bits
- Access SATP CSR by number instead of old CSR name "sptbr"

Changes since v2:
- Move to lazy TLB flushing because we get slow path warnings if we
  use flush_tlb_all()
- Don't set ASID bits to all 1s in head.s. Instead just do it on
  boot CPU calling asids_init() for determining number of HW ASID bits
- Make CONTEXT version comparison more readable in set_mm_asid()
- Fix typo in __flush_context()

Changes since v1:
- We adapt good aspects from Gary Guo's ASID allocator implementation
  and provide due credit to him by adding his SoB.
- Track ASIDs active during context flush and mark them as reserved
- Set ASID bits to all 1s to simplify number of ASID bit detection
- Use atomic_long_t instead of atomic64_t for being 32bit friendly
- Use unsigned long instead of u64 for being 32bit friendly
- Use flush_tlb_all() instead of lazy local_tlb_flush_all() at time
  of context flush

This patch is based on Linux-5.11-rc4 and can be found in the
riscv_asid_allocator_v4 branch of https://github.com/avpatel/linux.git
---
 arch/riscv/include/asm/csr.h         |   6 +
 arch/riscv/include/asm/mmu.h         |   2 +
 arch/riscv/include/asm/mmu_context.h |  10 +
 arch/riscv/mm/context.c              | 261 ++++++++++++++++++++++++++-
 4 files changed, 275 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index cec462e198ce..caadfc1d7487 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -41,10 +41,16 @@
 #define SATP_PPN	_AC(0x003FFFFF, UL)
 #define SATP_MODE_32	_AC(0x80000000, UL)
 #define SATP_MODE	SATP_MODE_32
+#define SATP_ASID_BITS	9
+#define SATP_ASID_SHIFT	22
+#define SATP_ASID_MASK	_AC(0x1FF, UL)
 #else
 #define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
 #define SATP_MODE_39	_AC(0x8000000000000000, UL)
 #define SATP_MODE	SATP_MODE_39
+#define SATP_ASID_BITS	16
+#define SATP_ASID_SHIFT	44
+#define SATP_ASID_MASK	_AC(0xFFFF, UL)
 #endif
 
 /* Exception cause high bit - is an interrupt if set */
diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index dabcf2cfb3dc..0099dc116168 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -12,6 +12,8 @@
 typedef struct {
 #ifndef CONFIG_MMU
 	unsigned long	end_brk;
+#else
+	atomic_long_t id;
 #endif
 	void *vdso;
 #ifdef CONFIG_SMP
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 250defa06f3a..b0659413a080 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -23,6 +23,16 @@ static inline void activate_mm(struct mm_struct *prev,
 	switch_mm(prev, next, NULL);
 }
 
+#define init_new_context init_new_context
+static inline int init_new_context(struct task_struct *tsk,
+			struct mm_struct *mm)
+{
+#ifdef CONFIG_MMU
+	atomic_long_set(&mm->context.id, 0);
+#endif
+	return 0;
+}
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 613ec81a8979..6216fed8f9cc 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -2,13 +2,269 @@
 /*
  * Copyright (C) 2012 Regents of the University of California
  * Copyright (C) 2017 SiFive
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
  */
 
+#include <linux/bitops.h>
+#include <linux/cpumask.h>
 #include <linux/mm.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/static_key.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 
+#ifdef CONFIG_MMU
+
+static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
+
+static unsigned long asid_bits;
+static unsigned long num_asids;
+static unsigned long asid_mask;
+
+static atomic_long_t current_version;
+
+static DEFINE_RAW_SPINLOCK(context_lock);
+static cpumask_t context_tlb_flush_pending;
+static unsigned long *context_asid_map;
+
+static DEFINE_PER_CPU(atomic_long_t, active_context);
+static DEFINE_PER_CPU(unsigned long, reserved_context);
+
+static bool check_update_reserved_context(unsigned long cntx,
+					  unsigned long newcntx)
+{
+	int cpu;
+	bool hit = false;
+
+	/*
+	 * Iterate over the set of reserved CONTEXT looking for a match.
+	 * If we find one, then we can update our mm to use new CONTEXT
+	 * (i.e. the same CONTEXT in the current_version) but we can't
+	 * exit the loop early, since we need to ensure that all copies
+	 * of the old CONTEXT are updated to reflect the mm. Failure to do
+	 * so could result in us missing the reserved CONTEXT in a future
+	 * version.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(reserved_context, cpu) == cntx) {
+			hit = true;
+			per_cpu(reserved_context, cpu) = newcntx;
+		}
+	}
+
+	return hit;
+}
+
+/* Note: must be called with context_lock held */
+static void __flush_context(void)
+{
+	int i;
+	unsigned long cntx;
+
+	/* Update the list of reserved ASIDs and the ASID bitmap. */
+	bitmap_clear(context_asid_map, 0, num_asids);
+
+	/* Mark already active ASIDs as used */
+	for_each_possible_cpu(i) {
+		cntx = atomic_long_xchg_relaxed(&per_cpu(active_context, i), 0);
+		/*
+		 * If this CPU has already been through a rollover, but
+		 * hasn't run another task in the meantime, we must preserve
+		 * its reserved CONTEXT, as this is the only trace we have of
+		 * the process it is still running.
+		 */
+		if (cntx == 0)
+			cntx = per_cpu(reserved_context, i);
+
+		__set_bit(cntx & asid_mask, context_asid_map);
+		per_cpu(reserved_context, i) = cntx;
+	}
+
+	/* Mark ASID #0 as used because it is used at boot-time */
+	__set_bit(0, context_asid_map);
+
+	/* Queue a TLB invalidation for each CPU on next context-switch */
+	cpumask_setall(&context_tlb_flush_pending);
+}
+
+/* Note: must be called with context_lock held */
+static unsigned long __new_context(struct mm_struct *mm)
+{
+	static u32 cur_idx = 1;
+	unsigned long cntx = atomic_long_read(&mm->context.id);
+	unsigned long asid, ver = atomic_long_read(&current_version);
+
+	if (cntx != 0) {
+		unsigned long newcntx = ver | (cntx & asid_mask);
+
+		/*
+		 * If our current CONTEXT was active during a rollover, we
+		 * can continue to use it and this was just a false alarm.
+		 */
+		if (check_update_reserved_context(cntx, newcntx))
+			return newcntx;
+
+		/*
+		 * We had a valid CONTEXT in a previous life, so try to
+		 * re-use it if possible.
+		 */
+		if (!__test_and_set_bit(cntx & asid_mask, context_asid_map))
+			return newcntx;
+	}
+
+	/*
+	 * Allocate a free ASID. If we can't find one then increment
+	 * current_version and flush all ASIDs.
+	 */
+	asid = find_next_zero_bit(context_asid_map, num_asids, cur_idx);
+	if (asid != num_asids)
+		goto set_asid;
+
+	/* We're out of ASIDs, so increment current_version */
+	ver = atomic_long_add_return_relaxed(num_asids, &current_version);
+
+	/* Flush everything  */
+	__flush_context();
+
+	/* We have more ASIDs than CPUs, so this will always succeed */
+	asid = find_next_zero_bit(context_asid_map, num_asids, 1);
+
+set_asid:
+	__set_bit(asid, context_asid_map);
+	cur_idx = asid;
+	return asid | ver;
+}
+
+static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
+{
+	unsigned long flags;
+	bool need_flush_tlb = false;
+	unsigned long cntx, old_active_cntx;
+
+	cntx = atomic_long_read(&mm->context.id);
+
+	/*
+	 * If our active_context is non-zero and the context matches the
+	 * current_version, then we update the active_context entry with a
+	 * relaxed cmpxchg.
+	 *
+	 * Following is how we handle racing with a concurrent rollover:
+	 *
+	 * - We get a zero back from the cmpxchg and end up waiting on the
+	 *   lock. Taking the lock synchronises with the rollover and so
+	 *   we are forced to see the updated verion.
+	 *
+	 * - We get a valid context back from the cmpxchg then we continue
+	 *   using old ASID because __flush_context() would have marked ASID
+	 *   of active_context as used and next context switch we will
+	 *   allocate new context.
+	 */
+	old_active_cntx = atomic_long_read(&per_cpu(active_context, cpu));
+	if (old_active_cntx &&
+	    ((cntx & ~asid_mask) == atomic_long_read(&current_version)) &&
+	    atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
+					old_active_cntx, cntx))
+		goto switch_mm_fast;
+
+	raw_spin_lock_irqsave(&context_lock, flags);
+
+	/* Check that our ASID belongs to the current_version. */
+	cntx = atomic_long_read(&mm->context.id);
+	if ((cntx & ~asid_mask) != atomic_long_read(&current_version)) {
+		cntx = __new_context(mm);
+		atomic_long_set(&mm->context.id, cntx);
+	}
+
+	if (cpumask_test_and_clear_cpu(cpu, &context_tlb_flush_pending))
+		need_flush_tlb = true;
+
+	atomic_long_set(&per_cpu(active_context, cpu), cntx);
+
+	raw_spin_unlock_irqrestore(&context_lock, flags);
+
+switch_mm_fast:
+	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
+		  ((cntx & asid_mask) << SATP_ASID_SHIFT) |
+		  SATP_MODE);
+
+	if (need_flush_tlb)
+		local_flush_tlb_all();
+}
+
+static void set_mm_noasid(struct mm_struct *mm)
+{
+	/* Switch the page table and blindly nuke entire local TLB */
+	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) | SATP_MODE);
+	local_flush_tlb_all();
+}
+
+static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
+{
+	if (static_branch_unlikely(&use_asid_allocator))
+		set_mm_asid(mm, cpu);
+	else
+		set_mm_noasid(mm);
+}
+
+static int asids_init(void)
+{
+	unsigned long old;
+
+	/* Figure-out number of ASID bits in HW */
+	old = csr_read(CSR_SATP);
+	asid_bits = old | (SATP_ASID_MASK << SATP_ASID_SHIFT);
+	csr_write(CSR_SATP, asid_bits);
+	asid_bits = (csr_read(CSR_SATP) >> SATP_ASID_SHIFT)  & SATP_ASID_MASK;
+	asid_bits = fls_long(asid_bits);
+	csr_write(CSR_SATP, old);
+
+	/*
+	 * In the process of determining number of ASID bits (above)
+	 * we polluted the TLB of current HART so let's do TLB flushed
+	 * to remove unwanted TLB enteries.
+	 */
+	local_flush_tlb_all();
+
+	/* Pre-compute ASID details */
+	num_asids = 1 << asid_bits;
+	asid_mask = num_asids - 1;
+
+	/*
+	 * Use ASID allocator only if number of HW ASIDs are
+	 * at-least twice more than CPUs
+	 */
+	if (num_asids > (2 * num_possible_cpus())) {
+		atomic_long_set(&current_version, num_asids);
+
+		context_asid_map = kcalloc(BITS_TO_LONGS(num_asids),
+				   sizeof(*context_asid_map), GFP_KERNEL);
+		if (!context_asid_map)
+			panic("Failed to allocate bitmap for %lu ASIDs\n",
+			      num_asids);
+
+		__set_bit(0, context_asid_map);
+
+		static_branch_enable(&use_asid_allocator);
+
+		pr_info("ASID allocator using %lu bits (%lu entries)\n",
+			asid_bits, num_asids);
+	} else {
+		pr_info("ASID allocator disabled\n");
+	}
+
+	return 0;
+}
+early_initcall(asids_init);
+#else
+static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
+{
+	/* Nothing to do here when there is no MMU */
+}
+#endif
+
 /*
  * When necessary, performs a deferred icache flush for the given MM context,
  * on the local CPU.  RISC-V has no direct mechanism for instruction cache
@@ -58,10 +314,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	cpumask_set_cpu(cpu, mm_cpumask(next));
 
-#ifdef CONFIG_MMU
-	csr_write(CSR_SATP, virt_to_pfn(next->pgd) | SATP_MODE);
-	local_flush_tlb_all();
-#endif
+	set_mm(next, cpu);
 
 	flush_icache_deferred(next);
 }
-- 
2.25.1

