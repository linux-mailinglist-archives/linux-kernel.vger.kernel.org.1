Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5347B2C386A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 06:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgKYFST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 00:18:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52077 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgKYFSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 00:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606281498; x=1637817498;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=kcIwYdcBVem1A54ootbTVE1YFkVgdjAkW2DXd7l8DJg=;
  b=SKqSg3qB9zb3Uo8l9aGbM9brB7yMhrEkcqOEOyfGZsGvPhmeSk2/0Ec1
   IUpnaoieg0DbWchlBKIwG7q+JWrgV32rt++Dh2Y0FPYW67Qv4FG/n+3sv
   b1seDTGsWJvyszpoiY7gmUVZi0jqQR3q90dT0UwGMvp5lWX84E6fjyLTi
   DYWwdHpwflC/OVraK5xj5RSXHmRKZu8Wf83DFToyTn2YwLLU5opBVt9V7
   u3pEmR/ODpDOIFm9jXs04ALBVE8Mv34w6tizm2tHJxJsKAS1ng5gf2UT4
   XvczY8QnffgJfFywSUSvK0r8r/sgkuiI36ZpLOA0f+8J7YfkgeHLKYCbG
   Q==;
IronPort-SDR: Lg2G9vXFlSjGPBDXhFGREBb1pV16jAm8nO0RHg4/McuL3Adw1ONdRIj0AVgBsio7O3+0AintTM
 AWo87xc8x5RHALISO7AIu/W9Q3sxnldASThXLYqx6LZWNlnLyfLJP+yKCXbQZkcyLoxD77UCTE
 5BOq78uVKRZxK27pN392zTqnsntZ8PJ/Mfb/7FBvkobOuA4fYGjITPciOJ5FshJ+UEA7oOPC4n
 AJablObp6NhreG+EkRMgTtdl+PKuqfKt1iY1MfwLshD1+BkqzBzod1mDvk0byNMGUAQhv8FU/v
 YDc=
