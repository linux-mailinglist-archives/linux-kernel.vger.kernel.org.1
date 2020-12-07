Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5462D0D33
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgLGJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:40:27 -0500
Received: from mail-dm6nam12on2045.outbound.protection.outlook.com ([40.107.243.45]:9719
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbgLGJk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:40:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzJ+m7T8DUhoCaxvDs8CAwMAKI0POr8NfsTgKnKHEyaxaYfNsqUhM3CyOR28e54n5B5k2pDH05aifxx4HXF6q/5XC4fP/1R5XrMaQ8aBggb32FqWiDCuJs+w8OzT/l8zkCU+iEXnK3/Ehh1cqxFc75BnGV7ahnTC/tJkFY338kLl+XTYQ49IT/hnn3vUOkmklLYYV5sydeJvdkcMhHISnS//iwl1jsQIrwxOj7ucf+3VUQMwD4CeBbfRsQV5roWiu5oM3qjHSSq8KVJtobAZQ18vIy+VB7002o2Ldf3y4I9u+LxUfwKHxicy3UjJ9OmkjNIyYvtguRyz0SekZZ/IPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+o6OKeeRuU69AHg01oe8fAxWhN/psz1ReNFd7cpcrk=;
 b=TXnTZb+XF8w63PwNBXwWTETFaEct+owU8CvN2AJ+cHg+eViSEbRqY2xHGbf2qpItJ9lvV6OFejxDWMQmIDxyJNqr0O4X1YAlk2iFuBiizkHd3RfxDYGPBnkncNAzTQAa5nB5MXQGaqY3cL+9Q4UImqIacPNa+sDUu0FFdqGMJsJSM9D2/IKlhzG4swoC9E+DnCvecn9cIxBbikL/HSRXb8jPd6tj/TzI/TujQyYHFJcbN/pFuFQWQZOnZVWluZeE7bYitO0R/HzAY72t0axB2yQfRXIXENFkTdq11SlgXck58bxnY2bgwLzHxCqU6M9bdwIlNCVitXzgqFDVsHQxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+o6OKeeRuU69AHg01oe8fAxWhN/psz1ReNFd7cpcrk=;
 b=p6+vNPd81qYHKzBuO2hdN9j29dhsPI4NDllts4wxKOd+pOnqgkvZIUhNkyqCLt/NiDivV3P4IKDcK/o9VYAUHzxKxKXUYHZzPQMJsGqgwSQZIaQP2T3vXVt8DiyuGy6DTtI3CWnFXbin5PD7IObJ1KvWtlYyNQcvPFMiFziobc4=
Received: from SN4PR0501CA0061.namprd05.prod.outlook.com
 (2603:10b6:803:41::38) by SN6PR02MB5341.namprd02.prod.outlook.com
 (2603:10b6:805:67::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 09:39:33 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::3) by SN4PR0501CA0061.outlook.office365.com
 (2603:10b6:803:41::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend
 Transport; Mon, 7 Dec 2020 09:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.21 via Frontend Transport; Mon, 7 Dec 2020 09:39:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 7 Dec 2020 01:39:30 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 7 Dec 2020 01:39:30 -0800
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
Received: from [172.30.17.109] (port=44180)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kmCzR-0002vY-HO; Mon, 07 Dec 2020 01:39:29 -0800
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
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 06/12] arm64: dts: zynqmp: Add label for zynqmp_ipi
Message-ID: <99008851-6c12-3acc-6530-25af08429ff5@xilinx.com>
Date:   Mon, 7 Dec 2020 10:39:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X81fXtxvsc7KE7cK@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52027ca8-6a5d-4cf2-52c0-08d89a9400b2
X-MS-TrafficTypeDiagnostic: SN6PR02MB5341:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB53416FAD3EBE7577E84C093FC6CE0@SN6PR02MB5341.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qeQaUxlXBXAAs8yfJFEJEUBcUK/+/GyIw4+3HRlOTPXZJDpZmnNbrpFughvh6fzzXOiQYG4XCTweCxVAhfyUY1MhXWqJm+xHMirxehIVX6QaH2pRjT4IwQrgDFqy2ajIOWsC2pCNfc0QTmjWyXTA7MCXjn+MRWmYtAxmFki0NAAeRbrwEaoDf9O7ABX8GELTQe6ah1JGtKFq6osVe7j2WHHE1kLxkk7xFSV33FoWJQzH0MBg/SbY1DDRDLxJgtBlU+hH13JNWufQbAIsEBAAh9a2qeOyLt74AdED0Ai2XGVN+2bgrhTJSBJS41qBzlWJk+D7668qeP/MjcTJmXsoJ4YT4/PifLRRurGNpTiqmkF6oUHVjP71YqqAmAH9T32VwdNFCV3hUZa2DLALyVDw14EKsXsU/jshqxbbD/ow6BTbp/HlWgK7i7l0xI+O98ecJPd28XJ0iM0zsOlZTLNcQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(136003)(396003)(46966005)(186003)(2616005)(478600001)(356005)(9786002)(7636003)(110136005)(82740400003)(70206006)(26005)(8936002)(47076004)(70586007)(54906003)(6666004)(8676002)(2906002)(31686004)(4326008)(316002)(336012)(36906005)(83380400001)(5660300002)(82310400003)(36756003)(31696002)(44832011)(426003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 09:39:32.9645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52027ca8-6a5d-4cf2-52c0-08d89a9400b2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5341
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06. 12. 20 23:46, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Wed, Dec 02, 2020 at 03:06:05PM +0100, Michal Simek wrote:
>> Add label which is used by bootloader for adding bootloader specific flag.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> U-Boot needs to add u-boot,dm-pre-reloc; property
> 
> I'm not entirely sure what best practice rules are in this area, but
> shouldn't U-Boot locate the node by name instead of label ?

Labels are not listed in dt binding and there are two approaches how to
reference nodes. Via full path with node name or via labels.
I do normally use labels which are much simple.
And also if you take a look how dtb looks like (convert back to dts) you
can see that for example aliases are using full path (just &label) but
clocks/gic which is the part of <> is handled via phandles as numbers.

And labels names can vary and shouldn't be the part of binding doc as
far as I know. But I can be wrong of course.

Thanks,
Michal
