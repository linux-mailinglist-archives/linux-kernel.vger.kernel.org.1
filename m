Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28F2FE788
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbhAUK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:26:50 -0500
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:35393
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729157AbhAUKYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:24:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVmfN/yAxN+P87RfHFz2TS0vVoNy5hbhC8E1xxvtzW4TkEM8pqKh5itWQxaSaYYMjSgttwA/x5uAVSkj01O/KzddohuzHVxou6sMqDnebyOxvK/UuWQV30kQFYABFJ0paCv/rEA92j00DbAYyZzbIivhTwryz9YBKRWccht3aZ8ldJ0Hv3SpRunGA39e63dd6OX7zMKnMpsmK1GQgrNF/RbPezOSAz62QQAU1dceqtxk47+lrTVO3D5UPJhka1sSHNaHER0ALYEW4bYFi/U9dw7qgGuKjuCkwS22FrNZnvHHTlpG+62eBvP6rHkGIOTtJ+ML++BwCAQZwmtvzXHebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcWfjobAP4g+siZtsrLWHUdUVopaAVe8BkuAbpIU3Vw=;
 b=QLenOiKRYfw/5j4XJOEIqzDjZmCOHZDeoe1KqTCjTh39jhQmy9V76XfDXtYUKfeATc+jhLZAt3vHyhIRyZK1SMB994yPdtWo20o7XDOpZxNwH4jHtaZYf04Jy2DG3G3tuBRhAUmfSOmWHMs6fTW4+hhAgu4vCOpceV7Omu1iUzLU+418MyPP4NMlEd/axmlvakeolEbUBChF1GJTEwqyCF8GjFleAMGgDo0CKwROuMg7n/lChz8uO8CAG+vG0EU220pJrdT/q3sK+rZHvJqYVuPlbZigHE2x/hHSn+B0kCkZwlmAYGPnN+AM8dj0k3jlSuAMEOxegHltb00G//JWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcWfjobAP4g+siZtsrLWHUdUVopaAVe8BkuAbpIU3Vw=;
 b=pRU6pnvOUSGZ1golE+NB0+kGQgu++wiLcMOVuyr84qpuC7Hlgjmzg8ukmS+qBiSiYZw/g/QIg+10Kd3a1ZH6YJ7zhiiTk9tlPnkXUzDoMUnuo4Dk5RrOJRHvLGJ/2r1d+oW6IUC6qCQRz0I1EXauC1je8ae3fjK80hMha8mtNTU=
