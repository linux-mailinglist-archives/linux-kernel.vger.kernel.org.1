Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942182D38A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgLICPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:15:37 -0500
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:61649
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgLICPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:15:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUa8LMhqyNQqXzdQXY9RcTw0dKgeX4VxWSxTlRcZGngTm0nBzoxAXEr2YdtSAARXMfBw4vk7sywIHugPw+yzbltK1Loru6vxsrWkPZQUmtQDTKYXyP5nd+r+SmU3+qXGfQrHaHmUb/1EInUCQN8gHM8G523YT6yYyDB0JwBo6Cv1Uqm3xZ/95zrp1gwp19uCbxqiGqRzGjyjGUu6ZcZtcW1wdAlqPbqIGJXyzy08SvlzGGRlleExfVYOQkvitgt9HgI6EtbRa/TEkITyrch2wi8K4qUK/D5XWv2ta5NYi3a7YNvNx6jxeDzbXOcK+LImq+8n7L0M4SFOkAScTKXVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs+3rsbGvMh9hyW5oeG0tTwxuI+DrokISdVtrDkogvQ=;
 b=Oh2/LE0ekfH5UW+/2Ygi3d+jFWZxMtwC4iD05xCrJcqyawA13iAP10ZSIluBhLqOMTnIhv3/9dOeCxmUor7u6fr+8L89KYvvPCdwxe6EEk4vNmBU+4WdyOXmB69b9KaFOp6Cl8aOEop/GOUe9euguGVwZMbHStywlV9xAgn2nEOGndl54bGGTHRsQJPIbZPDOoBZvqg2/A2xr+tX2DcXh3i0P9VvuTpXZq1Kp2JjXgUXWaV+D0zCFQ5eEwRE1hg4lDaEaHJX90351zPJWRZLG2+58djzyA4hDRsmLx4zVwsw7AgAm1pn30jcHGpS3DObXB2ZKIICrRuQzRXHkHCfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs+3rsbGvMh9hyW5oeG0tTwxuI+DrokISdVtrDkogvQ=;
 b=MRRu98ZNw/G0ratE2FmkPJvADksg8CgjXlo/yAniB06DBlh+HcjowW7+uzrNlkcvT6bKriTBUQ2HYmDH360haFf/2VSU7YS4PmptuF6mvqDXL8XDSeRvptjZ1p0tWI4S7YpxzVCrELKYYt3V+NEKk654mMhMEBLQt7L6C9hWxzI=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1525.namprd11.prod.outlook.com (2603:10b6:910:9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 9 Dec
 2020 02:14:44 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::501b:362c:9295:dad0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::501b:362c:9295:dad0%5]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 02:14:44 +0000
