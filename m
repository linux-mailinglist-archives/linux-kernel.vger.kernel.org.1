Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBEA228CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 01:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgGUXiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 19:38:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26909 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgGUXix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:38:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595374732; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Q36saumYYreHiesPJdg0r1mLXwlLVPpkkK236UndvMY=;
 b=FijmA7ckanFEBHsRzd8bKIrrqdffIIj5TvnQPCZ/r+IXG3wupTaz0SQ5OI3PA8eBN1k9gZ5Y
 WhdMBS4lHSFtqp/Ol83wAff3AV97Bp1tQpCD5fm7c+irAX3oKtBPADstN+fbm6d6wqvNfPBG
 dMXmjyV7B8L9aoAOnGS6eoFItpk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5f177c08e32d449b31a09a9c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Jul 2020 23:36:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 948EFC433CA; Tue, 21 Jul 2020 23:36:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4752AC433C6;
        Tue, 21 Jul 2020 23:36:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jul 2020 07:36:39 +0800
From:   tingwei@codeaurora.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] tracing: add trace_export support for event trace
In-Reply-To: <20200721123733.1a87568a@oasis.local.home>
References: <20200720022117.9375-1-tingwei@codeaurora.org>
 <20200720022117.9375-3-tingwei@codeaurora.org>
 <20200721123733.1a87568a@oasis.local.home>
Message-ID: <dc17f10c4f931ffc9059abd89810939c@codeaurora.org>
X-Sender: tingwei@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-22 00:37, Steven Rostedt wrote:
> On Mon, 20 Jul 2020 10:21:15 +0800
> Tingwei Zhang <tingwei@codeaurora.org> wrote:
> 
>> Only function traces can be exported to other destinations currently.
>> This patch exports event trace as well.
>> 
>> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
>> ---
>>  kernel/trace/trace.c | 24 +++++++++++++-----------
>>  1 file changed, 13 insertions(+), 11 deletions(-)
>> 
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index bb62269724d5..aef6330836e2 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -2697,17 +2697,6 @@ int tracepoint_printk_sysctl(struct ctl_table
> *table, int write,
>>  	return ret;
>>  }
>> 
>> -void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
>> -{
>> -	if (static_key_false(&tracepoint_printk_key.key))
>> -		output_printk(fbuffer);
>> -
>> -	event_trigger_unlock_commit_regs(fbuffer->trace_file,
> fbuffer->buffer,
>> -				    fbuffer->event, fbuffer->entry,
>> -				    fbuffer->flags, fbuffer->pc,
> fbuffer->regs);
>> -}
>> -EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
>> -
> 
> Please move the ftrace_exports routines up, instead of moving the
> trace_event_buffer_commit() down. As it fits better where it is (next
> to the other buffer_commit code).
> 
> -- Steve
> 

Thanks, Steve. I'll fix this.

> 
>>  /*
>>   * Skip 3:
>>   *
>> @@ -2868,6 +2857,19 @@ int unregister_ftrace_export(struct
>> trace_export *export) }
>>  EXPORT_SYMBOL_GPL(unregister_ftrace_export);
>> 
>> +void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
>> +{
>> +	if (static_key_false(&tracepoint_printk_key.key))
>> +		output_printk(fbuffer);
>> +
>> +	if (static_branch_unlikely(&ftrace_exports_enabled))
>> +		ftrace_exports(fbuffer->event);
>> +	event_trigger_unlock_commit_regs(fbuffer->trace_file,
>> fbuffer->buffer,
>> +				    fbuffer->event, fbuffer->entry,
>> +				    fbuffer->flags, fbuffer->pc,
>> fbuffer->regs); +}
>> +EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
>> +
>>  void
>>  trace_function(struct trace_array *tr,
>>  	       unsigned long ip, unsigned long parent_ip, unsigned
>> long flags,
