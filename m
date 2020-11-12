Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB262B038D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgKLLKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:10:05 -0500
Received: from foss.arm.com ([217.140.110.172]:47404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbgKLLJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:09:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CB4A139F;
        Thu, 12 Nov 2020 03:09:57 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0F943F73C;
        Thu, 12 Nov 2020 03:09:55 -0800 (PST)
Subject: Re: [RFC 02/11] coresight: etm-perf: Allow an event to use different
 sinks
To:     Linu Cherian <linuc.decode@gmail.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-3-git-send-email-anshuman.khandual@arm.com>
 <67e0864f-e025-aa08-d1b7-36cf19629197@arm.com>
 <CAAHhmWiWbUTt-BvjeqGm3mfN2L8A8gUOVVDNX0P=WCEDj=Mc4A@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2e51db24-5d37-7f3f-c306-adde5fbe0dff@arm.com>
Date:   Thu, 12 Nov 2020 11:09:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <CAAHhmWiWbUTt-BvjeqGm3mfN2L8A8gUOVVDNX0P=WCEDj=Mc4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 10:37 AM, Linu Cherian wrote:
> Hi Suzuki,
> 
> On Thu, Nov 12, 2020 at 2:51 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Hi Linu,
>>
>> Please could you test this slightly modified version and give us
>> a Tested-by tag if you are happy with the results ?
>>
>> Suzuki
>>
>>
>> On 11/10/20 12:45 PM, Anshuman Khandual wrote:
>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>
>>> When there are multiple sinks on the system, in the absence
>>> of a specified sink, it is quite possible that a default sink
>>> for an ETM could be different from that of another ETM. However
>>> we do not support having multiple sinks for an event yet. This
>>> patch allows the event to use the default sinks on the ETMs
>>> where they are scheduled as long as the sinks are of the same
>>> type.
>>>
>>> e.g, if we have 1x1 topology with per-CPU ETRs, the event can
>>> use the per-CPU ETR for the session. However, if the sinks
>>> are of different type, e.g TMC-ETR on one and a custom sink
>>> on another, the event will only trace on the first detected
>>> sink.
>>>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---


>>> @@ -284,7 +307,12 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>>>        if (!sink_ops(sink)->alloc_buffer || !sink_ops(sink)->free_buffer)
>>>                goto err;
>>>
>>> -     /* Allocate the sink buffer for this session */
>>> +     /*
>>> +      * Allocate the sink buffer for this session. All the sinks
>>> +      * where this event can be scheduled are ensured to be of the
>>> +      * same type. Thus the same sink configuration is used by the
>>> +      * sinks.
>>> +      */
>>>        event_data->snk_config =
>>>                        sink_ops(sink)->alloc_buffer(sink, event, pages,
>>>                                                     nr_pages, overwrite);
>>>
>>
> 
> Perf record and report worked fine with this as well, with formatting
> related opencsd hacks.
> 
> Tested-by : Linu Cherian <lcherian@marvell.com>

Thanks Linu, much appreciated.

Suzuki
