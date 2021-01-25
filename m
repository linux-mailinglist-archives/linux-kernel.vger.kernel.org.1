Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD43023C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbhAYKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 05:37:01 -0500
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com ([40.107.237.73]:14726
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727496AbhAYKdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:33:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuD3kCk78mRs54lcCcH2B+hiROA0Cnf1nRWs/EkNbHnavDmXqT4ycBhzAco8qBCQub5aajHHwf29yz4YmRdz/pwhXQEHClKo9rKwS6dfNoRB67MXpJ7Wj6Ga/YGE3FLUspV9dB9P7Kw1xnhHK9v06V75Xjm2Dvlod9FWTkoELnKs85zJSTc18EiyZh3X8duPGSq8Vop4By1EWqo9yDPGRnIzvHBjqHRT+N8LdliSX5/KyKhNXpJMo1bUSpBgh6WH9tq6lMmKC9xFn0IYNpqkDpyuPrvD/EdjNF491WN6lx/c29vZmqvbcEvoaxCi7Z/DQdKoU+SrGWEivLYObaR8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBqXa9zQRZAV3nBH/6u30RgsvlLiBLemiiAzAUzpkIE=;
 b=GR65oGa2DhWz5WumUleqerdcX7iPDz1Ao8aMlUmxf/qW2YoAYlLz8AbsYZOfYUwmoCWvJOBdsxp3rFSBrfpk8Wk8g9mrMPqdwJg6nHfzoi+ZlF+c5Qi0dLuF1hfbAyriyX9hPqG66QvzUfII75SC1UrxnrqEZjQSPnR0PYw/xufQrcJg7/cWS6LYxRFuemeKUj8bUcNcgXh4gd2It90GO4VYoQJDG3Y3mmAL00u2Qu6qOxTXM9aje3RG4N/X8QksOFMl+ZnnSMD5btrTb74c7i6PD+CNS3uXw0d336/1aPbiKj5ZrI3LWfwIUqeM/nVpzQSCNCo7SALu0lsq5OfCJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBqXa9zQRZAV3nBH/6u30RgsvlLiBLemiiAzAUzpkIE=;
 b=KS6tRZrfVsSbws6XIAmDR5/rDyuTZ1CSGwLchKF47+uW3kRz8i0l8sIeCr59eph3nSjRxL1PKbcXjZCAw5Nz6LQFjmOeBGyPqvwbmEm93wlmAUYsBGTnafG+wAmKnVg7lNjo13xcmBhVlzqqUxbF/lhM0Bhs9vmJVmt2KrMhGmo=
Received: from SN4PR0501CA0044.namprd05.prod.outlook.com
 (2603:10b6:803:41::21) by SN6PR02MB4448.namprd02.prod.outlook.com
 (2603:10b6:805:a8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 07:52:07 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::92) by SN4PR0501CA0044.outlook.office365.com
 (2603:10b6:803:41::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.5 via Frontend
 Transport; Mon, 25 Jan 2021 07:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 07:52:07 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 24 Jan 2021 23:52:04 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 24 Jan 2021 23:52:04 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 xe-linux-external@cisco.com,
 dwalker@fifo99.com,
 broonie@kernel.org,
 danielwa@cisco.com
Received: from [172.30.17.109] (port=36946)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l3wfM-0001J5-A0; Sun, 24 Jan 2021 23:52:04 -0800
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>
CC:     Daniel Walker <dwalker@fifo99.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210121231237.30664-1-danielwa@cisco.com>
 <185100f4-67f1-140b-ad01-9997891e68da@xilinx.com>
 <20210122203240.GS3710@zorba>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/2] arm64: boot: dts: add new dts for hellcat & petra
Message-ID: <849cc330-8545-f1cd-1715-5244e399897e@xilinx.com>
Date:   Mon, 25 Jan 2021 08:52:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122203240.GS3710@zorba>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c24f8b0d-525d-4841-c609-08d8c1061d31
X-MS-TrafficTypeDiagnostic: SN6PR02MB4448:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4448B805024E10C9FD4F75D5C6BD9@SN6PR02MB4448.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0FLnUs4CxVW7tSapK91+tle9H6ziS50ps/c+6Dj4phpi9codKTK32bAc+NY4RkZ6+VMalw+tsTTM/WdtIaWAasRnUj5h754asDr5frft3jv41fn1Fp7tMBanbPMHHkhussxJsN0iHi3eQ7IrzbLmo/RT0mDMH7cRF8JaizroQL0WMfMMIm+b7KHcOMIlFxcD4vPhmh2YkmCG8A4tN4qdUQC1QiLFMRO+gcAMyE9Ldp29AKRqD86DZqakug4X1u6Np5H57jLtQ+C8CwtaBGBjbbM+NMTg2y52DQpHzNb1kxL/n3+LBoiTRlV/YxqfuZqzdT1jlVxh+tCYZHeQ612satM5yqFnoUtTubamHLzzaPqD8zh0VDYHVgU4/7ZVUFx26JFOKasK4LKxeou023Cabr1y28YZZ0mGQ754xAtcjIWL+/qoje+7X1brP6Xz5BCVr2eK1snS5azjp13yK4Pp1BbLNXxNopnezKGiu/DqQ4CSHjAk7r1yeVQA3CS/CfER6Q3bzfoDObjCNrKUJmf7QoMP/dsZoUnXV4SE5zO7xjxxU5pvp6edpPGxEt4fTD7+OV3R5CgIzK4IepXwIxFsP+rAkRC5XxsETjLXOwV4vRw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(376002)(346002)(46966006)(54906003)(5660300002)(110136005)(82310400003)(6666004)(7636003)(9786002)(356005)(47076005)(316002)(36906005)(186003)(26005)(336012)(8936002)(2616005)(53546011)(8676002)(44832011)(426003)(31686004)(966005)(70586007)(70206006)(82740400003)(36756003)(478600001)(2906002)(4326008)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 07:52:07.5821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c24f8b0d-525d-4841-c609-08d8c1061d31
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4448
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 1/22/21 9:32 PM, Daniel Walker (danielwa) wrote:
> On Fri, Jan 22, 2021 at 09:48:53AM +0100, Michal Simek wrote:
>> Hi Daniel,
>>
>> On 1/22/21 12:12 AM, Daniel Walker wrote:
>>> Add Petra and Hellcat dts file. These platforms are based on
>>> the Xilinx Zynqmp platform.
>>>
>>> Signed-off-by: Daniel Walker <dwalker@fifo99.com>
>>> Cc: xe-linux-external@cisco.com
>>> ---
>>>  arch/arm64/boot/dts/xilinx/Makefile           |   2 +
>>>  .../boot/dts/xilinx/zynqmp-petra-hellcat.dts  | 856 ++++++++++++++++++
>>>  arch/arm64/boot/dts/xilinx/zynqmp-petra.dts   | 847 +++++++++++++++++
>>>  3 files changed, 1705 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-petra-hellcat.dts
>>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-petra.dts
>>
>> First of all I can't see 2/2.
>  
> It wasn't being submitted to you. But here it is if you care to look at it.
> 
> https://lkml.org/lkml/2021/1/21/1468

I think spi-dev should enable the same approach as is used by uio driver.
Take a look at 05c3e0bb5629b897b0459e4bfb1b93d729033b99
But it is up to Mark it this could be reasonable solution for this driver.

> 
>>
>> Long time ago we said that we are not going to push any PL related
>> configurations. It means all below can't be merged.
>> And there are also coding style issues.
> 
> You'll need to explain this more. It's likely this was added at the suggestion of
> Xilinx. If it can't be upstreamed what should we replace it with ?

No idea who gave you this suggestion from Xilinx.

I had similar thread with Michael Walle about supporting Ebang board.
PL depends on your custom design and can change quite quickly that's
there is no good/bad configuration. That's why all of them can be valid
and kernel is not the right location to store thousands of
configurations (likely in overlay form). That's why only fixed
configurations for PS are added to kernel.
And I prefer if there is any good reason behind why these platforms
should be added.

> I will review your other comments and re-submit.

Happy to take a look at it again but completely remove PL description.

Thanks,
Michal

