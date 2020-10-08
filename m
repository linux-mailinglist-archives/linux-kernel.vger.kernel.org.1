Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE1287EC0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 00:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgJHWjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 18:39:53 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:62988 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730491AbgJHWjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 18:39:51 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 098MXBRI021616;
        Thu, 8 Oct 2020 17:39:45 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-00010702.pphosted.com with ESMTP id 3429jg89f6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 17:39:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhKI61wkH+n3h7Bj90zHPVn+GYlwiznnC7/CvTavuiWpOimwSDLgsJ+y20FnFJ6VrqaxKxXfnNQPKSpGx3yAzKN5RSaSh0Fr1nVGnZoFNNdslBH9La+PGlwzuHX69GuRHKdPsfpeOhvn0JDc/6oJ2kW7FGnPYbtIvFrpC+/tqcgo9ltzDb+ZMNjGVYT/+groHmuQsDqgdhUQixXb6jMuzNDCqABcLMDsRtRbE2SjBm89Jat+tP0VU8rouXpGM2PGEMdJZXJVwZdZLbz3TZdZGZDZzYkuYPKwL8QD27F+YXQrzj+rOuKfmwcmwYlBqqHGYkSS0dgq6xmj8Lw7Mmu0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZRzPf/PuWOgwZQVp/7klGRDBfZEGe7dHEzTXjcBj9U=;
 b=JoZld90Y8l2ZAvXBFot6nmTUubiC6E37rJBWlsSZD4QjUWeUTI6QKIkYjNSAxpkTpsBWN/VaKoScrQOjCN3n+CRDt7ZFSn8ubeXKMq+bnfXWrEuIN+ye1quv1VIXv5ZupHUTP0nLu5xbKqlHzUqcaYhkTO6e/qAHHM1QbfHaFugdrhVv3K3053yPYIGfi1PwcUZarYzbFvpubMF9QOUIq0FLS3zM2PfVXfedcMqoC5maC5Rk4Xw03AfJMPX70B3g0t5GVVbSJYc+P6h4gSqWTYeJtDP7L75VpeLkDAdIR1HHP0DWwU0Lp9amSRd5oeQDsGOS3fitWK00EgO/b7Fq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZRzPf/PuWOgwZQVp/7klGRDBfZEGe7dHEzTXjcBj9U=;
 b=ZkWFOSokucd3kmWqI9muuPQiaqASsyPI8LaaUkSNzXc3Ghh5p5oRRvmCyNi7NeXcjJBnhICrwyr6Epo0PNkvStBJ7yAl5LnwsajfbGZXDlPGc7j7nv9EpSVNfgMDX9dPXpQzTkyRz3WFW5lG9wnkz2u09qCkhQvLK8Ce17ZW/Uk=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB4447.namprd04.prod.outlook.com
 (2603:10b6:805:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 8 Oct
 2020 22:39:43 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 22:39:43 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Auchter <michael.auchter@ni.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: extcon: add binding for TUSB320
Date:   Thu,  8 Oct 2020 17:39:28 -0500
Message-Id: <20201008223929.399791-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201008223929.399791-1-michael.auchter@ni.com>
References: <20201008223929.399791-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: SN4PR0501CA0056.namprd05.prod.outlook.com
 (2603:10b6:803:41::33) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by SN4PR0501CA0056.namprd05.prod.outlook.com (2603:10b6:803:41::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Thu, 8 Oct 2020 22:39:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c6d4210-8c43-43ea-b48a-08d86bdb0d0f
X-MS-TrafficTypeDiagnostic: SN6PR04MB4447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB4447426763EA6E5D2674B96D870B0@SN6PR04MB4447.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ixS8jzjcIdKKbghZk7p1kgQ/pBRsDkxTAj7uWBK4FlTm1FLovULbvfloXFypLQVPuH7IY6XsGXjrfhDhGDTC6VCFslWXJ2M6oBUHLTUxfPI4yv443mJqzrxChkb17kDmlWmtgK9pptc4kg8L2WaUUjDvO/t2aim4tugSrcG8ZpPnhlWgq/nsAmaL4wcYb+4x7yuNN8EbN9Wcj8YSu9aVswoXewtmMzUkB4GsoM0Oz3AdL7t8kwcUUjFxbLDtMtdJmv4oZI4sBN61uWgDku4Ey4ZiW9tFIjgWB6B9d3UeDno7LBuFgl4d3Ppw+1YzVnY/2CiJuIh9ZlCn0A/ztEa7WiNuUSoHWguHakG79qv6JrMQ9Gyq0e0VIx4u6rbgciuktazLQNJ530ONAFUFZibTx57DIYlJYPSH/mx7wWPgodnICEZBgpvtoea62RnOKrSoIFieuEJw1QrRYzhD7BFBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(396003)(366004)(966005)(316002)(4326008)(2616005)(186003)(52116002)(5660300002)(8936002)(16526019)(8676002)(36756003)(66946007)(6512007)(478600001)(110136005)(6506007)(44832011)(66556008)(6666004)(1076003)(66476007)(69590400008)(2906002)(6486002)(7049001)(83080400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: IAAhT/+uo0Z8weVcVh6vSaxM3mr7j7dnXlVUsXxBtuA/4qa4js6cikRpL9LrkbI1rSX4tqf1VrQv93U/miMXHHl4YSMSDwJTeBFdU06qQG5lNm+NTSTJre9PqkDwdibQGcS2TRq6878MDHCF3ql/OGnrAMCDb1ZQVUWho9i/9n5VR9Bdlko45NbocLkO1BdfnPQGZGHuyqTK6hlZB/5K5wzhets/EkIt3CyHH+vmCEA61QotmAZvhbAEKJJxF90KFihSAAUZk6UL3mzr9cHvcTgJJgUsZ850NW4eG7xxrtVamurTzslkOslkbn2hXgVPTB0/ttHZ1beDitRHoli1X4pCOw+YilfllY/TNhZ7rg9s+P9EYxnrkWuaVgcjclLJIUuzHXfy32xo1I6KK6xC6pZxi9DGbtvjPb/fsMTlghFtfXJ+2IBB1NVLMoTVFsA9mqNufIx7SNUmXxF+P95MLtdzUUsiqAvbEfHCLeXOol605weyJYoQZlkXK0AMSqm5Yvtl7HR6vOUHApeTLJLPkuYo9EqgazJaPZy71zVIZZhiHEte7c6FntX3C+9+xV7NTYjYy5ns9Zxo4IrZ+ZAW8t4/Q8UAo/d41yhlRqOOMyGvoy5ydzGbgE0Q4mPydCZMZIgCYCI0B8Rzh8t2jYs4vWtFAfoh3PlTDx6tLmcBbTfjqCWXkA+PuuEScZ6D4m8n5IMc3Ob8dmlJzKRrc2RcZg==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6d4210-8c43-43ea-b48a-08d86bdb0d0f
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 22:39:43.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWSwCSXUzlXsbBqCaHiwo8lTzlAPYl6khuYH1cya94wKc31X9bLjX6k587eWL4JKr29qZihiiZfLIohcAlowGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4447
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_15:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=984 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010080158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree binding for the TI TUSB320.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 .../bindings/extcon/extcon-usbc-tusb320.yaml  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
new file mode 100644
index 000000000000..57f1bcbf1295
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/extcon-usbc-tusb320.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TUSB320 USB Type-C CC Logic controller
+
+maintainers:
+  - Michael Auchter <michael.auchter@ni.com>
+
+properties:
+  compatible:
+    const: ti,tusb320
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        extcon@61 {
+            compatible = "ti,tusb320";
+            reg = <0x61>;
+            interrupt-parent = <&gpio>;
+            interrupts = <27 1>;
+        };
+    };
+...
-- 
2.25.4

