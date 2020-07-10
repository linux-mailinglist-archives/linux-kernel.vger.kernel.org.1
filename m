Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508DA21AC62
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 03:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGJBKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 21:10:16 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43533 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgGJBKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:10:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U2EumI3_1594343413;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2EumI3_1594343413)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 09:10:13 +0800
Date:   Fri, 10 Jul 2020 09:10:13 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tracing: use union to simplify the
 trace_event_functions initialization
Message-ID: <20200710011013.GA51939@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
 <20200709175739.4c628f38@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709175739.4c628f38@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 05:57:39PM -0400, Steven Rostedt wrote:
>On Fri,  3 Jul 2020 10:06:08 +0800
>Wei Yang <richard.weiyang@linux.alibaba.com> wrote:
>
>> There are for 4 fields in trace_event_functions with the same type of
>> trace_print_func. Initialize them in register_trace_event() one by one
>> looks redundant.
>
>I have mixed emotions about this patch. Yeah, it consolidates it a bit,
>but it also makes it less easy to know what it is doing.
>
>All this patch is doing is optimizing the initialization path, which is
>done once when an event is registered. It's error prone, as you would
>need to make sure to map the array with the functions. Something like
>this is only reasonable if it is used more often, which here it's a
>single spot.
>
>So no, I can't take this patch.
>

Sure, I think you get the point.

>-- Steve
>
>
>
>> 
>> Let's take advantage of union to simplify the procedure.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>  include/linux/trace_events.h | 13 +++++++++----
>>  kernel/trace/trace_output.c  | 14 +++++---------
>>  2 files changed, 14 insertions(+), 13 deletions(-)
>> 
>> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
>> index 5c6943354049..1a421246f4a2 100644
>> --- a/include/linux/trace_events.h
>> +++ b/include/linux/trace_events.h
>> @@ -122,10 +122,15 @@ typedef enum print_line_t (*trace_print_func)(struct trace_iterator *iter,
>>  				      int flags, struct trace_event *event);
>>  
>>  struct trace_event_functions {
>> -	trace_print_func	trace;
>> -	trace_print_func	raw;
>> -	trace_print_func	hex;
>> -	trace_print_func	binary;
>> +	union {
>> +		struct {
>> +			trace_print_func	trace;
>> +			trace_print_func	raw;
>> +			trace_print_func	hex;
>> +			trace_print_func	binary;
>> +		};
>> +		trace_print_func print_funcs[4];
>> +	};
>>  };
>>  
>>  struct trace_event {
>> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
>> index 73976de7f8cc..47bf9f042b97 100644
>> --- a/kernel/trace/trace_output.c
>> +++ b/kernel/trace/trace_output.c
>> @@ -728,7 +728,7 @@ void trace_event_read_unlock(void)
>>  int register_trace_event(struct trace_event *event)
>>  {
>>  	unsigned key;
>> -	int ret = 0;
>> +	int i, ret = 0;
>>  
>>  	down_write(&trace_event_sem);
>>  
>> @@ -770,14 +770,10 @@ int register_trace_event(struct trace_event *event)
>>  			goto out;
>>  	}
>>  
>> -	if (event->funcs->trace == NULL)
>> -		event->funcs->trace = trace_nop_print;
>> -	if (event->funcs->raw == NULL)
>> -		event->funcs->raw = trace_nop_print;
>> -	if (event->funcs->hex == NULL)
>> -		event->funcs->hex = trace_nop_print;
>> -	if (event->funcs->binary == NULL)
>> -		event->funcs->binary = trace_nop_print;
>> +	for (i = 0; i < ARRAY_SIZE(event->funcs->print_funcs); i++) {
>> +		if (!event->funcs->print_funcs[i])
>> +			event->funcs->print_funcs[i] = trace_nop_print;
>> +	}
>>  
>>  	key = event->type & (EVENT_HASHSIZE - 1);
>>  

-- 
Wei Yang
Help you, Help me
