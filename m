Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6392F2D72E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437440AbgLKJfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405618AbgLKJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:35:16 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DD0C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 01:34:35 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g25so4301244wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 01:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5QQ72igs5Cq7RXBQftsVNnYL8BXMf0c4vZdsSi9iD6M=;
        b=ZbEyYIsT/WsA8D/qEVLOi8WoMHEZQG+J1GHGY1nKG8ojW4A4kbYb1BZyVKg3bZzFXm
         fpcQ7+i1S5ixpOztTywXdrE6+VC90jztUX/HKFDDLwQa6m8iXsXC6oDBcSvuriVJ5v6e
         ZV6Hxu7P5Yzj8VoqkhqJjMifBhxRYc9ZbaAdCM+D/jxAcl0jZAI5i+cqh/hRCqo3Xuhp
         XK98kFXYjXbfvjXfUB/rN8NDmCtESjTaSYGOJigP/WJdnR9vDm8igGYqFQk6KvgI7kk7
         caIWe4L1SBkGqYGj4lTPZErXDKgNbDV9l5WDn5nC0SexXEqgDRE+bg+aKHzvA1qLPyPw
         F8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QQ72igs5Cq7RXBQftsVNnYL8BXMf0c4vZdsSi9iD6M=;
        b=HGcw7Ag8dI1OdvEk4mjiyS7WBJX5cctA1BUK80j5dP3VzNRpeByLGWAnsY1uMgtw2X
         C+M1Er/UfTnFy2qu5hgW60r3GD86NmHAyXAb1xlCMip7jkyothUt7lR++qAeCouIr9a2
         QkQvGqLTQC09CAqwmvey1/f57jX71ZC2MabD4M2SnNpz+rohmbJQib7U+TifYzPxZpzk
         DHUTQ+MFrUsiFz+4iw5fIvBAuLqx2um1V4zjNm99LZmCenJZPPn0YDUNGvG/1Kix3Sgk
         YuKbAj6K1+RhOUn1OCsueHtezIcr28kqgttQmXTqjcB1AOjRslv5Lo9p+nIlIggpSCZ7
         uZTQ==
X-Gm-Message-State: AOAM533gGc45KONNT4wAeN6A2Mu6RMNUpcDGKcveS7UvNekeDDApS77Y
        aFIO5sT5xaT4q9jzAB5nWIGuYHO6aFIanA==
X-Google-Smtp-Source: ABdhPJxonejdt+TKQH5LoBQQzj9Xf9glLgQrvjTCz41n2F3sIkw98JLxxTja92T7/i70saMzZSW1ig==
X-Received: by 2002:a1c:7c19:: with SMTP id x25mr12370270wmc.145.1607679274075;
        Fri, 11 Dec 2020 01:34:34 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id i16sm12616554wrx.89.2020.12.11.01.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 01:34:33 -0800 (PST)
Date:   Fri, 11 Dec 2020 09:34:30 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        yezengruan <yezengruan@huawei.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        kvmarm@lists.cs.columbia.edu,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
Message-ID: <X9M9JuK5DIWzgdyQ@google.com>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
 <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
 <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org>
 <20200911085841.GB562@jagdpanzerIV.localdomain>
 <CAJWu+oq26OK1-7Ze2pb5xpRJ-tS9wtXOdGFrYpHq+fhkyGhjkA@mail.gmail.com>
 <fdc35e25f2bc2cdfa0849a84802eafd6@kernel.org>
 <CAJWu+ooy=r=G+AnyriQDA9_4CJqfO6hkf=c8heV8HV+yNea_PQ@mail.gmail.com>
 <78091359dab0d8decfc452f7c5c25971@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78091359dab0d8decfc452f7c5c25971@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Dec 2020 at 08:45:22 (+0000), Marc Zyngier wrote:
> On 2020-12-10 01:39, Joel Fernandes wrote:
> 
> [...]
> 
> > > Quentin and I have discussed potential ways of improving guest
> > > scheduling
> > > on terminally broken systems (otherwise known as big-little), in the
> > > form of a capacity request from the guest to the host. I'm not really
> > > keen on the host exposing its own capacity, as that doesn't tell the
> > > host what the guest actually needs.
> > 
> > I am not sure how a capacity request could work well. It seems the
> > cost of a repeated hypercall could be prohibitive. In this case, a
> > lighter approach might be for KVM to restrict vCPU threads to run on
> > certain types of cores, and pass the capacity information to the guest
> > at guest's boot time.
> 
> That seems like a very narrow use case. If you actually pin vcpus to
> physical CPU classes, DT is the right place to put things, because
> it is completely static. This is effectively creating a virtual
> big-little, which is in my opinion a userspace job.

+1, all you should need for this is to have the VMM pin the vCPUS and
set capacity-dmips-mhz in the guest DT accordingly. And if you're
worried about sharing the runqueue with host tasks, could you vacate the
host CPUs using cpusets or such?

The last difficult bit is how to drive DVFS. I suppose Marc's suggestion
to relay capacity requests from the guest would help with that.

> > This would be a one-time cost to pay. And then,
> > then the guest scheduler can handle the scheduling appropriately
> > without any more hypercalls. Thoughts?
> 
> Anything that is a one-off belongs to firmware configuration, IMO.
> 
> The case I'm concerned with is when vcpus are allowed to roam across
> the system, and hit random physical CPUs because the host has no idea
> of the workload the guest deals with (specially as the AMU counters
> are either absent or unusable on any available core).
> 
> The cost of a hypercall really depends on where you terminate it.
> If it is a shallow exit, that's only a few hundred cycles on any half
> baked CPU. Go all the way to userspace, and the host scheduler is the
> limit. But the frequency of that hypercall obviously matters too.
> 
> How often do you expect the capacity request to fire? Probably not
> on each and every time slice, right?
> 
> Quentin, can you shed some light on this?

Assuming that we change the 'capacity request' (aka uclamp.min of the
vCPU) every time the guest makes a frequency request, then the answer
very much is 'it depends on the workload'. Yes there is an overhead, but
I think it is hard to say how bad that would be before we give it a go.
It's unfortunately not uncommon to have painfully slow frequency changes
on real hardware, so this may be just fine. And there may be ways we
can mitigate this too (with rate limiting and such), so all in all it is
worth a try.

Also as per the above, this still would help even if the VMM pins vCPUs
and such, so these two things can live and complement each other I
think.

Now, for the patch originally under discussion here, no objection from
me in principle, it looks like a nice improvement to the stolen time
stuff and I can see how that could help some use-cases, so +1 from me.

Thanks,
Quentin
