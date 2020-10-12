Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A7728BBCD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbgJLP0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:26:01 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:9466 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389555AbgJLP0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:26:00 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09CEgp5r015568;
        Mon, 12 Oct 2020 09:48:13 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-00010702.pphosted.com with ESMTP id 343afs3wpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 09:48:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIL5BUTHTZ9BHRINt6OzjFjrTB39M0DSgamYdaR6ujK7jI3Ck16M0J89WS1UKwbjc3toh/Xj+W03Obg+3iQUjMcJGKWtqXh1aojIG+hgwsK9ac1ARiaHcnnp2ET4UhEum/1hIJ3audq/dC242E6fiNmwIgKWisPAkRbHRQmSB9Rz+nQlDE5sOs4edUr+WLiQ9yt3bj/rdnBmoUkGf82TG9pimb2xERHIbNRwCgU2iV7uvZVwOmb5zBJm5Ge368i/c/y4Jurq5fzvuyATRMViqbAj2xxKhzzet3CRjpanyqDpMsyiS+hhZiiKMr7Fc2AR1XVtjjYq3AuC3fTRl3Urvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx+kfgwe37pWbM728J9G3qMxn7bfsRKHz97oxhjjqxI=;
 b=j3c5Pxw/O7TTheyQDYj7P4nHTtHc7hG4ZtxxrE2FwC8+bJ3rJtVKZLS0ngrDDdc6gPHk63G7Ro6gG4vbaO7X4KuSNzZPGrSFuC0Ux45azHd1+TQV/jfpJktxh/q5A05PVRf+oIDt+cB8j8FFXFty/34ZojtZSkwwEKhAugGZY9IJ/EyYV4ht+xw3kjbwGQrE7TrMJKDUUXbdGx0Tp6akxl0SdJ4QHWd8jNr3eOonLbvwvkAJjLoPymdspt6AMDZjn7avRbo/5cU/SJacfhS6I5wlWiWGWREJzx9aBEqVwTgZTvdr6KlMxlO7pV1214qc8kqkyYJuJbEWxaHOjUNOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx+kfgwe37pWbM728J9G3qMxn7bfsRKHz97oxhjjqxI=;
 b=ABXpgXVa/0zaCM1qfKqdstTIIYb6/1+6eZurj4UH+c8Ag44JggTAiQYH67UJyqSbxt3kGd1ydCAZlfOyIDJ5VGORzg7lWQLilIq/pMiRlYN6fTvRyan/ormpSjjoOZwyG7N/WR5jv3L1OY34g3uvJSJRry7Csp7S+MFf5cgikfs=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN2PR04MB2207.namprd04.prod.outlook.com
 (2603:10b6:804:10::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 14:48:11 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 14:48:11 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Auchter <michael.auchter@ni.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: extcon: add binding for TUSB320
Date:   Mon, 12 Oct 2020 09:47:53 -0500
Message-Id: <20201012144754.738830-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201012144754.738830-1-michael.auchter@ni.com>
References: <20201012144754.738830-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: DM6PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:5:190::16) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by DM6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:5:190::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 14:48:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 199bb783-9222-4f33-6eb8-08d86ebdd73b
X-MS-TrafficTypeDiagnostic: SN2PR04MB2207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR04MB2207961EE7D8DB4CF50EDA7787070@SN2PR04MB2207.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvbp75qZcGUECbeEbIcFb+WXOb07cqsJU5/OdAWDaVXxi6hzVp4BlgiYgZALMdIVo4vI8l4xB9mqPe4NOm50JnuafEUGD9EmfOny2Y56WOH/jaBngfU5s977heut+f7bk0MVQnqtEQPZug29lys4/ahKS7qzWhbNC/jZwQFi59xKdYyVUSm9IC/lw9WjXcpZ/DHpgzeumbX2mq6ODhRtwGrm/5W7E2JWt6QUgR5NwAzj91ukOSmMLUcN2Eq9E25jo781sL2P8J2VEhp0sdvZ8KnFUNiBTUlcMeDJqCzeESdJHYJX3GktzDgWt961JKlEfCgM5f+2UYe4YIrukizMOvrV60UVE/eSImJG1GNkM6QZW1WlEKEIYtMBsRyY5etQqQIsGm5B0zJASCWZJImwSz8FDk0O7AXfzrUo0BGMUFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(5660300002)(66946007)(4326008)(86362001)(66556008)(66476007)(478600001)(69590400008)(2906002)(966005)(1076003)(2616005)(316002)(186003)(16526019)(8936002)(7049001)(8676002)(6666004)(44832011)(6486002)(6506007)(110136005)(36756003)(52116002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rPgneP6MxjolmmvTAVA6zpWx6XG3WliCEVy667YnfcSk4c4uS6Hn+JTSYyDi6/stmbwEU03xwloW4SDWZOOn1GYewUraw6rbqKt+YnXC0LxNRO4W0jF/c+hvRZMumoE6j3v+nwFJ6/s15NsComU66vXlxKwgvu8WXldRjCYt8pNMkEDs23AuLLvqeyJF7DFBYILg98/s2XdlbzYVAxiN7XXusqfpHFJ4l90DJpAk69YX2C7WDQ2kCwjP+8Ca3JnRjyCjODn8u16Drjj6cqjaEs3TGx+ZIhsR5WL13+1kcQRvtuKDFHGYu6RP8WjdryBYniYDG9xXocGXEBV89hJUOgoJlT1AgOajl7qQvaDbpJmxegb6hC9G3ixzsbAJ43oV/1XGxVexKT40V1gqxJozgGih/zjLEOgc0Rq3HCAS2J3xCmpM0NGP3xQvKUwT+QIldz6AgVJSXRyCaMtQyMnFaJG6JCIE2De3dZ2VCCmMZAAU83VToM3kD/EQNlnxjf9QhgTasYkESbeW6VkV71twb8TLi9Qq/AUw27HxCoJs5f3zWRJpUQggge/eePQTloxHG8UKcB+nC3cZ2Hpy5lK8v4cu25nNYFNFcKj4aKLrIGUBTLAzOT0hICuuQuXqWMmZ0IJVe/qM7as873MmGDOrVJ2MBa315FLNH/WgYI7OPRz1Vz4y9YwJixYBiAdxnX4lm1lD0e7hrt5GXA7fyjl+Gw==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199bb783-9222-4f33-6eb8-08d86ebdd73b
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 14:48:11.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IDAfPV6Q2bHqvjC2hXz3mfUozScyrz9yNuyA7QnGEKRxEA28gcjigaSsanGf+lC10+SpITemm9hi7WkU5DoSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_12:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010120119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree binding for the TI TUSB320.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
Changes since v1:
- use tusb320 instead of extcon in the unit name

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

