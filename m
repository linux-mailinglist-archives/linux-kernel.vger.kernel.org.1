Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669EC2D2457
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgLHH14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:27:56 -0500
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:54855
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbgLHH14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:27:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mu9fSHd1QW1vU5KZui2XtpTF8BPR+oMO2dFdcixIASAB9hYEXVOniRNRHLlM1zp4UVP2I7AZaK6rizNZTEOiQHvsk4l7adKHCV86xu1DWPHrnzDFiGGQrXxZ2zd8GDhbV9+eNuyHx6SS/jV5tfsmoKAxqPvBgxgfN7HvI6ogXUB6MiK+7cNLbMhCrEZRZJrE34Pk87KJ1jObRlG4Yhs2TF+1xVasblMdNqsmsWE/VBMmNIx1AXQzk0Il3wzDe8KzL31GH9sdp9eF922TO/Dzpo7Wo9rKmFvv/NB+WLKFEcvoLHYdzAKp31UM66cicvlq78pEzRX0LBCflAQZz2BV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIwotGCQQjejC7YTj4qfHU3GmsNZ0GSFnsEvSnJyup0=;
 b=AZYm9XWOqvPMTFgHYdLEaPwrj3VCWhWUU6fNgZLkXafVSeQqa9j5iusLRZ0MLkP9mPj4IYnjTZiEWD/ckZL0mZUuq/MonyVLJSu5CU/UQYiMk4UiTG1tjGaMMvXV0KR4FQ7Ng6vJo4YwJvpVFbIqDeWaReRnUnpnn4g8BkP1lk8nKZIV4PFBPtunDUuo+55o+KOs+M0sB4jVQKklcWSXMZjb6YXUHJdb5OvtmvneHLO2zAe8SRwnz3KoPs4vL2yO3uY9MFy//h+RfbR6Y5To/QZoTn8l1pNqHv2DwUAvfOCReWbwWPHBjkC/J5IzlC3C+sNiqC7owNCwdBKolcvKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIwotGCQQjejC7YTj4qfHU3GmsNZ0GSFnsEvSnJyup0=;
 b=Tuc/xTZ9J1xZSCpxyqZtrq+YKWFfBAo3LDgHkDu6tgpFv2ug/kTiaHhEJChPNi0H47Ib/dkJld7jpTr9t5QpMmWBYp1NXO5mLSTL9p7mqUsTOpvrR1Kw5OhdvV+WopJnK4Z5RiZci1TKo+zf7GIUemdzgyuWE1Ju00SJF1d2cK8=
Received: from SN6PR08CA0028.namprd08.prod.outlook.com (2603:10b6:805:66::41)
 by SN6PR02MB4781.namprd02.prod.outlook.com (2603:10b6:805:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 07:27:02 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::37) by SN6PR08CA0028.outlook.office365.com
 (2603:10b6:805:66::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 8 Dec 2020 07:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.21 via Frontend Transport; Tue, 8 Dec 2020 07:27:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 7 Dec 2020 23:26:46 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 7 Dec 2020 23:26:46 -0800
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
Received: from [172.30.17.109] (port=42068)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kmXOX-00032f-OU; Mon, 07 Dec 2020 23:26:45 -0800
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
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 06/12] arm64: dts: zynqmp: Add label for zynqmp_ipi
Message-ID: <4010c2d4-bee1-827b-1079-1f1bbf1f10d1@xilinx.com>
Date:   Tue, 8 Dec 2020 08:26:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X86poiQSzv5Uva1r@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e62111-2264-4241-960f-08d89b4aa832
X-MS-TrafficTypeDiagnostic: SN6PR02MB4781:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB4781C08AEABD7B62F16F443FC6CD0@SN6PR02MB4781.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8xncvd4SEDzVesXCYyIFaqHX8m6mQDARQA51XGddo4NwSKxPEOZfdNqxTR8cMdLBYieCRUD+0gj5XFH9S4Ff9KwQ3eJc7pWn27TqLQ6Q1rMc/MN2afT0XoXr/L9eiIgVAeBxXAJM9DbBKMl7QzYKwE/foEhq5dncicxRvnKz5lKy+P2iZ461jH+tgZNoZOSofkTvzzWc9G5XHHFLy5ABnN6BxJkeg7bkvWpbWcVjYCeYlE2+eUf/iI/5WTJQ0SccCk/REvvz2kOOK+/RhCVaC6YnQDD1FF0ZVMy8wIzFRdSeFfcJha4qhevO6Fl3FUFXu4UF0prb6vSm96bWTCiMmuYwzbjRzmah4xQX3NosaCq72uuoPWH4JbToBArXKXkolk7j4TvsDC+lBa6jMwZpC+Fgl3vLRmQrtLRHTnoU/5ArUuVXUxWyKKTslOVROz8VTmYD6SYm3noW/zBYYUijQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966005)(70206006)(36756003)(83380400001)(8936002)(6666004)(70586007)(4326008)(26005)(31686004)(5660300002)(82740400003)(426003)(44832011)(8676002)(478600001)(2616005)(336012)(7636003)(36906005)(9786002)(2906002)(47076004)(356005)(316002)(110136005)(31696002)(186003)(82310400003)(54906003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 07:27:02.3888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e62111-2264-4241-960f-08d89b4aa832
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4781
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 07. 12. 20 23:16, Laurent Pinchart wrote:
> Hi Michal,
> 
> On Mon, Dec 07, 2020 at 10:39:25AM +0100, Michal Simek wrote:
>> On 06. 12. 20 23:46, Laurent Pinchart wrote:
>>> On Wed, Dec 02, 2020 at 03:06:05PM +0100, Michal Simek wrote:
>>>> Add label which is used by bootloader for adding bootloader specific flag.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>
>>>> U-Boot needs to add u-boot,dm-pre-reloc; property
>>>
>>> I'm not entirely sure what best practice rules are in this area, but
>>> shouldn't U-Boot locate the node by name instead of label ?
>>
>> Labels are not listed in dt binding and there are two approaches how to
>> reference nodes. Via full path with node name or via labels.
>> I do normally use labels which are much simple.
> 
> Note that labels require the DTB to be compiled with the -@ option,
> otherwise they're not present in the binary.

U-Boot is using different concept. You can see that there are a lot of
-u-boot.dtsi files in dts folders. These are automatically included to
DTS before DTC is called. It means you don't need to build overlay to
get merged.


> 
>> And also if you take a look how dtb looks like (convert back to dts) you
>> can see that for example aliases are using full path (just &label) but
>> clocks/gic which is the part of <> is handled via phandles as numbers.
>>
>> And labels names can vary and shouldn't be the part of binding doc as
>> far as I know. But I can be wrong of course.
> 
> The DT bindings should document the interface with the operating system,
> and if applicable, the boot loader. If the boot loader requires a
> particular label, then it becomes part of the ABI, and I think it should
> be documented in the bindings.

We have been discussing with Rob some month ago but didn't have a time
to do step further. Just keep it short Rob was ok to keep bootloader
binding inside Linux repo.

There is no hardcoding for a particular name. There is just a need to
have any label. U-Boot needs to have one property(e.g.
u-boot,dm-pre-reloc;) just to do early allocation.
The name is just reference and none is really looking for it. It is just
a way how to include it in much easier way.

Thanks,
Michal

