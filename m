Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8F42FFE62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbhAVIkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:40:42 -0500
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:62368
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727039AbhAVIiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:38:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTEDVYcvpuyoLPnYOdhcnFnLOSJIBlG2qhute9zt4P3bBYJr6kDP6j7RW3qUjcWTGKWt7l6f5o1sSG0ht2Sq6nO8NvoCBJGrIp3eO0RHPjx1GkGO6RuPe300rbsozFo+ZqPXOjO8vn8b0bRm7+k0yqtZWedbwIJdPld5Tp0XCiOTOJtkcdwDegTUHazOD4B91+9oEwEWn9O8LMWwqdIyFXynageuJSzUpmbkFiKwQOWr4aUvXatNiddRDaBXlbaR8zIgrJp24NDo34r5rPH1plDSK7Hur93DZ46k54ZheUPU0qefOjlainjXVPXQqBdX5aeCNI0c6kn4ElnjDYEEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH9fGYIDXNLiqHn6Gp0ro6cYfBPzUWcF0Pa54/wWwWU=;
 b=EH4zOEQ8Xuami3rBI3rCZA4oTxLNpgAT7GTyulJnByOmDiQTv6/1RtT+8WO6JOITQDj6ogqz6/6u07C150ec8S2Q7YFYzfodxT00yDrUoJB3uhl/CJnpDsEIZJeQYQMZpSweHPFFekpWLLOg0fcyBmY8W9pZ1goYK42tZvAznPCI98WM1tC9cDP9epztbaF1YXUW4LhWs72TJL7PSoWq2p3456Uw4GeXPmYEkrsqgFPf4SU0DmQaPN0u8Ee1DGmKYy4fFsWUajsuclh1gt4BSn7TXAqsyn54cYSbi6eaCOUiHpRAKiIKyKVdp4Z7cYMAM3S+Hbssr3NYxpgKlJhqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH9fGYIDXNLiqHn6Gp0ro6cYfBPzUWcF0Pa54/wWwWU=;
 b=bKnqlfhmVmifpOpPMIoZVinp6JQBLjwsD7+4uu2Ttf2MYvHRMllgmQZRg8rUC1ZyV99ASyD52py0rPwq5dEkNHr+/uPf6xHpvZ+yeqIE7/Y+7tzmd16P5av6J5Z3+DgcWCX7U4KezrAAYu2GoHpBHKauBERyZAF4Bse/paDPNyI=
