Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60E22C0ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgKWMaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730715AbgKWMaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:30:18 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:30:18 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id o144so15766824ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RktsD0CPRruiXqUdBpuftqUscZZRDieT6qGFGubMkAw=;
        b=wyZIPxLr8uXMI/LvXgjy8a7p4+YR2Mss//CR8/zKtcZe2HwB7CyQuXYi4KSuFYxxXB
         nzyMKCj+pGKf6v+tHMiTtCupLxq5NF19Kq73prgdRGTZmhBYix+FZzBaK7If1Lsq6cgN
         1cyLnOIcZfSnUkOid/FpW7LsxxviClYNY1SEUyn3bnSEz5njKszaUAnLM9Wquaiaf4nj
         wTw6OxVte65U1FbYoVt9zNjWIz5LgZEN6fl8foVO6VUnWCoO/lnR+s+Rj5eB7oWR3YlQ
         4s1VPpFXLaxebrkwJP932K/5opC+Np7+pq+lYR9uL2ViDPSF7A1PUAibj9rAlAAJa//O
         1gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RktsD0CPRruiXqUdBpuftqUscZZRDieT6qGFGubMkAw=;
        b=n0QbAuBh3ezMF3motIhoG0ybbVWEZbC9IAH1VwquOvhP9xrmYU0FzvczanpomCPwmI
         ThzXEVgIFl7qf+mBEK/3hoU6Xg9TFjN5LTyxX3LGBJSQcWdu47z6y2P1UdEHvu9VnR1e
         Hl81F8RCiJ9EuhKd5p0O/i5TBxUDl18BsT7WqXE01LERVnOGC9/wBubRzgFul2T4INbG
         a5U6fSPqNEIkU3HkFBe5I8FbVW/ah/zyjm+IzXkTAn52CVHD4b4nJGSL3iSUrTh9/uDr
         lJI92l2FJfVqPSejAlNLqu+VM/EQ4WX6bAQZNgFG7Upyu1yo5OxRa3L2IkYipJnDtn4H
         CGSQ==
X-Gm-Message-State: AOAM532e8rGmTTf4sPfDl2PZOY7IoCcG/zhO5OJ4pZ6c+OYeWDx9pq1t
        0r/7uGYhSakIS3iYoysaz5SKWf+bRnT7HuTxVUfIfw==
X-Google-Smtp-Source: ABdhPJxGV9ajyo7weUN6KmvtjtrVucPBvdCmyNlmd5p78yIQGCidKGKBv1+/2+wgFVHWzoYz/i9TmcvXmL64dT5sXkU=
X-Received: by 2002:a25:26d3:: with SMTP id m202mr34277382ybm.504.1606134617766;
 Mon, 23 Nov 2020 04:30:17 -0800 (PST)
MIME-Version: 1.0
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <20201114051715.GA23685@codeaurora.org> <CAJ9a7ViiZHi92Wr1uurb0B_nE4SmeHmbMChutaS++=FxcC8DTw@mail.gmail.com>
 <aa859d04-8ccf-cb4b-9ae4-524ab7c8451f@arm.com>
In-Reply-To: <aa859d04-8ccf-cb4b-9ae4-524ab7c8451f@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 23 Nov 2020 12:30:07 +0000
Message-ID: <CAJ9a7VhEmBWtasznUSwKm=pEtB2z-4k27X-hs9kZU8kz0bREjg@mail.gmail.com>
Subject: Re: [RFC 00/11] arm64: coresight: Enable ETE and TRBE
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Tingwei Zhang <tingweiz@codeaurora.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Mon, 23 Nov 2020 at 03:40, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Hello Mike,
>
> On 11/16/20 8:30 PM, Mike Leach wrote:
> > Hi Anshuman,
> >
> > I've not looked in detail at this set yet, but having skimmed through
> > it  I do have an initial question about the handling of wrapped data
> > buffers.
> >
> > With the ETR/ETB we found an issue with the way perf concatenated data
> > captured from the hardware buffer into a single contiguous data
> > block. The issue occurs when a wrapped buffer appears after another
> > buffer in the data file. In a typical session perf would stop trace
> > and copy the hardware buffer multiple times into the auxtrace buffer.
>
> The hardware buffer and perf aux trace buffer are the same for TRBE and
> hence there is no actual copy involved. Trace data gets pushed into the
> user space via perf_aux_output_end() either via etm_event_stop() or via
> the IRQ handler i.e arm_trbe_irq_handler(). Data transfer to user space
> happens via updates to perf aux buffer indices i.e head, tail, wake up.
> But logically, they will appear as a stream of records to the user space
> while parsing perf.data file.
>