X-IronPort-AV: E=Sophos;i="5.78,368,1599494400"; 
   d="scan'208";a="263496269"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2020 13:18:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5A4sh4xxYDFJaR1jILYKOP9wJAz1XrlRRC07JQFOm+0U2/+GJr2AdEHE2TOPYK3f/e+qNTlK4gGpgX3/EzxrybWwRLDRIpyK9fAe6xG0TX3xD8CErWhQulgqBLCBvxmP/MlQGI6hnMjjQ5XUgixUNj+TDeOqzXHkwjHKdKzo1jorScS8LeA2QhmDpWCvje3FElBitcw7gZYw8OIhF+aqYaz09OrwatrMDe2QG/CbkaqQvK5bhBxVJ/q9oJLlASUBaagSBWzfzgKCfaN9Y/hxS1losbktcOgaCv9PQ0v1CSc5glk5dPTujFFYu3D1UaKNb4crzw5UvBrRrwNwJXzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rChYadDMdfqLrRchCgYkP1dM2E2w/gWOvaWe8ocvGQU=;
 b=eK0YLwDueZxJ9qQBNKwI0G6EJlwAdx0ZHWnmXUat9SzTTuuk1cQHvwnITfOq6NxhW01KQKsZxK9Uhef4jyduQyF2mBvD7gqgKITGeCnA1KkIjP82xY96tW4QjdvE8lblvsoqRsELCRAs5MB638lfeBKqfWQM0TX1z/40fIvswOk2cdQc/o6mCgX7SpWDgTol9CBQ48F4f4d4dmlnxjhetJUNl6H7dnksa190NdMjYoVl3HbZqKjzahjQhwyd/W/NCGnRkiS8n4yQsJOQB2e8upWdnNXkl1Zj4RLDgrwIIq2w+ayejPESHHFzsdwq8oB2Qcvy4PTaqIT1Q9zV1p24eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rChYadDMdfqLrRchCgYkP1dM2E2w/gWOvaWe8ocvGQU=;
 b=kYgKXYxjVvHZq4PvJcgzV+jDmrCdf+baJtNK2Qq5/rzzyaR7Z0z32UUu+aFnGKettpjbKNydvK/KUuDxks5LBKj1QSIrBODHs1CJWQ1WTvWiSZ5nvpPJ/GtgjyZfHAoFFu6jFo/+vzfYQ4TzAE/p9rJR/nvTDCX8erTRSDUiYj4=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5131.namprd04.prod.outlook.com (2603:10b6:5:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 25 Nov
 2020 05:18:16 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::d035:e2c6:c11:51dd]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::d035:e2c6:c11:51dd%6]) with mapi id 15.20.3589.025; Wed, 25 Nov 2020
 05:18:16 +0000
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
Subject: [PATCH v3] RISC-V: Use SBI SRST extension when available
Date:   Wed, 25 Nov 2020 10:47:52 +0530
Message-Id: <20201125051752.295572-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.182.227.30]
X-ClientProxiedBy: MA1PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::33) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.182.227.30) by MA1PR01CA0117.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 05:18:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f25a0c4-4fab-4482-9ef7-08d8910183c9
X-MS-TrafficTypeDiagnostic: DM6PR04MB5131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5131882226BF1D09AF3D99D78DFA0@DM6PR04MB5131.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ji6iX7TvfMfqXYumif3k/9foJ1c1hVo7ydHVhLLCjOB98MGJgmGlUb3tHFMvrs6DZEk5O19NnoH5+f7+wy0SdOgegJ9CON4y6ihJXDBRSDMjFtTBk3k2KY8LSMsDe5+2ioLJDT5YKt9fNYsbTEoLl3/fAhKl/mOv6IiERlTN/HcZrv1oo9uAZ6GxtcTUWDgpIowt1KBgcbuXiTUU946ovznevLRdDzzybKlqK5RrjuJo0jQOyJvYh/yZZa9nyf6TK3ikI9h3OpyRTJYeYCHyqaZc9T/6dhUOb3oZfco59sOr8yE6L3vwLcBD/asMtDChwZZUBDsfsujsZ2QItVMfyBeewZBKTEE2vS2VdbcxtOgwKMWO1lyP0+Aqc04ORcdxpBIIiVmBYTJvpkzIOSOXaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(7696005)(52116002)(16526019)(36756003)(186003)(83380400001)(2616005)(44832011)(5660300002)(110136005)(2906002)(6666004)(54906003)(4326008)(956004)(316002)(8936002)(8676002)(55016002)(478600001)(966005)(26005)(1076003)(86362001)(66946007)(66556008)(66476007)(8886007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wMziT/1WMJaMPgFvOtitXnbv13HaqxKI+zTMrURkn/5tQaT7U2E50XOYzy5J2kBzBI4W6k+xDrMCHr+zVFVIokkp8JjLaMpGkvlyvg0bBYUEmAM7yWIAw0v6lYi46ib/P7g6n3aIZ5nXaK7aZRi7fm4nq1HGJ1TSZlglupco1LAj4gJTjBHTtOFVp+29MoRkdKbwb0yK9sz8Zbt1yoQ/IP23iWpai/6eeVNzyVkb1Wf6H/+N/LiXZTlL+ctGbJIG+bzKBS3p6hNpTGhnY3QQqLi9P3P2kwfINQWuvU3Q4xeYKViMuw74QNf6mLOlviz1ABfs6oYZdk+p44bX4U3jpvzPi2GCnk1AH5ytrAwmJBSbJbEkagCsG7Euh+Rupu7fXjMRgHJwUbgSfF9kBoALLL+IKXtZVkOtZxWbBgwx1jMAeNeswc4u04GaXwaQsIlbC1vzz4T/w/sgp2E62Sq1wo7faHYif2jFU0s5R/jYn6tuTj52w4rg2m3Ne8XOaaKKsbS8UhaWzLyY7VOmT/aFM5FWGxH8QVW4HMVuUZHu2yNuw6w0CKW99ifkqSDIN1/TPoITqU/b0PivpQiy1cLcjKNyKeKbTk6kYgxgAuqf5XGz7Q/uzntBqH22RO/qg93UnO9kbEn6Ar2WfHXkZBb/5MD1jxAjwfcmIBDMYwQNGE0ghiAeXWxX/YmMH6fo9L335Rs9HhWLkB2R0s37fSK3fT9UIB3aFciH19jqrdRFSpv8K6AcsiYfdatm7xMy4kOhbEOowHGDih6m2goildFeh7dKsFLYi5KeGh/J6cXs+fRqRO4kSoSx3VKdYdj9ifgTP4uw1S0+BVU0QmC6p7mx6AMXZWsNe9a9/GbhJWzHIWj5psYqDDj4TGNfiMa5N4q3OPG/wmLcUVddC7ThX1UdAg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f25a0c4-4fab-4482-9ef7-08d8910183c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 05:18:16.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6u6H6qm/yt480fR+5F1YP5vtQuQyEhQJYFPK9O/+koz0/gphDolR2QgXtygs+D+a+dxceU/94QZtL0Q9aoYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI SRST extension provides a standard way to poweroff and
reboot the system irrespective to whether Linux RISC-V S-mode
is running natively (HS-mode) or inside Guest/VM (VS-mode).

The SBI SRST extension is available in latest SBI v0.3-draft
specification at: https://github.com/riscv/riscv-sbi-doc.

This patch extends Linux RISC-V SBI implementation to detect
and use SBI SRST extension.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
Changes since v2:
 - Rebased on Linux-5.10-rc5
 - Updated patch as-per SBI SRST extension available in the latest
   SBI v0.3-draft specification
Changes since v1:
 - Updated patch as-per latest SBI SRST extension draft spec where
   we have only one SBI call with "reset_type" parameter
---
 arch/riscv/include/asm/sbi.h | 16 ++++++++++++++++
 arch/riscv/kernel/sbi.c      | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 653edb25d495..5b2d6d614c20 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -27,6 +27,7 @@ enum sbi_ext_id {
 	SBI_EXT_IPI = 0x735049,
 	SBI_EXT_RFENCE = 0x52464E43,
 	SBI_EXT_HSM = 0x48534D,
+	SBI_EXT_SRST = 0x53525354,
 };
 
 enum sbi_ext_base_fid {
@@ -70,6 +71,21 @@ enum sbi_hsm_hart_status {
 	SBI_HSM_HART_STATUS_STOP_PENDING,
 };
 
+enum sbi_ext_srst_fid {
+	SBI_EXT_SRST_RESET = 0,
+};
+
+enum sbi_srst_reset_type {
+	SBI_SRST_RESET_TYPE_SHUTDOWN = 0,
+	SBI_SRST_RESET_TYPE_COLD_REBOOT,
+	SBI_SRST_RESET_TYPE_WARM_REBOOT,
+};
+
+enum sbi_srst_reset_reason {
+	SBI_SRST_RESET_REASON_NONE = 0,
+	SBI_SRST_RESET_REASON_SYS_FAILURE,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 226ccce0f9e0..33b834ecd195 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -7,6 +7,7 @@
 
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
 
@@ -501,6 +502,32 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
 }
 EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
 
+static void sbi_srst_reset(unsigned long type, unsigned long reason)
+{
+	sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, reason,
+		  0, 0, 0, 0);
+	pr_warn("%s: type=0x%lx reason=0x%lx failed\n",
+		__func__, type, reason);
+}
+
+static int sbi_srst_reboot(struct notifier_block *this,
+			   unsigned long mode, void *cmd)
+{
+	sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
+		       SBI_SRST_RESET_TYPE_WARM_REBOOT :
+		       SBI_SRST_RESET_TYPE_COLD_REBOOT,
+		       SBI_SRST_RESET_REASON_NONE);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sbi_srst_reboot_nb;
+
+static void sbi_srst_power_off(void)
+{
+	sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
+		       SBI_SRST_RESET_REASON_NONE);
+}
+
 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
  * @extid: The extension ID to be probed.
@@ -593,6 +620,13 @@ int __init sbi_init(void)
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

