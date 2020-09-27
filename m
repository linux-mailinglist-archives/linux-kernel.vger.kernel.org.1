Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BBF279E78
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 07:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgI0Fjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 01:39:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:35762 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgI0Fjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 01:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601185188; x=1632721188;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=j6JFP/4w6ylgj0hEXF98BzRdhi0Jc9cxMwlr8d7CYp0=;
  b=XcYrwxl40z+Bwunnp47IjBHCfchidItEgC27ReVJ5D3iuTSPpZcv8tCr
   dOPhHmUd+bBwsEs5BPu0LH0Y3oA3TFI5DAgpRQt/EmAQtSgnietpnAwl0
   Dg6d8yk9WjxXLelIaDuTOue37bn2klowGbcSvtzfdTUFxQkCZUD1aIK57
   FvooJU22bm2kJBYf+w3ksqSTTtj6OxHBjgtyq1kH/zHTt5eHZRuPZofhQ
   tDcI3HhX3/xhPS4dBgTFHC+r6XTAM08LCaPS1jv2SNxht1pnUTpqh4GdO
   gEnoYvjNvC/xFsVudH6yxDXXgom8UXB/hdufiPW8+V6tmyQ+p7y4gVQqX
   g==;
IronPort-SDR: 9YtPcKjC9I4ova3n8dvn3JLVD6uP/Uw47ji+fwyyo4YTPDRbQx+kpvQ1R/vCZOTsYq1ARZkO9V
 r+8iU/fu+kJ35SguV3FtJMybCqttZhCTJLBe0mGNJpGt7khDmf02Ub1Hsg1qPwip3NLRlkhj1+
 pll0C2mPBD3VLffShA/3VVpLaSLkNbXqjYKhKe6CKtUbSpPjNUOXtvlYl+pboZgc7zSchhzMj1
 yWVC3zBkY51QzPG6aoJUmUg5MBhPzt9CWcoiQzyB0npS3yY2b/l2bJkvHz78+gQcf8g2vyBSG7
 aZU=
X-IronPort-AV: E=Sophos;i="5.77,308,1596470400"; 
   d="scan'208";a="149583751"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2020 13:39:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO5AlgnOU0bdh6EMxg1PvZzsIjc0YE2zbmGlaEMqTCXrfkA55RxLkibuZ3khphTfmdnchHpaqqJmauJ0oMl4G9snoZMm/JlU5RxkH9ndGAm1R0kytQBYCaAf+ihyne4TQ+mHNJCQqWIa75jb9lDMEcWPkhHyq5fqXntvh6qbgOuIIWpVdncsKAgf/MQiVIW+Gc/eqN3D55dk1Khe6Jj2x5LBnEY6izSw8B9GUImCYMs+zASw5BU6QMDmEmyQaoVxryMsFY4TYGpLc4aSF61km6rqExnhEKbrygdqb9tHYAMbuMfPOzyiAF+KCMnKyOCtBl4IFNY0Q88NsaO59uoE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNSzVYDNQStOZktFdSPDo5JkxtebzVTMXT4tII2jvbU=;
 b=H0Qz2YPdrYkz8O7t52bMYjdg0+hG1c0N1TODzhp+zPSTBKjG2jtMqySzCgKEPMnU0VEiBOrLfK15eTBi89NGecb+cNtgJYx51AKvIni5vCBtuA/ejiq9GX4/pNiSSjJAiHUBsqbN93STM3v+m5Zw5Gzm53ktco3Umn+d5YXQqe7PKuXTofx8j+tiYtSXhMobrMEY6qXRyyhp8TT4WJ9DBQRv0XyomOpZBkU+uRAAaR8+XdU2CFKgk0kniNtB4Gli3PMVGLYvLxq5rcVKpAq3Q95sRvtuyOCop65+DTcatNfWNklfCXzHaIPKPw3GqUOoy/7w79NcxQA6Vsu3D3JdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNSzVYDNQStOZktFdSPDo5JkxtebzVTMXT4tII2jvbU=;
 b=WzkN7cYgshSgieQDCZO8qROTN7abcJZj1jdTeokt2UKmsLiIJBF3TKWzUPPAlAv2na6QAMkSRz9S5iBBNHQBkSXjET9Gn3G5kelfy/mycTycWalqVvJZNwaz371DG9tzZq6DGPcqO4bg2k3D6Jpng5Hv/XADZilzYGWu/S/VVR4=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5835.namprd04.prod.outlook.com (2603:10b6:5:163::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Sun, 27 Sep
 2020 05:39:44 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3391.020; Sun, 27 Sep 2020
 05:39:44 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v3] RISC-V: Check clint_time_val before use
