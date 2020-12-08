Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8BE2D2B30
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgLHMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:37:37 -0500
Received: from mail-eopbgr770057.outbound.protection.outlook.com ([40.107.77.57]:18593
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729432AbgLHMhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:37:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4s68nMTEoqmUhEK/TgvG+PyVFt7ilYxS1p8UaORPWQPRwhNjRcudNTXK7ryQBnJCTuhT2njhoVCCahQrjaPPWu+N37ebvQ7vYZb9GQwPsOgc1v8EV8667Fx01iYF55sFHWe2ptqVpPWNQyrIBL6eTMR7mMiMMa+1lIQmGXPwmu7LLEjDB1TbkwWJjnQ1NjpxqoqYWWvtGu7uu633FbJwyeC0P2JjyCeQN5DaquhzYXzogsFokzdCS0AkrEcDSDpfsStzVGRxFFG+26B0kMwQoDUrjoePevZySu9tdXX/PbY4Tv+4RJQ06NX69YalcdJ6Q5QdAbLVWR7WXXTYNg0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gtcyCoTiChIytfGwyjWRc96xljB+mrO+FyvRHM+a7c=;
 b=ktPmDudsT0slQhqNyEbmLD1aSABtr3d2e8K3Fca9J8k6BB5YYVozJurUcx3JrkfC9ZDhKbz5LQvoLyDbWxYffrylPmcJ0oPOQbbpv9JttqTu27mi9OVebpLNtb5eVZDJsz0TD9N5QedI8kwqQwH97F4p+zBO2at4QbWsc31b8Oz6rUow7F1qMqMJ2ZzMFer5CfCYcrYFzx/VmtR+l7HpDXlws3MVXjdYpXGP7AWYDSHoUBiqJ5DQzm2jSfhQCnOjhwIelNNghuI35KZxQeYrIFjmD5O+elObCj71p53DvpF00WKICDwaxjabVTlCqHus0FD58SJZv483try4d9AyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gtcyCoTiChIytfGwyjWRc96xljB+mrO+FyvRHM+a7c=;
 b=T+yP9qRartVWdpmbc5eH2wbnVnq+0SDHYGu5J25DUkx9SoCRjPCiQEy1/MRFSkPY32YcqJU8xK98j8EC7FAc1VxZwsEL8Pdleoq6diK2EK8AXMlrVhJSY84j9wz1vI6RRIrtpvmsmuGIFkV+0OV57u4wOdn5knwMuOIXEbUJ6y4=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2150.namprd11.prod.outlook.com (2603:10b6:910:18::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 12:36:24 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::501b:362c:9295:dad0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::501b:362c:9295:dad0%5]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 12:36:24 +0000
From:   quanyang.wang@windriver.com
To:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com
Cc:     quanyang.wang@windriver.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: zynqmp: enable COMMON_CLK_ZYNQMP for ARCH_ZYNQMP automatically
Date:   Tue,  8 Dec 2020 20:35:08 +0800
Message-Id: <20201208123508.998073-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 12:36:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5d6410a-d0fe-407d-8b8f-08d89b75e01e
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2150:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB21507A0C714A825122951942F0CD0@CY4PR1101MB2150.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPQeo9Zg+UeVadHXkdkrwvWjA5fhQaZuAejfDn9MqTRhRI009/fc3ZgSbS5UVdRwxMckJul8znIPl3RM914+5uiFCAlRTCbap+58wzhlYYnJJDMFEpnB9xrefz9YWQ8aT1Qi6td5nbF3Jrcz+hozggKisie3AHliiajH7v0P7WdwOTI5ussyb8c3hIxE8qr3VxJ5PSaEtkTqpZVEJWFw5dYqVj1ohtLOGJqw6rfQ6kYzRNsfQOEVwrnz0Vjfvf+gW9fCPItgWD9gsNCO6hr39HD3GQgoBGXft5cxyNcJHtmcSogNaSdjRBNus1moutBoNrw0y+Z9y6mVXgy4ryOspg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(376002)(346002)(366004)(36756003)(86362001)(5660300002)(4326008)(6506007)(316002)(2906002)(83380400001)(52116002)(2616005)(8936002)(8676002)(6486002)(66476007)(186003)(66946007)(4744005)(26005)(956004)(478600001)(9686003)(1076003)(66556008)(16526019)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C1NjHzsfVwXxH6l+MXq/An4SKLal5FSr6UZGHS3gKlTPIScaAkL3oH/G7C23?=
 =?us-ascii?Q?42dMPzKqpSt8GrWNCuxDzB8Oyqf1diiBuNNXqN7e7is/M1elmuHjHu+j6oc2?=
 =?us-ascii?Q?ucZL05PEKZ4eWv44erFceoPI4+qQV2ablBXpq3CpQIFIZmi+qJeEEPkbY85U?=
 =?us-ascii?Q?nR3kPWFaiyODkjwGLK1wnVPULtEmKM/30do4RZBKhPLGrrB/sh5rT8h+x3Ju?=
 =?us-ascii?Q?aNSV9SHW+1Dh9tmqgCvYGqORYW3Zf9Xk9A66dHiiJSfCi18wW1Bz0LqozbX/?=
 =?us-ascii?Q?FjQM3ap9wfBCz3CvRRX/ew5/DshsjQH0yIPlaWnVDzuQ0G2x3hTIR9lI9XY/?=
 =?us-ascii?Q?3q+AI4pIqqLhO0PAybV5RA4IZwXs9SCgxzHvgKzRDvvgdnkTmqz/UsWbah2p?=
 =?us-ascii?Q?qqAi1kAacWG6XDRWblG1axP+DFYPNQFco+KyXEQPjjXmUQWUj8nw3fYePcUM?=
 =?us-ascii?Q?8UNUkHUekZg+bpU1c1SllzBqALTKqM6xQKwohBWtBnyq4vudwiWpGWDQDt+t?=
 =?us-ascii?Q?Bwe8PzXTCahNXTJXBCM63iNOhugyAXAupC1WeXoyBbf34M//ESBqWacV9OoV?=
 =?us-ascii?Q?p+Hf3HbOWVJwdtEVXV1bYOLb/tgOwYk7xrTR41rUU/5W5AEfepBe8bNvbLVC?=
 =?us-ascii?Q?Ap1v4yaFS3FE79b8I4oNyi2qCcYku/mFkzPQZKcK2zNJR8t0waGx/eyTM5fy?=
 =?us-ascii?Q?eADtiXhZk9qpmgB87P2RqYB8CEWRqze3KTIWYwGe4gz7YA3C/uu75ipyIk8X?=
 =?us-ascii?Q?8ZP0fZ+H0mgCS1D5OiL0HmpXwR5J+ijGloYH/iX0Sw5WzwbmksU/Vy+7RoTm?=
 =?us-ascii?Q?Pc0c4uSquiZgw04e1tLJmJFN6dCMJ3CPERBLLiNPKYavCvSaMt6a0IAFwJ5f?=
 =?us-ascii?Q?kkvg6qe2pW8ZsWrC8gfWFFUuSNfPsdt6kqafvOG2WR9D0CleJ6QqHuPqTS8r?=
 =?us-ascii?Q?lL6BRSz1SrRoErUHJDXX8x15pWixyrW/yOQ8o8jNydI=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 12:36:03.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d6410a-d0fe-407d-8b8f-08d89b75e01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nq2v6OVSrJE9spyxUkyoUmxpErB20ro+1uV369D5kru7K93lx4zQ2OVC0Tu73ZptzIL4qJlDksY9ZvsPd+D8x/sNcJakR65Wgi74giri3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The Zynqmp Ultrascale clock controller generates clocks for peripherals,
so we need to enable it when ARCH_ZYNQMP is selected.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/clk/zynqmp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
index 17086059be8b..a8aa58bbb790 100644
--- a/drivers/clk/zynqmp/Kconfig
+++ b/drivers/clk/zynqmp/Kconfig
@@ -4,6 +4,7 @@ config COMMON_CLK_ZYNQMP
 	bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on ZYNQMP_FIRMWARE
+	default ARCH_ZYNQMP
 	help
 	  Support for the Zynqmp Ultrascale clock controller.
 	  It has a dependency on the PMU firmware.
-- 
2.25.1

