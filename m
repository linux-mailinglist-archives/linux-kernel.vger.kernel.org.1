Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC12AB32C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgKIJIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:08:06 -0500
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com ([40.107.92.84]:17153
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729745AbgKIJIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:08:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCqAjIXFn6x3dfZkPxItuwOyZCj6LVxjZMlYHsp5xj7GCl7mJfavErw0xAbaNZEIPzis6PtGWxzs9bg06kJCUzZSiv8oqNC896KmIRNy329HuSAjJ+n30I3JkeLn8wSxJ4l29Rgw2bHo1AiME/YPeicNAOJiBfCSBCCJTP7kJh7mBQcndTLd1suM8iX7ktQ6Ir3bV2S6+yvjIOMSRcjl0QypfheEKChpLOZeuOPIWh5ou8ohHqmnPWOGC4BydRGlWtahxhvKAiVJu2zCYmBuEZqyDXrsUFOftMC4ryYefPHxlwidn2j7AQetyvHTNlc+SmtN4yUkEbU/bDTL1k5ygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eU4FHEY1wThLphgN5Th2vKhLTEoFSgPh64aCNCDOxc=;
 b=ltUfw1eWIoPyS7WHqH0ddfKTCv88ePIIKVBKdincV/EhGYQX4kM2+TfgKb47HlCB/j7bgm77J7SLBAYsi0U4jVquVW0lNrdqW+8Pn1FslD+8NCLreeEVQz24R0PNoiLSINZdZsuXYjV2ELt0jX1pzuS2d2pKJOYGb+BhNGFghdjeTbddqFUrZ5VbJRhsdMF3G0EkyG5A6OigVbaLPTkpiNQeL+UFr26sEhAWS5z0gCYvU8Q9vL411gyRoqUL+unYRVZgwHgag6VDt4xjjAR7VnmsiS2N47bNnL4/0KP7aZUup0xqRbMazO4qd6GGH1uHYsgGFRF0+MdmTley+HozUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eU4FHEY1wThLphgN5Th2vKhLTEoFSgPh64aCNCDOxc=;
 b=An8cEcWVZBXNqJEJLrDITerYjGYGdPx5wpg4Upt7YDsNVXG80uZQLUNaqhV1eyl+g+k+G69GkjpoEqN+0fAvhXt05K+3noKqm3aIOlr+fFkGtcsvhk6uSv/4SgKy3F4+29+kShhilnjtdl8YdcI7Yku7KWlikvpgpr9bV7/Rkqg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA0PR03MB5497.namprd03.prod.outlook.com (2603:10b6:806:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 09:08:02 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:08:01 +0000
Date:   Mon, 9 Nov 2020 17:05:56 +0800
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
Subject: [PATCH 5/8] arm64: dts: agilex: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201109170556.2e3a173f@xhacker.debian>
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
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 9 Nov 2020 09:07:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 146efc21-6592-449d-9a23-08d8848ef5d7
X-MS-TrafficTypeDiagnostic: SA0PR03MB5497:
X-Microsoft-Antispam-PRVS: <SA0PR03MB5497175C17C60AF57FBDFF0FEDEA0@SA0PR03MB5497.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ke9K/6wNRj56tGBbt9v81Cw7FxjtbuOrvWR8y8ncO46apJiMxEFJRmTf1wXYM44lz9k3bLfcoYur9ACcErYFqzKvEPSmp2glXIHGaj2s0sJMUhCHrn35o481equuab3zLofPlZUXEWsaLjDpHM3kyZWROnxMySJcY1oDWFe7evIWWmm65nYw70p7VIEW2AQh9xwH/VODzVPU3DO0pXqrF6gsqxw6JOgR5Lza9DzsMtgGjPMsQ1xiC9nG8qBefdRkc1hRBsAVpHHiF4FeLiNWZDuaa2rIPgEl5g1ocELUl+PMGNhiG1zvT9VlfrsAuUGRFDUoN7Sh7I0wwNJCLpI0bWpPbmcaRKodk/GT3WgnzppE+P4n90CZuWy7cpJzbo6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(9686003)(54906003)(66946007)(52116002)(8676002)(8936002)(66556008)(55016002)(110136005)(66476007)(26005)(7416002)(4326008)(2906002)(7696005)(186003)(478600001)(316002)(1076003)(86362001)(5660300002)(6506007)(83380400001)(956004)(16526019)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NvZCtSsaksV+KM92zNmzyfmKE5EzR25uqrQBpTsxvekP5mbGfCYGPpnFbYghg7xnwK/X/yhcuvW7HWH3SjayoeTdza8pTCd3G4dn4Qf1hEhzbyeBpeCRtF5q+JdH8Pv6jIbe9Sa57mSDWmcQil9D0KPAUmBYCjNqBbM8Zn66qlz/qhMTgsaDqEZ9HgwSXD96wALQkRK7QKwBOqCKJqQySXd4K7MKoPv/E+bA54e/PC/oxD/zi9TxHn+Z/G/sDr3ctZtWZRcRhoUC7NqHWEqnvbIvE64RhaMDGrt91wsHFknoexCVpj4ZaB9d0Ej9B39wmFpYWa+dj3eKnzqXLxwCiQVh7rKvLi2yDQvXFsRQFSgk2kAiDnQ/Q69mZjx1Xwzilfmk1e0M9bfEAwKDtyBvwgGbNr6orADRGmx1bxMp5f31PwstTfHV0HXNsAs6xKAF8fVwTedYzyAfLT+yOSN7mRDlWlYeyYrE5jIwQikBs+JzZufw7Y1faUEAZiuHsjJn38R/ExF8VeaqrfcT7f3EGp72mtuyhd9Qw8g+jkQrzFIt2iDYxqwSgAsSJ0Y2ykLYqKFrbWh1dfW0euXKkWb73iHLanm0lcjMIA1sjVQlXsQHhpKDic9O1MoxgcljiXGa9xxx/rY8/aFZ/rMEBpSXmQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146efc21-6592-449d-9a23-08d8848ef5d7
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:08:01.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgHMA8TISJ1HWyVN/d55wu0YPMyaGL51JwZodwBXuOZMpMuqzco6scQ6SuEwdgd1BQjtrkY/JoXABvAAU1Ksbg==
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
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index e1c0fcba5c20..2f731e3a7cd7 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -202,7 +202,7 @@ porta: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <24>;
+				ngpios = <24>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -222,7 +222,7 @@ portb: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <24>;
+				ngpios = <24>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-- 
2.29.2