Date:   Sun, 27 Sep 2020 11:09:16 +0530
Message-Id: <20200927053916.879116-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::35) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.209.177) by MA1PR01CA0165.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend Transport; Sun, 27 Sep 2020 05:39:40 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.171.209.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33f6dd5d-4641-4129-333c-08d862a7bd1a
X-MS-TrafficTypeDiagnostic: DM6PR04MB5835:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB58351F346CC5FAC4FBCA47A78D340@DM6PR04MB5835.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btRsyiX1UOFFFbEF7IpOi26RYvpXFTgHtiF4V94qDiSL2cLULs4EYBnxICn+Dp05jRxxIzIsjijjCUPtA+gbksje18PAZyKvYuZmIAgVJqLj4ClrMKReyd7ImSSl5qhEsiR/3gFllNLJKsKDMMWrd7LmMb8t5je+L4PX9k6Ta2O6rZiVQBaneAtTDqnMqUtQTeXW7rN3EHVkrAD86PMY9cQj3SKTYhmr1zCSOqQJ48Hgb55exW1bOdb31cmPf1PZpufoLNIvnMu7R65RYADSKXIaY1uY3HCR9xcfGl3GdLiOyPzkARr39YgK56LslWou+lFRGZ1reGkhwxLvXh5/AcGjB0QFRvnAKHwumj4AqvsB7m3lB/dEfHnzYRqgYHjb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(478600001)(5660300002)(44832011)(66476007)(316002)(66946007)(66556008)(36756003)(110136005)(8886007)(6666004)(1076003)(83380400001)(26005)(52116002)(7696005)(16526019)(186003)(956004)(2616005)(54906003)(4326008)(86362001)(55016002)(8676002)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: HSQB3O6t4/sLHaNTCM1gab1P/6+5InGbs/1dOi5cCgFN6hNhQ9yaVtYkMrlkVMlpT17kpbLRkzY6T75AAKEPH6rZm3NMcBsFmnGXyiDX9HszGoj2BK6iQMdRisG2D0LNBH3N+HU2TFDm6yWyNwd43WBusfIjDWaEBhYMDwZOqth4Z0+gcuPFOceQIYwQGtkf3FjsClvfhROmbJVOCRKHCcEb8GbFjdPl1r4R68gUsFLoRKfsL5CCea0bxKcfiMNoT1arRqcdj3ys0Zw68pnc1PuDM8+aQFPpT63+quSErcwbrVUBGAWgwireJzKkiDrSrguLofWwKpqf0OwQd9eK5fooDYV8RU90OoeDex5MT61kHzhpu82kDWG3M13h5AORXqjCu1M8IEokQjAEtSBdnFrBTISrbxNu9mbVL6hxLUo0tUtHm1dSwDfHhlcyZsR6uWiMVUNTnLlR6ZkDGcSVtJ2TTGAeALfrZZwki7ZP9hI4tOBeZT3pQ72pdDOBYKEny9gbHwynXbPjqTLph117OtZe6xUzOEsmco4mOsh25ITayqf1LDyqW9blAAepdVGngi4fvsyOd+yQrC6P5MaTGTbKjPbsFobIafapZ/W3LhSqNvFtbNgaRJ7R1wO17zIjC3rUHCm8iPQ7FuDoyt7O2A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f6dd5d-4641-4129-333c-08d862a7bd1a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2020 05:39:44.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxkvC7XjVp7hyxcs3GjS84TnughnW7x/T3C9qalpFmqbxOe82kWQlEIE3dkOzDpl4vYzYq+Sp4uGYlAkBVkQnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5835
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NoMMU kernel is broken for QEMU virt machine from Linux-5.9-rc6
because clint_time_val is used even before CLINT driver is probed
at following places:
1. rand_initialize() calls get_cycles() which in-turn uses
   clint_time_val
2. boot_init_stack_canary() calls get_cycles() which in-turn
   uses clint_time_val

The issue#1 (above) is fixed by providing custom random_get_entropy()
for RISC-V NoMMU kernel. For issue#2 (above), we remove dependency of
boot_init_stack_canary() on get_cycles() and this is aligned with the
boot_init_stack_canary() implementations of ARM, ARM64 and MIPS kernel.

Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation
for M-mode systems")
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
Changes since v2:
 - Take different approach and provide custom random_get_entropy() for
   RISC-V NoMMU kernel
 - Remove dependency of boot_init_stack_canary() on get_cycles()
 - Hopefully we don't require to set clint_time_val = NULL in CLINT
   driver with a different approach to fix.
Changes since v1:
 - Explicitly initialize clint_time_val to NULL in CLINT driver to
   avoid hang on Kendryte K210
---
 arch/riscv/include/asm/stackprotector.h |  4 ----
 arch/riscv/include/asm/timex.h          | 13 +++++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/include/asm/stackprotector.h
index d95f7b2a7f37..5962f8891f06 100644
--- a/arch/riscv/include/asm/stackprotector.h
+++ b/arch/riscv/include/asm/stackprotector.h
@@ -5,7 +5,6 @@
 
 #include <linux/random.h>
 #include <linux/version.h>
-#include <asm/timex.h>
 
 extern unsigned long __stack_chk_guard;
 
@@ -18,12 +17,9 @@ extern unsigned long __stack_chk_guard;
 static __always_inline void boot_init_stack_canary(void)
 {
 	unsigned long canary;
-	unsigned long tsc;
 
 	/* Try to get a semi random initial value. */
 	get_random_bytes(&canary, sizeof(canary));
-	tsc = get_cycles();
-	canary += tsc + (tsc << BITS_PER_LONG/2);
 	canary ^= LINUX_VERSION_CODE;
 	canary &= CANARY_MASK;
 
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index 7f659dda0032..ab104905d4db 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -33,6 +33,19 @@ static inline u32 get_cycles_hi(void)
 #define get_cycles_hi get_cycles_hi
 #endif /* CONFIG_64BIT */
 
+/*
+ * Much like MIPS, we may not have a viable counter to use at an early point
+ * in the boot process. Unfortunately we don't have a fallback, so instead
+ * we just return 0.
+ */
+static inline unsigned long random_get_entropy(void)
+{
+	if (unlikely(clint_time_val == NULL))
+		return 0;
+	return get_cycles();
+}
+#define random_get_entropy()	random_get_entropy()
+
 #else /* CONFIG_RISCV_M_MODE */
 
 static inline cycles_t get_cycles(void)
-- 
2.25.1

