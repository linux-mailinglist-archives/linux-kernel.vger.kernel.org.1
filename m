Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADFC27AE0F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgI1MmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:42:15 -0400
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:22935
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbgI1MmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:42:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzaNqS9sa4S07Wq+AZ41UGhM+EH/E9yBk7O+kXUUyxbqaP8+nFN/WnOkwQrjpx5X3+C85rFyugJtI/4n3Uh8WKf7bl9UsfjQ0j9U4zssVdWZeeuVXXJdwmqyM1d7nYlcrQMOzqe3qTh63TxMa60zam9C5/IjSSzjSPuJ/4m4aN7JWX8nMiPhMxXx8DrD79Gf57opCIKYu1FLs7CmwjK9kHbzFp55qCWkcrxgoVeREbMrDARQnGncrMbh0wb7WwMRA1Ptu5hRJUdqEhOCYcdj3ljxbuUSnLWWb+s+JX43EOiEGNS9MZswv61v0XsreuDL0uGvKLYAXgNpKD3Ewj/lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJgXfRgbwBCAbdKWID5BO50XbJFRbXBcly79efT7PDc=;
 b=mUBU7Tp0LdsNo4dWxio5LyLBERuSEZUpdE8Rjb2G0c700Th72B2SDJrbz6/hsqkw8nG5whtchgHXyGf1T88wxuMeKWkLpbC5gL8qU9RxLO9gcWFZxA9MFNwB11gd7ByBehc21djxSWfA4qGoSAPxdaEyoMJ23v//qtzr07lFcUNKNFFo7334TZfie6ZMFnOqVImaiKBlD0D5uwfP+zaBvTZeI0o/SAJyDUgahZRbsi309QZDIzWLsy2rqqhnZvrJFtmz7GefX1AWGVx1a4D3OxBn5RARUyifRb+Szcm08bHq3adJM9JpvLDEtMiIrVNPX3fe0fyhpVp9bN9a78znCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJgXfRgbwBCAbdKWID5BO50XbJFRbXBcly79efT7PDc=;
 b=SUG1iLl+Og7shKvflxQRh9BU4vRWDretKKHWC9VLufrz0Z+LCKOnJTYhsPq4aNYQkePwah8XzfcYQPfJULXTObHEtCUuAsc5xkqOYuc3UQxUTXi10GEBO9xreKEbRpuSBQE+iV7+sxi4T8KE13O6pqdtxsMlo+3tTOSTYOuk74o=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1941.namprd11.prod.outlook.com (2603:10b6:903:120::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 12:42:09 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::2d47:2e9c:cfbe:6fb2]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::2d47:2e9c:cfbe:6fb2%6]) with mapi id 15.20.3370.033; Mon, 28 Sep 2020
 12:42:09 +0000
Subject: Re: [PATCH] time/sched_clock: mark sched_clock_read_begin as notrace
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        a.darwish@linutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        ben.dooks@codethink.co.uk, Steven Rostedt <rostedt@goodmis.org>
References: <20200928104952.26892-1-quanyang.wang@windriver.com>
 <20200928105859.GF2628@hirez.programming.kicks-ass.net>
