Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1F2AB32E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgKIJIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:08:10 -0500
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:24742
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729745AbgKIJIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:08:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hucp0NsV43xjI6q8vi3ZqWe7EdJQ3yayJGL2h6oRSbjUolTSFZoNr/YDIrSw5yUsmxJMQ2YYq7tx8W8IsrdonmN7tz0hIEDJ5AECcP0E/hzHw+x6rpQFpy6DkeZT6IX8jpQH5pVpTCZUil6DKqB6hrLhePZYLvq5uM9e4JD49h7euX623HdLYICgRVRmXLMTjOdShK5LViKvOpaLrNY78b9FUGjP5CQWtHcrNeFvs6Y2T6jCBQ9vvoW+ZhIqLQXxyYWox45tCjbMwgUI3D4jM5dcKhHsOm5AwJrZAHlCYaQsPH8LlhEJbQDQgGWqTsx4rfYkF2Ch+cLaH+eEw6Ul/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQe+8uJOlN1WhLmtosXJ80BPM7Ycxc1hPotJfCUZC2w=;
 b=DBYdhkXFMS9Vp0trRSGCgoPgYqQSNVstqA/+80ug4sEHGm4VgYPAJLmlA2DdQgc958SoMlKcZY5G/d/uqDMM4TnWa1n3ppV8wRHAhbnZNfaaJJIwzvsj2u9hIRTzSKktxJnJQCXVuCz0LforbRs6mXKOItVu7BhXeLRtfYylE32+L3xkWBXimCDWcVG5cVKuI/F6BOcZESzVSt06k4T45G4QwzED8eyzqCUi/NkLmnCk5G7Zu7y6e9n/Y5soGL2xiPwY/meq9XKbyol5Hs/6r3lOym148L4bLN80Q88CqOob4h+Kzxp7Dg1wxuzQEvHOfsfgIRFdJHZkG8w6pOXOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQe+8uJOlN1WhLmtosXJ80BPM7Ycxc1hPotJfCUZC2w=;
 b=iRZZMHZVDekE8cBlRrSZp70hgBB179cU6GF2wHa+IalmraPEUN3t3BPf23ZaEc3d2mFqSAzcKkxcMfSY1GaHvykbSNxUBclon3+HZ9f/lfk8vKp3/TVKZ62npZnQkhPWJRdkLcom5xWyj2Dd/tJ3+XIqycsLbK+2eeSDjMPcaxU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA0PR03MB5497.namprd03.prod.outlook.com (2603:10b6:806:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 09:08:08 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:08:08 +0000
Date:   Mon, 9 Nov 2020 17:07:12 +0800
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
Subject: [PATCH 8/8] ARM: dts: socfgpa: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201109170712.6e8c1a90@xhacker.debian>
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
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 9 Nov 2020 09:08:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29b89890-18b1-40d6-c073-08d8848ef98a
X-MS-TrafficTypeDiagnostic: SA0PR03MB5497:
X-Microsoft-Antispam-PRVS: <SA0PR03MB5497F617366C8B4BF26F1D14EDEA0@SA0PR03MB5497.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UMRKMdiYWpf/ZgVGqUJn3Et0C77uJwgmkiM8/GdCUMB+0g1ytMmcS2X4FMq818Xp1AzrOXDzu/WQ2A/bh0dXrM3Lqgjz80elj8GXvRHyhn1iXseogAukb0gAivqvKrHoSbVqQDh8Wo9/PAKZpctSGWIQTCbkKYZwGt6696fBdM39dXS+iuuBTOrTTkcvC2bWeh4Dm2/lUDXcyUq3cVqSesy5+Immq4kQ8Hkxe8pOW5ztjQBDISAuhnmJPBv6FL0zNLSZLlhkXUnyEpMz26gsyDYd7dlZ3xMCdJjH447w8F4me1OyRymattuC6gsUkynLz8qiN/BPbxXtDcZpAmFWkn+1ye6VZEex52lTI9Z6BN/mhihrCXXONpZ1UGUCs2c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(9686003)(54906003)(66946007)(52116002)(8676002)(8936002)(66556008)(55016002)(110136005)(66476007)(26005)(7416002)(4326008)(2906002)(7696005)(186003)(478600001)(316002)(1076003)(86362001)(5660300002)(6506007)(83380400001)(956004)(16526019)(6666004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rOKA+kmD7IB6+UfhNB5lFdt3sI2s0ufCvhe8fPPyWg4DYSr1V8FvBn5A4nbmF8SwDwgbNw/lmYqR3Jcdlrsq3Vl7rBsbfgrem1WcA/mab3to+NR2Ip+t8QmhObV2KwarcSR+6Ko9FUbCYiloPhU0zv5X5kGNBI1cFb1v68M095p1OKU2lmTen6pFrfI8+ieLihI5tBjMe0EVGhDdaOj5nBvliVdmqHsiWtqO8VOhic3NlvhBasi5mWCMO65kzR1j97S8fB+qA5/omV5Oy4zlzgECkq6u4E3l+L1HHAaI4ovp/MthWkn4porJcVytjkxNC1YeYFh3oVgrByN5yMUkWr3NALKm1wsDWE6ZGTRYQIuu9Vtow1gQT5JLBNHYCmr9jHNvITq+YapaVn9U22/VSvVf0saZIOh4fOu3rFtMzO8a2NT8pNXExcwVHZEbNSenzziLAiY5+EkHDUwJMJUf70ARz9Gmde4A3Hc/C1TWfdon90Mf0R4HkpDHnnAc7G1j3Ce7cORc2pWvJJH73rooXrwmV8yxNkaqLlBpAchwvAvSHCegksOFIzUeHVMPlT9kRv+Xg64xmLNiF7sZIf9CTGUL6/ohdJdcxGpueIws6tijxXlLyFq8+htmoGZ3J/phntSkbct5kR6TIPxg2Pudkw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b89890-18b1-40d6-c073-08d8848ef98a
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:08:08.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0e00UWP/GsutOdO0/XqBDhYazQZvFYxlWEO0Gu8jn7A9CEJlMBgQ8Hm0tRstlYZzKp6n09x0u3rVy0WUKh0QYQ==
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
 arch/arm/boot/dts/socfpga.dtsi         | 6 +++---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 0b021eef0b53..32b7ad814ec6 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -612,7 +612,7 @@ porta: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <29>;
+				ngpios = <29>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -633,7 +633,7 @@ portb: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <29>;
+				ngpios = <29>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -654,7 +654,7 @@ portc: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <27>;
+				ngpios = <27>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 0013ec3463c4..34e23e0582fb 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -491,7 +491,7 @@ porta: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <29>;
+				ngpios = <29>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -511,7 +511,7 @@ portb: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <29>;
+				ngpios = <29>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -531,7 +531,7 @@ portc: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <27>;
+				ngpios = <27>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-- 
2.29.2

