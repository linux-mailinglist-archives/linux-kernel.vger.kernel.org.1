Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A102630008E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbhAVJaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:30:35 -0500
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:57806
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727249AbhAVJBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:01:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+mIgGgnIlGDNzy3moX8EmtOtNtQDauJoJ28s+1GJNetLhDd06wygAQr4VuN+8xGs0EIm9jRmfUhkNNgckcpk8D64nOHuCWB1LeDlyG3nK3Y7nOe3fDMdr0m4+t49kmCW+8OE6+oI3J45krsFt95aQgz1Ml18eKVToBQct1sdINyDf1etVoqgqO3Bvhp4zggwCVXTgK/dZLvjV+yvXXcu5Qs6Net9rjbBoO0ThKpT7dOFX+qjO6EEgbf09L+AZ8GWs5dZKGToPP5oMhDY1MhAMmfMb/NuDbpt8CQrSgbiiCQamicdaKKjVUJkiW/y3lOZXQwAuDCdyaN4/moCYaExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg6saDEl/J12bG/IXZ7Lp0MXUE6pXqjwk1RKZ7VBH4g=;
 b=Ji/fRCAFN6zAaNU/F4a42G7SfisAGkOByiTNRWTv8XmMPv4M/LsbysvBlGc3AGx/ZY+o5YK07AEdGkZKdCdgBc9JZgu7ARIR7DXMa4uGqHfo9rCGvpVI/PnL/55NFHZJWfIT/YMCk6KBOq6z5x8aKliF5rZPyphjPqUe3BJB8JqCmtEP5khgDWoI2Ju+yv1aFcALiDSPK997mc6e61Rz+S3d7DGHQQf+uNkmIqd3vUNyi4JHEUVMdPofb5jBEogIxJk4LICJmGmWgmIo53lF6cLsYmbTBLyBaBq39fE2bjL7Ov3tuKtEVf0sVjA7CwL3OB6yI7ktXT+ZkVePqa4hXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg6saDEl/J12bG/IXZ7Lp0MXUE6pXqjwk1RKZ7VBH4g=;
 b=SwVn8Np4BNIRhs0MTlIXWWt9DhKHNLSHGxzNxZU1mHNlD7htJtJMLT0169HkP9CxLCZzG2Q5y4n8Lq8GC0AEA09t3vh3mpdFX7SpevA8tpDTbIMmaZirLvuJ62dU+LNdNC/7GxIXp/7qL+i2fr74B9kDpN1GxX6S29EFxdr3lEU=
Received: from SA9PR13CA0148.namprd13.prod.outlook.com (2603:10b6:806:27::33)
 by BN6PR02MB3202.namprd02.prod.outlook.com (2603:10b6:405:68::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 22 Jan
 2021 09:00:42 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:27:cafe::27) by SA9PR13CA0148.outlook.office365.com
 (2603:10b6:806:27::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend
 Transport; Fri, 22 Jan 2021 09:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 09:00:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 22 Jan 2021 01:00:16 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 22 Jan 2021 01:00:16 -0800
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
Received: from [172.30.17.109] (port=49536)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l2sIg-0006zA-LK; Fri, 22 Jan 2021 01:00:15 -0800
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
 <272e23e0123f02c559bfa4ada9de73eb197aced8.1606917949.git.michal.simek@xilinx.com>
 <X81fXtxvsc7KE7cK@pendragon.ideasonboard.com>
 <99008851-6c12-3acc-6530-25af08429ff5@xilinx.com>
 <X86poiQSzv5Uva1r@pendragon.ideasonboard.com>
 <4010c2d4-bee1-827b-1079-1f1bbf1f10d1@xilinx.com>
 <YAoAN3JF27zWnjn5@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 06/12] arm64: dts: zynqmp: Add label for zynqmp_ipi
