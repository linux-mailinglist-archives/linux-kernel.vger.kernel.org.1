Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE472DB899
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 02:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgLPBqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 20:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgLPBqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:46:24 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9FBC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 17:45:44 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id v5so6959850qtv.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 17:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCToIgJ9t4fgOgR1IG7z/T+GyYq+8OtwKPwUFbQA53E=;
        b=Gi1o+o2odN0GzIaw5X46sC3GPFaeMhjoBJnGwwFiCma44bSFjsl0bgwIxoEg9ec0Kp
         OztQkTIT0mU8btHuUYdrAT4EBge+EdFc4M94KJ50AivdTCaUvXua82zvmcJn/JcJ0DqM
         GdIW0Wjfmmh0z3upTz/s8oanoeVm2H+6egJWp0TS+xccJ3MoOzpnLVgObdOzRQ0p/26J
         beoVo2wEs4tlY6mVtHNJ8VGZDCOEpSbST+AcuoWOvWGmTF1lgyN3Sd/zwvNFkrQvSnJP
         N0T98P8htYMq+8wRWezxBwXtp74BY8sEV/M6s3OVeHNqUSOsRFaePCy8ZVgFL4MP7Elw
         3/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCToIgJ9t4fgOgR1IG7z/T+GyYq+8OtwKPwUFbQA53E=;
        b=MW1D4bJhUiDT1oDnU45IyiSoh6j+GafMtISy4drArmhljB7vfyOniN3laMS0ToJ9pR
         tA/js3MkUIrtIPTDVvgWE56qEurbgSILNeRTQZ/2XutvWnxDESg7iyOs5LL4ycHIpPDz
         xS7cXcgQN6i6Wv/bU0AU3ypMpeLuzVPG4+y1wczzug5um3nTXOhqGYvBDVfiTMJYx0CC
         L/3R4KY7/l+Xf0VFT1cP5d5cZJylKXZatd+j5TNYP6uPVe6o/C7wyrT5IVRbPxYKHa6s
         A6mDgp9WLFSJQ259jT/oL9sFlHSQHyGTxa9Y46iAZM9hMBL4QiFmv5dXfurkMlVfc+Tq
         YPCg==
X-Gm-Message-State: AOAM5310TzbPQCSk9ko8RN9Em6vVy8e7YrfBJ99+hY1Mf5Yj7dPu19w5
        4fbfHbkcAcXUpWylzbYbXMhdbprmwhJ0NCR5yfCfqA==
X-Google-Smtp-Source: ABdhPJwU/7CORIsAIiTVntmow90QUVubXxG+PPZiFr2mV+dF13CoGd56D1d8SNThX0rRsMFvF8yaaWWUEt3jESh+Tz0=
X-Received: by 2002:ac8:6758:: with SMTP id n24mr41536181qtp.258.1608083143215;
 Tue, 15 Dec 2020 17:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain> <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
 <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org> <20200911085841.GB562@jagdpanzerIV.localdomain>
 <CAJWu+oq26OK1-7Ze2pb5xpRJ-tS9wtXOdGFrYpHq+fhkyGhjkA@mail.gmail.com>
 <fdc35e25f2bc2cdfa0849a84802eafd6@kernel.org> <CAJWu+ooy=r=G+AnyriQDA9_4CJqfO6hkf=c8heV8HV+yNea_PQ@mail.gmail.com>
 <78091359dab0d8decfc452f7c5c25971@kernel.org> <X9M9JuK5DIWzgdyQ@google.com>
In-Reply-To: <X9M9JuK5DIWzgdyQ@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 15 Dec 2020 20:45:32 -0500
Message-ID: <CAJWu+oqwYQDvcRa3_TPtDDXGnUOBPEqM4vCLCc7konKSe0jPEg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be preempted
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        yezengruan <yezengruan@huawei.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        kvmarm@lists.cs.columbia.edu,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Quentin,

