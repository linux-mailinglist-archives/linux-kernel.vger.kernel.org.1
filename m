Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D048D27BEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgI2IJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:09:28 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:23648
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbgI2IJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:09:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZotZgKOrRhgzSl6KoG+EQnqC4w/0lsYuDX/tP5mJqahXfxwRj1Blf3mYZ7U3Fmfv8U18mcI90r9cUtiDTLHm/UpUgmsAUCLbZWXgE4cI/RLWZXchfgGdL/mZ43cZTro9meVBA8LFGvvQHZKOb9sGCuCFQspfoy/7PqBNappoe1rarTe8CHB0DloktMaFSxebmKlfHH9Vfy4vfQ9rqRgfa0CWfrRoinI2IwNUm9y1Mo2hwy5X/PuEyHlW2QRjHirC6N+bOeqhiSe+8QF0+RFBivkaU3q63Iu6qUUrb46CYrTCZvRwuGH4XIKdeTGbBWLZTL/aV+ocefig1q8mSaa9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR0HITloQ/6AsgJF1Y2NkLVrGfxY6rQgjS6lH3cF6nk=;
 b=DXfD8sY23VPU5anBhl3g9dTrVb3eVBInl3G1hjCM/Qot5/XCOPp6Xt4KvuYxgvcf1FRgolDr/UVqTr8naPBB7/5G4OlQC0xSPuqAssHZ/tYo3XjJ6F54wuCjB+weanmRf/ASLgaTQzCweEQ59y/rlAMKl2SlE0dmOmJGnszG7W6OvqKzGFNt92cETOpagOgBj9buwPf/2k7FEWcMTCH6FmVb3jFLNSXx587tqp99ElmUZZKItPYpL2sdM+1agoVQjdtdcGKzrnkgCaooTvr3ugUI6LNtu7bThix+cOaKLhc5+L25OjvsN2HCozZ+my1sIeatXmEGOGlb0+wMuxgR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR0HITloQ/6AsgJF1Y2NkLVrGfxY6rQgjS6lH3cF6nk=;
 b=ptvRuE4nF41FLPEweuyva1JRBv/IQSk71DgqsNTdsl82LYifasEo2gJ2LCZa0cUN+p1GF1EVQHRyxtg7RoIOPVEtgCme7G3uvLLBt9YC0v81dZ7OezNaAUumm0/CpWUFUagsZ+b21IBzrOC9g5U9KNcanL6P4teuf8mCl0iVC2Y=
Authentication-Results: codethink.co.uk; dkim=none (message not signed)
 header.d=none;codethink.co.uk; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1525.namprd11.prod.outlook.com (2603:10b6:910:9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 08:09:24 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::2d47:2e9c:cfbe:6fb2]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::2d47:2e9c:cfbe:6fb2%6]) with mapi id 15.20.3370.033; Tue, 29 Sep 2020
 08:09:24 +0000
Subject: Re: [PATCH V2] time/sched_clock: mark sched_clock_read_begin/retry as
 notrace
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        a.darwish@linutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Randy Dunlap <rdunlap@infradead.org>, ben.dooks@codethink.co.uk
References: <20200929015051.4097-1-quanyang.wang@windriver.com>
 <20200929074930.GG2611@hirez.programming.kicks-ass.net>
