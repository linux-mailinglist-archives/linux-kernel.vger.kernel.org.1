Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841362785D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgIYLba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:31:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14322 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgIYLb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601033487; x=1632569487;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=AagZOpzn1NhSFHSKXVuHifaG+tTjpnreFa9A/fwMqRc=;
  b=HZjoJ0biVTafZMmbhLKXB5CT2F+ytkpDPWaBuMdrXTrHKurus70Wyjw0
   VickKYoeQv5ucTYSHqlrXu/cVJ87M07PxFWYHwQbU1giL9g8RVKnK/xQo
   Fk4DsxDU5j9/VuCEhNipJeX73hHp1tb9ZIT3PdbxZiGHCiW9JLxGxKGXl
   WhAmU1tTXfxxze0Vz26kEXWuLkx2FnH5MPou/YUFOXedslLh/nYEtU/jt
   sbPnyl3wnJznOeRy1owyfcBxE1oIbvSQWLldIVFSVvxX4WmmF9yyAj07t
   +HXWnTgqB95AqdJYYU7weYOBTMsx8wIU62i53WzLHjGXix4gDdKemZk9H
   w==;
IronPort-SDR: Ac6AwkeMnUG00kyrpesMXaw5R9AdRcP9wR4G710fZLTiQbsy1X9C/BzcUI95SzDLmJkixWl8Dv
 v1gey29XjWGwA9B5OWiNL/VbnbJgGwMpEXypLX/9gQmpNgMnsljzGvCVvvzMDKEJFX17ulJxam
 sXc6nj5xtA+UlkQg6740bJ2ik40vCa3CpUjMR4uO8E9PHXYBtKyGa+q50Jp9ghhLgDnAPdjmXY
 3Ya4MV9UbQNDKKEIGzAqDmoxlgOkmpoqA5LTkzJE+702kO3E2MmcJOBSz8c+VG0l0JiJ0CYUX/
 jFU=
X-IronPort-AV: E=Sophos;i="5.77,301,1596470400"; 
   d="scan'208";a="148192336"
Received: from mail-co1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.59])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2020 19:31:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHt/vn6JyrgvJw9XfVrCvnbM7F9DB5KHfoTuDeRgonwUbXwLZXD31yGPjYsiDT7rSYnizblU3n+yQJ1ZGgibxdWwiRgwgTFdq9h4F0WQ3M/yUqMgUhDIykMq10IIiYwPn2Fzu0bMvwLOSWXsRYyW/LWLNQRqdAVas+7nnYVH+ppx85c6qvqQrG1x1IA94GCtNRhFY/vOvMzM6yBZonmRWzeit+87ws+0y8m/BIPMOS24NWBH2qkxdScwpcdtPC5orFFRaE/z7qxW1ZcZIiowOSm2kflJzhuwf1R28uSeTUsxf7ZEzHa09LKP5SPwBsAFyptu0uJ+h+MX07pkxDi8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eLTscy+oRZCsZU1VrMbFHJaai2nVNimxRk+clxEkpw=;
 b=CbLtdc4Ulz0mHuUTAUv1p3tYpRJgler8eUo23nZfgrwKMgsmAfHbpb4kN/MotY1aFwycU9PNoTBxS+w9+j0ZG3fhZ8Nnn3vbCHlijkx1ZbSPupE1kulFel33DNoSw2z7N7AbTdoOyczTroFNiUD1HKj1zuA7T4wQ+79jwIFThxyed7HbMGOrd99AQw3rWvQDz1ePVU8yLwCLzicfgTwwaPFudT2x9tJnVoncH+MiFbDdSFreGQV3+6S8J/1OZZjnzG3EMBZBjXuDHX6h0abxu+Iv7m5tc+0Bn7tufWmrogu87C/PmLAxlHlpxnQ41uOSh5ZZaqjZ/QmdxdUc80Z+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eLTscy+oRZCsZU1VrMbFHJaai2nVNimxRk+clxEkpw=;
 b=kcT1wREN7zT5M820kGxOOGDYknE0MhEFsuB0Rs3DwJtBWF52nxaDEUNUL/GX4xB2TuT0hzB8sv1CW7DyHZfiIEqbuyuy3qnlw8pHQY92ZM56VLuG+macv9ax5cknhSNnKiBZAAsQAdibQoRGiIOCvH5uOu5dRh0Z5GM2WedIBKM=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6778.namprd04.prod.outlook.com (2603:10b6:5:24c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 11:31:24 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3391.020; Fri, 25 Sep 2020
 11:31:24 +0000
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
Subject: [RFC PATCH] RISC-V: Use SBI SRST extension when available
Date:   Fri, 25 Sep 2020 17:00:57 +0530
Message-Id: <20200925113057.725911-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::25) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.69.106) by MA1PR0101CA0063.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 11:31:20 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.179.69.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de43d0f2-8251-4b81-9026-08d861468894
X-MS-TrafficTypeDiagnostic: DM6PR04MB6778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB67787364E87ADAD71C2C3C4B8D360@DM6PR04MB6778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Sl6Cz1aeARx0iExNmYpdplXnkJAh9PjXQVvxdkto74UOip0pxoGOCGyFosKD7/1VY8CjOMnXIbkv3qJ7TJzbGJI1/+H4GAOesuBsu8CNMV7mn1oR32eKZqKHl6VWMcKMNZAVEMvxYbdysS+BKhKAc4H5qBDu2H7X+HoaXtYukP3V7N79WI75xV5NlaIAEhZDEdPDpyonPi41OqIY0Q217ukUnXRKeh1IBZUPBBKKEBxtokA9UgmvzPSimYxC6qLvZcbHCKD1x3gms29zWlXDEgoYPU7/jYSmzqH8yO8Qu9pm+xznHZAlLbObMirmgn1tpCp+25+iGLJ7KVUpq7BQSUPZl2dUV9cCHvzTDC072IoMZ2CYI7li1NOCLlJ9D21Z4OwysH9UJ19FQAJ59vGuNXg54GqlJl/7CS5jS+8VfjW7QIuzVfvJR4YJuogR/iT8mkEgtP++r9RjEF/Vey0xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(66556008)(66476007)(16526019)(8886007)(8676002)(2906002)(5660300002)(966005)(52116002)(7696005)(54906003)(36756003)(8936002)(86362001)(26005)(1076003)(316002)(6666004)(55016002)(66946007)(478600001)(956004)(110136005)(44832011)(2616005)(83380400001)(4326008)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: R60o+qehvarRj6EcZq6MOpmepUKaqWFSvvIbAp8h4Cwi/+FXUopIfIMPjFhOpKb3YqFurC/YhO795/2Vdj+e45hmlx2GHlZzTR7rdNF+w4MZq6ELqNPecEGq59RMwLfZZksfq9M0q8lrDMbNhsAggWBWy4v339Up3le0/WyMEELJkLN7kE7XJMGBExwxJ0OzR3IPBwOmPNvSENja8CyK8BvUX9iWxWKSvTjbFKRyQ+qHkwQAPhk59aIvq2QE8qDluhbw6DhnRmwffBJKn52m4YvgXei3WFXgyBzh4T2uR5QYRDBGfTj+HBFCTxQHJt/ASCu42chvbVIPJrht2C8PJTyIjiqgSR2XjP5ctyxosHGUzDt/G4cbjeUzhuUnGhRyGpWW+Kds/UQrohs26lJ5dXG4OmPdRxkEvf0woKvoVoHEz6+UdXObv6VwCzKgjBB1UVftNdIZI4nSyj9j0RNznKCV/Z8uiTKjuZetppE+DRHmixx/l+mGCVeCxp/j90AlzamOjUicsAEEzH43umXGGcoeJLk2GNh+m7jGlhvCcQqpB7SGExqD0SbJs0JIsDJuOI+NPAyLh/+QrtafVnZ8j9bO93R9REQOp8QtMPGOPXHLKet5UlnqDxznFC1lJqEdxV62CpkFtVi6UNBxLFotWA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de43d0f2-8251-4b81-9026-08d861468894
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 11:31:24.4854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfko+HV7101Necfi+Rf3nYfpVVDuFyZjJn1MW4wWhb//w/jhbJ8OmKvLrid6gXaZxdNoSjJ1haXNcNIlZPMzcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6778
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI SRST extension provides a standard way to poweroff and
reboot the system irrespective to whether Linux RISC-V S-mode
is running natively (HS-mode) or inside Guest/VM (VS-mode).

