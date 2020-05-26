Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CC71C5DC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgEEQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgEEQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:40:48 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9062C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:40:47 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t8so1325120qvw.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l2bZJQmx2yOdyRWXMcVA9Hr5m54Y4Z+/y8vz43EAX8c=;
        b=HGTZoh4KeqX6Uji51n5Dqfk0eq1uWiMkwpLlCbtNM2ptuSoknJ3SJokShT9RddkiiA
         dyCYk+AJUScVGogd3LbtB5qGZ7TArY1dddPKiSFnpH2cT1Er1UBaOgmvSOKhQwwtxgU7
         An/Xfou2A/jLmU+WaypU/qBQLQ9I0Lwq3cDA60/Pk0qRhkEN6COva+m26DdvjqiwoqG8
         omVIPq8k/FOSepfH7rvaBuy3OYeTlxnsee55DCHQ2VjVtOHDuqUv+Vdtppv0fnaFmxUE
         rjObgvGNPkng+b4UO4ikBvcvtv6Y+HXUE9neG4LXYuvRdX1LjY30KRhklHfrHkFnsIwa
         vqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2bZJQmx2yOdyRWXMcVA9Hr5m54Y4Z+/y8vz43EAX8c=;
        b=BlQP1rZKH8fAHEjjbkjSs+M8Gr0QDBGrKMuDo6ZbCksGAKdyT9/IV6dk0SNEorOHS9
         jU3Am/8W2jHkqFjQ7p1COWvAPEFmeqPi3TFAt1nd/8rcopo4Qup9KtTiJhZ1wYSR1fYb
         R3tH32zeXUP6+AkLuUgPVtfa/JwXKvTUB4PWelj4R5RmiE5a289BxLRLqn8kQ93uwyo5
         cNHPstJO+0B2YyVi86qJzxC22WLEqjPNFLd9wrSzob32U0JTq7MTGWu6HBfgcp2+bCDm
         +RrIF0AxAU3ovOR2hUbOqf/hMunpcuUDwYHB94D11b9u4RV/ZGkogapphxWb1yh4OveE
         ICYg==
X-Gm-Message-State: AGi0PuY1hPxuQOj/JLD7sz7Mzx6yIXF+4pQI/66MqiK11mv4lMLtqIgp
        AUJ5k1ZjlZa/ulFjyX6qUnlRxA==
X-Google-Smtp-Source: APiQypJBI1Iddc2SwERK37fLTH83IVhbEuz4QyGiAEOV6UK9VOcqk/apxzVDX7wNDl531Nz60OWwpw==
X-Received: by 2002:a05:6214:54d:: with SMTP id ci13mr3591929qvb.131.1588696846971;
        Tue, 05 May 2020 09:40:46 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id s4sm789531qth.61.2020.05.05.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:40:46 -0700 (PDT)
Date:   Tue, 5 May 2020 12:40:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200505164031.GC58018@cmpxchg.org>
References: <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz>
 <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz>
 <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
 <20200504160613.GU22838@dhcp22.suse.cz>
 <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
 <20200505152712.GB58018@cmpxchg.org>
 <CALvZod48mu1w=fjpD=GXqCMdNq_8rExQ177_EP+Lx+TvR6fw+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod48mu1w=fjpD=GXqCMdNq_8rExQ177_EP+Lx+TvR6fw+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 08:35:45AM -0700, Shakeel Butt wrote:
> On Tue, May 5, 2020 at 8:27 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, May 04, 2020 at 12:23:51PM -0700, Shakeel Butt wrote:
> > > On Mon, May 4, 2020 at 9:06 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > I really hate to repeat myself but this is no different from a regular
> > > > oom situation.
> > >
> > > Conceptually yes there is no difference but there is no *divine
> > > restriction* to not make a difference if there is a real world
> > > use-case which would benefit from it.
> >
> > I would wholeheartedly agree with this in general.
> >
> > However, we're talking about the very semantics that set memory.max
> > apart from memory.high: triggering OOM kills to enforce the limit.
> >
> > > > when the kernel cannot act and mentions that along with the
> > > > oom report so that whoever consumes that information can debug or act on
> > > > that fact.
> > > >
> > > > Silencing the oom report is simply removing a potentially useful
> > > > aid to debug further a potential problem.
> > >
> > > *Potentially* useful for debugging versus actually beneficial for
> > > "sweep before tear down" use-case. Also I am not saying to make "no
> > > dumps for memory.max when no eligible tasks" a set in stone rule. We
> > > can always reevaluate when such information will actually be useful.
> > >
> > > Johannes/Andrew, what's your opinion?
> >
> > I still think that if you want to sweep without triggering OOMs,
> > memory.high has the matching semantics.
> >
> > As you pointed out, it doesn't work well for foreign charges, but that
> > is more of a limitation in the implementation than in the semantics:
> >
> >         /*
> >          * If the hierarchy is above the normal consumption range, schedule
> >          * reclaim on returning to userland.  We can perform reclaim here
> >          * if __GFP_RECLAIM but let's always punt for simplicity and so that
> >          * GFP_KERNEL can consistently be used during reclaim.  @memcg is
> >          * not recorded as it most likely matches current's and won't
> >          * change in the meantime.  As high limit is checked again before
> >          * reclaim, the cost of mismatch is negligible.
> >          */
> >
> > Wouldn't it be more useful to fix that instead? It shouldn't be much
> > of a code change to do sync reclaim in try_charge().
> 
> Sync reclaim would really simplify the remote charging case. Though
> should sync reclaim only be done for remote charging or for all?

I would do it for all __GFP_RECLAIM callers, no need to special case
remote charging unnecessarily IMO.

We can do both the reclaim as well as the penalty throttling
synchronously, i.e. all of mem_cgroup_handle_over_high(). And then
punt to the userspace resume when we either didn't reclaim or are
still over the threshold after reclaim.

Btw we should probably kick off high_work rather than set userspace
resume on foreign charges, right? Otherwise we may not reclaim at all
when we push a group over its limit from outside (and in a
!__GFP_RECLAIM context).
