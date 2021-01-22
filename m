Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87932FFD45
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbhAVHUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:20:45 -0500
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:17248
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbhAVHUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:20:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcF6EywG2Hd+YUedgH9p+oU/CPmyNDubaXHfwJNk/7kytxXQGGKveC+mY6Hq3e2kpunOkGcAfC/ccHUG4Lf0ZHCg1g7+iP8EGaZ5oQ5qtSgsbUrNv0RVns/M+1vtDP5/H3Ju6NW856M21tcKXrf8ke1N5kaQiSF74LmKiypXfn9Lo4hv5QkqUVFYGjXdCOhqfxdk8oP9XK4+lu3j5KX6//C1zbLP/T/jncIvrFkg4RnelU3lFOTbeKHoP5NuGOhgKsGp/5jwY5FFoIVj+MCnkd30kOuhTQEIG4eweUoPoSZikj/TNK2HvRyVs35HSjw8LiJb1slubDYCqjFOfzljOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Btzz8jsmL4cWPEqdsMaKM7bZIk9/0TLj38mreigJxqs=;
 b=GXbCcKFVxR/5hYtuhNzieZGNcUFcxT9TQQ8WN5sYPawaqYHbUuHc7VnwEtzuPtsBy6RubaOMivsTMCfiXPeWTel+AU2LufcsFDZIIADGKsAxFobI89nMVYQg72rhAbQ7UM3TsXV5daoxkEu+Sw7AEnmTzm68EPpUDo9+H0wsjIS73waY87drdu0gKc6+GTW4yjrmGaeoSw7/1AM4aWdKDbOelwaxhFep6CB491KdZMKw3E2SxTDj4YsNSaIoFNENN5K8EZ1w2VzeLOntkqLxtMUknUaO7zemYh7IFrxBFOcn37K2n9jQQzW53xXCBKdvXJdEt6J/paTc0UGGOiEVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Btzz8jsmL4cWPEqdsMaKM7bZIk9/0TLj38mreigJxqs=;
 b=Vti6v7Ew/bgqIlqZE50MkIIE97M/eZeTSmWdRuXeioAALaMtZODycFolLpXfwBnU5BXhtNS8FF3x221duEc/CADC0Z6d7BwxZzpyseCXUZ1JEbfQ8XozHMjWCzUdNQ/XgvDjXdpN6aSccIXppgy5GU0gSORwuY/RL8cHsyXFu3Q=
Received: from SA9PR13CA0240.namprd13.prod.outlook.com (2603:10b6:806:25::35)
 by MN2PR02MB6173.namprd02.prod.outlook.com (2603:10b6:208:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 22 Jan
 2021 07:19:46 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::8f) by SA9PR13CA0240.outlook.office365.com
 (2603:10b6:806:25::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6 via Frontend
 Transport; Fri, 22 Jan 2021 07:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 07:19:45 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 21 Jan 2021 23:19:19 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 21 Jan 2021 23:19:19 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 krzk@kernel.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 laurent.pinchart@ideasonboard.com
Received: from [172.30.17.109] (port=40844)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l2qj0-0004Ul-AH; Thu, 21 Jan 2021 23:19:18 -0800
Subject: Re: [PATCH 3/3] arm64: dts: zynqmp: Wire up the DisplayPort subsystem
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1611232558.git.michal.simek@xilinx.com>
 <9769d4d103b6eb75e3324825117f6832a746004e.1611232558.git.michal.simek@xilinx.com>
 <YAoCMqq/hpY0Jz6A@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <80b7a167-86ad-3012-b080-b380e7013f18@xilinx.com>
Date:   Fri, 22 Jan 2021 08:19:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAoCMqq/hpY0Jz6A@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2988c758-0199-45e2-bf05-08d8bea61863
X-MS-TrafficTypeDiagnostic: MN2PR02MB6173:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR02MB6173A5CCDDF450101E8D3F31C6A00@MN2PR02MB6173.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSmenvzVmwlGRiL1YQKb60RLl3l4WuTl0HmsoUXhynjDhrUPcOo9sWURo/vsrD+L2sEqqSyWEOiHWa5Ipoi/YZdANq0YGLrnfCSqWVESeBYgywIqWv/TbJAW6yC4Sv5mAy2nancmRzWcTaImWx20s2EEfnh6TkdxKRC6Z32YiJLRLDJpN2DUzsKKsFoKDuLcqGoWoFLLpCUZXkweely7Z0lR+ZrqMXigjEa9xdp6pOpqB8MkXdI6x0oD4OiYMb8Kfh8Ohk0hcPm9qTV4QDosBtloJ9spaRyNGH1xbnZdydZJpc4Up+8TmepSlkrKvj/oITf0oTYDSVf+4xEUaKWvD9FR/FJ0pz21Do6K8m5eLoy35s53XM/nFNNQFyQmXBq/EtQzvLmJ3sg9tV+LkZCItOid2/vBPT2Qwp5dHrxxcUC2i3XuVXEZvjqJ9/CmrCkGeEAm/xdTzAw5H+8dziyyoMvR6CyfbKeJQcGsvuJsvMjlM9yYSFUwi7e3aFsQlJsrwdx7CzmP4QHLtzBFi7+0JQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(316002)(70586007)(36906005)(26005)(6666004)(70206006)(83380400001)(5660300002)(31696002)(7636003)(336012)(54906003)(82310400003)(478600001)(9786002)(186003)(82740400003)(53546011)(44832011)(2616005)(356005)(47076005)(4326008)(31686004)(8676002)(36756003)(2906002)(8936002)(426003)(110136005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 07:19:45.5084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2988c758-0199-45e2-bf05-08d8bea61863
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 1/21/21 11:37 PM, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Thu, Jan 21, 2021 at 01:36:07PM +0100, Michal Simek wrote:
>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> Enable the dpsub device and wire it up to the PS-GTR PHY lanes routed to
>> the DisplayPort connector.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Wire all the boards
>>
>> ---
>>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 31 +++++++++++++++++++
>>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 10 ++++++
>>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 11 +++++++
>>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 11 +++++++
>>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 11 +++++++
>>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 11 +++++++
>>  6 files changed, 85 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> index 71ebcaadb7c8..a53598c3624b 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> @@ -15,6 +15,7 @@
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/phy/phy.h>
>>  
>>  / {
>>  	model = "ZynqMP ZCU100 RevC";
>> @@ -108,6 +109,18 @@ ina226 {
>>  		compatible = "iio-hwmon";
>>  		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
>>  	};
>> +
>> +	si5335a_0: clk26 {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <26000000>;
>> +	};
>> +
>> +	si5335a_1: clk27 {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <27000000>;
>> +	};
> 
> This is fine as a workaround for now, but I'm still wondering how we'll
> solve this properly. We can declare the SI5335A in DT without wiring the
> output that provides the clock to the PS, otherwise it will be disabled
> as part of the boot process.

All these clock chips are preprogrammed to certain rate and enabled by
default. It means there doesn't need to be any SW handling to enable it.
When driver for these clock chips comes we can change this that's why I
used labels which are saying which output it is.

Thanks,
Michal
