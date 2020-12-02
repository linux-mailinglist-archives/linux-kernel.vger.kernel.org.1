Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE392CB5C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgLBHcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:32:10 -0500
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:11105
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgLBHcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:32:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpP3Z3r+ov8racrnZSqFufcPJlEZn5GEejetnn4BgzX+jsSg7dmh2vlYDYxurHdpLzdzszz4Ryzg/IFxnPm01OagcpacX+1ByfipWRe9kfl9U6xzXDPDq3sX/Qq8di4Ipivk6MbXFQdHfmoWhrvxA/KWxU/hbkvAYx1NIe0ZlKdF38fi8oJLQ1gGOdbYt6vFfU9pWrmziQbU41endhmiAf7TYuGLWdyB2jPjio2GemGaCxErQe+G2cEAQ4M4tH3yUDSFz4XgVL39aOIOvdhL/GgaO8V+1SjA9s/1XQn334f6gy/FIDAd5jW25AZ8TIXuNG7rN3mK1ty3Gnz02Hzsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqj/4ZDm+yPr83taQYA59DMtTHaXi4x+s56agp7EzcI=;
 b=Mh2TNW0IAtBvOylAkasZGyzv2ZZxxmwtmnZeNRs8tCvru3QMf1V2kcFylv6pnq/RmSVg2ZdU+tfQV40PWx85wwnaE59XdhXMVBkU7CwyPsS43z2JPla7uaQQKzSRd6mXQWwlqBvA1Ka4WLp4bd+jvesPrVVUHPs0tJyYjog5xhjg0Hojb3BL3P4MDjpXDPGxxZUFcDM/NLPvREfYUxuOSV56HWbbf3W3DyUiZWbnAcD6XRTrg8gU1CMtNEGjlU4BIojm+ry0Sb5TWSoAjfra6FT6biV4wKcWTRNesA6+FESSJ1FRlX7nLMFj6o6G4GhvIeo/5UR+LZWC2NFkD6g4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqj/4ZDm+yPr83taQYA59DMtTHaXi4x+s56agp7EzcI=;
 b=cXVcetya11nwvF8TFW/o9ghgTG3J6WnICsTble2CLdJTCe6eKA0cZFxwkDFMCt5yWJ9JTb2fNfAzCn/ACC7TpCZbGsAqJHbSj8i3X/eN/aBFGR976d66vx8XN/d675HvvQvBz7qy9rVrCZCxgXqYFnuS6o3AkYmPaDnSebtLTaI=
Received: from BL1PR13CA0472.namprd13.prod.outlook.com (2603:10b6:208:2c4::27)
 by CH2PR02MB6070.namprd02.prod.outlook.com (2603:10b6:610:6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Wed, 2 Dec
 2020 07:31:18 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2c4:cafe::62) by BL1PR13CA0472.outlook.office365.com
 (2603:10b6:208:2c4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.8 via Frontend
 Transport; Wed, 2 Dec 2020 07:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Wed, 2 Dec 2020 07:31:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 1 Dec 2020 23:31:17 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 1 Dec 2020 23:31:17 -0800
Envelope-to: manish.narani@xilinx.com,
 tejas.patel@xilinx.com,
 rajan.vaja@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 zou_wei@huawei.com,
 gregkh@linuxfoundation.org
Received: from [172.30.17.109] (port=54052)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kkMbc-0006EX-UX; Tue, 01 Dec 2020 23:31:17 -0800
Subject: Re: [PATCH -next v2] firmware: xilinx: Mark pm_api_features_map with
 static keyword
To:     Greg KH <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Zou Wei <zou_wei@huawei.com>, <rajan.vaja@xilinx.com>,
        <jolly.shah@xilinx.com>, <tejas.patel@xilinx.com>,
        <manish.narani@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1606823513-121578-1-git-send-email-zou_wei@huawei.com>
 <65ea30eb-2595-4af8-09c2-6d352b9be509@xilinx.com>
 <X8a067jdynVt3Lvg@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9dbf2dd5-40db-3cbf-4d53-b027435ccbfe@xilinx.com>
Date:   Wed, 2 Dec 2020 08:31:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8a067jdynVt3Lvg@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4489ad4a-a06b-4f14-2562-08d896944210
X-MS-TrafficTypeDiagnostic: CH2PR02MB6070:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6070294EA562D18A25160853C6F30@CH2PR02MB6070.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTQk2LVYJl893Xe5Y41YISOEEQjR+KDKUadE4bOSTLfQUL48HYfTgaA8QrooAUG4naUXS4slbyN+CQFpdxZ3T4U5f5tCVp7vlDcAktREkN7FrOtl2lG69BQNIr5Ernb0RpzyhKOWvAMPTtmbw3gocTcds36scBfYpFzXSnVoYk8+uunfMCVTm4O7yJW4IihUFyEQ8ETf3ZgX8T2TKIf1Zs8gD2cUpdZfpeHDUsZwu6vsJTw/kw/c2eykNQsBs+WQDOZ5haNSvJC3T/QFdkKiY+0bw0WBRXCF/LUoVWqu2dpew/iaZQWQ6Vm5wa7pEXYPSkbTLB1nN2f0kdU1AeYb7DyyCkLuhguY5Bg3pao/m9B9A5KNW/aBbvi3St/+NiRH/xlB6mVvdcC2ziL0+Bk5ypSu15E6HuumPOsmOulzqUBTjq376H3EsPkCmTw1t3lVlHZD0BB3bC9g8ytVyFVTIw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(336012)(31686004)(70586007)(47076004)(5660300002)(9786002)(2616005)(4326008)(478600001)(82310400003)(426003)(2906002)(356005)(31696002)(110136005)(44832011)(8676002)(54906003)(7636003)(26005)(186003)(316002)(8936002)(36906005)(83380400001)(6666004)(70206006)(82740400003)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 07:31:17.9186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4489ad4a-a06b-4f14-2562-08d896944210
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01. 12. 20 22:26, Greg KH wrote:
> On Tue, Dec 01, 2020 at 01:03:59PM +0100, Michal Simek wrote:
>>
>>
>> On 01. 12. 20 12:51, Zou Wei wrote:
>>> Fix the following sparse warning:
>>>
>>> drivers/firmware/xilinx/zynqmp.c:32:1: warning: symbol 'pm_api_features_map' was not declared. Should it be static?
>>>
>>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>>> ---
>>>  drivers/firmware/xilinx/zynqmp.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
>>> index d08ac82..fd95ede 100644
>>> --- a/drivers/firmware/xilinx/zynqmp.c
>>> +++ b/drivers/firmware/xilinx/zynqmp.c
>>> @@ -29,7 +29,7 @@
>>>  #define PM_API_FEATURE_CHECK_MAX_ORDER  7
>>>  
>>>  static bool feature_check_enabled;
>>> -DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
>>> +static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
>>>  
>>>  /**
>>>   * struct pm_api_feature_data - PM API Feature data
>>>
>>
>> The patch is good but I am missing fixed tag to get it to LTS.
> 
> Why is this needed for any stable kernel release?  It's a sparse
> warning, no one trips across those in stable kernels...

Ok thanks for explanation.

Applied to zynqmp/soc branch.

Thanks,
Michal
