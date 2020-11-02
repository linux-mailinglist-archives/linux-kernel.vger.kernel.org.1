Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09BE2A248D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 07:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgKBGAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 01:00:07 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:51822
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725208AbgKBGAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 01:00:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTH/9cBQMYYTgof5RYSiesvuwFYjuTis/kWkCTt6MhB8vPFqvBCLmMpgKeY2vmOweBHfff5QiqK15xrCnViAMwXNUqpDw2nA33MDFjuc55CsqU3O/35RXuxd+6biNUbjZvzBUnhGvzdakWNOd1IPk+hQXMwu4d2D32yDINlOkyYUl7JFI9pMkmYQ7zR7CDIhUoYTk6MCMz6xhO4dGwtBZvha3j8Y+pakngdFlGt/imMpopeCQCX5LUc+QMlq6lWeOmQXIdMEEocTnEegwRyc+QNbT7sVNN1ZtyZQdD/Mx08OT6LxcAEvim0U3rYjNFvP/urUiFHUbf5SD9LU/3zOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk+s+qoegWiGYKOPXVQ9hOnj7U0qAUCpC32z3iLLkJc=;
 b=Dj/vxn7nKuOpMb9KYIXD5Ob975pWlH++NpNFKhnxDc+dunJ3rmvIx8qp3023bsEJgzL+g6Xd6b+kv6tMTdyCwmWbgyXvoNskb8wVzsCuQgJkXn9eblAUXbODqnaGTv5ujbRsM+7YSa1GiesjefzVsG4uU+7F7WcpSUE+ofVeaaEoZWPkS9KVDzR7Zw6OElTGYWgqXeTNOt0h6uNHPjXcq3+PqLb1yiQsw4pQXPu/9lOJLoK+wBODYw1Q4AhN+IoZQOvD2/kXsiyNYhk8d2bbIjsnrAu4GlF5AyQWzMjgSa2HzjKWBzA2eS4qMGyZ6ciGMymOTymQER2kMPot3/AZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk+s+qoegWiGYKOPXVQ9hOnj7U0qAUCpC32z3iLLkJc=;
 b=VRhJZDxb/qJ+1EQlDUG2iiv8vx2RkvLUMx+GdPrOfPfAD30aWgpNq3N7NdJzxR+nKMuslzb79a6+6wuDlsywZCf8Gsk5P6Y/RfsWVYMZ6iKo0bV89gqG/p7ToJubuS9El4kCAdw7PmhBfxoSyZ/lhmPLEMJ3NWyz0WjkYmixK+Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6893.eurprd04.prod.outlook.com (2603:10a6:803:133::7)
 by VE1PR04MB7439.eurprd04.prod.outlook.com (2603:10a6:800:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 06:00:02 +0000
Received: from VI1PR04MB6893.eurprd04.prod.outlook.com
 ([fe80::48ec:3370:b98c:ad13]) by VI1PR04MB6893.eurprd04.prod.outlook.com
 ([fe80::48ec:3370:b98c:ad13%2]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 06:00:02 +0000
From:   meenakshi.aggarwal@nxp.com
To:     shawnguo@kernel.org, robh+dt@kernel.org, V.sethi@nxp.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v4 1/2] dt-bindings: arm64: add compatible for LX2162A QDS Board
Date:   Mon,  2 Nov 2020 11:29:40 +0530
Message-Id: <1604296781-28295-2-git-send-email-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604296781-28295-1-git-send-email-meenakshi.aggarwal@nxp.com>
References: <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
 <1604296781-28295-1-git-send-email-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To VI1PR04MB6893.eurprd04.prod.outlook.com
 (2603:10a6:803:133::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0067.apcprd02.prod.outlook.com (2603:1096:4:54::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 05:59:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc76d1a9-86a5-48c4-5f18-08d87ef4897a
X-MS-TrafficTypeDiagnostic: VE1PR04MB7439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7439BB85C72D92D65DDBB6A68E100@VE1PR04MB7439.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXH/Bik/xMkoUkORRFEUDNMpluzR971dQFjnvtbO9iSoh+kig+g28K/vufxpHMM/YVico5MkXogjPobRb5KykaNsCAN0v9jShwtLa0VbfsZwFoPAQOY3GR+10xcAfUTAbjvXL94qQDhR7aa9EUIzT6zphg1qC1rYH1xvFIICqMM+bc20QQX1G4B55DvTNpXvu2L1fo753CVNNSTCuNn+AgADpmtRJy8nyWjuqcYfc7CxdfXsJUgeVZTdfmPcKCJ4XIw2ztCzBaUrTIo+fG6pT3z9eC6gCTNzIdi6VpSIOQvPT0zZyE/GClxNhritWg8W+5qxxDgiOhZ004Izc3wtPmx26seedHZ6nOSLGWJJZGa3j3awx+aymS19idOsUumX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6893.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(5660300002)(66556008)(8936002)(6486002)(4744005)(8676002)(9686003)(316002)(66476007)(1006002)(6666004)(66946007)(7696005)(86362001)(52116002)(4326008)(55236004)(16526019)(2616005)(36756003)(956004)(26005)(478600001)(186003)(2906002)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OtnPXRGfOas0my6BiPLeFYJaokCbkUfK6hunysrS6pdM2wK0HxATgZL7IaMFc6dEVlA+y0db5Gs8P/WHIN6byCjm5mH2DzoDfYUXlFUln5IRmhZnWTsQmJnFyWfDQUcNhWlBdXUq2hq2w6mqOU+0o1gRoABIMLdYIimz1uvML6LtEOiJcvWUstmE+aHfmq9uFZCkSXZguNGuWHYqLe0gSKCBIemUd+1xm6ZMUeq0xfB3XOOpcg23Q1GF73B/ulevPjDfuP7wHVoAjVWFf8fY1Uh07ts1tEbkHF6RHf/bT67mK0FQpt9FbYB41qQBqUkJlu5Sw8DGsKCPqHVrbB2X1z1wE/uRiPkOcJruSTrAjE4rHSRdmbx5IZxxYqCq2i+OYWdGHZt75qcl/t6epm7lWbVQNdplOR5UbkcmmGy9Ews1j0GHz8xXmSqtdyH53/VVxXKxlNPWzUAyksH26X8WNAo0AEgZhr1xDThdE0X8KxENQ5YWZcFnoCN7kdWSL48KM4mB0ZvSeXYs96U7IMFqJ8vYP0zCtqVN4uVLLc+fJrIDMjNPDXvY/ejsxTmfk17rcUwofXYcqVqiKs4qUlDEuiabFugWfinmyWF0qmA8QV+sqAL/JaLQDAiRJlUBzZOMb9KgzHc8OKiJTFNr1Za/cQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc76d1a9-86a5-48c4-5f18-08d87ef4897a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6893.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 06:00:02.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywSw2pd8nlY7DiXyKu2LPYhHo15oAYfUjv36mjy0UU7zECVtPbn0ywMFLCL/JFKiA7p2TuOunE94wnInJAMsSpfF0Pz4uiXEe3Qepq4NXhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7439
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