Received: from CY4PR13CA0002.namprd13.prod.outlook.com (2603:10b6:903:32::12)
 by SN6PR02MB5679.namprd02.prod.outlook.com (2603:10b6:805:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 08:37:23 +0000
Received: from CY1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:32:cafe::84) by CY4PR13CA0002.outlook.office365.com
 (2603:10b6:903:32::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6 via Frontend
 Transport; Fri, 22 Jan 2021 08:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT049.mail.protection.outlook.com (10.152.75.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 08:37:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 22 Jan 2021 00:37:07 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 22 Jan 2021 00:37:07 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 krzk@kernel.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 laurent.pinchart@ideasonboard.com
Received: from [172.30.17.109] (port=47594)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l2rwI-0006e9-N1; Fri, 22 Jan 2021 00:37:06 -0800
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1611232558.git.michal.simek@xilinx.com>
 <9769d4d103b6eb75e3324825117f6832a746004e.1611232558.git.michal.simek@xilinx.com>
 <YAoCMqq/hpY0Jz6A@pendragon.ideasonboard.com>
 <80b7a167-86ad-3012-b080-b380e7013f18@xilinx.com>
 <YAqC4WigXbw6ihqE@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 3/3] arm64: dts: zynqmp: Wire up the DisplayPort subsystem
Message-ID: <d59354ef-5648-4b91-85dd-c19f871b8289@xilinx.com>
Date:   Fri, 22 Jan 2021 09:37:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAqC4WigXbw6ihqE@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5573ade-4ba5-4907-9085-08d8beb0f069
X-MS-TrafficTypeDiagnostic: SN6PR02MB5679:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB56798D081B838DBB4B324A1EC6A09@SN6PR02MB5679.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: st4C4ccXK8ZVqu8xRZSiM/hu1zcRGKrbHHd0NNDuyg5W8F+HEcReE8han8tMwhxV9e3ZG1CsHB8qZ2axyxwuYCxW0GhCezROEwQQTWCr5Azk0xFKM9cXKE27/jCvAI/WRpRrdFWEsCWnwAXa5gsRM/oUNen3BxGbFESMqUzvrZH5L4HTcPY/SKFqDg0/mW5wLoYUyFWM3IeX0Pn250LnNf+Ry6z2b29BmvwC2u3T/1ZYiINciSyPROMP6Wftn+ezG8NilRnRYMcB8kiNkJuuN2YoPrfwzrVsDIAg6EZtLOIjgBsPqmnnEvF1ll16rCqV50DSkll4OTvOZomKA4cK2HRwS8m+WI9RXPbQTXdsqVz3KhEuPa7zv/qxvAmU6IBoq6Q3gcLHGviS92e4wrHENUiFQIpaq7KkOoO2V9qX5u/ezHOIH1+aKflVPpdHwVKPCI6mv8JprrBRr6hwSVuHPQ74Pf0J0JzvbGYmaPGUfqcZ7OMtjcGJHajYcR6aw/rbPb3hwQ4UtzPjZUvr7z/Hcw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(4326008)(36906005)(2906002)(7636003)(82310400003)(47076005)(8936002)(31696002)(316002)(478600001)(6666004)(36756003)(31686004)(83380400001)(356005)(44832011)(9786002)(5660300002)(82740400003)(70206006)(426003)(54906003)(26005)(70586007)(336012)(186003)(2616005)(53546011)(8676002)(110136005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 08:37:22.9257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5573ade-4ba5-4907-9085-08d8beb0f069
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5679
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 1/22/21 8:46 AM, Laurent Pinchart wrote:
> Hi Michal,
> 
> On Fri, Jan 22, 2021 at 08:19:15AM +0100, Michal Simek wrote:
>> On 1/21/21 11:37 PM, Laurent Pinchart wrote:
>>> On Thu, Jan 21, 2021 at 01:36:07PM +0100, Michal Simek wrote:
>>>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>
>>>> Enable the dpsub device and wire it up to the PS-GTR PHY lanes routed to
>>>> the DisplayPort connector.
>>>>
>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>
>>>> Wire all the boards
>>>>
>>>> ---
>>>>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 31 +++++++++++++++++++
>>>>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 10 ++++++
>>>>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 11 +++++++
>>>>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 11 +++++++
>>>>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 11 +++++++
>>>>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 11 +++++++
>>>>  6 files changed, 85 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>> index 71ebcaadb7c8..a53598c3624b 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>> @@ -15,6 +15,7 @@
>>>>  #include <dt-bindings/input/input.h>
>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/phy/phy.h>
>>>>  
>>>>  / {
>>>>  	model = "ZynqMP ZCU100 RevC";
>>>> @@ -108,6 +109,18 @@ ina226 {
>>>>  		compatible = "iio-hwmon";
>>>>  		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
>>>>  	};
>>>> +
>>>> +	si5335a_0: clk26 {
>>>> +		compatible = "fixed-clock";
>>>> +		#clock-cells = <0>;
>>>> +		clock-frequency = <26000000>;
>>>> +	};
>>>> +
>>>> +	si5335a_1: clk27 {
>>>> +		compatible = "fixed-clock";
>>>> +		#clock-cells = <0>;
>>>> +		clock-frequency = <27000000>;
>>>> +	};
>>>
>>> This is fine as a workaround for now, but I'm still wondering how we'll
>>> solve this properly. We can declare the SI5335A in DT without wiring the
>>> output that provides the clock to the PS, otherwise it will be disabled
>>> as part of the boot process.
>>
>> All these clock chips are preprogrammed to certain rate and enabled by
>> default. It means there doesn't need to be any SW handling to enable it.
>> When driver for these clock chips comes we can change this that's why I
>> used labels which are saying which output it is.
> 
> Unless I'm mistaken, on the ZCU106 board, the chip is an SI5341B, which
> has a driver already. I tried to declare it in DT, but the PS_REF_CLK
> then got disabled at the end of boot, and the system wasn't happy about
> it :-)

In series before si5341 chips are enabled as the part of sata
enablement. Maybe you missed always-on parameter.

si5341_9: out@9 {
	/* refclk9 used for PS_REF_CLK 33.3 MHz */
	reg = <9>;
	always-on;
};

I just retest it and I can't see any issue. Sata
I see DP driver probed but I can't see anything on 4k monitor but maybe
there should be something to setup (I use fs from 2015).

thanks,
Michal


