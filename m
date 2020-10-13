Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D440128CA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403949AbgJMIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:44:19 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2975 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403918AbgJMIoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:44:18 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 4C6FD9BD907B2567ECAD;
        Tue, 13 Oct 2020 09:44:17 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.6) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 13 Oct
 2020 09:44:16 +0100
Subject: Re: [PATCH] perf jevents: Fix event code for events referencing std
 arch events
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <kjain@linux.ibm.com>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <yeyunfeng@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
 <20201012105430.GH1099489@krava>
 <5b0aefe2-e0d5-b5ff-654c-4e93c427050f@huawei.com>
 <20201012112419.GJ1099489@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9e8e3d2d-d15d-13df-ab97-34df8d81a6a1@huawei.com>
Date:   Tue, 13 Oct 2020 09:41:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201012112419.GJ1099489@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.6]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2020 12:24, Jiri Olsa wrote:
> On Mon, Oct 12, 2020 at 12:15:04PM +0100, John Garry wrote:
>> On 12/10/2020 11:54, Jiri Olsa wrote:
>>>> ff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>>>> index 99df41a9543d..e47644cab3fa 100644
>>>> --- a/tools/perf/pmu-events/jevents.c
>>>> +++ b/tools/perf/pmu-events/jevents.c
>>>> @@ -505,20 +505,15 @@ static char *real_event(const char *name, char *event)
>>>>    }
>>>>    static int
>>>> -try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
>>>> -	  struct json_event *je)
>>>> +try_fixup(const char *fn, char *arch_std, struct json_event *je, char **event)
>>>>    {
>>>>    	/* try to find matching event from arch standard values */
>>>>    	struct event_struct *es;
>>>>    	list_for_each_entry(es, &arch_std_events, list) {
>>>>    		if (!strcmp(arch_std, es->name)) {
>>>> -			if (!eventcode && es->event) {
>>>> -				/* allow EventCode to be overridden */
>>>> -				free(je->event);
>>>> -				je->event = NULL;
>>>> -			}
>>>>    			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
>>>> +			*event = je->event;
>>> I'm bit rusty on this code, but isn't je->event NULL at this point?
>>
>> je->event should be now assigned from es->event because of
>> FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD):
>>
>> #define TRY_FIXUP_FIELD(field) do { if (es->field && !*field) {\
>> 	*field = strdup(es->field);				\
>> 	if (!*field)						\
>> 		return -ENOMEM;					\
>> } } while (0)
>>
>> And es->event should be set.
> 
> right, thanks
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> jirka
> 
> .
> 

"PMU events" testcase was still passing as it does not cover this 
scenario, so I'll look to expand the test to catch such problems.

Thanks,
John

