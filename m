Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E52FE73B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbhAUKM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:12:26 -0500
Received: from mail-eopbgr760040.outbound.protection.outlook.com ([40.107.76.40]:62939
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728469AbhAUKLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxbqf/usKPyuAbIinmdsQzwFJEaLH4Lv8eX3+9q3RBknphdXptx4s9HTE0p0FQYOS0F9BgTic8sduCXkW9zpyE2NlGDbBPJzDTbFbI+QM+k1pbsTb/1J+QbUw9m7dgKFuqYuesRTsNquyutwDtubLL0JPYy1R/MoDMFXVRw/ND2nmK8MLSFy58gDdpYEjFm4BAWmt1nNOFRPZ5TdOndcu9DudhSmgX2uY8AEgsPPVfUblP7gPzxkQjNQwZAsJqWKduZsMTkhqz06aq7U+jsKqZ/+mMGcH+IqlxRcdA3bBMKeaOH8qaBtdBSiA7I7aJhoE3pGd7QSxYmZTmRNIBFUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS7yU5sUlSO2Q3Ui6v3Nky50meJEIllnE4EAjjSxEOY=;
 b=RFddAq2ksqYeKvpy3YCURbYJyRrstJNNcobJzhkGkjWdI+NpA/UqsyoTBcKfxusfimbrZVzt6Fgz+abcWTrcwO1uOu4Sph75WiA8n5RgZY+xJvUab/NX08wG0mjAPA4LRp99b/ZYcSVedIeSaBl2AZzLCnmKZzuHcCaCd+VgBEKaBEN/q8+nOXEBnIGuOZbib4o4MpVFrui/4lMtR8/lMV3N4HJ8F5fBT2fHsfkWqXpYbDI0/gVZepkWgfA+347kjr2CyajfsX2QZOZVwDYMwdPv28sQg92i+QbC+WiX7IJV+rtYYR3hJ+tpfOacnqwJLzxcge8osLibzTFp7D3ahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS7yU5sUlSO2Q3Ui6v3Nky50meJEIllnE4EAjjSxEOY=;
 b=s8sTaAXfOdFbv4M7VVKD1FcSfte/oPipJ3bpX+d08Pd0oeAWNn8Da6N9vZ85mHjhImAtXZtm2eMuXx2dO63Frj/7pMHnEUUTNXcD5dxSzfgihfmZgvVsmys2u32JCAwwcu7j80B9LND4wywN2yGIINz79tYB/byygE1TToCwGZo=
Received: from CY4PR18CA0056.namprd18.prod.outlook.com (2603:10b6:903:13f::18)
 by MN2PR02MB5904.namprd02.prod.outlook.com (2603:10b6:208:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Thu, 21 Jan
 2021 10:10:21 +0000
Received: from CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13f:cafe::4b) by CY4PR18CA0056.outlook.office365.com
 (2603:10b6:903:13f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Thu, 21 Jan 2021 10:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT037.mail.protection.outlook.com (10.152.75.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 10:10:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 21 Jan 2021 02:10:10 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 21 Jan 2021 02:10:10 -0800
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
Received: from [172.30.17.109] (port=45914)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l2Wun-0002sH-2D; Thu, 21 Jan 2021 02:10:09 -0800
Subject: Re: [PATCH 04/12] arm64: dts: zynqmp: Enable and wire reset
 controller
To:     Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
 <dd199853-71b1-aeef-fe17-57a4110d2da9@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6543a8d1-bf0b-ed44-8ccd-115f14e48dcc@xilinx.com>
Date:   Thu, 21 Jan 2021 11:10:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <dd199853-71b1-aeef-fe17-57a4110d2da9@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e992a93-c2d5-4c9f-de13-08d8bdf4c330
X-MS-TrafficTypeDiagnostic: MN2PR02MB5904:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR02MB5904F7324D50AA591CC4C760C6A10@MN2PR02MB5904.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMiDrn4DFpiaoZVpLFD1oiNlfAQpUoEy8r0mG+XlMw1CFBh8DLBSY5ZgX/pB7XjX/svMPqspPorRZkMcvD0C5AQyPddF4fiA39YB+EmmHTd37qp1wUB2zSxSY6dzI6lLd7Ofz817gUEtd3Y9EoPEfA5MU278yqsincBoC5PydCBiZeYghtM4THPSg0TuDooE1wRIj7bZXGcXrox3cdnAPYtunXjxc5E99fu6L3u6yTNwVydsfxVkwpIGjQMkA0qow4c8yJIQrBQXwgHWA0U/pMV0WaWhiEGShYf3znt1Jzqd2jA5viZHJA8S3zJPvkiTsvJILB+P1tOF6mp1xzvdifqZxVb4VE7IDSEji/p7w/DGyH6GU2mfcW1CzxU7GB280R/TkA++jz6D4CMEActbN8wFkCud1kWfCy1mHNQCc0rhR0RrlR8jcI6viv2384ZSyJI0CQZbx6ZItLF+vVnHC/UAp2inzBpmEO7+6QCYQoiW/Zxiu23u+jmiazbM1og4uf0Pj6r+A1RNQHS+8AvmEQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(82740400003)(36756003)(8936002)(53546011)(8676002)(6666004)(44832011)(31686004)(47076005)(356005)(2906002)(83380400001)(9786002)(316002)(186003)(26005)(70206006)(2616005)(478600001)(36906005)(82310400003)(31696002)(336012)(5660300002)(54906003)(4326008)(110136005)(7636003)(70586007)(426003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 10:10:21.6735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e992a93-c2d5-4c9f-de13-08d8bdf4c330
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/20 10:32 AM, Michal Simek wrote:
> 
> 
> On 06. 12. 20 23:38, Laurent Pinchart wrote:
>> Hi Michal,
>>
>> Thank you for the patch.
>>
>> On Wed, Dec 02, 2020 at 03:06:03PM +0100, Michal Simek wrote:
>>> Enable reset controller for several IPs.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>
>>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 29 ++++++++++++++++++++++++++
>>>  1 file changed, 29 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> index 68923fbd0e89..4fa820f78d76 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> @@ -187,6 +187,11 @@ zynqmp_pcap: pcap {
>>>  			xlnx_aes: zynqmp-aes {
>>>  				compatible = "xlnx,zynqmp-aes";
>>>  			};
>>> +
>>> +			zynqmp_reset: reset-controller {
>>> +				compatible = "xlnx,zynqmp-reset";
>>> +				#reset-cells = <1>;
>>> +			};
>>>  		};
>>>  	};
>>>  
>>> @@ -466,6 +471,8 @@ gem0: ethernet@ff0b0000 {
>>>  			#address-cells = <1>;
>>>  			#size-cells = <0>;
>>>  			power-domains = <&zynqmp_firmware PD_ETH_0>;
>>> +			resets = <&zynqmp_reset ZYNQMP_RESET_GEM0>;
>>> +			reset-names = "gem0_rst";
>>
>> I don't see any of the reset-names used in this patch defined in DT
>> bindings (or used in drivers). For all devices but the USB controllers
>> it seems they can be dropped. For the USB controllers, the bindings need
>> to be updated first.
> 
> Let me double check it. IIRC if there is just one there is likely no
> need to list the name but if there are more then one names should be
> also there. But you are right it should be the part of dt binding.

I will skip this patch.

Thanks,
Michal

