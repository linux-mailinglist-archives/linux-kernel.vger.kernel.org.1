Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF61279850
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 12:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgIZKWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 06:22:40 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38920 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 06:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601116390; x=1632652390;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=yxm7CksDC7RAhimb/lDBFHxvgD8VeaFnoVlO5Aslok8=;
  b=mOhf5GFRWxcBJ3unvnHTSg0NyiVB02Kw+CK3JJlfQb4T2VLCrzBJYM8m
   RSlivuBmZJAgy8vEPxCyQmPtxc7BkZ+iYnnNUm/+4yehkMRgUSFEjSAVZ
   40rIkciyp5nWNZ0rOYhdd5Q3VdjBHCZYVBgL6pK/ALJJ8SmflOpe1bT5l
   X3FEG00qeYpKSGtar25VYRQTdcnmT7KjrQfvBmAnqIFzGhP86Szlmmdot
   XUGozce5RQY8S0/O8DCPydET9FYI7D3NrD4zuZCCi3Lz0AYWJ2TS3RGDD
   TlpvxhUwcydeJG1Pbk6CNQhh8mZnDokAH94Csk3AUAPrQDYhOWFPyATEL
   Q==;
IronPort-SDR: kLCgm4+Qb91vvDjVYbS0dH/MW+oAaZQSHxHGe3XC98b1no6iC8yYMy6+g2if7WwkqLu43dJyyt
 EOOtm/jTWOpYJrkvlqjddSDofORvIkttjBrOdr2poQgtjZKwYH8dVafQEva6TqotdD5lGcVFH+
 ChQ+hZVLrQIuBu3gL7HMsprz1Tr7KwW3ce18nfG+VASe5xrpErm1gBgKZUGSqJYV+Q169XvpnR
 70/PMAd+kHsr6378cbuWg3FI+FID3JlTi7ghnGkNawENZuZ9CdqbFgAsB/lbr6aAOTScGCff0w
 duA=
