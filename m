Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19002C23EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbgKXLMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:12:23 -0500
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:31054
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731232AbgKXLMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:12:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9y6CrHbt5lJGS7nbmthHyJlcTs7EMPdQE+ZWX9ToK0weIwpkPdRmNRsB0z7TuqPEs9jZ5WND1Asafh01Y1XllMn5hmNJwjszjMRUkTZVmLVVEN3mBhGKPeePdjzKKYW/HEPioAu1ih7Nqo1DtvSpfi/BppE5bM/lN5UMj1/eOkJ5uSLRzGFD4ORGipx2g4Sjls6Yu1ELfH50k4pCVrsvfXEfvlMeAFkoxfkupbXU+GLUk+pCV+j5M4cMJ1LcZqRunkDHE9SN1wMRX4y0IMZRmTZ15/JWo5wkh/D2E74r4F73z8NZRLPb1rpPYz68vzT68PjEsIuy+73JTEjYzIA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7ovQ/CmZdtqGi7giTIb4xZPi7GgTreGKVw3EFwE9OI=;
 b=fpU9AR12mf0NG120+WYQGefamMgwWq6ovi6xQnduG+zX0jhNygKRWO0E7NQvN1ZqpDsFQ982Merqm5QL7r73pmHqL7GC8y62QpzJpcgq0miTRgWYpLx+Ax8poynlkx2ysEjl7q73iaDAdBp7k4be/BKz7EKUhPDKHKNQgcgRsidVBO9YMqiSggeI8Ip0nezg3/HhgUeF3vcc1OB9JltYWZVbrX5UxpCN6xYUXBPQxOIsWVYm+w1DXzkNPJKLmakz1FfN730E2nXUUiYNSk0LJeqDBN3YW5HLl9favLuEeT3RZ5ATxvxy+zNb0Iv7qzZV8fPvVRv4pEePuvr7Jci0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7ovQ/CmZdtqGi7giTIb4xZPi7GgTreGKVw3EFwE9OI=;
 b=ZluaostCjBKHL6JgkArVQVNPBLMebx7k3iTJmutBrMQV43iAr66nEkoL9T3gldfbr53XvIXy/j1H+QU7evud+HwG2fOQ0FeIukW86ouQst0cYxWetkNwEQ4+AlrIS94X3AYLHBzw0LV/P2cyDGXhmfJv+W/TdCffEunAeU1R2RQ=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 11:12:16 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f557:4dcb:4d4d:57f3]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f557:4dcb:4d4d:57f3%2]) with mapi id 15.20.3541.028; Tue, 24 Nov 2020
 11:12:16 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Cristian Sovaiala <cristian.sovaiala@freescale.com>
