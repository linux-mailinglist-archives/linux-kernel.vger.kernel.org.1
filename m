Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45C32FE6EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbhAUJ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:59:10 -0500
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:50753
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729065AbhAUJ62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:58:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJxvou6Kwjc1FmmkLhB79y/2/b3yoTvA9M4hI5dgmU5lpzkGNZkB4416tTM24Tzycd27WrU69FVULq5gyHT40eYtCknvEPM6aGyvYzFNJa/sGCYFyusj42uCJQI7UUzqF6cys3hiDvnH9b8GLmYgW67XxZcL8ZVz7olfDWWwK6rLLlouath8YXMhptNqtRPh7NTSpQrieiNh29QKdAH8p0iRvZxA5D2bporTM0qgMWNYfm6yT6CGS9iqYltkbbGcY/QjwcaZinXfjWlR9g9tuYcoCD57tOE7WhK8oLGBX0sqnfH91FHiGmSBpc2o84uhBKyn3M6u1cAzeJCArakAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YcGb+nlMqM4stOPyw++a32wO/5HqCo1BBZ3WOHTSYA=;
 b=fafRsDVCEcf1gPMdKYzIzz4ihxeM8Fm1tKF8MD/bgpYZ+XUtCUxIiFNhM+KGfJ7R2eW8i+lYpxKag9UFTv4v7Vvn2WpDnhs/9PcuJqV1RcDB2sxVJ0T3cvEapVBDAtL82O5yJdFFdT/RRkgQiubeOsmqbxkqHiWxgPI0mSAlIXYtEBupb7ypNwfBg/kipwvbTrd8OlkL1S+bjyvUBT2pNR/jWXxAHB2WWcNeuU7zm5jkMZ4N6ROd18lpXkuolvKMCdOCVgiAee5qE1p9QJMdAmF3holFWl4k88/89TXsp0/RC32GqtPbyQzsnoknRoyyuQktAh6vh8TqmawR0yOZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YcGb+nlMqM4stOPyw++a32wO/5HqCo1BBZ3WOHTSYA=;
 b=pxsyONI8yOkWwSVlQpJyK6NdmbREktNhfWP6/4VswR5r64/+lM+WsLhF9thT0ZkCc42BdNRU6xyoHxJvKsuMK3bMcUwSkrVqaUQqXsSnQx2sBVgM6AgqB31UAcw5wxr9FJFjHxHfQblt07/IE7nKm3gMXBkMb25lIsjnBBn+eXU=
