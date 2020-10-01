Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82557280211
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbgJAPDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:03:23 -0400
Received: from mail-eopbgr70122.outbound.protection.outlook.com ([40.107.7.122]:42382
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732096AbgJAPDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:03:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlqx1RpoFnHWLV/hu2vC0BWGjGBv3jLOmqB7Hz6vn2XJvup283ftd3StIdIbk4SGDmNOU1ZMeIy5G/AFlesV+wRES5YohYCEUMwEv3FsVoCKMdcEQ4qjD3rsSLF9uxUCw0/zoqwib2qy5zcXBq6ZpnTZCO0TT23WLVTYoWH2qcj7fbbCwep3fa6BHaqGSQr2agYJuA9KOtnrlf4D72Iaq+D5JY5Cxsw+pft68pFOb4LgiWcf+icNvDc7FcE9qbchsKPLWajgvlhcXNuz+jUJBvejlBQ/Px4lF0/hlcTHQwPY+XkTqMGaWShF8voITwYVPXYl5QrQ/owQSN4bSVF/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgVniPFRvWDCbZgvFmKmId9NROEzdjoGdEL7ClH+5cw=;
 b=oMh8Zp1lEAIiG9SHaadS7vWZwDtDSzNe8eGovgn7I/drhshcCuC4H+ywJgplKhVBBoNnWLXCnnBqjXENgV2u/MK1d6ncYiAHHiDKDbRwdMNob7z/NaNNSm8JryM2keXwdJ96xngtvUguTVsLT1GjCa0pVOK1tFA1tNh0TdoGZYQGcvGgd8ncba4ZKWurKjVpqmI1kaT3uGKSSbN+GE6w/JuKXPLxc7393NSp3j4YD/gDYNd4wXsgxuBKN6mMDlkiQBJUmStiUqk6NaFgYEwgNPDZ94LX7BCGN2YEQs+U2thFG/r56LgJSqDJXU5PpZ0otdzyG8OATFyHmY3iUx621w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgVniPFRvWDCbZgvFmKmId9NROEzdjoGdEL7ClH+5cw=;
 b=pCT7vQ7Ow7lp2v7YcqVkMUMYS+VSjgpW0nA7ImZo7ladKDDhjR0Iw4PYVO4O3aZaj7XEJjgj21CHYTk6O6LHEb76d4mXkITZRDdLU69LXu5FesTd2v55QmDVXrwpIq6DVeWUHpkRruSAFnarjuA/Myx3seIsVsXPZngvvIA3+lY=
Authentication-Results: kemnade.info; dkim=none (message not signed)
 header.d=none;kemnade.info; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3105.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:129::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 15:03:15 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 15:03:15 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: arm: fsl: Add Kontron i.MX8M Mini SoMs and boards
Date:   Thu,  1 Oct 2020 17:01:57 +0200
Message-Id: <20201001150217.31301-2-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001150217.31301-1-frieder.schrempf@kontron.de>
References: <20201001150217.31301-1-frieder.schrempf@kontron.de>
Content-Type: text/plain
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM6P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::36) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (89.247.42.197) by AM6P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 15:03:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 276b08d7-0344-47ed-81b9-08d8661b1f82
X-MS-TrafficTypeDiagnostic: AM0PR10MB3105:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB31059D49E913BABF06600D9CE9300@AM0PR10MB3105.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvAVl0cIZWfdAff61dg04BEYqBNjc0d4506PNqI+j/eVKBCiY7pfHlDcW+KOROcduPGdpy+uLfADkpGYpwMUBt6xmKT/yFj9olRertj9XbxqkpGgUFAkQ5cwTUkOlhkLGXVqo9KoD06aHMOGm2vi224qk/PHw7aP0MjXTH30EJbEjSpl8U1K7MNHxane0762LITZcIDCsfaIeo1E2MYVd96sWgfBDuddyBiWDOyKIUr3GeiWW8Rh26zDTY6JxORubeAXW4uu0ltYdvJQ1eGODf5Xh1fGF42YECPNvtU5oyP0H6lzuoWz4Ef2bDQnN7zIBBjORee8hSCgyvVLanfpT8CeJiNIFHl2A6AAOE7+IJTnj68PA7yJDuOoXDLEWpYY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(136003)(396003)(39850400004)(376002)(346002)(366004)(2906002)(110136005)(8936002)(316002)(186003)(1076003)(26005)(956004)(16526019)(7416002)(6512007)(2616005)(6486002)(52116002)(8676002)(36756003)(4326008)(66946007)(66556008)(66476007)(6506007)(5660300002)(478600001)(6666004)(86362001)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ykSB2tKBq68i+zCUSO9JaPhsTx3/J77+Lc/kbVyUyd7ndK/jNF4KUVxvGeK+eiTKRqIEYOpMdI3ssqkWJRf4RWOJbBkSMzNVwCOukd+ynz5xow4IewLfB8IHhK7XmOzCF0mxAEFzKK+SgZ3WB+yh2OyfSvJvRTiRqGF9pbYywYQcfeJP3Fo/la2uDX6jTctKM6r88UTC15eOKzPmy+pzH/Ii2XVBGPgJVS2cxrPSBVYMmMlk5HmUuAeo8x4OKKdTshUeDhEsb6iLUQ0O+7FltW5l3ta46gSWBbSqosHADILlZ+qHgaIk5+h8FNHJ+ye4IM0mLaJIm2H1yXTM7SDgvmrdIf9Sgcct9e9aJgTX+oRL5WtWLTxd5IAvTyErNJdCceyAwLP1taoUzWCgKMfT246OIIX0Xd3jU0ETQV4zLtlVLoNkxSpkiCVjAOkIz4QZ7NKzuKzjyuWWVEJil36eWDCeButAVNKfo2728B1IybZAuF6yYSU1LRNqyKYaSDmzOpx74S8uOe+jtZjao5zTJB/ny5DCEQGJ23zOw6xF2S4v8Afmc2NOV25wjxLRIGKksFJdgH6k6QBQFJqd1nDITEfD/Gdjzo5RHbSpdd63ZMj0pCNHkBt8od5xiq9wL4xL5XZ9uxM6pWsY6hrHxT60LA==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 276b08d7-0344-47ed-81b9-08d8661b1f82
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 15:03:15.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dARiymzHfjUXne7zLTuXMLBZ5JxZmFM4Zz4J6+B/7tRnXrgj2Q/n7bsG2ri40+kjVzuFxebEJdNabRfGNFSxxNRWVonUI8rVOn8y3b5/pUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add entries for the SoMs and boards based on i.MX8MM from Kontron
Electronics GmbH.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v4:
* Rebase on next-20201001
* Enhance SoM and board description

Changes for v3:
* None

Changes for v2:
* Merge the SoMs and baseboards N8010 and N8011 into a single
  configuration (N801X).
* Add Rob's R-b tag
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1ca9dfa8ce9a..6daf4c046785 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -405,9 +405,16 @@ properties:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
+              - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
 
+      - description: Kontron BL i.MX8MM (N801X S) Board
+        items:
+          - const: kontron,imx8mm-n801x-s
+          - const: kontron,imx8mm-n801x-som
+          - const: fsl,imx8mm
+
       - description: Variscite VAR-SOM-MX8MM based boards
         items:
           - const: variscite,var-som-mx8mm-symphony
-- 
2.17.1

