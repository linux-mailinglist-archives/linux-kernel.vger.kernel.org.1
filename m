Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549F1279783
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 09:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgIZH2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 03:28:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60153 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601105296; x=1632641296;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=VZzU2JljOb2+CPcK5tqaPbpOGFlM/u0H2Pjp3INIJ4E=;
  b=FiNqsJaJ8svJObS33Wrh/AkQl3KslY7a95e0eqoHYdWoRKceXSRjrvRj
   bPzrN9KVaIEOR+hsf1DbhQD+mPlimuIQAN5r+GQ9a0mcVU1qPkazZY6BU
   SlOM0K4A8BBCigUcPcE5tKI0v81ZyxLH7wuOl7228FIVfy9YK4LCpEMzN
   pKELdpjCbVlhYxXXvwTJxonT/dg/w8KZ+vlH5zxXGa2lkWta3pWRh0APp
   53oYD3lhheHJsUuPdIA0no/Do+Fmo6WSFZXZ7LQ38+lNiEP9KTejKatKC
   dzyu8l5AaTjy4Yr4RR6oS7U4ZAOw9x7KeRvysiaFQZiSitBLDWUZu3Sp4
   w==;
IronPort-SDR: J1bUl6bjZY/G5JNZlvEhLjaZXIFqOQZ7iV4LZtGcBoQCd74lpUThpivpbNiWEjvr1ZxU0IXiDy
 13DlGzSknJyOqNy6uNI32DSRZzDf9qjhJ60QXqArcS6ofitv5p3TLXUluO54LbodHnIn2ZVn7X
 tDhN30Wkd7MesigvNu9vj2XGGKno2BAnK6POAITqY5bbKwzygYBLLmZ16ZZQK9FBHOvaVrgAzZ
 pH1TJX5XLjuz3fQzwX12ohzDPkUFgR43Lwb+iCftQ7zDi0cVgfeUujNf0oR+BgFickg+8yphJR
 nKw=
