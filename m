Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2192AB329
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgKIJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:07:55 -0500
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:41121
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729847AbgKIJHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:07:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHtSIFkdMZbO5wu1088DRX0GqKwbBjRy279+HscMLKyoAvuooQ5FJZxZiyqunLrrhgJip9s8atFeXqpwcO00iNT/86lNZBQMBH/DS3G6gIR7XQxgcuQUgsWsudLmr03OaDIVinBkoJO3H/ReC8V7avA9Zekh5g6jnXRMuJ8uWm5ZRGFyt03T5tFwMEXsBn+ObV6ZTaz3YTBprD+YFISVoWF52MFgtREFG7WyC9ahvDGOnuEOgKZ5drmPnDsI+IqBLEH3oQl2Pbe1geQZ88Xba6BnOs+emerr3EI/rHyzJ4H/TNNlnJz/DmSZtkw6WKYI2coXcI6gIDEqgXIIV4TXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjxXV37ajQT9zC+599QihV3ZTdBsPHjXVm2NQlxkMAw=;
 b=O0pZzExEo+UbWjYx7/mcE3EmOIU4IB8Xmb6i1GCasX9yEvi++yDZwSAwWg/8UIqxeuGv76j4uhyqK6cH8qDmsHQ4ls5+6WxJt0SgiWv+SYrdU2+f/gMjM0Xj7IFrtnsWBLu2DBla3PNGHoSX2on22J51HSTYi6l7mNV6WSSWobQ92xbdv5Thp1vqdG3qBfaAmOnZMEjfEzO9la8v8ViXINsWH9skQS1nJZpSC6Usp2x+Pqg6pkPkTZpCrYF5L8lxQvuFbKU0KT103jr+G0bkb5ekG0zthqIhEFIhu6OYjtQXWPKgUHoD9aE91oHtw0sCychqTBYjm+OfcJQfScnXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjxXV37ajQT9zC+599QihV3ZTdBsPHjXVm2NQlxkMAw=;
 b=fHygaaqTC3b/J/Zw5XLetMg1Px+wO3M2fnB+zPmjyaq94xIKkGpG1S0RAu8YgfvprxUnzEoxhkXk2+BT5yEJoMOD1Aw2UPLIzv8R7/yeoy0DovOkPN5y/uprB6MRIp/xaOiVXvj9pSFirCtt1thi8T4XqNl4LNwcCSUwaK7ITnE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA0PR03MB5497.namprd03.prod.outlook.com (2603:10b6:806:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 09:07:52 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:07:52 +0000
Date:   Mon, 9 Nov 2020 17:04:04 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/8] arm64: dts: apm: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201109170404.1c612f6f@xhacker.debian>
In-Reply-To: <20201109170258.4a70c768@xhacker.debian>
References: <20201109170258.4a70c768@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 9 Nov 2020 09:07:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d56740eb-cec2-4636-e65e-08d8848ef024
X-MS-TrafficTypeDiagnostic: SA0PR03MB5497:
X-Microsoft-Antispam-PRVS: <SA0PR03MB5497728C504D0FA318E020DEEDEA0@SA0PR03MB5497.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ylhW8J6kT4aqrui1tj/qWIJWoX+vGN+6pRb9VgFo5O73gvL8gJiQOfat0e9uNKLCvygq4wBnyo6JMzNwmQdcF5kOcK9kWi9I5+l9LYVYmLVA9ulyCJUEda3hW1lfZPdKC0tididQlY3gj5A69q/SCj7KEvg0XNhX//Ww5ODAX/8G4Bhvnvs4ujfNWdw5xqfMhr7unWa2dBWyqddQ3ztEknD+lQFWsSpdk6cTRyj5VHool7i0R9d95CA6X8R0ohjeEuH37GCiZeqM4nW/sx4+GmhhDqVnMQs7YmnjnwwGCgXUPpH6ppkbfQ+HJ4buzKOAhHSLxYLmV+0WPXvTm1+y50Ytb2FN+/nKavTVX1tPJk6VIII2btLQ/QUAPawmwTq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(9686003)(54906003)(66946007)(52116002)(8676002)(8936002)(66556008)(55016002)(110136005)(66476007)(26005)(7416002)(4326008)(2906002)(7696005)(186003)(478600001)(316002)(1076003)(86362001)(5660300002)(6506007)(83380400001)(956004)(16526019)(6666004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0HPz56Vtay5VSLAUHq3kzGJTbI1UK/KFTfP4Z00Vw/joQAFW01a/7gGXpLU+C0l2ngyzX/qR+dyk2Dktv5WYP/q9Vtody0jGCpz+nHBLyXWa+muLaaSlGvV1VH8Bc+XtwgnChfWDwCIQBy0SF0LVxA+iyAuykimxUw27mr9SJZWRnptW3TJrWSl1vb7DfDuPeb6qXds0ogfMdaHmazGo+CfegEtis5ZZtMHVhT/ZBX0+PMUeF3I/MUHNKBrfB0pM4Rn1uUtLgkx+j2OCg74J7IY+xvByiYVUQGkVsrgVwELLp98DvW3Pnh1yLdgXdKtGWteClHkrP5tB8Y0ps+KpAAPIhbp3aAjjzPnehlFjfUWYg6Wg4QphNTRixBs3CTIfaocVvWKNKFfzMYmwTJQiePctj19AIbhQUNdZ9HKL/7A8W0wGnD+QxnlSmLssSXicmEtJjTjAJZPvIJ7cjGFRSdx5Yr2sb8T7Td7oJ8Yp9Aqngv9dBqQPJvUwJgLlIvK3d32tHisUQoJ3sKvj3ac34zloGkZI9TnL82U8gliKH7CPFc4wA3e3krSuqWyfn62DNsBXClVVfzXE9ilcfBQZjcuqQquFItm9yeGVziTLZd6SbEW6Wfv0hNoOfwPWWmbnYgRw61HztNk19VnH0Bu8Cw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56740eb-cec2-4636-e65e-08d8848ef024
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:07:52.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwqwrRPyHY71v5wQG4xeqa5obB/pZaee2PnDehQJqs4zTwp0VG4Cw7+1wdYXk2znVCfjBAbXVMU+rq4WRyMxUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5497
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to remove similar errors as below:

OF: /.../gpio-port@0: could not find phandle

Commit 7569486d79ae ("gpio: dwapb: Add ngpios DT-property support")
explained the reason of above errors well and added the generic
"ngpios" property, let's use it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 2 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index a83c82c50e29..08b19fc5ee9f 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -716,7 +716,7 @@ porta: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <32>;
+				ngpios = <32>;
 				reg = <0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 0f37e77f5459..4689fca9112e 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -832,7 +832,7 @@ porta: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <32>;
+				ngpios = <32>;
 				reg = <0>;
 			};
 		};
-- 
2.29.2

