Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA50627EFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbgI3RDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3RDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:03:42 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C29C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:03:42 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q5so2466975ilj.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8mrTDb/+4C9kt/OFrFWQ4KoVsWdxaBzMsz+MNCGDv4=;
        b=Q/vzMXcYGsM37mtX/zsNK3/+zVU6kxcEOtcPXrPi9N5z2tYvX1jvRPm0R1MdSDX4fV
         /DYpI71tvRg5Qu0u6Tb6MXv3+SaUHPuU29JKJP7S/rp2GXczJV9kJOktRtR+t1T858UV
         NbXDm/bY0wwGJa7A/CWEzkNDoWvXBPN9xI3q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8mrTDb/+4C9kt/OFrFWQ4KoVsWdxaBzMsz+MNCGDv4=;
        b=RyMPc6wd5BNUGmTCRLny2gEynw67N+/2dEPngbJtlRdRNjXgaMc+QUBRJbWJff1TH0
         q/htVD9b1nlZskUea67XXAeBYHgoEeZ2TkLQmH/dvChv5V5ZofyYwxD+rb3X9hqr+qgI
         M36XyvdSlzuAq7iwIPHxF8PBZNkLuV4kfjTo32jdzqFEW85YOsZk9Cwo1/Hjc4mEjxvd
         UwqRGhGy+Ru3LWyGmqvquPpe84AhJ57Y5KbS2ClaoyGJbL6vYi6VuVlam7bfm3Wvb0qz
         FAnqha5/zbbtXqM2bPkDHqYmW0tdMB8s6c/haEfaya5yjbmbpR9Wh4V0VG6RhPFbk5DN
         Hr7Q==
X-Gm-Message-State: AOAM53160FtLAB93+2fyaliEwvemPTZxcNgiMLu1Eb+cg18JG/hCih4L
        yFVpakJzj9oYmN/X/GFbiZWSPLzFJXn72apV7QNi5A==
X-Google-Smtp-Source: ABdhPJxutkr1DdLu49sPIlC6A2hL23UJIbkDO1DoXzlFkslrWFmM/cN5bd/j+OfTumzQJtNkcSCHrsgv+IZpDhzLw28=
X-Received: by 2002:a92:d842:: with SMTP id h2mr3125152ilq.176.1601485421339;
 Wed, 30 Sep 2020 10:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200922075002.GU12990@dhcp22.suse.cz> <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net> <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net> <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz> <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz> <20200930152517.GA1470428@google.com> <20200930164822.GX2277@dhcp22.suse.cz>
In-Reply-To: <20200930164822.GX2277@dhcp22.suse.cz>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Sep 2020 13:03:29 -0400
Message-ID: <CAEXW_YSLhXR=7Asa19v7z2Aj=AqDiehHQLych3B7S+qxgPEWzQ@mail.gmail.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 12:48 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 30-09-20 11:25:17, Joel Fernandes wrote:
> > On Fri, Sep 25, 2020 at 05:47:41PM +0200, Michal Hocko wrote:
> > > On Fri 25-09-20 17:31:29, Uladzislau Rezki wrote:
> > > > > > > >
> > > > > > > > All good points!
> > > > > > > >
> > > > > > > > On the other hand, duplicating a portion of the allocator functionality
> > > > > > > > within RCU increases the amount of reserved memory, and needlessly most
> > > > > > > > of the time.
> > > > > > > >
> > > > > > >
> > > > > > > But it's very similar to what mempools are for.
> > > > > > >
> > > > > > As for dynamic caching or mempools. It requires extra logic on top of RCU
> > > > > > to move things forward and it might be not efficient way. As a side
> > > > > > effect, maintaining of the bulk arrays in the separate worker thread
> > > > > > will introduce other drawbacks:
> > > > >
> > > > > This is true but it is also true that it is RCU to require this special
> > > > > logic and we can expect that we might need to fine tune this logic
> > > > > depending on the RCU usage. We definitely do not want to tune the
> > > > > generic page allocator for a very specific usecase, do we?
> > > > >
> > > > I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> > > > to provide a memory service for contexts which are not allowed to
> > > > sleep, RCU is part of them. Both flags used to provide such ability
> > > > before but not anymore.
> > > >
> > > > Do you agree with it?
> > >
> > > Yes this sucks. But this is something that we likely really want to live
> > > with. We have to explicitly _document_ that really atomic contexts in RT
> > > cannot use the allocator. From the past discussions we've had this is
> > > likely the most reasonable way forward because we do not really want to
> > > encourage anybody to do something like that and there should be ways
> > > around that. The same is btw. true also for !RT. The allocator is not
> > > NMI safe and while we should be able to make it compatible I am not
> > > convinced we really want to.
> > >
> > > Would something like this be helpful wrt documentation?
> > >
> > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > index 67a0774e080b..9fcd47606493 100644
> > > --- a/include/linux/gfp.h
> > > +++ b/include/linux/gfp.h
> > > @@ -238,7 +238,9 @@ struct vm_area_struct;
> > >   * %__GFP_FOO flags as necessary.
> > >   *
> > >   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> > > - * watermark is applied to allow access to "atomic reserves"
> > > + * watermark is applied to allow access to "atomic reserves".
> > > + * The current implementation doesn't support NMI and other non-preemptive context
> > > + * (e.g. raw_spin_lock).
> >
> > I think documenting is useful.
> >
> > Could it be more explicit in what the issue is? Something like:
> >
> > * Even with GFP_ATOMIC, calls to the allocator can sleep on PREEMPT_RT
> > systems. Therefore, the current low-level allocator implementation does not
> > support being called from special contexts that are atomic on RT - such as
> > NMI and raw_spin_lock. Due to these constraints and considering calling code
> > usually has no control over the PREEMPT_RT configuration, callers of the
> > allocator should avoid calling the allocator from these cotnexts even in
> > non-RT systems.
>
> I do not mind documenting RT specific behavior but as mentioned in other
> reply, this should likely go via RT tree for now. There is likely more
> to clarify about atomicity for PREEMPT_RT.

I am sorry, I did not understand what you meant by something missing
in Linus Tree. CONFIG_PREEMPT_RT is there.

Could you clarify? Also the CONFIG_PREEMPT_RT is the only thing
driving this requirement for GFP_ATOMIC right? Or are there non-RT
reasons why GFP_ATOMIC allocation cannot be done from
NMI/raw_spin_lock ?

Thanks,

 - Joel