X-IronPort-AV: E=Sophos;i="5.77,305,1596470400"; 
   d="scan'208";a="149552964"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2020 15:28:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmZPr/pDDFUX09UDfNDLUMXRPIxigqPI8Yrwyw1Ce5n3hW6aVwCYazaaSmHhFqgP6yhcAHWe5OTt4yKfCmwff1KYz2wN/E3FgED/ZK4QEIycBRJB3ZLSah5iouWWg1T0+v/Oa0kdC980nUr48Zv5D4NIfmWR99mv56HW1HNwoi2+gif0yTkiSwBx+XSeVZ0E/GgtKsfH0eniubznv01w6Gw/6fXo663aRuPugNZNqW1q67gsfeVlb3uBeLRszzQg0vdo9BSKDvIUuwjBreKsBL4I4NUEAzEVifHQwrp3iPH5MmRNfnszQBy2oeWARub5JcVYHvmwmcBDIT5v7TYVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3Zu2Ex45yAXc98YlTPW2vbFGpRgTS659XkEHOJbjCs=;
 b=jGXNTnmOdi+/Zs7eUDKRRzwnAqLbfIdey4d8L4G507JCJnBsDGVBbLeH9yEmsoOFcyoQ67+Xqt9JnKK5wZiF8S3Z33RuUdC9VamkAFBHYbGr8Q60tS4kgYLiRSFeoxywFJguMmjOTaxAL4ipdPcbxVl6+35zbeLzlM/RNvYehWG7IQpGQXmi5hmXcGhNaiHWPwCVAOu2H6TwCawFRgJ0UYG7bpCMI2Ir76aMI51NYxgO8oY+A39xa3aGNE3eXfx4rS1UY0LewI7epFhWysjwrE7AiMiW4H5ppgH0wWIeQ5Bev06/wyWuXuVGEWHDbfPKIhCdlgaqNvusuUYKFBNL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3Zu2Ex45yAXc98YlTPW2vbFGpRgTS659XkEHOJbjCs=;
 b=KXpZfJtqB6wZuy8ab04DoIUDf0vfDBgwY3IuWh8wRBO+0T3CNzQEwR51oaruVxu71ePgSHCvFAVVEpSemXErMCM5g4cnWPN38zP5A2uj+YGwWypZvreujUO0iWq0EOjIXSI9HwHJshfPTyKpflKFwebYKsOjqTdXqCjwsOQSK7g=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4812.namprd04.prod.outlook.com (2603:10b6:5:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Sat, 26 Sep
 2020 07:28:12 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3391.020; Sat, 26 Sep 2020
 07:28:12 +0000
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
Subject: [PATCH] RISC-V: Check clint_time_val before use
Date:   Sat, 26 Sep 2020 12:57:50 +0530
Message-Id: <20200926072750.807764-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::36) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.126.16) by MA1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Sat, 26 Sep 2020 07:28:09 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.179.126.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a62fb04-3b1b-48ba-5384-08d861edb99c
X-MS-TrafficTypeDiagnostic: DM6PR04MB4812:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4812DD54A39F2274DE7D86B18D370@DM6PR04MB4812.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AX1bBFMuuhXtYEaZkCfSJavq86CmMp9bFXgfmGcll3OIKBiIvJ4FmbCcO+HQBiYYP72we2jjXuBeHPvos6cXA198RzQrYygZPPOXelurX+HTdjTkLYK+KOaY1MulP60wMtUIZBNS0xFvZE8n8x/H5vbe5KGc+T9FBBKsct8jdO7cXxSOLIh6sQpi40Hi2LvsUEOjg8zhsooNvEOwq2uxJel9+2tZ6pXPQ5d8aPzK0L76q2Hb3fUpkxheqrQ2qSyNpgFAN1Ujg2wvmQSi7qVWpl5m7vqufX1QQY4eXWAaTaHqqzHv09EeSApF5YhNImbhg30qh8W8cjmdWhg6PwFDJqfV8iHcJezKaFnrkkmbNe4YQAH3gGMPJ1vCdaAgnJeX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(83380400001)(54906003)(110136005)(36756003)(8936002)(55016002)(66476007)(2906002)(8886007)(5660300002)(66556008)(16526019)(186003)(26005)(66946007)(316002)(2616005)(6666004)(8676002)(86362001)(1076003)(478600001)(956004)(7696005)(52116002)(44832011)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BRA7iDlqUDnXuNOhB5OZ2nQUumvlJ4sMIrA9qKeQP55NhbB2m907N+jY4yCDUgzUyfb1PK5L0Y/Syp3wHxx5W/FEN0lTP1YWxN0+LmeGPW3gccozhRu9eNsI7tht5E+h8p4ENKvUeLBn1Zhbhv+P35VM+1seqyROg6+r1b4e06fCHP3f7qwj8rzi/qNw/GaPUXK9LriJ56OEzLJQVbFrxo9IxVUXMWbRHEyrvQE8ZKbQTI6u77B5RnQlhd6O3XQc4IYP2laTMErj5Fjy80h8wUxv1b843juEawu/y48/0FZq7fDRLvNM2eqmQKuJhZgt3PCTYIEtW8nKw2QdXGMSRzzRv+xM7abuwnS50yaRZOwNWGX4TEeuIvkYRTjWX1dWNUsqVBrHOgRpgbV0ovNvSnnsnctIwIsD6RgB8fTmmvMDTR2IMLe4xPC8fn8E0qZbJzWqO/LlGWlakpwDIPMRlIgzAMxzKQfj4mB/LFrmCJK136KqivKNpX3XAk+fw/oGe6n5q2d0X5Mqe/3TsfzbmhkmCWDSO9lsoCZmWVkhgMfSy6SWEkx9MwSH24wIVSZxAdnsNK7WA8+Y/7+nnnq92JKPP/kTN6It8PPfHgw+AOa3MnBY/SsDlEfhOVVWLfYOfIIxMi8EBJPthi8kKICGTg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a62fb04-3b1b-48ba-5384-08d861edb99c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2020 07:28:12.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaZyjEU5SFjTEpI8K7su5km5mV5p3JRuaqznOVAG2GNKeY17RqbPm+v57uwYKq4EvUV8EGBwtMzBUXC4LPaBSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4812
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
 arch/riscv/include/asm/timex.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index 7f659dda0032..52b42bb1602c 100644
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
+	return 0
 }
 #define get_cycles_hi get_cycles_hi
 #endif /* CONFIG_64BIT */
-- 
2.25.1

