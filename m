Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6772F1DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390407AbhAKSZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:25:01 -0500
Received: from mail-dm6nam11on2137.outbound.protection.outlook.com ([40.107.223.137]:28680
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389992AbhAKSZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:25:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXyUvgOJLCt2mcx7AitqXzTDewHGvadyshvjuLrLLR8M0/RRrH1uoMyJc59qZahE/KCrO6Dq8o3cYUWUftxxh2RwtRj756S2XxYAxXwENF4SrL5Y7lZpsU7TN/1+4GTzuRl4ZfnuAB+tTK58i01jd/eb5Es2D20M/8mcaCIpN/vVhQ1eJkBMTHU/QL9doLq0iIMLv3N9ejczXPGDKqwB28j8PAIw3GpBppAOY1vLLNJxG0JfvGH9AgBj4fDe4J9iJLA+CsjfGDs/crudmGdc/tk+QPQLaiYFATwc3bB8pnyb73HjWWHh3RFlrts1AjliZ9XOdqnR0t5ys3kHpnu05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdPxlv6yCvB+JhkkFsWDxqL/GnBXdGx+PBxToNA2ask=;
 b=K7nK2T/OEkzdqCKlU/4F5W0oKhlhkQGi6GzxNZVFQ4w2uCp0QJfV0lim2IwneDIbZDRwSD0OI5GDIWqATdtr0/Vwx7ia79exIDZrrBj5sBysphNZzPKvwp32BotNDm4242I9jdeA0mGRRrL8j4mTIamDwXQtPx1Y6/tp1r2o79FsruTqKSE0yFu/Sc+RTfFIeLfzgqvjT49y0fVHmNtmU8NfC3r4GhlbcWmy2Vn7UEATKCqydrkLaY2GzyogxALQthDmbTddyE8AQqQ2G0SqGe7uFhIgnbiaKZahDwb93spj+E3bKXHLnSJgXnqDyxvqZv6fseiegPc87RNxllRoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amperecomputing.com; dmarc=pass action=none
 header.from=amperecomputing.com; dkim=pass header.d=amperecomputing.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdPxlv6yCvB+JhkkFsWDxqL/GnBXdGx+PBxToNA2ask=;
 b=FCJ2C76lJN/NZlefhEJziNIz/5DN9vWin07FQeCF4pVxGYFYFndYSAE2k6HuQPly/1vUXIfHat6jmr7NfbFrnOIu3BlsD4DjFm1L+wgbBER3s/J2b8kIglXK+nK76IpovN2FNWaZmC1/3c0ivU07cWSvHmcje+CfvAB26F1fjJ0=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=amperecomputing.com;
Received: from MW4PR01MB6276.prod.exchangelabs.com (2603:10b6:303:7d::20) by
 MW4PR01MB6097.prod.exchangelabs.com (2603:10b6:303:7a::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Mon, 11 Jan 2021 18:24:06 +0000
Received: from MW4PR01MB6276.prod.exchangelabs.com
 ([fe80::e458:ec66:9b0c:df0f]) by MW4PR01MB6276.prod.exchangelabs.com
 ([fe80::e458:ec66:9b0c:df0f%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 18:24:06 +0000
Date:   Mon, 11 Jan 2021 10:24:03 -0800
From:   Vanshi Konda <vkonda@amperecomputing.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, patches@amperecomputing.com
Subject: Re: [PATCH] arm64: Kconfig: Increase NR_CPUS default to 512
Message-ID: <20210111182403.4tscmqc6yxceafkq@con01sys-r111.scc-lab.amperecomputing.com>
References: <20210110053615.3594358-1-vanshikonda@os.amperecomputing.com>
 <20210111105636.GA7071@willie-the-truck>
 <20210111175741.ldifmv7uhdekbq5d@con01sys-r111.scc-lab.amperecomputing.com>
 <fb9542df-19cf-4db7-d112-0917e5b65e9f@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fb9542df-19cf-4db7-d112-0917e5b65e9f@infradead.org>
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY1PR07CA0033.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::43) To MW4PR01MB6276.prod.exchangelabs.com
 (2603:10b6:303:7d::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (4.28.12.214) by CY1PR07CA0033.namprd07.prod.outlook.com (2a01:111:e400:c60a::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 18:24:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 057ad6c9-0f23-4f23-2acd-08d8b65e14ef
X-MS-TrafficTypeDiagnostic: MW4PR01MB6097:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB60979E1D449CE67EE5BA641BD2AB0@MW4PR01MB6097.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swuOeUIVNyqPC4vaOtHzievGiGxOazmbtF2RhWZVZhUbipDBNYc952REWlNhCNvX3nBreDUcvvpQwMl7kphB895IEJqR6M5RmaZHUx4oQ+UXPvpTBl66XFYH2YYzLZZjeNJ6OBRTS1ky3IdxPq3xLsBkAerJ8gqYECVzBeM39pcKTt6B6DYh6tjhk5czz5Oz2yKdsxyIFqPwQqPp+tBE4HnamiJ1K09kUrwZHQ4Rtb8ih516RGIBNQb/nm+j9prROA9uk+sJNKxP2EFlzbfNH384p4VHmLZt586zEOkhJrSKt6iwDX4piVYkQHl5WpQs44NBsHVoY5xLc2e2VGHABt6jbuJj+fpw76SsbU4IIBo9Uu/TLrYESYobzxsO4u7fzBje8AF3IKSD+v0TC8gPfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6276.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39840400004)(186003)(4326008)(16526019)(52116002)(6486002)(2906002)(6496006)(66476007)(8676002)(1076003)(316002)(66946007)(54906003)(8936002)(6916009)(26005)(107886003)(66556008)(86362001)(83380400001)(956004)(478600001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hAnWkrpBR56eG9ufyp9cy2CnKaeCMTeUr8VxkDkfX/SpahzoCYbwRChpsKmw?=
 =?us-ascii?Q?13/Z3UPupCmLhOlXJmDhhRSBr/n3IFmBhpoqcz5LLEmg6EpmiqPZFvMj7L70?=
 =?us-ascii?Q?3q25LA+BFhNC9Rhtvlmb1s9dVTwBBtwsEy4110W7R6mn+ZXeTavGpGdyQEVG?=
 =?us-ascii?Q?hXZrDcy+QufCU1qqRVZKDZYJgpOjVtQmmefndsyEh4qsmrUjHsY15x1u7Lqu?=
 =?us-ascii?Q?nVOBZ3FBP+mlwuDbcMAxVXSDGkEIIplExPHMBsPKRhq8RLS8JN4HJ+UtRxTo?=
 =?us-ascii?Q?bwVrYBxAOD0I5OxAeRme1sWZgtQhwrWZ+s63vGbVMTNbu/dIcpGvir1VCo12?=
 =?us-ascii?Q?JzgbuNBu7tJyiEsmmfaWI1Oo0cZXxZ7LJvqSBSkarroWgbPPK4bgpPub66TR?=
 =?us-ascii?Q?yAdfGxWYTs40OyNfOs9ABwFl7ij1utuRCHuQkX/qX5NOWlJEsRZr+RfgT7q1?=
 =?us-ascii?Q?8NWMQ/Kd9AurrwmQYuEzkMZ84pR2090EUVuD35BcAqIDn/lRE0e5obYvoLvm?=
 =?us-ascii?Q?DbYis8fQlQ/LaCtgyfXrtmUonwYUnVDR9S+S6C8obUftYugPOeZHstaOVIF8?=
 =?us-ascii?Q?IatzBVYkm3lBCwj3m4NwxcnSLSrSzzr/1n/kfhkPyj+vHem3McK52AkKe4OI?=
 =?us-ascii?Q?NKekZ8Mr4kvd7z9+Gmq/ZoLyQrCLGfKB4Jg1WwjpbiNUeg9zOoej3PpuCk0N?=
 =?us-ascii?Q?LEIoGRIlATnFUt+Zp3DDpZ/uI2qhTPY0vO+Afv7w9/6zqcs5zHlurD+0FZJh?=
 =?us-ascii?Q?6AucRLZ39UYUAMcMRgrGTgvV4CgiAo/q9pLmHtBqla7seF6INJYOgw7yXnta?=
 =?us-ascii?Q?L/OIvGCBMVbkDHIw/TsAoq/8RhMdpqEYayGw2LllHa+F4nTVK/fdUe9EpeuT?=
 =?us-ascii?Q?Sz4AqI69fNPLNlYglWlOGHDth4S50mYeszqEc6yfA7MzfZV+1geXXCDMcmOg?=
 =?us-ascii?Q?cJTUv3PR6WxuctkMbAkiQ3wLpd15Vj6wtZfrqdHgW89EfqPLC0WZh+71IFDl?=
 =?us-ascii?Q?mSL+?=
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6276.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 18:24:06.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-Network-Message-Id: 057ad6c9-0f23-4f23-2acd-08d8b65e14ef
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ljHjbcvkpnOVTlQxUZ2iI3us6k6vQ3XmJOq4ZgiP2hmX0Ky2P7vJRbKZTVjPbRFSzuqTKg4oZStvpAYRWbZnRlrKzFJ65BN12GmknMkolM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:03:18AM -0800, Randy Dunlap wrote:
>[EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
>
>
>On 1/11/21 9:57 AM, Vanshidhar Konda wrote:
>> On Mon, Jan 11, 2021 at 10:56:36AM +0000, Will Deacon wrote:
>>> On Sat, Jan 09, 2021 at 09:36:15PM -0800, vanshikonda@os.amperecomputing.com wrote:
>>>> From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>>>
>>>> Increase the default value of NR_CPUS to 512 from 256. This will
>>>> enable the defconfig kernel to support platforms that have upto
>>>> 512 cores.
>>>
>>> Do we already support such a platform, and what is it? I'm fine with bumping.
>>> the number, it's just nice to be able to say specifically _why_ we're dong
>>> it.
>>
>> I'm not aware of any publicly available systems that run into the 256
>> core limitation. At Ampere we have internal systems that would benefit
>> from this change as they support more than 256 cores.
>
>But what does that have to do with the default value?
>Do you expect to run defconfig kernels?
>I don't ever expect that.

Sorry. I should have been more clear in my earlier statement. We
currently have systems in development internally, to be available
publicly later, that support more than 256 cores. Given the time it
takes for a kernel version to be adopted by distros it makes sense to
change the defconfig now rather than later.


Thanks,
Vanshi

>
>--
>~Randy
>