Subject: [PATCH] bus: fsl-mc: added missing fields to dprc_rsp_get_obj_region structure
Date:   Tue, 24 Nov 2020 13:12:00 +0200
Message-Id: <20201124111200.1391-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: AM8P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::27) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM8P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 11:12:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6499a30-5718-46ce-3d41-08d89069cd5d
X-MS-TrafficTypeDiagnostic: VI1PR04MB7118:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB71181EB88FB367FC155FD7F7ECFB0@VI1PR04MB7118.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNRHHWLYwmzQD/iNg9aAzBHthMRk0r38u1EAYKk/U0J67dr2bn1BHtfg95jtmSi8s6MCeCM0MsCxuJdTNnGo7KljBVWV/FFfbOHs0ujcc64nVMsuOSMCJVGNZYU1l39C/s/r9h4szVz7QoSl4SexKllazL2jdR+J6w8+WAwRi/xVZsZIceFl6b8MTKCB6EVkVB6u0bW/PLd8FXy0C6EXntKtJMzADF9tjAL0vgvCytroD+LCiLuCBSKIlniKyfOZMIqEs1axmgT51qZGRycaAarKj6lXdprPzQHRHwdZJu93MlFYkIb7T33GH8MGAdS2Aqjvp6gj/a7KTgeZkKIBZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(9686003)(6512007)(316002)(6486002)(83380400001)(54906003)(36756003)(2616005)(1076003)(8676002)(478600001)(4326008)(86362001)(5660300002)(956004)(6506007)(6666004)(66946007)(66556008)(66476007)(26005)(2906002)(52116002)(107886003)(186003)(8936002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VtCuI8oNW4hHkQ2mgZYsdRE+HR+6EUZjff6jsL4ZT8jcZwxxQ8C1Bb5YLoAZWQf3GU378islqDQG37cEAy7dBsCenmQgHL68QzPrxZWiOoBkIagrpQZRnweD7UBcV6MJv88dfJjZp83KUra/PRi2W33Fr86jCsXDwZy2Nt69IcJARtIdjIT9ITH8IknSmJ498KCopgT23O0dZh0mSotQtoQIR+KwX2vLDTAyPHiI5f2n1jlJrf/7IEuACTej+ZnzgDRALgTuynaEq/QWqTUtxLOjrPsssProUX4cybU1N+r9U5tHs5xkKHGs7HwjbrpbOKm+48IzWeJbtsJ1HjFKaLN/ZIPvAmlAbPi5SaZ3q5CLMhO17mWLF7DnWQkWSzIuXGXxbvVh1a20nM68S+XbDOuAZSpA0hjJtdUUgkZLPgXc8mrYB9R1EZgNWNGq5waHntpXJN5XSgHdrS8RlGc4BtrlKXFcc+pzU8jhv2DW0Ii5AI94gWTlS40TmXwnIaIlumNYnfwWViyE0qbk2vbX2z0USXg7V7FsMigCZjKX5BTU2yrh1VaqYdQDs/GN88BJ1zmtS3TSi3I3WtTwITAI3WWN4x6CKYeS5IC1QOh1nnEmK9royo2sWwWZCmZwFxsMqYFnPMbsH0wb9SOW0W8GNQcby9qbHEd7wx2j4ahp4kXEE7munkQIwgNRVZVebR4WerJ/ZvMdA6JKC98OeHg5AkRu5DbcQgjSRgMIRuPRO6yGQFwqYS5Wb8X+6Z6FI7L0fh2UcFfbkQuXmZZ7gGp7ul3ncaAhllM1HK5HTdzimN6S8aiWDqvOBGUeLB043jRaBk4UeTgeeUxpSyjyBbAqUKO4iIlUZqNQlBbQiNsBtOO1Y9CNHd8Mhd/ujlI/7ePJQpcdhfo8PdccdpFmwsMF8w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6499a30-5718-46ce-3d41-08d89069cd5d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 11:12:16.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Trgwp1qNNmovOUg0ArvedZlz3H0kwM+XelEn9cYnEk/KCPvpCsgy+lRuL54zEy38tZXbKAKKAEC7iJjYSvA1Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

'type' and 'flags' fields were missing from dprc_rsp_get_obj_region
structure therefore the MC Bus driver was not receiving proper flags
from MC like DPRC_REGION_CACHEABLE.

Signed-off-by: Cristian Sovaiala <cristian.sovaiala@freescale.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/dprc.c           | 2 ++
 drivers/bus/fsl-mc/fsl-mc-private.h | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 57b097caf255..27b0a01bad9b 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -576,6 +576,8 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	rsp_params = (struct dprc_rsp_get_obj_region *)cmd.params;
 	region_desc->base_offset = le64_to_cpu(rsp_params->base_offset);
 	region_desc->size = le32_to_cpu(rsp_params->size);
+	region_desc->type = rsp_params->type;
+	region_desc->flags = le32_to_cpu(rsp_params->flags);
 	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 3))
 		region_desc->base_address = le64_to_cpu(rsp_params->base_addr);
 	else
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 85ca5fdee581..c932387641fa 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -211,12 +211,13 @@ struct dprc_cmd_get_obj_region {
 
 struct dprc_rsp_get_obj_region {
 	/* response word 0 */
-	__le64 pad;
+	__le64 pad0;
 	/* response word 1 */
 	__le64 base_offset;
 	/* response word 2 */
 	__le32 size;
-	__le32 pad2;
+	u8 type;
+	u8 pad2[3];
 	/* response word 3 */
 	__le32 flags;
 	__le32 pad3;
-- 
2.17.1

