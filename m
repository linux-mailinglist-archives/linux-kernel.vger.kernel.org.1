Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C752D0D46
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgLGJow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:44:52 -0500
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:11040
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbgLGJow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:44:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkL/HVRiNdVktu7svvCURwyfPWPG0/QjOepqfH/jqmbMqz24+M01+DF9AaFbPuawrz3Z2LPI3obathbFVQRlvj4IIdmwW6nd4ZJpV8UuoAGBC1KBMVIhlh/qGCLCbRK5J5jw3bdkrYmo8VdUF3ajYiRoM5FnJaqHbq2cvtAam5JwBMZ13hoEfCa3AHYCPX8mM63SVTCIuwsZP4krVCp9oyWqG3f4TTF0uNEE6Qc6Ibgr8gVRMX8LludCL1HsWesaVGDHybuywiiRabti3gYEN+Tu2xYZtiG1Fa13ozgK8yeWS7XBtoXH9qYh/z/Y+mmZEnxkgPR1hc2mQy4LboM3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/Yy1WOLNI7WGFe6bTMWyBcgy56mDktoCKquvexUJ8g=;
 b=Ji1LyPUgsZUZY7RTFnq5tE3iLo+8KRf9fIVmnRFlnv7lEYWsjtt4Mu9TIHqBI2s7sKzVyL9jTjiljFrRZY/aQE7cRhovlSmy2ccJ9FBhxmdCK9+3LujjSorHJEYvH8UYd3Uykg+zGs0+UUJ2EbDozMFU8vgdmEP53oYUjbV8nj1HBW/64buzSC0jRJ4c1FYq8fzhGkPx9a9aAS87Q7639zwmpBkqYEmT72jpk7KD1UHHM09m6Ilf3glVkwIDC45Bsda306bIctJRNCuo884Tc2bO35bjSxvaFaP+nx/VLQ8KsnwpYY4551BrZe5hfxDthcmxs/Z033+LsI5CBBamEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/Yy1WOLNI7WGFe6bTMWyBcgy56mDktoCKquvexUJ8g=;
 b=LePS8ZAg+NkkQ78Ll0JtfUYBg4NnxNw/MtB66Ww76+KMvEk5tLobYYbI5I/b7Td/Vh06UVxaeCumUOu4rKYfbNzO7sqLmCKZTogB3LVmt7QP0NPQu89pMNuHTCB61SGeJJoOk+fhVM/oeggWqLy1p7ii06S/6L02HccAzPv7U4Y=
Received: from BL1PR13CA0481.namprd13.prod.outlook.com (2603:10b6:208:2c7::6)
 by MWHPR02MB2799.namprd02.prod.outlook.com (2603:10b6:300:107::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 09:43:59 +0000
Received: from BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2c7:cafe::a5) by BL1PR13CA0481.outlook.office365.com
 (2603:10b6:208:2c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.10 via Frontend
 Transport; Mon, 7 Dec 2020 09:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT009.mail.protection.outlook.com (10.152.77.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.21 via Frontend Transport; Mon, 7 Dec 2020 09:43:58 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 7 Dec 2020 01:43:43 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 7 Dec 2020 01:43:43 -0800
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
Received: from [172.30.17.109] (port=44528)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kmD3W-0003T2-S1; Mon, 07 Dec 2020 01:43:43 -0800
Subject: Re: [PATCH 06/12] arm64: dts: zynqmp: Add label for zynqmp_ipi
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
 <X81forerb/QuXB2U@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0c35fcf0-145e-b3a9-9af9-a5f60ede10c2@xilinx.com>
Date:   Mon, 7 Dec 2020 10:43:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X81forerb/QuXB2U@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4659a6d8-e9c2-4380-33ec-08d89a949f25
X-MS-TrafficTypeDiagnostic: MWHPR02MB2799:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR02MB27995F94016BDF404AF6EEE4C6CE0@MWHPR02MB2799.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AandRqEsTWom7sbyi9PQ4dgf/Xi8DPaKi/j8oqfPjnEMpHcSWD/LD9DKZDalinXHKkn1vL/DzI52KUGPgtv2X1e2ZeblfzbVoepOlVozq1sBrhV5PJy7IcjEkWTKvT2Q2S0Em+5ZnAK+EiGxmKUojetvp29lGPJmMjZKttF9ZSu8SKNJAbQFAG4dOZkkJS4KQ1ew7W/azn+6tv7aINCxuu6O4mhLKBQhHum9ORT78yAkW8FSUo0GMPahZLDhaLFowk6Q2y6QKzwLelAOhYGkmfpoQWugRvXEkq2qaSsSI+lM8MUydegxCj4oZ8QL0fCXvAX7Q4Zrjturms6UUWai6iwHG5mv1iT0D2rgoUOgroJ5IRl7MD0mIfHGtuDtwM7cYJ9BGOHr99alzy7QkQdB3jYa48BgW9eDxdFldRzVtd0PdNC7puGCv9IXf2PFBtzxFqS2AZR409vMLg1UuXQlEw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(396003)(346002)(46966005)(36756003)(26005)(8936002)(186003)(9786002)(44832011)(31686004)(316002)(36906005)(426003)(6666004)(478600001)(82310400003)(5660300002)(2906002)(336012)(82740400003)(110136005)(2616005)(70586007)(54906003)(4326008)(70206006)(47076004)(8676002)(356005)(7636003)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 09:43:58.7358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4659a6d8-e9c2-4380-33ec-08d89a949f25
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2799
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06. 12. 20 23:48, Laurent Pinchart wrote:
> On Mon, Dec 07, 2020 at 12:46:56AM +0200, Laurent Pinchart wrote:
>> Hi Michal,
>>
>> Thank you for the patch.
>>
>> On Wed, Dec 02, 2020 at 03:06:05PM +0100, Michal Simek wrote:
>>> Add label which is used by bootloader for adding bootloader specific flag.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>
>>> U-Boot needs to add u-boot,dm-pre-reloc; property
>>
>> I'm not entirely sure what best practice rules are in this area, but
>> shouldn't U-Boot locate the node by name instead of label ?
> 
> And regardless of what mechanism is used, it should be documented in the
> bindings.

I don't think we should be documenting labels because names can be
whatever. DT binding spec is just talking about name rules.

6.2 chapter.

A label shall be between - 1 to 31 characters in length, be composed
only of the characters in the set Table 6.1, and must not start with a
number.

- Table 6.1: Valid characters for DTS labels
Character	Description
0-9		digit
a-z		lowercase letter
A-Z		uppercase letter
_		underscore

Thanks,
Michal