The draft specification of SBI SRST extension is available in
srbt_v1 branch of: https://github.com/avpatel/riscv-sbi-doc.

This patch extends Linux RISC-V SBI implementation to detect
and use SBI SRST extension.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/sbi.h |  7 +++++++
 arch/riscv/kernel/sbi.c      | 25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 653edb25d495..2fcecec7dd0c 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -27,6 +27,7 @@ enum sbi_ext_id {
 	SBI_EXT_IPI = 0x735049,
 	SBI_EXT_RFENCE = 0x52464E43,
 	SBI_EXT_HSM = 0x48534D,
+	SBI_EXT_SRST = 0x53525354,
 };
 
 enum sbi_ext_base_fid {
@@ -70,6 +71,12 @@ enum sbi_hsm_hart_status {
 	SBI_HSM_HART_STATUS_STOP_PENDING,
 };
 
+enum sbi_ext_srst_fid {
+	SBI_EXT_SRST_SHUTDOWN = 0,
+	SBI_EXT_SRST_COLD_REBOOT,
+	SBI_EXT_SRST_WARM_REBOOT
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 226ccce0f9e0..865e028a9a4b 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -7,6 +7,7 @@
 
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
 
@@ -501,6 +502,23 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
 }
 EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
 
+static int sbi_srst_reboot(struct notifier_block *this,
+			   unsigned long mode, void *cmd)
+{
+	sbi_ecall(SBI_EXT_SRST, (mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
+		  SBI_EXT_SRST_WARM_REBOOT : SBI_EXT_SRST_COLD_REBOOT,
+		  0, 0, 0, 0, 0, 0);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sbi_srst_reboot_nb;
+
+static void sbi_srst_power_off(void)
+{
+	sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_SHUTDOWN, 0, 0, 0, 0, 0, 0);
+}
+
 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
  * @extid: The extension ID to be probed.
@@ -593,6 +611,13 @@ int __init sbi_init(void)
 		} else {
 			__sbi_rfence	= __sbi_rfence_v01;
 		}
+		if (sbi_probe_extension(SBI_EXT_SRST) > 0) {
+			pr_info("SBI v0.2 SRST extension detected\n");
+			pm_power_off = sbi_srst_power_off;
+			sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
+			sbi_srst_reboot_nb.priority = 192;
+			register_restart_handler(&sbi_srst_reboot_nb);
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.25.1

