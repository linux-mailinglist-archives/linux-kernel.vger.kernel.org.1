Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09AC303B92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404987AbhAZL0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:26:12 -0500
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:39556
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390519AbhAZJVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:21:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp7TqQ2rtJHUeyW4paPs5zHewXnBfZUs1eVoyUkBjSYUKLL5KLdNPjtQGxNBweEZC1/C4sYyWTe/5uumP7sSybWmfdRbZ/4EhnSObvFjbQSOqapZJ+/0f04Kh8Qh4XYs3D20fzmzxpvN2vxmVB5ZLBMu+e9Qi9y2MrPGe9gcbzoa6sHGPkVhu/LsaQRUKaUpjTAzutgDuoN0qYR55WL2eVS3bsajQA+g56x03N5li29AqmA2A7iZNHOcXC5Kysepj65iowenRp7WgDzkBZCREKeCp+NnzpS5eoR5KqXl8K4uk/zCzP7hh+noRboFNCqwUblI7+wVEqXahX8SdOkmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux1ccx0k19Cv6pSNDOvaZtddX5MspYBbtJrkbVRcrCg=;
 b=nVVcnVqGrythvQ5cQSgTjjkPdKfaon2YkMDikOHrMFrOCWE+7cpnydqCn/7rERgVsJ1qCuoSQ7bue0+io+Uoa7xtbGX3/FWj4hcbSn98e3Rul++w8KHYYs14S+eqxm16KHt2e1RncvwwH9MJppbKFm81I0MGQ2KOYDx8dbZjzdDl57zDR9pVqa49qiZo6t65ZWSSkrfKB6zwEhtm1GwV2pEBI4Hu9dTtCFHcYXc1KOrjAPVSWnOP3xnYDFvZbtoJDgEvS/8lTvE0c2tpOybB+HXincg7HNd4+OdU2NjDY/y1mYrwYN0F5AoFAKwUI5XIiJet1pPyACIGDtxUR99rfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux1ccx0k19Cv6pSNDOvaZtddX5MspYBbtJrkbVRcrCg=;
 b=dB4Iq6yUGpPLznw6zCMBVB+KbbIjbg7GWdY6EDv7cYNCT/Siu1S8e9Z+674c41cxZUjqKZ2fO2q6FCiPlPAyfAxY1YoffkABWEr89hVcjREcCWWZwbcQKd4lBndcylCtN1mS7AKDvQzYyiaeaSl4M9MXTsyJ3g1qIiZEVfJpb7g=
