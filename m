Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4112728F45C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgJOOH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:07:59 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:64594 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729647AbgJOOH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:07:58 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09FE4Zaq025915;
        Thu, 15 Oct 2020 09:07:54 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00010702.pphosted.com with ESMTP id 343afse63y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 09:07:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0EIl84a8f//hWahXZ4DMQ+Djeekx41wDy+sRoBEiuAC4VLKVyOitBaQtaKO5Rrfdmt8grUG8GYeZxLaq0xv5/HyQBiJKoScLGa9GGq9XXzHsD4l08TO8pZSVXWi+e9av15hgJIYPoISfYwNCCkR8U4jDJDPKkN04WrgFsH+Mhuo5XGEaBWxVI67xKfSS13BFTMao8MNM+Tkkud+lwmeaZergiLPOuCvFy0UXtLoC3GS30BiVC/f80INKQE/PcT6BlhFhbwxkRFtMeaM/2GhkNRjUXiQmo9tScqxnFj9hEzYAOTkjcmAjcxit4cj7Lb20QLM9NE5aFKzYDD3onBlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn3Y74wdwkkGzKNymGQpG/7NlYm3tsINrJm4MnHSiDw=;
 b=i6VHqJOSQMXj5xfO7zkRjIJNeOt/EEQaH7xrGOxF2JKQT3uwOUd2r5pZnuIAXzpUxqeO8iLgx5rjMPqZUzYVKZ2sHAgDFoN4jTLeW6kZSqJqqSMnbw+iGb6URID36BgZapvgYv5MUdWDS2TUnJ2pCEQyx0yEg7K4cwjGwbd2oSCkhmc20cBYY89j0i7dqkHs/YB+rNxueBalklPy8rl+qjoF1U0guktwqqtj96kHwPkF6REhtzRdTBC6UXbHF0CVlWw91OV6LesQAU61URYZEw9GuNndPCyUZoYbffA6JmyIQAgoI061Dvpwh1r3oBrLuPgvNrQZ+Q18/crnKuK9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn3Y74wdwkkGzKNymGQpG/7NlYm3tsINrJm4MnHSiDw=;
 b=hAWyKg77er70UoPACu/hF+sS5kfRXO+eH9sd5JreIMBaA1ihABhlaCvUYxUqWqA6C4KX4B7RnRyMk3050vOKe95MXhcL4uFJQKPkWrl+rWXQ5hoY9JNZiB711AW4NIGOx3ggGUxNTA/7ueTEAZlDUcxFC6HpAPI5srPfiDBgATE=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB5421.namprd04.prod.outlook.com
 (2603:10b6:805:f6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Thu, 15 Oct
 2020 14:07:52 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.034; Thu, 15 Oct 2020
 14:07:52 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Auchter <michael.auchter@ni.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: extcon: add binding for TUSB320
Date:   Thu, 15 Oct 2020 09:07:35 -0500
Message-Id: <20201015140737.1183818-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201015140737.1183818-1-michael.auchter@ni.com>
References: <20201015140737.1183818-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: DM5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:4:2::17)
 To SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by DM5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:4:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 14:07:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f95c792b-4b09-4a8b-3e6d-08d87113b4e0
X-MS-TrafficTypeDiagnostic: SN6PR04MB5421:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB5421A899BFCF07DC4B639F0187020@SN6PR04MB5421.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7CE2gF53ALpiVLpwQK6L0eFxEtOSe5LPpZd4ojHBGefWin/5gm5xDjwh4+oW5Emp4KrSmHlQiILN4n+Rr9h1EzpkeAMHyESPcqytWAJqFC6oqR0v/DGImyon10TGkXHvvbMpOjjfU1EpiQxzcmtxiHZ7P6KM10mnDhuL7bzWA9dXi/+o0lr1HxhlP+M9P2dEDDhpV/my9NKYLhDWenRQRJYczyM3ApSwoHtheTVrF6nyU6RabwG6GCZkDTtG0CeAqobIFXkE6IFp90PkSY2TcriiQO9aGh3hL3zePYN4Ajk0TyxHc7vr+jPzpkL+2ktxj76O+M0otwgMb61RuKdiOxNKHRlSy9LPzih+nHUz8CGQQs/Vd6VFN6q7qAnXV5YEE5ck+7R7ILFChaA5UGrq+eo4Tm4eqoQSYgh06u17N6CI1+MzloIHKzv+F8th+dqfq+rU1VUgPt3LMAMUWKAnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(39860400002)(366004)(136003)(69590400008)(83080400001)(4326008)(7049001)(6666004)(478600001)(8936002)(2906002)(8676002)(186003)(16526019)(66946007)(110136005)(316002)(66556008)(966005)(86362001)(66476007)(2616005)(5660300002)(6486002)(1076003)(6512007)(6506007)(52116002)(36756003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: f8QnP/et7mLjS0/UpZtMtm1P9TgAE/aWO0JKt31nCuytmH2Kg/TkmgtnPdw/Rh+uxejk4xxsGxyKNz/DeVwdW58fWXVMQGQ286r/tORTVPvCRfXRNALxZcxdvB5I7lb78fQ+eL5OJssZS/3Tkzfbw8uANrUA/yiWenRrUjWk0pIp4bFpA4ldPwh5KMMY8fJNqxauoidlzObgHka/LzfiyPuvDbdOzsmJ4RbVDvLT+pHItDpAydlIEokk0Es+nPh6XBInhgbKPiRsXRrZMzbBtSjxk440hsHZH0vx6GGdKJJN9JS8EtEaPJX5SpCDfdZUMWzoFWuGu5v1TF6Hx7vQWy2ApNvN2Pcwzo/aEdePSQrfY9xylyLVYpggTafC4TslhlIQtSwwvm5ENxwKZyzYH036zzdNOfKK5H4596gJF4AkdeRPlPjGHrBL/2QLULWP5I+Rnjn3EZ05pf60FdG71gZWq6/+hRi90HKIuwTFEexykhKCvLB5ulYqWvps6+gY9glrH1VNheMIh25CdZS1DslpeLhjEJcMzFFLx9c2v3q60be+BpWjxeTltzxtuOUYlvdLQWfiou4PXtWJjF/RjLgHlqQFmwiTrlTj9pxQl7UZdvvugfj5fuSqFpo07xXLKqnNoBqYdiWH+PmTC1OkWg+eJ7W6YTxoxPgp3EaFWa8KZ+4H6RCaNKouMpd2pu+iOe79YVa+OBGkAwrRkfeXDQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95c792b-4b09-4a8b-3e6d-08d87113b4e0
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 14:07:52.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1+w2yxVGvlOEasJZHIKH8yTNOSHzZRCIcpn8Wy29xx0VhkCEJ9N4VwFx93+1ebUfbW0TMOyCaN5TnvA6SCg+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5421
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_08:2020-10-14,2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010150099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree binding for the TI TUSB320.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
- use tusb320 instead of extcon in the unit name
since v2:
- None

 .../bindings/extcon/extcon-usbc-tusb320.yaml  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
new file mode 100644
index 000000000000..9875b4d5c356
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
+        tusb320@61 {
+            compatible = "ti,tusb320";
+            reg = <0x61>;
+            interrupt-parent = <&gpio>;
+            interrupts = <27 1>;
+        };
+    };
+...
-- 
2.25.4