From:   Quanyang Wang <quanyang.wang@windriver.com>
Message-ID: <22a5d255-7a9f-3139-1e8a-4263fea690c0@windriver.com>
Date:   Mon, 28 Sep 2020 20:41:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200928105859.GF2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HK2PR04CA0047.apcprd04.prod.outlook.com (2603:1096:202:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Mon, 28 Sep 2020 12:42:06 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdac5aa7-dba2-45d4-b248-08d863abea06
X-MS-TrafficTypeDiagnostic: CY4PR11MB1941:
X-Microsoft-Antispam-PRVS: <CY4PR11MB194140BF44850366F4F6115EF0350@CY4PR11MB1941.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjzvZEPy9ErttPht9BozXTZX1D+p5CeAqyJw6uNkl8rtmpPQ9zImXczGOd5XLza+v1T3wRHyACVibRM3B9CXjlnUm/SKi9hzoWz6ICZ/mGuAj10NUgewX5VcW+ZqVG5cCn4Im56hCNf4RBSq4bdzA57hjc/0+/XvpZAM6kDkeCFavxL2+dqHdDyCjmFYRhfb9QjAAgYuHuLLCXathQX41jeicrISbHONqGkjuQDscdSkyulnGQ1yWVRRrEAFSMllV5G536TrAWVjqN0RXFvPlLN2cNH5Xmv3U0IC2IVsfLZUt1UHuBbttrynjWgrWRHVpZM4cNrtqZ9CYXrD8GXRoTjOX+S3IPuMQM8lsJs7S0i3//hsEB8UIwJP3uz83GrGn+92a5nmaZNO07cv0xCLwGgkXiQr3DAEgqio5w2e4ponrMz0ugkLjvolp9t+ik5xBmu0P7nKBTKFiIz75sRCvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39850400004)(366004)(6666004)(31686004)(66946007)(478600001)(2616005)(956004)(44832011)(6486002)(8936002)(52116002)(7416002)(2906002)(6916009)(8676002)(6706004)(16576012)(54906003)(53546011)(316002)(36756003)(26005)(4326008)(186003)(16526019)(66476007)(66556008)(83380400001)(5660300002)(31696002)(86362001)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ax387dZi+Jv9XxLNHDmb1tVTIZ4Rq9l98AqKkVaOLzDYb7/KrOOPv1dmw/xUAx4L8ipXGTQkXIHW31rA8EnHZO8uF1hpRelqjlNeSX3v26pw1SRzzma4ZjKEcDsNUL8de38tfgtKiQrjMAnjmE4fH1dciEb/WWdIiqqRCHoZ6ajsnaw1zdDfq787wZ69VuJ/MNbFzBIxfx23zlPcXQGTs4OE/N0IZmGJc252lqKIZl4w7WS4r3I3Rl93ZJBaLwLzhTUJO7ZlP0lC2DyYujOYmFua8CHVlIgMQ3ZIn5Bc8meCBDxr4Y1ILsXeoveQmQesvzvmaTNCICRfkeP6zv+YMisHLB4WGVps7gMYLwJ8pbQxjA3oV/rV34x0ITji0gHAGSP1Z/RJK/+uoK03rHRngAgPdgyWvl5BAXPNNvM/VtfX1QbZOOjfqUZPonkdjV1EQE2dd0F40ZWvtlMhRzq9AZvJk5NBRQzwb/1FBuJxgqGfC0mRB2ebOhneVSXb4P9ebP+X6tXrEYTrQZ+Ig8zpkYWpt1SNPJVs0gyUm0MKYXMMjt0gV2FrlOKFKOrpcGX52hYGKiUMGg/CvuJdblz9hi7VNR+4rYrCOe5OI4O7WjUaO4yTEs3jPCF4L9+8s/rmr4kZUV4FQDMWvGUZYOVTFg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdac5aa7-dba2-45d4-b248-08d863abea06
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 12:42:09.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J491FmWsee4xmHY/8NcVCgSo/lDkQ66RO6lfm/A7k5A/equLe4OM8wj5ThPpEEqx5cNmvc8D77rMKgqKcCuFa7MyVy9oFHNz9kwXJYaQJwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 9/28/20 6:58 PM, Peter Zijlstra wrote:
> On Mon, Sep 28, 2020 at 06:49:52PM +0800, quanyang.wang@windriver.com wrote:
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> Since sched_clock_read_begin is called by notrace function sched_clock,
>> it shouldn't be traceable either, or else __ftrace_graph_caller will
>> run into a dead loop on the path (arm for instance):
>>
>>    ftrace_graph_caller
>>      prepare_ftrace_return
>>        function_graph_enter
>>          ftrace_push_return_trace
>>            trace_clock_local
>>              sched_clock
>>                sched_clock_read_begin
>>
>> Fixes: 1b86abc1c645 ("sched_clock: Expose struct clock_read_data")
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>> ---
>>   kernel/time/sched_clock.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
>> index 1c03eec6ca9b..58459e1359d7 100644
>> --- a/kernel/time/sched_clock.c
>> +++ b/kernel/time/sched_clock.c
>> @@ -68,7 +68,7 @@ static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
>>   	return (cyc * mult) >> shift;
>>   }
>>   
>> -struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
>> +notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
>>   {
>>   	*seq = raw_read_seqcount_latch(&cd.seq);
>>   	return cd.read_data + (*seq & 1);
> At the very least sched_clock_read_retry() should also be marked such.

In fact, the sched_clock_read_retry is treated as a "inline" function, so

it doesn't trigger the  dead loop. But for safe, add notrace to it is 
better.

I will send a V2 patch.

Thanks,

Quanyang


>
> But Steve, how come x86 works? Our sched_clock() doesn't have notrace on
> at all.