From:   Quanyang Wang <quanyang.wang@windriver.com>
Message-ID: <3e9755ef-cf20-b5a6-455e-a11e110e6325@windriver.com>
Date:   Tue, 29 Sep 2020 16:09:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200929074930.GG2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 08:09:21 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 768b0875-bcdc-4807-c56c-08d8644efa0c
X-MS-TrafficTypeDiagnostic: CY4PR11MB1525:
X-Microsoft-Antispam-PRVS: <CY4PR11MB15258ED50FBE0A4B63A4A55AF0320@CY4PR11MB1525.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPAxArFEwB6JUtCC+Cn9hoCEsmO2WdxzdnEVJgo5ciL046lVHq0+8s+IZZyQLWQGi3px98YTGfAL2zB5iEusQo37RnxX/EEzUqA5RbdbbCOfjvapB7oSvoqNrgOOmzzRH2uEKXdT4K8HYTHtyG9Uac1qJaXeslFySmVMq2hoEQe1VwDsUXbK/8/2F1mlWzvOHV9HNqy8j+F1mQ9UtGJrfjBs3b4wCbQFgGT22P+Zy8PBH6E0JN8oYhHIvgCysiJKZ/KNzCjHwBAuz4d8Ym7zb7o+CQ3Vpz/tQoXPzO41a0llylBoGlCX5aHbUCwEfG2nfdPRDS7JgYDhVY0V3bvF2p6y37S/dkxxeI2OTxZ+hMVto7Xore+MIyJI0dMvOZQWrqCIo9d4+52xTJiP8sGYeqUfTmMI7D2YhHf56ZSubvt5JoQ5b2UL9KubLMPOtvfBvhWS07y/1xg8XP0hj4OmNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(396003)(376002)(346002)(2906002)(31696002)(8676002)(6706004)(8936002)(186003)(31686004)(53546011)(16526019)(26005)(52116002)(86362001)(6916009)(7416002)(83380400001)(4326008)(54906003)(6486002)(36756003)(316002)(16576012)(66556008)(66476007)(66946007)(44832011)(5660300002)(478600001)(6666004)(2616005)(956004)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4/KEZgOZk5W5GyUa3NseUPmhRrnmjBsenu2UqYEyyTQwmsFCDvs6bf59k6fA5uD+2XALd2ZA/+D4nZQlDJYx2MTmfeLEABd7q7qS+TPtyREfoQvAIWBkKKR4YdG0r/hib9lgvYhIIOOwgX2c/7GEKh+1YitxST8AsfPvcgmjkgBw+bWE3R8VZMGKpy4PcCldYybl9WXAqJxd/Z4qhMXt7x9Sr5//2RjXc4WqYs9TO9gz8u+CsbD8BjTzfUQLLgtLYhQO/mot22X5kprkQ4sGW4sC5Gl9nTeu9OKYe+3BfUnsqFIm2W3eUsawnjbrbOtSn7Qd1HGuZAJ06fRyTsq1gnJ2ScMuKHczIi53Y9bVkmap230Zyveh0RC0s0GyMIEYLQtm5ugpnnHeHWMBPcH+yfxkI4DPsC46EfsF1pwQghZ4s4cc5uXau5NNq0b0Yfmv0vjf5zrMDRVyM8Y9GkTFRgeVBC55zmvt1588oHEQr+yWI9FEjIA5j2BBKV5KoSJccFfudEthRkCPZUQGQzWAWM8ByZoGjKgb1gMchg/BChg3WtL0b1JS5ytECmdizxpzF3PPi8cySt4SvHojKAejrVeNDHNKJ6NdCeFnQA1XkSROJXrm80OROzoNG3goFh61rtWUXIFS22u7gldAQOeopA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768b0875-bcdc-4807-c56c-08d8644efa0c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 08:09:24.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/zxvIo3dpWFLa2QCZClF4i7pDSzLqtm9ld2WLk25p/kQC5VwumqiJzPLzm01tttOpG2Q0V4UlQ78MrXvoyFEGY+W87kxQkFr6NXa35oNHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1525
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 9/29/20 3:49 PM, Peter Zijlstra wrote:
> On Tue, Sep 29, 2020 at 09:50:51AM +0800, quanyang.wang@windriver.com wrote:
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> Since sched_clock_read_begin and sched_clock_read_retry are called
>> by notrace function sched_clock, they shouldn't be traceable either,
>> or else ftrace_graph_caller will run into a dead loop on the path
>> as below (arm for instance):
>>
>>    ftrace_graph_caller
>>      prepare_ftrace_return
>>        function_graph_enter
>>          ftrace_push_return_trace
>>            trace_clock_local
>>              sched_clock
>>                sched_clock_read_begin/retry
>>
>> Fixes: 1b86abc1c645 ("sched_clock: Expose struct clock_read_data")
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>> ---
>> Changes:
>> V2: Add notrace to sched_clock_read_retry according to Peter's suggestion.
>>
>>   kernel/time/sched_clock.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
>> index 1c03eec6ca9b..f629e3f5afbe 100644
>> --- a/kernel/time/sched_clock.c
>> +++ b/kernel/time/sched_clock.c
>> @@ -68,13 +68,13 @@ static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
>>   	return (cyc * mult) >> shift;
>>   }
>>   
>> -struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
>> +notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
>>   {
>>   	*seq = raw_read_seqcount_latch(&cd.seq);
>>   	return cd.read_data + (*seq & 1);
>>   }
>>   
>> -int sched_clock_read_retry(unsigned int seq)
>> +int notrace sched_clock_read_retry(unsigned int seq)
>>   {
>>   	return read_seqcount_retry(&cd.seq, seq);
>>   }
> You're inconsistent in the placement of notrace, I prefer the first, the
> second read like notrace is the return type instead of a qualifier.

Thanks for your review. I will send a V3 patch to fix it.

Thanks,

Quanyang

>
> In any case,
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
