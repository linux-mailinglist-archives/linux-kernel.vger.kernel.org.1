Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E593528B399
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbgJLLSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:18:16 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2969 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387681AbgJLLSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:18:14 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id DACD698E2956841DAB43;
        Mon, 12 Oct 2020 12:18:12 +0100 (IST)
Received: from [127.0.0.1] (10.47.8.38) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 12 Oct
 2020 12:18:11 +0100
Subject: Re: [PATCH] perf jevents: Fix event code for events referencing std
 arch events
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <kjain@linux.ibm.com>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <yeyunfeng@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <=linux-arm-kernel@lists.infradead.org>
References: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
 <20201012105430.GH1099489@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5b0aefe2-e0d5-b5ff-654c-4e93c427050f@huawei.com>
Date:   Mon, 12 Oct 2020 12:15:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201012105430.GH1099489@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.38]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2020 11:54, Jiri Olsa wrote:
>> ff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index 99df41a9543d..e47644cab3fa 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -505,20 +505,15 @@ static char *real_event(const char *name, char *event)
>>   }
>>   
>>   static int
>> -try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
>> -	  struct json_event *je)
>> +try_fixup(const char *fn, char *arch_std, struct json_event *je, char **event)
>>   {
>>   	/* try to find matching event from arch standard values */
>>   	struct event_struct *es;
>>   
>>   	list_for_each_entry(es, &arch_std_events, list) {
>>   		if (!strcmp(arch_std, es->name)) {
>> -			if (!eventcode && es->event) {
>> -				/* allow EventCode to be overridden */
>> -				free(je->event);
>> -				je->event = NULL;
>> -			}
>>   			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
>> +			*event = je->event;
> I'm bit rusty on this code, 
> but isn't je->event NULL at this point?

je->event should be now assigned from es->event because of 
FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD):

#define TRY_FIXUP_FIELD(field) do { if (es->field && !*field) {\
	*field = strdup(es->field);				\
	if (!*field)						\
		return -ENOMEM;					\
} } while (0)

And es->event should be set.

Thanks,
John
