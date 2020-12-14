Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17D82D95B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404957AbgLNKBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:01:41 -0500
Received: from foss.arm.com ([217.140.110.172]:45452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391938AbgLNKBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:01:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF26030E;
        Mon, 14 Dec 2020 02:00:30 -0800 (PST)
Received: from [10.57.63.94] (unknown [10.57.63.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3BE13F66E;
        Mon, 14 Dec 2020 02:00:28 -0800 (PST)
Subject: Re: [RFC 09/11] coresight: etm-perf: Disable the path before
 capturing the trace data
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        Al Grant <Al.Grant@arm.com>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-10-git-send-email-anshuman.khandual@arm.com>
 <2019e06d-65e1-fee8-f75d-bfa5750d2458@arm.com>
 <20201211203126.GA1921322@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b7b0cf92-abfa-ca98-0b55-62e63e4c3457@arm.com>
Date:   Mon, 14 Dec 2020 10:00:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201211203126.GA1921322@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 8:31 PM, Mathieu Poirier wrote:
> On Fri, Nov 27, 2020 at 10:32:28AM +0000, Suzuki K Poulose wrote:
>> On 11/10/20 12:45 PM, Anshuman Khandual wrote:
>>> perf handle structure needs to be shared with the TRBE IRQ handler for
>>> capturing trace data and restarting the handle. There is a probability
>>> of an undefined reference based crash when etm event is being stopped
>>> while a TRBE IRQ also getting processed. This happens due the release
>>> of perf handle via perf_aux_output_end(). This stops the sinks via the
>>> link before releasing the handle, which will ensure that a simultaneous
>>> TRBE IRQ could not happen.
>>
>> Or in other words :
>>
>> We now have :
>>
>> 	update_buffer()
>>
>> 	perf_aux_output_end(handle)
>>
>> 	...
>> 	disable_path()
>>
>> This is problematic due to various reasons :
>>
>> 1) The semantics of update_buffer() is not clear. i.e, whether it
>>     should leave the "sink" "stopped" or "disabled" or "active"
> 
> I'm a little confused by the above as the modes that apply here are
> CS_MODE_DISABLED and CS_MODE_PERF, so I'll go with those.  Let me know if you
> meant something else.

Sorry, I think it is a bit confusing.

stopped => Sink is in stopped HW state, but the software mode is not changed (i.e, could be
PERF or SYSF)

disabled => Sink is in stopped hw state, the software mode is DISABLED

active => Sink is active and flushing trace, with respective mode (PERF vs SYSFS).

> 
> So far ->update_buffer() doesn't touch drvdata->mode and as such it is still set
> to CS_MODE_PERF when the update has completed.
> 
>>
>> 2) This breaks the recommended trace collection sequence of
>>     "flush" and "stop" from source to the sink for trace collection.
>>      i.e, we stop the source now. But don't flush the components
>>      from source to sink, rather we stop and flush from the sink.
>>      And we flush and stop the path after we have collected the
>>      trace data at sink, which is pointless.
> 
> The above assesment is correct.  Fixing it though has far reaching ramifications
> that go far beyond the scope of this patch.
> 
>>
>> 3) For a sink with IRQ handler, if we don't stop the sink with
>>     update_buffer(), we could have a situation :
>>
>>     update_buffer()
>>
>>     perf_aux_outpuf_end(handle) # handle is invalid now
>>
>>   -----------------> IRQ    -> irq_handler()
>>                                 perf_aux_output_end(handle) # Wrong !
>>
>>
>>     disable_path()
> 
> That's the picture of the issue I had in my head when looking at the code -
> I'm glad we came to the same conclusion.
> 
>>
>> The sysfs mode is fine, as we defer the trace collection to disable_path().
>>
>> The proposed patch is still racy, as we could still hit the problem.
>>
>> So, to avoid all of these situations, I think we should defer the the
>> update_buffer() to sink_ops->disable(), when we have flushed and stopped
>> the all the components upstream and avoid any races with the IRQ
>> handler.
>>
>> i.e,
>>
>> 	source_ops->stop(csdev);
>>
>> 	disable_path(handle); // similar to the enable_path
>>
>>
>> sink_ops->disable(csdev, handle)
>> {
>>    /* flush & stop */
>>
>>    /* collect trace */
>>    perf_aux_output_end(handle, size);
>> }
> 
> That is one solution.  The advantage here is that it takes care of the
> flusing problem you described above.  On the flip side it is moving a lot of
> code around, something that is better to do in another set.
> 
> Another solution is to disable the TRBE IRQ in ->udpate_buffer().  The ETR does
> the same kind of thing with tmc_flush_and_stop().  I don't know how feasible
> that is but it would be a simple solution for this set.  Properly flushing the
> pipeline could be done later.  I'm fine with either approach.

Agreed. I think this is reasonable forthis set. i.e, leave the hardware disabled.
We could do the proper solution above as a separate series, to keep the changes
incremental.

Kind regards
Suzuki