Received: from CY4PR22CA0091.namprd22.prod.outlook.com (2603:10b6:903:ad::29)
 by DM6PR02MB3932.namprd02.prod.outlook.com (2603:10b6:5:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Tue, 26 Jan
 2021 09:20:20 +0000
Received: from CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ad:cafe::f0) by CY4PR22CA0091.outlook.office365.com
 (2603:10b6:903:ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Tue, 26 Jan 2021 09:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT010.mail.protection.outlook.com (10.152.75.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Tue, 26 Jan 2021 09:20:19 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 26 Jan 2021 01:20:19 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 26 Jan 2021 01:20:19 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 xe-linux-external@cisco.com,
 dwalker@fifo99.com,
 broonie@kernel.org,
 danielwa@cisco.com
Received: from [172.30.17.109] (port=32906)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l4KSn-0005b7-5L; Tue, 26 Jan 2021 01:16:41 -0800
Subject: Re: [PATCH 1/2] arm64: boot: dts: add new dts for hellcat & petra
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Mark Brown <broonie@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210121231237.30664-1-danielwa@cisco.com>
 <185100f4-67f1-140b-ad01-9997891e68da@xilinx.com>
 <20210122203240.GS3710@zorba>
 <849cc330-8545-f1cd-1715-5244e399897e@xilinx.com>
 <20210125210419.GU3710@zorba>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f2306899-f084-2cca-b67e-ed6255609597@xilinx.com>
Date:   Tue, 26 Jan 2021 10:16:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125210419.GU3710@zorba>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38ba5643-e59b-4b6c-99a4-08d8c1db9a0f
X-MS-TrafficTypeDiagnostic: DM6PR02MB3932:
X-Microsoft-Antispam-PRVS: <DM6PR02MB39327C1D9755DDB0D1F81C08C6BC9@DM6PR02MB3932.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HSuhA5rcmKnMHwn9lvIqTCLZ6jmiMRD6QGweephuIHozZln6QPPhvcPjnuSBKx1j8jjt/NIZWoblke49xigFlLFLrqdB5Unp04REgNF4Z74h2rQYvAkE2Z+NDBldMdlFjMU+JiEWIqHPsnBWTTXTHaG1b543NKKcxsVmYoQ+U+2n3nMFDvHj0jJaDQt+9jKxgnF1nFlUklFQ+m456AcVqcFBfY9Mg7TGCDZynaJZR01t/n5E7CFMAH2Jvas0QsSE8kKI0Mp8GeCXsnUzaxnnFoCWVzSNY3gY1NUq/o4Z0gr+BSvPjQzD7yAGc2tjAAw7HTmJbgaC2W3kswxeoTMPm8oUQUi7cwHd6bGwd26K0tQVh4N7u0IofIV3bO71Ln3/EbiFZ61oXRkJ1Pqy46yBzlf9DLOyPvMnku7AZvrjqUl8a86FFiZppFtIcFFnolwriImKh9pICEUmzf3yfITL6iv0dg0VakwgGpP5IHcPf2ucXzDbdrUpQ5nNGLhQtcWvRbFuqEiQE3PnYhWqX/9DA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(7636003)(4326008)(47076005)(336012)(6666004)(2616005)(2906002)(70206006)(82310400003)(82740400003)(356005)(83380400001)(5660300002)(31696002)(70586007)(8936002)(26005)(36756003)(36906005)(54906003)(53546011)(8676002)(316002)(110136005)(478600001)(9786002)(426003)(31686004)(186003)(44832011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 09:20:19.9007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ba5643-e59b-4b6c-99a4-08d8c1db9a0f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB3932
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/21 10:04 PM, Daniel Walker (danielwa) wrote:
> On Mon, Jan 25, 2021 at 08:52:01AM +0100, Michal Simek wrote:
>>>
>>>>
>>>> Long time ago we said that we are not going to push any PL related
>>>> configurations. It means all below can't be merged.
>>>> And there are also coding style issues.
>>>
>>> You'll need to explain this more. It's likely this was added at the suggestion of
>>> Xilinx. If it can't be upstreamed what should we replace it with ?
>>
>> No idea who gave you this suggestion from Xilinx.
>  
> Just an FYI , I didn't write this dts or work on it's original development so I
> can't name names.

ok.

> 
>> I had similar thread with Michael Walle about supporting Ebang board.
>> PL depends on your custom design and can change quite quickly that's
>> there is no good/bad configuration. That's why all of them can be valid
>> and kernel is not the right location to store thousands of
>> configurations (likely in overlay form). That's why only fixed
>> configurations for PS are added to kernel.
>> And I prefer if there is any good reason behind why these platforms
>> should be added.
> 
> I'm not sure what your talking about above .. Are you suggesting the changes in
> my DTS will change quickly ? They have been the same for years , we don't plan
> to change them. This DTS is not a prototype it's a released Cisco product.

I am saying that I will NACK all DT changes which target PL. No matter
that you didn't change hw design for years. You can add PL to DT overlay
and apply it in Linux or do it via bootloader.

> If I did delete this "PL configuration" where would you expect it to re-appear ?
> Typically things which aren't upstreamable are transformed into something else,
> it's rare that something is just removed and has no transformation.

dt overlay in your distribution, rootfs as separate file and base DT in
mainline.

Thanks,
Michal