Message-ID: <434ca669-e136-1bbf-7907-0d2110851a18@xilinx.com>
Date:   Fri, 22 Jan 2021 10:00:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAoAN3JF27zWnjn5@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7941fced-7232-4fe0-6f11-08d8beb432b0
X-MS-TrafficTypeDiagnostic: BN6PR02MB3202:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR02MB3202A828456B30B2C0658AFEC6A00@BN6PR02MB3202.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kfkh9vU6JVw4b8wX3ju7dRFTlMFl1JL6cHFcAGOyJl6zMIaIMfiyYOO5xmCJ6VBUwqiuJF9i5FpEWgLlnggU3gj+K0P7jNQMwERZCRrBKmmLOmUcoTYnYYKoO3MsO4aXkC2KrO4Foo2HxYY/BE+iI4ao/ApoRycN2wRZ7IcadpGSORQQJtDp4v49e4tdzVUzMufEEU5w7fqVnWExAnsw2SPydTWmDJQ3H4pjc8EM778xyKv4oFB3FMFVPEIDQ/A+mwcRH3kFFGFbd4r8uAa1lZRHufyBkT4MWda4h34YmaBP9gx2IdkxjQQi9wFuyT6Pj15B/aMLk21linH40XgTrBLTkRz9ZWgzH5yuF3qsCMEO1978exwsnlYe2KdW3PtBX7IJQMaH5DphvTz1PHaVaUqdgJ+ux5Wmi5pmrNkjuvoc13CsoZEq3Qa3s/L4/JpRgO21rr8rts6Cc8ry87ZNsHpBM2Sf99fFmkww34Yf0XbtKq18poSt4LaDaY4hRTBeP9/ZOdqzyFhxFHemjzasdw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(82310400003)(316002)(31686004)(36906005)(54906003)(82740400003)(478600001)(110136005)(4326008)(6666004)(8676002)(336012)(47076005)(36756003)(426003)(70586007)(2616005)(8936002)(83380400001)(356005)(7636003)(70206006)(186003)(31696002)(53546011)(44832011)(9786002)(26005)(5660300002)(2906002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 09:00:42.5885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7941fced-7232-4fe0-6f11-08d8beb432b0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3202
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/21/21 11:29 PM, Laurent Pinchart wrote:
> Hi Michal,
> 
> I've just realized I forgot to reply to this e-mail, sorry.
> 
> On Tue, Dec 08, 2020 at 08:26:41AM +0100, Michal Simek wrote:
>> On 07. 12. 20 23:16, Laurent Pinchart wrote:
>>> On Mon, Dec 07, 2020 at 10:39:25AM +0100, Michal Simek wrote:
>>>> On 06. 12. 20 23:46, Laurent Pinchart wrote:
>>>>> On Wed, Dec 02, 2020 at 03:06:05PM +0100, Michal Simek wrote:
>>>>>> Add label which is used by bootloader for adding bootloader specific flag.
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>>> ---
>>>>>>
>>>>>> U-Boot needs to add u-boot,dm-pre-reloc; property
>>>>>
>>>>> I'm not entirely sure what best practice rules are in this area, but
>>>>> shouldn't U-Boot locate the node by name instead of label ?
>>>>
>>>> Labels are not listed in dt binding and there are two approaches how to
>>>> reference nodes. Via full path with node name or via labels.
>>>> I do normally use labels which are much simple.
>>>
>>> Note that labels require the DTB to be compiled with the -@ option,
>>> otherwise they're not present in the binary.
>>
>> U-Boot is using different concept. You can see that there are a lot of
>> -u-boot.dtsi files in dts folders. These are automatically included to
>> DTS before DTC is called. It means you don't need to build overlay to
>> get merged.
>>
>>>> And also if you take a look how dtb looks like (convert back to dts) you
>>>> can see that for example aliases are using full path (just &label) but
>>>> clocks/gic which is the part of <> is handled via phandles as numbers.
>>>>
>>>> And labels names can vary and shouldn't be the part of binding doc as
>>>> far as I know. But I can be wrong of course.
>>>
>>> The DT bindings should document the interface with the operating system,
>>> and if applicable, the boot loader. If the boot loader requires a
>>> particular label, then it becomes part of the ABI, and I think it should
>>> be documented in the bindings.
>>
>> We have been discussing with Rob some month ago but didn't have a time
>> to do step further. Just keep it short Rob was ok to keep bootloader
>> binding inside Linux repo.
> 
> I think that makes sense, DT bindings are meant to be OS-agnostic, so
> boot loader requirements should be documented there.
> 
>> There is no hardcoding for a particular name. There is just a need to
>> have any label. U-Boot needs to have one property(e.g.
>> u-boot,dm-pre-reloc;) just to do early allocation.
>> The name is just reference and none is really looking for it. It is just
>> a way how to include it in much easier way.
> 
> Just to make sure I understand this issue correctly, does this mean that
> you need to reference the node in a *-u-boot.dtsi file, and want a label
> to do so ? The label name needs to be the same in the base file (taken
> from the Linux source tree) and the *-u-boot.dtsi file (in the U-Boot
> source tree) in that case. Isn't it the role of DT bindings to document
> such requirements ?

I prefer to have all nodes with labels just in case you need to
reference it. Simply based on experience it happens time to time that
something needs to be aligned, new property added and sometimes we touch
dt overlays. It means I prefer to have labels for all nodes.

In connection to u-boot. U-Boot introduced *-u-boot.dtsi files for
bootloader specific configurations. I think that's sort of bad design
and it should be done differently by simply document/align this binding
with the kernel. And in this u-boot,dm-pre-reloc case it should be
handle differently and any transition is required.
Normally *-u-boot.dtsi should just reference node in "root" dts via labels.
And u-boot is trying to align dts with the kernel.

And last part on this if make sense to also document labels as
requirement. I don't think it is good idea. You can have in general
multiple instances of the same IP which you need to add some properties
to. You would have to defined all of them for all existing SOCs which
will be very painful. It also takes so much time to upstream it that's
why checking one more thing there is IMHO just additional step.

I think that everybody should be trying to align all things together
across all projects. That's for example what I want to do in this gtr/dp
between Linux/U-Boot.

Thanks,
Michal