Received: from BL1PR13CA0063.namprd13.prod.outlook.com (2603:10b6:208:2b8::8)
 by DM5PR02MB3846.namprd02.prod.outlook.com (2603:10b6:4:b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 09:57:34 +0000
Received: from BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2b8:cafe::7) by BL1PR13CA0063.outlook.office365.com
 (2603:10b6:208:2b8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend
 Transport; Thu, 21 Jan 2021 09:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT031.mail.protection.outlook.com (10.152.77.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 09:57:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 21 Jan 2021 01:57:32 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 21 Jan 2021 01:57:32 -0800
Envelope-to: michal.simek@xilinx.com,
 soc@kernel.org,
 olof@lixom.net,
 arnd@arndb.de,
 robh+dt@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 michael@walle.cc
Received: from [172.30.17.109] (port=44700)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l2WiZ-00069C-Rh; Thu, 21 Jan 2021 01:57:32 -0800
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
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 0/3] add Ebang EBAZ4205 support
Message-ID: <0a1c6ebf-1d5b-4f06-56db-f04e87d2ae9a@xilinx.com>
Date:   Thu, 21 Jan 2021 10:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <aa96fcaa362181d4b6fef9f1de0aa914@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2908f50d-fc97-4138-16a0-08d8bdf2f98c
X-MS-TrafficTypeDiagnostic: DM5PR02MB3846:
X-Microsoft-Antispam-PRVS: <DM5PR02MB384660FA4C99F59A7AAD310FC6A10@DM5PR02MB3846.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYbHzeuE5fuaJ2JwhbVqNTpkkLe5qaXcDWeyy9G+nkMNd9EWUF/jSC3A13RbMpaITgOCM/68sFqt6axJ0RpNI44YfoDa9vouIecsp7sVmdzAkQshuZjG8UIdvkGXYkYJyTefIe4+NR+TEGtSxvgCTwZppYLUYSTMoTBFe6YhZpZakPkgXChC3+AgeoHXdmUnRfJ5EgGCYBjX1mlgF/nuLL5M/JelB49H+DHTBnLBlF7PVMy1hAJgOl5jz/vHLB5yXBTnp9so+jVRLbVc/SYnVeET7qS002qsmc5I9DZXOP78ymjoabyuVwBi5j8bL3bRQzMIi6aYdz2ZuRE4NU7mvAN7pOua0Z7pBWjngBtdvXMfIrr9wUYyr+wxHO94oj6d2K+6xbwGIPEZJXimmi/o3qODSsGXaHfy+vPV6wjLeLbRBsYQDPEDZ4Pb4GvLM+WqfGkAu7iM4Ngq57qvsai7e8h4qRMpkKJb6ECX1L9WatlWCy77w3S4seOVNlVMmPT1DDJnJ6a1plf7f/IgCMjNzXhlM5o02TH7QdrTKGvqcAyUAhfAEHSh46vpYjXT9HJQOnBGs97fBy95EYA4lCj6orlEjaIJ6Y7yAitNSG7gCcE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(54906003)(4326008)(966005)(5660300002)(356005)(36756003)(110136005)(66574015)(82310400003)(6666004)(47076005)(478600001)(336012)(9786002)(7636003)(83380400001)(53546011)(8936002)(186003)(26005)(426003)(44832011)(2906002)(82740400003)(8676002)(31696002)(70206006)(2616005)(316002)(31686004)(70586007)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 09:57:33.7948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2908f50d-fc97-4138-16a0-08d8bdf2f98c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3846
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/21/21 10:35 AM, Michael Walle wrote:
> Hi Michal,
> 
> Am 2021-01-21 10:25, schrieb Michal Simek:
>> On 1/20/21 8:40 PM, Michael Walle wrote:
>>> Add support for the Ebang EBAZ4205 board. This board was once used as a
>>> control board for a bitcoin mining device. Nowawdays it is sold as a
>>> cheap
>>> Zynq-7000 eval board.
>>>
>>> Michael Walle (3):
>>>   dt-bindings: add ebang vendor prefix
>>>   dt-bindings: arm: add Ebang EBAZ4205 board
>>>   ARM: dts: add Ebang EBAZ4205 device tree
>>>
>>>  .../devicetree/bindings/arm/xilinx.yaml       |   1 +
>>>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>>>  arch/arm/boot/dts/Makefile                    |   1 +
>>>  arch/arm/boot/dts/zynq-ebaz4205.dts           | 109 ++++++++++++++++++
>>>  4 files changed, 113 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/zynq-ebaz4205.dts
>>>
>>
>> any link with schematics?
> 
> https://github.com/xjtuecho/EBAZ4205, looks like these are
> reverse engineered (from a layout file?) though.

Interesting but at least something.

> 
>> I will let dt guys to comment 1/3 but series look good to me.
>> The board doesn't look interesting from description point of view that's
>> why all the time thinking if makes sense to add it to kernel.
> 
> What do you want to tell me? That for the time being, it didn't
> appear to you to add the board yourself - or do you thing it
> doesn't make sense at all. If its the latter, what would be
> actual reason to have a board in mainline?

I have bad experience with for example Avnet boards which people add and
none is really updating them and they are in the same state for years.

Long time ago we agreed that doesn't make sense to describe PL in
upstream projects and we only describe PS part. It means you likely miss
several things which are useful and the reason for using these SoCs is PL.

As you likely know Xilinx has Versal device and I didn't push any device
tree to any upstream project and thinking not to add any description for
boards and stay in sort of space that "virtual" description for SoC
should be enough. Maybe just versal.dtsi and one kitchen sink DT should
be added but not description for all boards.

The same is if make sense to push all DTs for all standard xilinx zynqmp
evaluation boards. If there is something interesting/new I thought it
makes sense to add it as pattern to follow. But for boards which looks
very similar from PS point of view I don't think there is real value to
add and invest time for maintaining.

Back to your case. Board is cheap which is not all the time case for any
xilinx board but you have only uart, sd and partially described ethernet
which doesn't work without PL. Is it worth to have this described?
Especially when it is visible that you need to describe custom PL and DT
overlays are not solid yet.

Thanks,
Michal