Understood - I suspected this would use direct write to the aux trace
buffer, but the principle is the same. TRBE determines the location of
data in the buffer so even without a copy, it is possible to get
multiple TRBE "buffers" in the auxbuffer as the TRBE is stopped and
restarted. The later copy to userspace is independent of this.

> >
> > e.g.
> >
> > For ETR/ETB we have a fixed length hardware data buffer - and no way
> > of detecting buffer wraps using interrupts as the tracing is in
> > progress.
>
> TRBE has an interrupt. Hence there will be an opportunity to insert any
> additional packets if required to demarcate pre and post IRQ trace data
> streams.
>
> >
> > If the buffer is not full at the point that perf transfers it then the
> > data will look like this:-
> > 1) <async><synced trace data>
> > easy to decode, we can see the async at the start of the data - which
> > would be the async issued at the start of trace.
>
> Just curious, what makes the tracer to generate the <async> trace packet.
> Is there an explicit instruction or that is how the tracer starts when
> enabled ?

ETM / ETE will generate an async at the start of trace, and then
periodically afterwards.

>
> >
> > If the buffer wraps we see this:-
> >
> > 2) <unsynced trace data><async><synced trace data>
> >
> > Again no real issue, the decoder will skip to the async and trace from
> > there - we lose the unsynced data.
>
> Could you please elaborate more on the difference between sync and async
> trace data ?
>

The decoder will start reading trace from the start of the buffer.
Unsynced trace is trace data that appears before the first async
packet. We cannot decode this as we do not know where the packet
boundaries are.
Synced trace is any data after the first async packet - the async
enables us to determine where the packet boundaries are so we can now
determine the packets and decode the trace.

For an unwrapped buffer, we always see the first async that the ETE
generated when the trace generation was started. In a wrapped buffer
we search till we find an async generated as part of the periodic
async packets.

> >
> > Now the problem occurs when multiple transfers of data occur. We can
> > see the following appearing as contiguous trace in the auxtrace
> > buffer:-
> >
> > 3) < async><synced trace data><unsynced trace data><async><synced trace data>
>
> So there is an wrap around event between <synced trace data> and
> <unsynced trace data> ? Are there any other situations where this
> might happen ?

Not that I am aware of.

>
> >
> > Now the decoder cannot spot the point that the synced data from the
> > first capture ends, and the unsynced data from the second capture
> > begins.
>
> Got it.
>
> > This means it will continue to decode into the unsynced data - which
> > will result in incorrect trace / outright errors. To get round this
> > for ETR/ETB the driver will insert barrier packets into the datafile
> > if a wrap event is detected.
>
> But you mentioned there are on IRQs on ETR/ETB. So how the wrap event
> is even detected ?

A bit in the status register tells us the buffer is full - i.e. the
write pointer has wrapped around to the location it started at.
We cannot tell how far, or if multiple wraps have occurred, just that
the event has occurred.

>
> >
> > 4) <async><synced trace data><barrier><unsynced trace
> > data><async><synced trace data>
> >
> > This <barrier> has the effect of resetting the decoder into the
> > unsynced state so that the invalid trace is not decoded. This is a
> > workaround we have to do to handle the limitations of the ETR / ETB
> > trace hardware.
> Got it.
>
> >
> > For TRBE we do have interrupts, so it should be possible to prevent
> > the buffer wrapping in most cases - but I did see in the code that
> > there are handlers for the TRBE buffer wrap management event. Are
> > there other factors in play that will prevent data pattern 3) from
> > appearing in the auxtrace buffer ?
>
> On TRBE, the buffer wrapping cannot happen without generating an IRQ. I
> would assume that ETE will then start again with an <async> data packet
> first when the handler returns.

This would only occur if the ETE was stopped and flushed prior to the
wrap event. Does this happen? I am assuming that the sink is
independent from the ETE, as ETM are from ETR.

> Otherwise we might also have to insert
> a similar barrier packet for the user space tool to reset. As trace data
> should not get lost during an wrap event,

My understanding is that if a wrap has even occurred, then data is already lost.


> ETE should complete the packet
> after the handler returns, hence aux buffer should still have logically
> contiguous stream of <synced trace data> to decode. I am not sure right
> now, but will look into this.
>

So you are relying on backpressure to stop ETE emitting packets? This
could result in trace being lost due to overflow if the IRQ is not
handled sufficiently quickly/.

Regards

Mike

> - Anshuman


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
