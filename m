Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3120429486C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 08:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394747AbgJUGiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 02:38:52 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:64899
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388999AbgJUGiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 02:38:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPl63EBIIRH1JqWei3lqkjLnV2c2IsxFbmM1/9kpELwG5yPeTUFMMuWDGmkQ1hnK55kclUARrGM3gqNQNNX4TR9zIijedbeJC0eqXEHGhzZlN4rdksmRwh94C+kYYkmyjZNToxB+i4FuHOMFH6jYC6+YCanj7uJ/itj/FBzGYZpHuODzwcesGti/eQyqdJecy5ToAbA7ZOA0CBXB1HtabN2UXKk+gU4H0nu1ISbmkq0bX6QanonIlIR8BvAcXRhKn9ouycigr10P2CgpQp73FFxAVIstNVEWiQunW1kpstaKFKlEW9H/wLwXPLuoxcwGRDZjPq0JRJSu734MGyssag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb+JlaZNaRoh+ynZ8M3CcXhr72alIMWIQseHzv4BmuM=;
 b=IcBnJ7RYUdHZTJlFJ6LDhPpleb2QmGR0+1FgKqnVJYYEHWI4K+WRQUNBMiP/muFiReHCLThIp4MgU/zRuEh5rvkEcpTctuXU/zBq2AnyCCaysRafnK57jdUsnnyXO6co/4z0TAOkiDJ5/0KUl1xaOfKwuRVqc3r+8B78mOt6KN7W+mezIQC6jRlXSZd2tvSGy1XlMFoYo5Uy1hwkai4dfKnlTMdS9ANQNJokkB0yGK/YENUrrVPS2pPNXTDiBVyDOEcEY7S4SxG9VSLwGFy3bOlhR8I5ivaslc7pnyfBZLcDsK6DKHVpTGvE/BHjan34E2A0uMM3z0q92t8oinYIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb+JlaZNaRoh+ynZ8M3CcXhr72alIMWIQseHzv4BmuM=;
 b=sTv5x/2uAAHbCQv+wajfzl7gFxBU6Qd2KF9lAmMpWF9/aPC68EX0XSy4HCkINefsT2qjWXJdS08FGwYtGOFBdxbDJZ9L28bzSMR2FcJrQFCFW8HEiDeiLlJTtViwRn6QASC+MA1oBpS7GZubzzTy39GtEm4FfIwjUrA2MOwA6h0=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2534.eurprd04.prod.outlook.com (2603:10a6:4:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 21 Oct
 2020 06:38:48 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 06:38:48 +0000
From:   peng.fan@nxp.com
To:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org
Cc:     michael@walle.cc, krzk@kernel.org, olof@lixom.net,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        festevam@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: defconfig: enable CONFIG_GPIO_MXC
Date:   Wed, 21 Oct 2020 14:33:26 +0800
Message-Id: <1603262006-28217-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0154.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3477.21 via Frontend Transport; Wed, 21 Oct 2020 06:38:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52e3a4f2-02e7-4540-0d71-08d8758bf6fa
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB25348CBFFD6586BEA0D8AA16881C0@DB6PR0401MB2534.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yhUa7asnQrcE9unZM4fOk7kWQ+ADqo7bDu8Xwclc0ufP5pMR22qe5bq+dUAaEtUAn8l34SM6o4y7MyQ2q8Y4NLfUxn6Gck52OJT3om+S451cBJmgFwsDDjIogLNr+cMT99/bjDOboEkz69ocVp+yj3Q6L5ocgyc2mRIt3Lmf43CdR/AXNKd9e1umgT2oNDQhNYH4SVNqvXuuuwZBo9mc0MeORy4p4czeYSa/0+YmShernhAcbhbeNKQGRsxojck86dY9GcaPQbQ6yp4inQ+rEBcnhW9JWvIQ2ua4vkt+nAhdf0in9t9H9jDStBtriXbWXaH3z7xr60aNu9cbSYqCNwgL7thEhA4omPUXi9LJK25K/GKsTepTLe+nzWGIkFI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(66556008)(8676002)(6666004)(6506007)(8936002)(2616005)(2906002)(956004)(5660300002)(316002)(478600001)(66946007)(4326008)(36756003)(66476007)(9686003)(186003)(16526019)(6512007)(86362001)(4744005)(6486002)(52116002)(69590400008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: akGZpA52L7W5Zjlwzveq5/V4B7sYdymVL1g7UiobrzVjuZxYB0Fcdo23Y3f3Vm3mRd7NhjFcLmsVnvp0A5Hr6dKE1TxSPSEdKv0Y4bp99lvuKC0pTp5Wde5jhGDr459ymlBY5xZ7WXK4WBqUuTRMjqgeHur6qOFBQl9Qx7DEwVA9a+PC/GgBzHLEPJAbvHkPJGA4n2cg1OdueSyubE1UTff0+iorwyKPfsCTmzalFVuWNZTwpiJ/gxYs/WxYvDzuxyrA+cmBqrXMRRkj7XZ/w5vRlY+lDICckWJW+FNKbByc2SXXwFk20Sed6FK6gTWcDaTlFsJ94S5C46AgFijyZurHN9a+P4AgtXDEwcET7YdJp3ouIvOjTbEmENwHfaGYRnALvZfqeSN5ALkFUGbQ3Y/PTjA5N1h+J6KHlI6G4AtT2L2xvWOQZ5xgkesjw/Ejp+o2SxifGvIyiNR3AW2oHgkFuRefPke8DgAOHRFl2UmSKFSu/O1zxzCG30PFfhN1kVVOATIDegNVTr8k5EAzZDePVFmy6mJiJQto6DZU1l8iYDJ1SmYeomqASuLb+ED+ZVE+HEWDWIdyFaQ9zatEK3KTduNRPWfAfWnUkNwffhzly4DqMgT5wOBxaxvycbtMtDxAPxJfeg67r5eACV9Ynw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e3a4f2-02e7-4540-0d71-08d8758bf6fa
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 06:38:48.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7Zlrxt331Vv9nDHSZ8gLgEcrJ0sInO2c339R3UaAnTOmgYD6EJVySwtJPaVipNddSRV4AUfq8OHhEQaozfXGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2534
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To i.MX8MP, always met "Waiting for root device /dev/mmcblk1p2...",
it is because the gpio driver not enabled. So enable CONFIG_GPIO_MXC
to make sure it could boot well.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 17a2df6a263e..5cfe3cf6f2ac 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -500,6 +500,7 @@ CONFIG_GPIO_ALTERA=m
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_MB86S7X=y
 CONFIG_GPIO_MPC8XXX=y
+CONFIG_GPIO_MXC=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_UNIPHIER=y
-- 
2.28.0

