Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2FA296007
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900106AbgJVNa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:30:26 -0400
Received: from foss.arm.com ([217.140.110.172]:57780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900098AbgJVNa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:30:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B588F101E;
        Thu, 22 Oct 2020 06:30:25 -0700 (PDT)
Received: from [10.57.13.45] (unknown [10.57.13.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49B6A3F66E;
        Thu, 22 Oct 2020 06:30:23 -0700 (PDT)
Subject: Re: [PATCHv2 2/4] coresight: tmc-etf: Fix NULL ptr dereference in
 tmc_enable_etf_sink_perf()
To:     Peter Zijlstra <peterz@infradead.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1603363729.git.saiprakash.ranjan@codeaurora.org>
 <aa6e571156d6e26e54da0bb3015ba474e4a08da0.1603363729.git.saiprakash.ranjan@codeaurora.org>
 <20201022113214.GD2611@hirez.programming.kicks-ass.net>
From:   Suzuki Poulose <suzuki.poulose@arm.com>
Message-ID: <e7d236f7-61c2-731d-571b-839e0e545563@arm.com>
Date:   Thu, 22 Oct 2020 14:30:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201022113214.GD2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 12:32 PM, Peter Zijlstra wrote:
> On Thu, Oct 22, 2020 at 04:27:52PM +0530, Sai Prakash Ranjan wrote:
> 
>> Looking at the ETR and other places in the kernel, ETF and the
>> ETB are the only places trying to dereference the task(owner)
>> in tmc_enable_etf_sink_perf() which is also called from the
>> sched_in path as in the call trace.
> 
>> @@ -391,6 +392,10 @@ static void *tmc_alloc_etf_buffer(struct coresight_device *csdev,
>>   {
>>   	int node;
>>   	struct cs_buffers *buf;
>> +	struct task_struct *task = READ_ONCE(event->owner);
>> +
>> +	if (!task || is_kernel_event(event))
>> +		return NULL;
> 
> 
> This is *wrong*... why do you care about who owns the events?
> 

This is due to the special case of the CoreSight configuration, where
a "sink" (where the trace data is captured) is shared by multiple Trace
units. So, we could share the "sink" for multiple trace units if they
are tracing the events that belong to the same "perf" session. (The
userspace tool could decode the trace data based on the TraceID
in the trace packets). Is there a better way to do this ?

Suzuki