From:   quanyang.wang@windriver.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, quanyang.wang@windriver.com
Subject: [PATCH] arm64: defconfig: enable clock driver for ZynqMP platforms
Date:   Wed,  9 Dec 2020 10:14:16 +0800
Message-Id: <20201209021416.1017790-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::19) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by BY5PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:1e0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 02:14:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8f68f28-9139-419a-ab02-08d89be83207
X-MS-TrafficTypeDiagnostic: CY4PR11MB1525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB15255812B90A01E04E65772FF0CC0@CY4PR11MB1525.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QX4eOVti4iHScElgE2Q61CRB7SEhWGXVq374lp3dTi3I5h6rRMxYXqAqgE+QzuaBOJtr+gzs/xDfdx8Ip/pxEkodIeSTK2dNOrxcWZpfn2+vXBUakJ8TP7Y4emt00h/5wiwNBbswP/Cw2e36rXSUp7q5Nb6wur9MqczeVSdZpuNzLHQyQM3E2o92GMMXg8HDVmLoyra/mQVMD3+XsJRTm4qXKLth6L7QnA7/8Xa12FDsVXQUOUcNY/rdSP6Kh1VUCy6krUWMmAtfRhF3Zs8tuwcr3ENSCGARVqysRTY6YjCiU7XOxs4wZfc4XaEmf7Muy+GzpZDGvew4II5zWZwir+UOvxrqQtqaYBTZV7QwxQZx2pQa1/WCEcAaeoo17SnG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(16526019)(2616005)(186003)(6666004)(2906002)(5660300002)(66476007)(956004)(66556008)(34490700003)(86362001)(52116002)(6506007)(36756003)(4326008)(8676002)(1076003)(4744005)(66946007)(508600001)(6486002)(8936002)(107886003)(83380400001)(26005)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HeTFVWZd2sa1jq2vBPY9p3oDYaRALMOiDfxCP1wIc3sftJcIPZENZhM6gx9X?=
 =?us-ascii?Q?rk7+oKWtAk6h+ufCUXsfhpQnXPSpXp04Cc3nuSgkGhwSvWazLDDw2DgbEz8r?=
 =?us-ascii?Q?9293IG1mfsGkgaqsAE6M8roVepPNLLtAt58ds7TGkrpAVGu/5g19/tqj1XvL?=
 =?us-ascii?Q?JIaezVU6rq1QwyTp6GHYIKP4CKDLMxijC1pNW1ONQPp7uTpnPuVCQK/lF65+?=
 =?us-ascii?Q?1WdzrJr+T8OFYtkL+Z0rjQ/a9vFjC3ZY9tsYTqDi9KRHkwWvujmH0IL1z1i2?=
 =?us-ascii?Q?r2zG3TNHZh7nknCA5zmCRw3LF5/E0jqXQ3s/5p0ZUrqUuRTGS66hEtGkekgU?=
 =?us-ascii?Q?4SoL0GolRfgmZTBXL8KDbpjxMYkFTmlQlwvUvWIXp6NeyNNXOsCMJbaiDEYW?=
 =?us-ascii?Q?mVRWzV4nX6k6dhcITQIv1my1yl9WTwqK8cbrrsXOlwm4IUFsXFm8CLlNjeXv?=
 =?us-ascii?Q?BtlWzKlhnJxEEwUXI3V4B+HFr1wq1cBJ2jqWKdNylajhG6ZmeKEt+TBcNi4e?=
 =?us-ascii?Q?OzRabbe8sqyqiO4PaXqEA4jJ9+zf8dc2fn5nSMEwMF2cTb4K6IrcvJvODUNH?=
 =?us-ascii?Q?XaiRAMRpR1vgYsWxcAU6aa0LO7HEjbSScZuxoLMI2ezmszuJmjrq5fRYmQoV?=
 =?us-ascii?Q?TTF5gpyBfYCXUJohmWA/PBfWx80tTQ8CFgZcJopIh015z7/mNZ8IFd/UMLGM?=
 =?us-ascii?Q?2JLi0kKcx1Fndtd6veLcij4m+Zi/rMgt1GZ75waCcDJ23XxGxXV6qENXlCNe?=
 =?us-ascii?Q?86DWqbrCrplBGxvshSKcAMDierZchYuHFndEVh25qW+J+I3U8ILy3EbU0CZY?=
 =?us-ascii?Q?e0OadwNN2r4n6b86LQRy2LUI/a+JgABVyorfgaNvhohSDscXzC4vXmu3C5QF?=
 =?us-ascii?Q?wntA29+BnLXT7wUSaEX86r1JuHuEOTG+6Cj89b47R1DwVhNfbpYfJLClHKdH?=
 =?us-ascii?Q?fh8tfyt25kXjDew9dIoubJwwli57PTV34Iun1Qy4TsjQKdjma9BCQvDOt1jX?=
 =?us-ascii?Q?aTEn?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 02:14:44.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f68f28-9139-419a-ab02-08d89be83207
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLxl5OnwoIXMbCcJ/m3pELCGnINV5mhy5qOaVyMOaW6cWDMcqouV1FCqJ/wB0FZnNA3rHxA/M98l/UdZmwoqitZTTDHG+9Xsz6eJZwPp8aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1525
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The Zynqmp Ultrascale clock controller generates clocks for peripherals
by default. So enable this clock driver for ZynqMP platforms.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5cfe3cf6f2ac..95b5a963917e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -872,6 +872,7 @@ CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_COMMON_CLK_VC5=y
+CONFIG_COMMON_CLK_ZYNQMP=y
 CONFIG_COMMON_CLK_BD718XX=m
 CONFIG_CLK_RASPBERRYPI=m
 CONFIG_CLK_IMX8MM=y
-- 
2.25.1

