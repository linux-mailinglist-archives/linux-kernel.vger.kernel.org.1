Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C62FE676
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbhAUJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:30:59 -0500
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:59968
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728688AbhAUJ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:26:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kg4QNJNRH6AZKn3MtMBxN6uY+jJC49XBaFOAcA3h5+aCJBtFXgDAlLiFPp6RMSwoGZ5hJJQh4pUNt/VLORzoMxuIXdWGHJR7/dQfqfuf4ejSJcTTd3FoA4hnMIRUkDYRGjm+bgCQ0e33W5Hr1B+323MnKIi7OB6+mnTbZ0HNQMscoDjTH2SWBjPxcTwOuSNMFjvvyijFLHJuAMvqOStiP3MjpARto3e6VS1wDFn4GzWooBmfdJi3B2AF4sgeTVsGEdv1sl6ALFXDzuHCGj6shM4/oeIS3fnB3kVkXxG96Qo8fr9QLTsuj4Hewjc5xmvCUExTZDy1ztLdTD6kOQsxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ3Gg+3Zn7mYCMiSxlvE6gso6Eeb6ZCM/zCkVKOW0Y8=;
 b=k2GTdH6Mc7cfLkLZWq1zNgik0Uexuv0kI+50FgcmGqLAqMcHzzj4Esepl+9WbEWco+Ww95Q09xuKqbvl5JR/o3KGICT60R6s4ZftT48nE+gvZMKDReY1ZjyqESdcKitESanmpp3ZM4wyR+VbQaeQNAkuTmsrfmvthRbpSrUJFmv4ckTGyd6EhonQ6fFpP9oLtYX3W3lCiHC91bF3yPiku/zRagdFWFpUX5401Get5cY5uexC93SQWt1ldR59SC/40xSlRIzeoCofFjTZXvYv2C12lvfR37bPgyViCATjsCDkPQqLD4WE4dcgi/lSk9r1aNQs+jc3Ww8eG2vGdqClhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ3Gg+3Zn7mYCMiSxlvE6gso6Eeb6ZCM/zCkVKOW0Y8=;
 b=SwPWxKWrKOMoL2lAz1YgQjnkngqMuJJfT68cegFRAleqxTQm+vgXVZerlmhQNZT0lv0mS1B8IXDw3IqAvDmIEZ8iS14LxXUJltWbbne7/lCIMulRPSyYa1c0hT9qmSKkSq0Rp4ejEoMDqkXizotVlaWTbrztxSZy7kd2r69a+CU=
Received: from DM6PR08CA0016.namprd08.prod.outlook.com (2603:10b6:5:80::29) by
 SJ0PR02MB7472.namprd02.prod.outlook.com (2603:10b6:a03:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 21 Jan
 2021 09:26:04 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::78) by DM6PR08CA0016.outlook.office365.com
 (2603:10b6:5:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Thu, 21 Jan 2021 09:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 09:26:03 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 21 Jan 2021 01:26:03 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 21 Jan 2021 01:26:03 -0800
Envelope-to: michal.simek@xilinx.com,
 soc@kernel.org,
 olof@lixom.net,
 arnd@arndb.de,
 robh+dt@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 michael@walle.cc
Received: from [172.30.17.109] (port=42074)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l2WE6-0002OZ-SM; Thu, 21 Jan 2021 01:26:03 -0800
To:     Michael Walle <michael@walle.cc>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>
References: <20210120194033.26970-1-michael@walle.cc>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 0/3] add Ebang EBAZ4205 support
Message-ID: <fff420d1-fc9a-23ce-0d07-58a3c6f10c4d@xilinx.com>
Date:   Thu, 21 Jan 2021 10:25:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120194033.26970-1-michael@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f52d5e02-6271-4036-c2c9-08d8bdee930a
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7472:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7472AFF50948F47461AB390EC6A10@SJ0PR02MB7472.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oMKDQ9Uxa8T/TysGswLKfrmWWbmyduxicZk6xOkHpaOiVb6GG4RQgpLhp6TOhigrTdLAbJeEqP1dnyFGvsQBFBSANfB8Is4yzqcW05kdz7NERT8HrTIx1nrLVCa9liXsXDm2JNvwB5H6MtkekazQWcdvJEgxuC3CWqt3MuQDYgzf6/NshuKKL1MHmuGoGb6JJ9aKHr97DG0lxgSJHS6XM4NuThcICOCXpk+a6lXNeBPMVlttTb8vl4hQO23DV6bWPv1okxHucu29U4HaBnHr7rJ/f0wdz+e4K6q0ygZUOaTSf5aX5Q5ZIRryBX8AleWz5Rc6879xHty+Hj4eL/6x0+wGpwhcH/3TxBzdoMTRDKq5BQl1g+4v7mVjwj8kOQAttn7EC/zsaNDhKI9m+z+SgZ95Zs55Y/J5lbBwRfKph9X1XSmDZwr7TGAynXkUgKrYN221JYrKim10DQ0NMFMN46I4s2VF4xYmEjkFxcP5Q98TpH88w5z5dVqVRga2uuv3lGG/JLw3elFGhLj0kFvA3ywGQzAq4CFYOvUzfuKiUU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(478600001)(82740400003)(426003)(44832011)(53546011)(36756003)(7636003)(70206006)(336012)(66574015)(4744005)(6666004)(9786002)(356005)(31696002)(31686004)(8676002)(83380400001)(8936002)(2616005)(70586007)(5660300002)(2906002)(82310400003)(316002)(54906003)(26005)(47076005)(4326008)(110136005)(186003)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 09:26:03.9107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f52d5e02-6271-4036-c2c9-08d8bdee930a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7472
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 1/20/21 8:40 PM, Michael Walle wrote:
> Add support for the Ebang EBAZ4205 board. This board was once used as a
> control board for a bitcoin mining device. Nowawdays it is sold as a cheap
> Zynq-7000 eval board.
> 
> Michael Walle (3):
>   dt-bindings: add ebang vendor prefix
>   dt-bindings: arm: add Ebang EBAZ4205 board
>   ARM: dts: add Ebang EBAZ4205 device tree
> 
>  .../devicetree/bindings/arm/xilinx.yaml       |   1 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/zynq-ebaz4205.dts           | 109 ++++++++++++++++++
>  4 files changed, 113 insertions(+)
>  create mode 100644 arch/arm/boot/dts/zynq-ebaz4205.dts
> 

any link with schematics?

I will let dt guys to comment 1/3 but series look good to me.
The board doesn't look interesting from description point of view that's
why all the time thinking if makes sense to add it to kernel.

Thanks,
Michal