X-IronPort-AV: E=Sophos;i="5.77,305,1596470400"; 
   d="scan'208";a="251723337"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2020 18:33:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQPVwI6G1vpK0rWqR8wD0J9AjYPeVZAu9UJ5fP3in6v+MYzvI0V7/Rt3fzajTpj/F6hsRvGKOvaicIyHemEtDFtNcBFhsxXHsGrL+0fdCLfn2z02tkgwXqdfh6rYGMCMJ44lr1Sa2NiGvPt5HhswwslJCv8l4o526zA/WUCKBK9JdE19BSI1U3z4TYw4Pzb4ETIQ50Mk+5KiyeTfnhQkVtRYtSSKJMpqjmuLkavXudC5AtyXr22z68xowOA1MIWu9OMK/Fy7+ymY3YRDJ8WxDWe3JgSKOjkAHWu1mZAxWdFO2CidF57Z+V/KWyph39IcMxebEQ18UwvEcfHs6Z3BvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeQd0st6BfhKndCzH1TEV6nn8Q3dDozmbCq226zTHm0=;
 b=hqkJ0JXlVmxec0sotYMs3yKfwWhLvpJW1og7lWtIPiA/lC10lONaYTJtTD92nffGmX8tKa8MtO6uPG898WbxvPoR13zjDRdwFcYSeITI8fpubIKLjUpnuJOZ1E4XsebIoUWk4unvgQ6Mw/oe98+JILs5JzITwY0FO7k6+6nXarjG+dVeYKjfq/gwmeqGTtplsYZG1cGi1VGvIrck08L31P5BpdT6ZNa/F9Epsag28O08/v3Suxt0ILfIkjmKj6O5OzZFMeUqAqPPT95PXe3bacaQIEsq3HTyiV+M0SqKlGJpLERdhwRhhO3pfFnd0Zia//fLe3U4uOVvXNeciDCvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeQd0st6BfhKndCzH1TEV6nn8Q3dDozmbCq226zTHm0=;
 b=UpHbrRxZ4kY5pnd+q/3slFZLobPY+vvk5W6ATmUvJLsGGQs86InBLAj+cJ/XyPq3Ae8nOKTaDElQ4Rt6yFMRTFEkopLNiuTDysB3rhF+UO6c500v/iUtzGoj1AXZdlQFrRtL9dgRp1KohRAXtIWo6NxOuBWsif4M4OzIXtrVVgA=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6297.namprd04.prod.outlook.com (2603:10b6:5:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Sat, 26 Sep
 2020 10:22:37 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3391.020; Sat, 26 Sep 2020
 10:22:37 +0000
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
Subject: [PATCH v2] RISC-V: Check clint_time_val before use
Date:   Sat, 26 Sep 2020 15:51:58 +0530
Message-Id: <20200926102158.828461-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::22) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.126.16) by MA1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend Transport; Sat, 26 Sep 2020 10:22:32 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.179.126.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 666612e3-e055-41c4-6202-08d862061713
X-MS-TrafficTypeDiagnostic: DM6PR04MB6297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB62977339746E2E184559CF9F8D370@DM6PR04MB6297.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DcYq/ehoMbfQWHb0NViamPQ5IIvojK5wgDpWOxlva2S5c8u9Ujax3n7HOZ5qdacZLFW7jLVPVPOHsIokkBgvdVTGcxAb7G/rekDHvY0i06jImoJoEiQluKYGRbQ4wu4i5dkWYC/Gdd9akZ+50uKBGqoDYf23qZVyCUhgZX2mh/rxDP8EqWEW+H7ZP6XOYmB1pPuYE1ZZ3GrmMxKWtEYMD1sNF7TfbuYuzEfD1g0/PP8+fR/Uj/ZawY59NXieL879OnekQg5PTp1beSig3NvZpX8yWGwcAx0rrsd3eq1NfQlTBMaPQ3TAWQF58M0E0LqC7W9QsLLOS3/H2YJ6lFjMkkrdi38s+DEiT2giYu8biQ/5L82ALlzYh3+10bytI60L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(54906003)(5660300002)(478600001)(8676002)(8936002)(83380400001)(86362001)(66946007)(66476007)(66556008)(4326008)(52116002)(7696005)(36756003)(2906002)(55016002)(6666004)(44832011)(2616005)(110136005)(16526019)(186003)(956004)(316002)(8886007)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NcHaV29+p6J+FSDN8u2AuEDC0dPjlaMRKH9LAuuFvvOpkrKmFpUgeNfzyEa+tMVFUzJh3kWfINQ/vDJcFGDsc45CaWMTSQvmTusCcHlj4xQZy2ZRNoi/I6Kdd7lWQvUDh3mZH3oZVmx5tTYIJQQ9L3uyOzK8DBEUNDdB/4nYtASaB16rhnRs5qliwSLKX2sGlOrl57juQzIJgao5fn1nFcEWwpDSz/+bXe2bhNrNqnyBlVCl0vskVRjrAyzvzlIgtIqAWvtD62OjyXBubk11ZyTQLiJIYMAssQbB1KOapku8VCoFTSuz/su105JOU94Je8vkfTbglq2Yy3RrtizNOsynnUWH+9iA2pkbe3J+edd5Y6dp2w6m/hKnn21KG1xKRFEKowBuQv+BqbVS7SAMG4ODURMNAjfrRIQLwxeV56ATuNLlsF4cId7MZrwjAjkmvnU1NjZRY4/cv6p14JHb7vPd3GYcGBmcCIzMkxKlR1WRZIE2xoMDnbkWyfpe8iUuUR0t3gd4m+0ZlXsB69+92tTTqrC/VyKdO+hPLdZQ1zKIu5Z3xnBgagpxydRO1USeeqojINoviRKPnlElfyDDolW+XbawYQPoBKHvSgW0nmOHoNjWbaWUmgh/hObWIm+5vrCpp2TmiXTMNoUMT5bsNw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666612e3-e055-41c4-6202-08d862061713
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2020 10:22:37.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRML9KlNGJgQmzGAet+BIklLo7EHYX82Wn36YFuzVoz3ccLw6QFqDUmGcjhSWY06sjza4OoxF7DqV3LiJkGBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6297
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NoMMU kernel is broken for QEMU virt machine from Linux-5.9-rc6
because the get_cycles() and friends are called very early from
rand_initialize() before CLINT driver is probed. To fix this, we
should check clint_time_val before use in get_cycles() and friends.

Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation
for M-mode systems")
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
Changes since v1:
 - Explicitly initialize clint_time_val to NULL in CLINT driver to
   avoid hang on Kendryte K210
---
 arch/riscv/include/asm/timex.h    | 12 +++++++++---
 drivers/clocksource/timer-clint.c |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index 7f659dda0032..6e7b04874755 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -17,18 +17,24 @@ typedef unsigned long cycles_t;
 #ifdef CONFIG_64BIT
 static inline cycles_t get_cycles(void)
 {
-	return readq_relaxed(clint_time_val);
+	if (clint_time_val)
+		return readq_relaxed(clint_time_val);
+	return 0;
 }
 #else /* !CONFIG_64BIT */
 static inline u32 get_cycles(void)
 {
-	return readl_relaxed(((u32 *)clint_time_val));
+	if (clint_time_val)
+		return readl_relaxed(((u32 *)clint_time_val));
+	return 0;
 }
 #define get_cycles get_cycles
 
 static inline u32 get_cycles_hi(void)
 {
-	return readl_relaxed(((u32 *)clint_time_val) + 1);
+	if (clint_time_val)
+		return readl_relaxed(((u32 *)clint_time_val) + 1);
+	return 0;
 }
 #define get_cycles_hi get_cycles_hi
 #endif /* CONFIG_64BIT */
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index d17367dee02c..8dbec85979fd 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -37,7 +37,7 @@ static unsigned long clint_timer_freq;
 static unsigned int clint_timer_irq;
 
 #ifdef CONFIG_RISCV_M_MODE
-u64 __iomem *clint_time_val;
+u64 __iomem *clint_time_val = NULL;
 #endif
 
 static void clint_send_ipi(const struct cpumask *target)
-- 
2.25.1

