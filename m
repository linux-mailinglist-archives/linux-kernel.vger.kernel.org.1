Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AED23ED89
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHGMuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 08:50:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34684 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726030AbgHGMuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596804633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQm1qyBf5aIqiZDpDRmY+FAOebMcwqNMHmnssREb4eI=;
        b=SJfiH1Jz9f0I6Lt7BU6YzFyCDBz+G8UsCFo1IvZOO+JhZremrx5lqYjuw6Z2uKx9JuuFIO
        VC7WAdygWVDtx6F8de2QaBItUv3C0r6k9OfMn5lI7gH2Hzgt49aKbsonBiHd8jXbI6hSig
        ajcfAuVlNYM4pTKJLayNpp2zpSe6vB8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-NmLnbKG9PCaFpPUqm-hsUw-1; Fri, 07 Aug 2020 08:50:32 -0400
X-MC-Unique: NmLnbKG9PCaFpPUqm-hsUw-1
Received: by mail-wr1-f70.google.com with SMTP id j2so719248wrr.14
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 05:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQm1qyBf5aIqiZDpDRmY+FAOebMcwqNMHmnssREb4eI=;
        b=baSKDaCKvjgfcqHs2lt2RvDIiD3Ldy5jzr5i2CfNZOmE4nFJGor5tYh5kswuFO/RUB
         ZtDbtEI7tKyco6TnnJtJ+f0v6BeaFDSqw+O0YtL/eCUELfItqs3Ox72DGLFExkQmHau+
         uPP38rTFdCHZz51zosIPv1mtDEILzhiRTH3QyB86+7sv5xE1ohs5daYyWv944oRSE8Cf
         rz/mvz8FY4lxOoiPs0ylOgEIiLr1oBBBga/g0bKrcFwAB/IgeH0uNjmMoEUJ1FGWyr1Q
         tuG7Pd6fErXEyH81Zt7JObunLhaIEGoWIHpCEIRvRya8DOATkOiXRkEgJ9Ho1Vngihir
         xB2Q==
X-Gm-Message-State: AOAM531eq1jFxfvHOHS/9Wl07HogrFKElYZNI07/1uK+zadWWhWgGJWh
        DExQG9LYs6pHJVxnLEOeb63WLeZ4dh5Gfin21m58jxNQcNwOKTnad4D3+6eb1eLTDnPBG6e181j
        9Ms3WoucdVPeKwmSf2tSkiCkT
X-Received: by 2002:a7b:c084:: with SMTP id r4mr12467057wmh.20.1596804631078;
        Fri, 07 Aug 2020 05:50:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzr3ELnnmaJebo+idGp6Bb4hQr4sKtgd7JLurmS4zIJg+LW2KlBmQL0sEv4yiipWRet9yHFEQ==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr12467043wmh.20.1596804630765;
        Fri, 07 Aug 2020 05:50:30 -0700 (PDT)
Received: from localhost.localdomain ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id b8sm10108132wrv.4.2020.08.07.05.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 05:50:29 -0700 (PDT)
Date:   Fri, 7 Aug 2020 14:50:27 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807125027.GP42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
 <20200807104618.GH2674@hirez.programming.kicks-ass.net>
 <383e33a0-bace-a387-b47e-30fbec4f18db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383e33a0-bace-a387-b47e-30fbec4f18db@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/20 13:30, Daniel Bristot de Oliveira wrote:
> On 8/7/20 12:46 PM, peterz@infradead.org wrote:
> > On Fri, Aug 07, 2020 at 11:56:04AM +0200, Juri Lelli wrote:
> >> Starting deadline server for lower priority classes right away when
> >> first task is enqueued might break guarantees, as tasks belonging to
> >> intermediate priority classes could be uselessly preempted. E.g., a well
> >> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
> >> there are still CPU cycles available for NORMAL tasks to run, as they'll
> >> be running inside the fair deadline server for some period of time.
> >>
> >> To prevent this issue, implement a starvation monitor mechanism that
> >> starts the deadline server only if a (fair in this case) task hasn't
> >> been scheduled for some interval of time after it has been enqueued.
> >> Use pick/put functions to manage starvation monitor status.
> > One thing I considerd was scheduling this as a least-laxity entity --
> > such that it runs late, not early -- and start the server when
> > rq->nr_running != rq->cfs.h_nr_running, IOW when there's !fair tasks
> > around.

IIUC, this would still require programming a timer to fire when laxity
is 0, but doing that only when there are !fair tasks around (so when
enqueuing the first !fair or if there are !fair already when first fair
is enqueued) would probably save us some overhead, I agree (as no timer
and no enqueue of deadline server would be needed in the common "only
fair" case).

> > 
> > Not saying we should do it like that, but that's perhaps more
> > deterministic than this.
> > 
> 
> I agree, what we want here is something that schedules the server if it still
> retains some runtime when the laxity is 0. But this is easier said than done, as
> this would require another scheduler (other pros and cons and analysis (and
> hours of work)...).
> 
> But, for the starvation monitor purpose, the goal is not (necessarily) to
> provide a deterministic guarantee for the starving task, but to avoid system
> issues while minimizing the damage to the "real" real-time workload. With that
> in mind, we could relax our ambitions...
> 
> Thoughts?

I agree that we don't probably want to develop an additional scheduler/
policy for this, but I'll think a bit more about Peter's idea. Maybe
it's already a viable optimization w/o changing EDF/CBS.

