Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136D52887F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 13:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbgJILlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 07:41:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2967 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732405AbgJILlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:41:39 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 90C49EF1BB54D9D31778;
        Fri,  9 Oct 2020 12:41:37 +0100 (IST)
Received: from [127.0.0.1] (10.47.0.88) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 9 Oct 2020
 12:41:36 +0100
Subject: Re: [PATCH] perf jevents: Fix event code for events referencing std
 arch events
To:     kajoljain <kjain@linux.ibm.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <yeyunfeng@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
 <a7cbb1f7-1f7f-6bf9-6acf-fd5455aadd82@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e22710ee-0afc-4d49-8432-a00549a969b6@huawei.com>
Date:   Fri, 9 Oct 2020 12:38:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a7cbb1f7-1f7f-6bf9-6acf-fd5455aadd82@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.88]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2020 12:26, kajoljain wrote:
> 
> On 10/8/20 8:49 PM, John Garry wrote:
>> The event code for events referencing std arch events is incorrectly
>> evaluated in json_events().
>>
>> The issue is that je.event is evaluated properly from try_fixup(), but
>> later NULLified from the real_event() call, as "event" may be NULL.
>>
>> Fix by setting "event" same je.event in try_fixup().
>>
>> Also remove support for overwriting event code for events using std arch
>> events, as it is not used.
> Patch looks good to me. Not sure if any adding any example with this issue
> is helpful.

So we get something like this in pmu-events.c:

{
         .name = "l1d_cache_wb_victim",
         .event = "event=0x0",
[...]
},

But event should "event=0x46".

I can add this if Arnaldo wants a v2.

> 
> Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

thanks

