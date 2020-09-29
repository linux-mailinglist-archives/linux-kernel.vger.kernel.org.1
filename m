Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E39127C1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgI2KCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:02:48 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:49659
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgI2KCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+ZRJ9lLePwrILVTMkV6o8ZBXw/bhONFTnQjaAZDk4avZX1x7URxZ+TvMTRAWqWPuF/WcGzwKQBSD8ELNo22zs64Lc7RUPmZUroQY04azK0GQxdZeoxrAjijPDuY0EPsYzWw8OFY8DJIuLoQY6t/by7zkGvOrwBpiLDKdhvd3wn52YjCK5dBal2g+ih47hwiULHlxrpD8kTC6mnfAxWwCs5IPwTvM1pFMWd+WpAuC5KMLmEFlKoUuyVFirZKzS9BDzWbn6ng1nhfPYoFTMPmQ7JmetKZ7CfswwYgLFgMcDzqVLD2bYCkvsdV5nTZJ5EBrwFkPjUaDFkVqeJULGJKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk+s+qoegWiGYKOPXVQ9hOnj7U0qAUCpC32z3iLLkJc=;
 b=McismWKUJ01VpQq7UcHaUFn1f3D0uhdGyOWQrQL82+ieyyD7RW0OAmf9PvMgIkBBSlLKIc9sWxKvbBDbniGeqXH5pLymy37VBfQ2uum9xG2NQ5Lasr/s2ZqDYetX77xqNSn7dk+xvLdtTuiK0BKIJW6TMhVlEce2FpVfDnLnZTN1A6hcJ69fYgoB3tlWV0XElRNRJo44FI2zZ/XibDqmvEYXvSlnAGYIZ/qnRgXTUE9IGokCQn9fkUVpAi0r2Y4obrUvoFNpO8EwMrjRtHEQLLK95GlX1M1ul1Esii+Mgc4OfZUamXPcHTZD+voiCX9zJ1BFmYIkY0HtJoAMas/FsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk+s+qoegWiGYKOPXVQ9hOnj7U0qAUCpC32z3iLLkJc=;
 b=d6kR0Ec4PUbE686+dIgcd9yKMKG8YIHhNRRnABkgGb2oOJ2EePbjhREbc8HtHeOF7VUtvYgtRlK8jJcZ3QzdBuUry5HbO+FPp+Njqjd9bKZgAFcTWHBzZbD55WiF14COerK9Gj715Sfl6WDew6X1WPnvbeltCOENosJawjFbe/Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 10:02:43 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 10:02:43 +0000
From:   meenakshi.aggarwal@nxp.com
To:     shawnguo@kernel.org, robh+dt@kernel.org, V.sethi@nxp.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v3 1/2] dt-bindings: arm64: add compatible for LX2162A QDS Board
Date:   Tue, 29 Sep 2020 15:31:57 +0530
Message-Id: <1601373718-13218-2-git-send-email-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601373718-13218-1-git-send-email-meenakshi.aggarwal@nxp.com>
References: <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <1601373718-13218-1-git-send-email-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To AM7PR04MB6885.eurprd04.prod.outlook.com
 (2603:10a6:20b:10d::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0005.apcprd02.prod.outlook.com (2603:1096:3:17::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 10:02:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a8d3e68-9464-4916-f956-08d8645ecebb
X-MS-TrafficTypeDiagnostic: AM7PR04MB6968:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6968EA1F3C245B97016B60388E320@AM7PR04MB6968.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJBVm3UK2kR+LIIDbo8u/QGkgTU0P6fn0lmAF7e+gylTTjI0dWiAqW4vOIOBfPVH+KfPLDimGMbWiS7xkleEbH4ZVNK1jV+L3L8kSPneTh7ACFfa5jMxZ8rHtJC6KzRVj3lG+zvGaM8dEjlHqAgFnqjYz78mZIqsIMm0Qar/hHG6igIiAHl/JUu+NTbNvtANRvAgtSm5jepGvOSGMlmlQ4FwFp3WwW40QzRJmG2T7ATdjLEJuUHoEAgBp/92XrgVmh72ah9vwFF0npah0PvsQHhJKvNgWAHmbNgBmOXGIxRNKyVB5936s4MV6sIHfULzD4H2BZR0OEXYx+mybnvNRNulIWbeT8M82Zw3ac7GqADwYIoUGtzaAA522MMGZIqPEmUuO2VZioCWx7ps8Y3CIa7kbzS6tZrOZ13Syeo31yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(5660300002)(66556008)(66476007)(36756003)(66946007)(316002)(9686003)(4744005)(2616005)(1006002)(4326008)(6486002)(26005)(52116002)(7696005)(956004)(86362001)(6666004)(2906002)(186003)(8936002)(478600001)(16526019)(8676002)(55236004)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6RnwLk2nFjgn4GhGL7l80Xnr4DbHOkj5bx7ko7nL0FYraWqeMos9K9ZhhaCqRtGjiykCn4n2Ff6D8YkNcZHXSnMnO3fRwUE+QA2hYeeofkPTJYIf+UW5HHb04VunfMiLwLA+68LjJMThRWHANLU3FTtQHLEGAvvs0luOLXwyWMt0MF+19xOyQxUMrvpELGULhDRC/Gjszme+pHXrQcUqWTdN9+WdgOqf8Tf6FtHQTLyQUnvUP+RCKtBy/H2g9nWyKAk+fvRsd8YEKFOKtCXtA/+1jimHhHBt+CK4s5vsjc2dwlAwn+m7u/rR8Mz/VjC4kNLwsB2+oeH/EjLGb2MpJcRcCJCJO34xG4v1P++EC2uYREQQlSjhE8SzxRBDD4yYFtkTmdbSFqRJ4a0R8SUohMeKIupkJg85MpcPJgcKhlld6wUkmvr2jGgUeZDk3qkB3NcLK3GRMRh3DPLsjP2rigMT6Z3aMV99aKoHVvThLHRZ52i/8XBL5Jqi3/Hqe3EjZgiwk6P0o76sWC/YRVYEDugYZUH2R3oa1uBXLQ9BmJeJ1GS7PXQH1Ko2VY217Neug71z8Qck39XPEjZV99eQ4bVqFPeNj9nFEwOV/1yVm1qbnWnQrv7oWSEqhMnEegOvuXH1lLKdi4AZDqzydOovuA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8d3e68-9464-4916-f956-08d8645ecebb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 10:02:43.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1DLeOhiPKPV/OVZCsdJ4IrG4PMdqIrJ5DwRv5mSBvTLns/Uk6RZmreThKGUoVcWxvFLY/7ZhMRxLlkWKI0IdknJWadYA0NcSHxzu3DJeSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

Add support for LX2162A, LX2162A is LX2160A based SoC.

Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6da9d73..5c7b7dd 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -518,6 +518,7 @@ properties:
           - enum:
               - fsl,lx2160a-qds
               - fsl,lx2160a-rdb
+              - fsl,lx2162a-qds
           - const: fsl,lx2160a
 
       - description: S32V234 based Boards
-- 
2.7.4

