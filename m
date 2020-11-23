Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4E2BFEC5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgKWDkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:40:06 -0500
Received: from foss.arm.com ([217.140.110.172]:54356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgKWDkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:40:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A95BF30E;
        Sun, 22 Nov 2020 19:40:04 -0800 (PST)
Received: from [10.163.82.200] (unknown [10.163.82.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D95A83F70D;
        Sun, 22 Nov 2020 19:40:02 -0800 (PST)
Subject: Re: [RFC 00/11] arm64: coresight: Enable ETE and TRBE
To:     Mike Leach <mike.leach@linaro.org>,
        Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <20201114051715.GA23685@codeaurora.org>
 <CAJ9a7ViiZHi92Wr1uurb0B_nE4SmeHmbMChutaS++=FxcC8DTw@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <aa859d04-8ccf-cb4b-9ae4-524ab7c8451f@arm.com>
Date:   Mon, 23 Nov 2020 09:10:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJ9a7ViiZHi92Wr1uurb0B_nE4SmeHmbMChutaS++=FxcC8DTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On 11/16/20 8:30 PM, Mike Leach wrote:
> Hi Anshuman,
> 
> I've not looked in detail at this set yet, but having skimmed through
> it  I do have an initial question about the handling of wrapped data
> buffers.
> 
> With the ETR/ETB we found an issue with the way perf concatenated data
> captured from the hardware buffer into a single contiguous data
> block. The issue occurs when a wrapped buffer appears after another
> buffer in the data file. In a typical session perf would stop trace
> and copy the hardware buffer multiple times into the auxtrace buffer.

The hardware buffer and perf aux trace buffer are the same for TRBE and
hence there is no actual copy involved. Trace data gets pushed into the
user space via perf_aux_output_end() either via etm_event_stop() or via
the IRQ handler i.e arm_trbe_irq_handler(). Data transfer to user space
happens via updates to perf aux buffer indices i.e head, tail, wake up.
But logically, they will appear as a stream of records to the user space
while parsing perf.data file.

> 
> e.g.
> 
> For ETR/ETB we have a fixed length hardware data buffer - and no way
> of detecting buffer wraps using interrupts as the tracing is in
> progress.

TRBE has an interrupt. Hence there will be an opportunity to insert any
additional packets if required to demarcate pre and post IRQ trace data
streams. 

> 
> If the buffer is not full at the point that perf transfers it then the
> data will look like this:-
> 1) <async><synced trace data>
> easy to decode, we can see the async at the start of the data - which
> would be the async issued at the start of trace.

Just curious, what makes the tracer to generate the <async> trace packet.
Is there an explicit instruction or that is how the tracer starts when
enabled ?

> 
> If the buffer wraps we see this:-
> 
> 2) <unsynced trace data><async><synced trace data>
> 
> Again no real issue, the decoder will skip to the async and trace from
> there - we lose the unsynced data.

Could you please elaborate more on the difference between sync and async
trace data ?

> 
> Now the problem occurs when multiple transfers of data occur. We can
> see the following appearing as contiguous trace in the auxtrace
> buffer:-
> 
> 3) < async><synced trace data><unsynced trace data><async><synced trace data>

So there is an wrap around event between <synced trace data> and
<unsynced trace data> ? Are there any other situations where this
might happen ?

> 
> Now the decoder cannot spot the point that the synced data from the
> first capture ends, and the unsynced data from the second capture
> begins.

Got it.

> This means it will continue to decode into the unsynced data - which
> will result in incorrect trace / outright errors. To get round this
> for ETR/ETB the driver will insert barrier packets into the datafile
> if a wrap event is detected.

But you mentioned there are on IRQs on ETR/ETB. So how the wrap event
is even detected ?

> 
> 4) <async><synced trace data><barrier><unsynced trace
> data><async><synced trace data>
> 
> This <barrier> has the effect of resetting the decoder into the
> unsynced state so that the invalid trace is not decoded. This is a
> workaround we have to do to handle the limitations of the ETR / ETB
> trace hardware.
Got it.

> 
> For TRBE we do have interrupts, so it should be possible to prevent
> the buffer wrapping in most cases - but I did see in the code that
> there are handlers for the TRBE buffer wrap management event. Are
> there other factors in play that will prevent data pattern 3) from
> appearing in the auxtrace buffer ?

On TRBE, the buffer wrapping cannot happen without generating an IRQ. I
would assume that ETE will then start again with an <async> data packet
first when the handler returns. Otherwise we might also have to insert
a similar barrier packet for the user space tool to reset. As trace data
should not get lost during an wrap event, ETE should complete the packet
after the handler returns, hence aux buffer should still have logically
contiguous stream of <synced trace data> to decode. I am not sure right
now, but will look into this.

- Anshuman