Received: from CY4PR01CA0012.prod.exchangelabs.com (2603:10b6:903:1f::22) by
 MWHPR02MB2400.namprd02.prod.outlook.com (2603:10b6:300:60::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Thu, 21 Jan 2021 10:23:51 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:1f:cafe::6c) by CY4PR01CA0012.outlook.office365.com
 (2603:10b6:903:1f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Thu, 21 Jan 2021 10:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 10:23:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 21 Jan 2021 02:23:49 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 21 Jan 2021 02:23:49 -0800
Envelope-to: michal.simek@xilinx.com,
 soc@kernel.org,
 olof@lixom.net,
 arnd@arndb.de,
 robh+dt@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 michael@walle.cc
Received: from [172.30.17.109] (port=47132)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l2X81-0005LW-59; Thu, 21 Jan 2021 02:23:49 -0800
Subject: Re: [PATCH 0/3] add Ebang EBAZ4205 support
To:     Michael Walle <michael@walle.cc>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>
References: <20210120194033.26970-1-michael@walle.cc>
 <fff420d1-fc9a-23ce-0d07-58a3c6f10c4d@xilinx.com>
 <aa96fcaa362181d4b6fef9f1de0aa914@walle.cc>
 <0a1c6ebf-1d5b-4f06-56db-f04e87d2ae9a@xilinx.com>
 <bd86194a13882ce472764d0c91029e33@walle.cc>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <8917c9a1-09e9-0a39-5732-da7f555ae9ad@xilinx.com>
Date:   Thu, 21 Jan 2021 11:23:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <bd86194a13882ce472764d0c91029e33@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbd60919-86c8-49f2-53b2-08d8bdf6a5af
X-MS-TrafficTypeDiagnostic: MWHPR02MB2400:
X-Microsoft-Antispam-PRVS: <MWHPR02MB24009EADD74F5A34C870181AC6A10@MWHPR02MB2400.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDwu1VGyURR8KzMvkl6GblpjG3GSZPHw43jiCPxoMk+4H4PdNcqE0Yj4zij6NuexgHq/klJw+N+JQKmHSCRaxLoIO9MgoyIrVR5IeC8dN82e+zTL57cBLTTZy+pD/kV2cdSSh170onEgFARwxmzHpPN0iXT9e7rQx9mHKL8xXJuWTove9R9ADP59wMAiqguMI+Wm9DyGiu0Djidt8qkgIWFlOzh4t+g08XnwUqKogLkCasPsCqZftHTRhhkKxtJiAl5abosOCsrLpJb68Nc4wRuR5IBVbY2fUsYu6izyD92w4+DWr/sx8WGK9KtOnjOPaVb6InSW5D9vxdSsek8Sbs5N7EG1OrgnuNR9b8DweF6/JpxhJnqT27qNusvuLuXx1VjaLP9vVh3Tq3wMw6D52tbukL8fmKdvTiRS3C4q+BhgIU9vdriFzjOwLipSBJPApkM9UP8apU/2MGMgFdyzHcWPXccxi6aHE4s+ZbvHrBqYe8ZUMudQ1WA7QLaw3r8yDgk/SS2O9ZhnL33w+tNVCNhbBDGDgPRp32W3Ows5g6lGUCsURt4yOvytV8/S/Le2uIOYzgOa0IRE7gIUF48A172SsMpJKAxYPar1U9ZAcfQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(70586007)(4326008)(478600001)(44832011)(36906005)(82310400003)(336012)(47076005)(82740400003)(8676002)(36756003)(70206006)(5660300002)(356005)(83380400001)(66574015)(316002)(9786002)(966005)(54906003)(31696002)(31686004)(26005)(2616005)(186003)(110136005)(7636003)(53546011)(2906002)(426003)(8936002)(6666004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 10:23:51.1640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd60919-86c8-49f2-53b2-08d8bdf6a5af
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2400
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/21/21 11:13 AM, Michael Walle wrote:
> Hi,
> 
> Am 2021-01-21 10:57, schrieb Michal Simek:
>> Hi,
>>
>> On 1/21/21 10:35 AM, Michael Walle wrote:
>>> Hi Michal,
>>>
>>> Am 2021-01-21 10:25, schrieb Michal Simek:
>>>> On 1/20/21 8:40 PM, Michael Walle wrote:
>>>>> Add support for the Ebang EBAZ4205 board. This board was once used
>>>>> as a
>>>>> control board for a bitcoin mining device. Nowawdays it is sold as a
>>>>> cheap
>>>>> Zynq-7000 eval board.
>>>>>
>>>>> Michael Walle (3):
>>>>>   dt-bindings: add ebang vendor prefix
>>>>>   dt-bindings: arm: add Ebang EBAZ4205 board
>>>>>   ARM: dts: add Ebang EBAZ4205 device tree
>>>>>
>>>>>  .../devicetree/bindings/arm/xilinx.yaml       |   1 +
>>>>>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>>>>>  arch/arm/boot/dts/Makefile                    |   1 +
>>>>>  arch/arm/boot/dts/zynq-ebaz4205.dts           | 109
>>>>> ++++++++++++++++++
>>>>>  4 files changed, 113 insertions(+)
>>>>>  create mode 100644 arch/arm/boot/dts/zynq-ebaz4205.dts
>>>>>
>>>>
>>>> any link with schematics?
>>>
>>> https://github.com/xjtuecho/EBAZ4205, looks like these are
>>> reverse engineered (from a layout file?) though.
>>
>> Interesting but at least something.
>>
>>>
>>>> I will let dt guys to comment 1/3 but series look good to me.
>>>> The board doesn't look interesting from description point of view
>>>> that's
>>>> why all the time thinking if makes sense to add it to kernel.
>>>
>>> What do you want to tell me? That for the time being, it didn't
>>> appear to you to add the board yourself - or do you thing it
>>> doesn't make sense at all. If its the latter, what would be
>>> actual reason to have a board in mainline?
>>
>> I have bad experience with for example Avnet boards which people add and
>> none is really updating them and they are in the same state for years.
> 
> Wouldn't it be better then to pull the plug at some time and remove these
> boards.
> 
> TBH I was a bit disappointed by your statement. It sounded like "nah
> this board isn't worth it". Esp. because it is just one (small) file.
> But more below.
> 
>> Long time ago we agreed that doesn't make sense to describe PL in
>> upstream projects and we only describe PS part. It means you likely miss
>> several things which are useful and the reason for using these SoCs is
>> PL.
>>
>> As you likely know Xilinx has Versal device and I didn't push any device
>> tree to any upstream project and thinking not to add any description for
>> boards and stay in sort of space that "virtual" description for SoC
>> should be enough. Maybe just versal.dtsi and one kitchen sink DT should
>> be added but not description for all boards.
>>
>> The same is if make sense to push all DTs for all standard xilinx zynqmp
>> evaluation boards. If there is something interesting/new I thought it
>> makes sense to add it as pattern to follow. But for boards which looks
>> very similar from PS point of view I don't think there is real value to
>> add and invest time for maintaining.
>>
>> Back to your case. Board is cheap which is not all the time case for any
>> xilinx board but you have only uart, sd and partially described ethernet
>> which doesn't work without PL. Is it worth to have this described?
> 
> I got your point. But it is at least a jump start for the users if that
> board boots out of the box. And yes, its unfortunate, that ethernet
> just works if the PL is configured. This is already done by the
> bootloader, because there I do have the same problem.

Zynq/ZynqMP boards can use U-Boot SPL. "Advantage" of this solution
especially for Zynq is that in u-boot there is open a way for adding
ps7_init file which is determined by device tree name.
I think it would make sense to add these DTs and also ps7_init to U-Boot
project and wire it up with zynq_virt platform and then you can boot
Linux with using U-Boot's DT pointed by $fdtcontroladdr.
Then you will get support from scratch to be able to boot.

Thanks,
Michal

