Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215622D0D10
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgLGJdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:33:36 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:6895
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbgLGJdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:33:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB9ebYEm8qK5xaZ8A+c9AWFfTytS4CSbWsYMLXXtU9Wk2uFteksl6tXNl49rcyCfNU/XtuZzZ0rzOoPaBSiRnEZSAtjM6K4Qdgf5QsI84xgV9W/1ZA0iGNtXS4SPG+sVFbXiwpWXbbd66bmWa+QrZftgOf7e8/MmYcj7IQ4KRQCBOh4tJtvjfHAB01Nn9LNrNx4xwIyxJyX7I3/5Uw3uHxmqluI72mat/kv4TzWWo0IOIJi3DWwBgUCuljDroYh+9beU11e+YyYqSKluYeyWHFIsrsa92KTgvT1NBXCHPQ84KT3XxUR5INqMY+CcuLfdS5fbpwFxVUgSuxbCgv+Tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM36ayQcHCaLFFqu0SM9P3j/1YmZvVapXgc/9q2MCUY=;
 b=c0LHR9BgNj69w6MadR5gGCeiSyiBmTx41HzMUtO7at7c3+/h/5rG3G+ZWtA9WQfB/qSzQoQdzyMBXto7bNo2UwMSVlFwCweFiVsP9Tcg75dzuFHKV+ZBU+BVc4xlKyhpNBh1CmAiDe2oe7Aoqj/i0ohWkOVdahhDp4l0xuAac5WJ3FGUyWKGl/3T6pImrhg1x1dnVW9sf/kgy58OFSF9X7Utby9w4bXSha2W2KRwAwbVzhAcCCtp8ewSkQu+MKH1xtUTDoNrpxzq8veWLIYMMOjK63zbwlgFWy+pWvChCsFNO+BIxvR/2TT22GSW2GFXr7uPBKjAsGMj0Cwc1y0yyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM36ayQcHCaLFFqu0SM9P3j/1YmZvVapXgc/9q2MCUY=;
 b=WtkPtfjnNVKCA5Zn/IoWPKaagREE1pbc6kDfvUDhNJlPEVY7JYVfIf6lTOj/6VRobJauJ2kelzd/d2aajNEOHAds8oxI/yWVYLxo+kf+kwJ3WLX0v4ORZwp55fxWlg51gQHJ/6ZM2TOWaXj83L7tQneyYuRUhqdDRN8Z80kykYU=
Received: from CY4PR18CA0048.namprd18.prod.outlook.com (2603:10b6:903:9a::34)
 by MWHPR02MB2702.namprd02.prod.outlook.com (2603:10b6:300:107::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 09:32:42 +0000
Received: from CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:9a:cafe::b7) by CY4PR18CA0048.outlook.office365.com
 (2603:10b6:903:9a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 09:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT012.mail.protection.outlook.com (10.152.75.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.21 via Frontend Transport; Mon, 7 Dec 2020 09:32:41 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 7 Dec 2020 01:32:38 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 7 Dec 2020 01:32:38 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 krzk@kernel.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 laurent.pinchart@ideasonboard.com
Received: from [172.30.17.109] (port=43550)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kmCsn-0005A1-PJ; Mon, 07 Dec 2020 01:32:38 -0800
Subject: Re: [PATCH 04/12] arm64: dts: zynqmp: Enable and wire reset
 controller
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1606917949.git.michal.simek@xilinx.com>
 <c0a99c5b0438e34073429624d99a2c3f16532016.1606917949.git.michal.simek@xilinx.com>
 <X81dXV0uCccZ3360@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <dd199853-71b1-aeef-fe17-57a4110d2da9@xilinx.com>
Date:   Mon, 7 Dec 2020 10:32:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X81dXV0uCccZ3360@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc693d36-b507-4d4b-cb31-08d89a930b43
X-MS-TrafficTypeDiagnostic: MWHPR02MB2702:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR02MB270288E9BD85C541112EFF04C6CE0@MWHPR02MB2702.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cItUJR/3T88lBe7D4dOQSR+UDdhbxnIkMCeKEaBoWrSfHhK2RcqvJ2DyW0IFBYFgB7efi1hLbxwiQ4iPggPAI/iKzy2tQMyTEmEweduqVdNUFR4IlV1GG7s1shwYafNHa6kXNBunkOi67ZGdedJrf3C9WWgPPsqnnrQYjPKNSpJY3wJLXXhjAFNVm07/W6N81GNWUqsFkpaVSMzglWvQSkaL1nUniRegqeVrHXl6EQu7bXejAysI0ywWKspzguWoO6tHH9TPP/T5y5CbCx4IDYIyKVc9TUFrH4CjsNenR3Iiag+/gKlZ4TEKgGK7K+U2Nx60SYqnZl6MeJ5mBqva5DQICJvH5vZS1nFQOdlk/SKjiAEeeCV8CPkm0tUPapeXWSMus7tTtlWJnHAzLCgFKCkVDQQd2JHPzbNO4bIUUSlmx6fiBjS6TII6pfnQGVh/
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39850400004)(46966005)(44832011)(36756003)(31686004)(82310400003)(6666004)(478600001)(36906005)(2616005)(83380400001)(316002)(54906003)(2906002)(4326008)(426003)(70206006)(82740400003)(9786002)(47076004)(110136005)(31696002)(356005)(5660300002)(26005)(8676002)(70586007)(8936002)(7636003)(186003)(336012)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 09:32:41.2157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc693d36-b507-4d4b-cb31-08d89a930b43
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2702
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06. 12. 20 23:38, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Wed, Dec 02, 2020 at 03:06:03PM +0100, Michal Simek wrote:
>> Enable reset controller for several IPs.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 29 ++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 68923fbd0e89..4fa820f78d76 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -187,6 +187,11 @@ zynqmp_pcap: pcap {
>>  			xlnx_aes: zynqmp-aes {
>>  				compatible = "xlnx,zynqmp-aes";
>>  			};
>> +
>> +			zynqmp_reset: reset-controller {
>> +				compatible = "xlnx,zynqmp-reset";
>> +				#reset-cells = <1>;
>> +			};
>>  		};
>>  	};
>>  
>> @@ -466,6 +471,8 @@ gem0: ethernet@ff0b0000 {
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>>  			power-domains = <&zynqmp_firmware PD_ETH_0>;
>> +			resets = <&zynqmp_reset ZYNQMP_RESET_GEM0>;
>> +			reset-names = "gem0_rst";
> 
> I don't see any of the reset-names used in this patch defined in DT
> bindings (or used in drivers). For all devices but the USB controllers
> it seems they can be dropped. For the USB controllers, the bindings need
> to be updated first.

Let me double check it. IIRC if there is just one there is likely no
need to list the name but if there are more then one names should be
also there. But you are right it should be the part of dt binding.

Thanks,
Michal
