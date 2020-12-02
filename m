Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844D72CB5D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgLBHjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:39:10 -0500
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:10285
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728812AbgLBHjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:39:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D80OB+2r8eQ76CcAr8WGuvgSE8jwizFnu/OMy0BjNYQr+PQADkUPKXzKynG0D/cjWrKRYWqGMHQHR+SrdF/468k6TCUl4jyNW7TSpOuDHIwxv5wL+DrDkECbNNwrWTGy+5Wrz7FWPYhmu8krG1InWnM2dYEqUvj31LlKZI4Ev+Z/u/vJMriCcUqYNTBtAx9dmFoFGjggVnWS9OJ39XK1jFWSVrGLop97qKZGWAHdqc2q+RwVRF9oPdBWrwEQ5JzlYVtz9N5C2L3TZfIINmjpz0sWm22K1OlZzYD6aryKOABnrV+/6SXsOPDubNEKbg146GQoND5ZEezreb/okDE9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s3530ouKGa8l8CJCsNxrZB7jpzQ2pm8aRdHKfOr8f8=;
 b=Mkdv3ZitdOUo9WHR89MGIyeJkGRRqk8W6Y2bNLC0+Q6Krwe7pCwloxODp7aIKd4jTy/HdKFaonSuqxOjdOubYDhiK5AZDBL2rFEg2TnYm9YC1pHX/Ne0vAcvOHpvSp8aDIGf1onFlnBcefBgKIRQMEjdsEpDRI6Uy1V73U0FZ74dE+F7MngFAB3AvBCHOenL4KI5m4JhSwuigzHi1q98+bbFE5ktgRObvj6b2h2jC1LU81XmQ2WdUO+FHumD1zCH4PHxqhhZAAFiseUvXH0PUx6SOgsxnON9U7t7RpkmAIxabHsVfFZLqUZjLirW5RO5zKiwEwI+SIgjTFeCHgZXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s3530ouKGa8l8CJCsNxrZB7jpzQ2pm8aRdHKfOr8f8=;
 b=tPtMYnlZp+ngO9VTvHpD4T/9it7Oz/xV0Jjnwuf9PPK2KmHMrA3IZ5RRlV1eCWEtDqRBhksAsmCsZFiYVg42jP2M5UoKASB2siXNJzp7NQAL40D5Hzwu30cIywF6B+xOTPTJxqxiTfK/WSM0pSebLuLxyD/Yaiq/bLoMAsstRD4=
Received: from SA0PR11CA0067.namprd11.prod.outlook.com (2603:10b6:806:d2::12)
 by BYAPR02MB5464.namprd02.prod.outlook.com (2603:10b6:a03:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Wed, 2 Dec
 2020 07:38:14 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::f6) by SA0PR11CA0067.outlook.office365.com
 (2603:10b6:806:d2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend
 Transport; Wed, 2 Dec 2020 07:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Wed, 2 Dec 2020 07:38:13 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 1 Dec 2020 23:38:12 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 1 Dec 2020 23:38:12 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 tejas.patel@xilinx.com,
 rajan.vaja@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 joe@perches.com
Received: from [172.30.17.109] (port=54644)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kkMiJ-0008AK-Is; Tue, 01 Dec 2020 23:38:11 -0800
Subject: Re: [PATCH 3/3] firmware: xilinx: Properly align function parameter
To:     Joe Perches <joe@perches.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1606837822.git.michal.simek@xilinx.com>
 <fb0a22fd12f6a1d69e4e66aafba5b84859d4a60c.1606837822.git.michal.simek@xilinx.com>
 <83c7170c7ce6195dc73dcf813965c3e4a99fa4ed.camel@perches.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2f5a0baf-e45b-2687-cff0-922e55fd6930@xilinx.com>
Date:   Wed, 2 Dec 2020 08:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <83c7170c7ce6195dc73dcf813965c3e4a99fa4ed.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3886a0a1-4737-44e0-1839-08d8969539ff
X-MS-TrafficTypeDiagnostic: BYAPR02MB5464:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR02MB5464A29D8327A301D660705CC6F30@BYAPR02MB5464.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRq6n5IG2C6rGyQfVFTAcxEITuUsdkYoGkVGv7kwI/to4aI5p0Y4Ix8Dty0sCjGcivXbiZiRxEMSkbrFE2SsS0JmpBmW9esCF/8YlE6ypAmIboIas1QUWuLov3DAzYbV1Z90ypEuxi5v1Gzfr6WZ9XS3YyPkPTgzn91XX/qzb02bqSCJ/fSKerZSz6Z460aHBuv0Y0FedBfrs/KQQaubYay0uzr9fFMvEoLiKHNApjQXoGeyMubsie4lw9DA/u8CoGnFwUK3ad0gS0n/GAGP7qCyGSacKdPQG5u37+ymPExgVJ7FfTgsnyEiRsCnb+vzgXMhpTKFVn32ULqm5L94IZ+9rfxzbtBilCY6b5xLWRJI3IC9t2/bIV8Ue1n1KId6ob0AuYpcWD2RfoNQBV2y2NUwT993M3ibJz2pk9UojO6JR+KfwACgdXKixPEBZFK74wIz90Cj9S+BbugGK3ovUA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(26005)(186003)(54906003)(9786002)(4744005)(356005)(82310400003)(31696002)(83380400001)(70586007)(70206006)(478600001)(110136005)(8936002)(2616005)(36906005)(7636003)(336012)(316002)(82740400003)(426003)(36756003)(6666004)(47076004)(44832011)(6636002)(4326008)(5660300002)(2906002)(31686004)(8676002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 07:38:13.9428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3886a0a1-4737-44e0-1839-08d8969539ff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5464
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01. 12. 20 20:42, Joe Perches wrote:
> On Tue, 2020-12-01 at 16:50 +0100, Michal Simek wrote:
>> Fix parameters alignment reported by checkpatch --strict.
> 
> Please use a newer checkpatch as the 80 column warning
> isn't enforced quite the same way.

I was using it but saw 80 lines breakage in editor that's why I put it
there.

> 
>> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> []
>> @@ -456,7 +456,8 @@ static inline int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
>>  }
>>  
>>
>>  static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
>> -			   const enum zynqmp_pm_reset_action assert_flag)
>> +					 const enum zynqmp_pm_reset_action
>> +					 assert_flag)
> 
> I think these changes aren't very good as it separates
> the type from the variable name.

I have retest it and I can't see any warning when they are on the same
line. Will send v2 with fixing this.

Thanks,
Michal