On Fri, Dec 11, 2020 at 4:34 AM Quentin Perret <qperret@google.com> wrote:
>
> On Thursday 10 Dec 2020 at 08:45:22 (+0000), Marc Zyngier wrote:
> > On 2020-12-10 01:39, Joel Fernandes wrote:
> >
> > [...]
> >
> > > > Quentin and I have discussed potential ways of improving guest
> > > > scheduling
> > > > on terminally broken systems (otherwise known as big-little), in the
> > > > form of a capacity request from the guest to the host. I'm not really
> > > > keen on the host exposing its own capacity, as that doesn't tell the
> > > > host what the guest actually needs.
> > >
> > > I am not sure how a capacity request could work well. It seems the
> > > cost of a repeated hypercall could be prohibitive. In this case, a
> > > lighter approach might be for KVM to restrict vCPU threads to run on
> > > certain types of cores, and pass the capacity information to the guest
> > > at guest's boot time.
> >
> > That seems like a very narrow use case. If you actually pin vcpus to
> > physical CPU classes, DT is the right place to put things, because
> > it is completely static. This is effectively creating a virtual
> > big-little, which is in my opinion a userspace job.
>
> +1, all you should need for this is to have the VMM pin the vCPUS and
> set capacity-dmips-mhz in the guest DT accordingly. And if you're
> worried about sharing the runqueue with host tasks, could you vacate the
> host CPUs using cpusets or such?

I agree, the VMM is the right place for it with appropriate DT
settings. I think this is similar to how CPUID is emulated on Intel as
well (for example to specify SMT topology for a vCPU) -- it is done by
the VMM.

On sharing vCPU with host tasks, that is indeed an issue because the
host does not know the priority of an app (For example, a "top app"
running in Android in a VM). The sharing with host tasks should be Ok
as long as the scheduler priorities of the vCPU threads on the host
are setup correctly?

> The last difficult bit is how to drive DVFS. I suppose Marc's suggestion
> to relay capacity requests from the guest would help with that.

Yeah I misunderstood Marc.  I think for DVFS, a hypercall for capacity
request should work and be infrequent enough. IIRC, there is some rate
limiting support in cpufreq governors as well that should reduce the
rate of hypercalls if needed.

> > > This would be a one-time cost to pay. And then,
> > > then the guest scheduler can handle the scheduling appropriately
> > > without any more hypercalls. Thoughts?
> >
> > Anything that is a one-off belongs to firmware configuration, IMO.
> >
> > The case I'm concerned with is when vcpus are allowed to roam across
> > the system, and hit random physical CPUs because the host has no idea
> > of the workload the guest deals with (specially as the AMU counters
> > are either absent or unusable on any available core).

It sounds like this might be a usecase for pinning the vCPU threads
appropriately (So designate a set of vCPU threads to only run on bigs
and another set to only run on LITTLEs).  The host can setup the DT to
describe this and the VM kernel's scheduler can do appropriate task
placement.  Did I miss anything?

> > The cost of a hypercall really depends on where you terminate it.
> > If it is a shallow exit, that's only a few hundred cycles on any half
> > baked CPU. Go all the way to userspace, and the host scheduler is the
> > limit. But the frequency of that hypercall obviously matters too.
> >
> > How often do you expect the capacity request to fire? Probably not
> > on each and every time slice, right?
> >
> > Quentin, can you shed some light on this?
>
> Assuming that we change the 'capacity request' (aka uclamp.min of the
> vCPU) every time the guest makes a frequency request, then the answer
> very much is 'it depends on the workload'. Yes there is an overhead, but
> I think it is hard to say how bad that would be before we give it a go.
> It's unfortunately not uncommon to have painfully slow frequency changes
> on real hardware, so this may be just fine. And there may be ways we
> can mitigate this too (with rate limiting and such), so all in all it is
> worth a try.

Agreed.

> Also as per the above, this still would help even if the VMM pins vCPUs
> and such, so these two things can live and complement each other I
> think.

Makes sense.

> Now, for the patch originally under discussion here, no objection from
> me in principle, it looks like a nice improvement to the stolen time
> stuff and I can see how that could help some use-cases, so +1 from me.

Sounds good!

thanks,

 - Joel
