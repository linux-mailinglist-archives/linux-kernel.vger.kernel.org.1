Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6589C28E426
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbgJNQPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387838AbgJNQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:15:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A0FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:15:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hk7so106464pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=64O+fR/GllKYCX62Sf5RVZIAk7qknLRTmC65T58b/EE=;
        b=ruI8d9dUhqJ3AqbFASjWfQWYfB0OdQU1zUY5jbpKvA0Raz7Fu/xlInj2J973Fz31sf
         SYoljLdfHknCl1jyKaIaqDGF+LF3TobqleD2BXbbdjWxtOSs4v7lC76WRqEa2uhpA2FB
         t3cRQOCT50R57IscF3K+as6QAtf4EFRKDs5AOfOgVNc//In1UNBVUfkAggD8hE2VZ/x6
         z7cFU5qROZgS+8ZcZuPPfm/co+q4C1jbr2wklTjFmMWpzadMB3nUSRh+6lUI8VsHISi+
         K3cIUH5HFBzGDVPoJWkf2NUwsbiUihVwawlRlx/905Bqvr42s6r1gk+1LCvLWh9TezHj
         ++hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=64O+fR/GllKYCX62Sf5RVZIAk7qknLRTmC65T58b/EE=;
        b=Lcd8x3vWGqyDOxMBjRRi0WtWlbT84DYaWsoAUmOr54mx16ngSJlOwo/ZEF8WjhInoW
         nZf7Ig7TZSyyng4ACkouxhwLn2d0ipcvaIpuygqyYK1L1jSa8QdIGhhjxZc6HH6nXSQ3
         IJ6Rg0ORKtDjYJgTGoqVkQSPCs9dQW6FhAKbweJayukrvC3D+gjwjSAu6rAimAl09nwN
         jEnbxiRWk6zatOlrC321j7CS+se/KVt6y8YqT4MpuGSxyjLKzGLzMOW5NW/9//y9RuYA
         IktXKqJ9fNqOOKzl36y1wCoqPS8AejyWwvqxDow/7HjO3l2yY5a62oOm9JzvFRbsG3qb
         wiXA==
X-Gm-Message-State: AOAM532Xo1d3yo7uVgVFSQ8rI7wjESYcHlrPepsT5mbCc5SKaxwrWhAz
        YB22k6evVAv6RLYOd6w6niM=
X-Google-Smtp-Source: ABdhPJxJEJ2UZAwbLWSxWCDnD8RH7ghYywPArppt9TBOruVqR1ZfroPlzIgrh6W4Gxqyl5Q+lJVzFA==
X-Received: by 2002:a17:902:d88a:b029:d2:1ebe:b4e4 with SMTP id b10-20020a170902d88ab02900d21ebeb4e4mr207419plz.12.1602692129432;
        Wed, 14 Oct 2020 09:15:29 -0700 (PDT)
Received: from ubuntu (1-171-246-157.dynamic-ip.hinet.net. [1.171.246.157])
        by smtp.gmail.com with ESMTPSA id g3sm111061pjl.6.2020.10.14.09.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 09:15:28 -0700 (PDT)
Date:   Thu, 15 Oct 2020 00:15:25 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Qais Yousef <qais.yousef@arm.com>, dietmar.eggemann@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201014161525.GB502296@ubuntu>
References: <20201012163140.371688-1-hsiang023167@gmail.com>
 <87blh6iljc.derkling@matbug.net>
 <20201013102951.orcr6m4q2cb7y6zx@e107158-lin>
 <875z7eic14.derkling@matbug.net>
 <20201013133246.cjomufo5q7qsocrn@e107158-lin>
 <87362ihxvw.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87362ihxvw.derkling@matbug.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 06:52:03PM +0200, Patrick Bellasi wrote:

Hi Patrick,

> 
> On Tue, Oct 13, 2020 at 15:32:46 +0200, Qais Yousef <qais.yousef@arm.com> wrote...
> 
> > On 10/13/20 13:46, Patrick Bellasi wrote:
> >> > So IMO you just need a single SCHED_FLAG_UTIL_CLAMP_RESET that if set in the
> >> > attr, you just execute that loop in __setscheduler_uclamp() + reset
> >> > uc_se->user_defined.
> >> >
> >> > It should be invalid to pass the SCHED_FLAG_UTIL_CLAMP_RESET with
> >> > SCHED_FLAG_UTIL_CLAMP_MIN/MAX. Both have contradictory meaning IMO.
> >> > If user passes both we should return an EINVAL error.
> >> 
> >> Passing in  _CLAMP_RESET|_CLAMP_MIN will mean reset the min value while
> >> keeping the max at whatever it is. I think there could be cases where
> >> this support could be on hand.
> >
> > I am not convinced personally. I'm anxious about what this fine grained control
> > means and how it should be used. I think less is more in this case and we can
> > always relax the restriction (appropriately) later if it's *really* required.
> >
> > Particularly the fact that this user_defined is per uclamp_se and that it
> > affects the cgroup behavior is implementation details this API shouldn't rely
> > on.
> 
> The user_defined flag is an implementation details: true, but since the
> beginning uclamp _always_ allowed a task to set only one of its clamp
> values.
> 
> That's why we have UTIL_CLAMP_{MIN,MAX} as separate flags and all the
> logic in place to set only one of the two.

I agree that UTIL_CLAMP_{MIN,MAX} should be able to set separately.
So the flag usage might be
_CLAMP_RESET => ?
_CLAMP_RESET | _CLAMP_MIN => reset min value
_CLAMP_RESET | _CLAMP_MAX => reset max value
_CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
If user pass _CLAMP_RESET without _CLAMP_MIN or _CLAMP MAX,
Should we reset both min & max value or return EINVAL error?

> 
> 
> > A generic RESET my uclamp settings makes more sense for me as a long term
> > API to maintain.
> >
> > Actually maybe we should even go for a more explicit
> > SCHED_FLAG_UTIL_CLAMP_INHERIT_CGROUP flag instead. If we decide to abandon the
> > support for this feature in the future, at least we can make it return an error
> > without affecting other functionality because of the implicit nature of
> > SCHED_FLAG_UTIL_CLAMP_RESET means inherit cgroup value too.
> 
> That's not true and it's an even worst implementation detail what you
> want to expose.
> 
> A task without a task specific clamp _always_ inherits the system
> defaults. Resetting a task specific clamp already makes sense also
> _without_ cgroups. It means: just do whatever the system allows you to
> do.
> 
> Only if you are running with CGRoups enabled and the task happens to be
> _not_ in the root group, the "CGroups inheritance" happens.
> But that's exactly an internal detail a task should not care about.

I prefer to use SCHED_FLAG_UTIL_CLAMP_RESET because cgroup inheritance
is default behavior when task doesn't set it's uclamp.

> 
> > That being said, I am not strongly against the fine grained approach if that's
> > what Yun wants now or what you both prefer.
> 
> It's not a fine grained approach, it's just adding a reset mechanism for
> what uclamp already allows to do: setting min and max clamps
> independently.
> 
> Regarding use cases, I also believe we have many more use cases of tasks
> interested in setting/resetting just one clamp than tasks interested in
> "fine grain" controlling both clamps at the same time.
> 
> 
> > I just think the name of the flag needs to change to be more explicit
> > too then.
> 
> I don't agree on that and, again, I see much more fine grained details and
> internals exposure in what you propose compared to a single generic
> _RESET flag.
> 
> > It'd be good to hear what others think.
> 
> I agree on that ;)
> 
