Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE292CEEFC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgLDNsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgLDNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:48:42 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B0BC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 05:48:01 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so7706368lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 05:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBODEac6wWABSFD4OdzED216K6yEsLpM1TjIWb4e1wo=;
        b=wiiMABR33/3hJ0QiQbmczxNJfaOvBl5PSKoac+uZEP3EnxF694ASr86+V05wT4RDGk
         HJsZqQFti6vdNdIxxbKP1jNDuqN09E8mZbK3cOWM7L0BnFppWLFV3uAkegMePkppu602
         gZU4WuGx4KMpl5SEncVAKmTks9MrLDHX//PviHYnBjVmcl1oZeBe09pHt3qZalyYUgeS
         1a6yLTpmcqtZWRS2rxYuRo4cQX1CPSCOL28o4BHs/hN11iwZxoGvAJdkrKK35xjBXvdf
         N3gO9xs4anofJeSc3RjqfM1N8B5omeLoieAq/UjvvHmc4GSNpYIVjt93aDEa6AWus3sO
         4G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBODEac6wWABSFD4OdzED216K6yEsLpM1TjIWb4e1wo=;
        b=RisvVFRr9P3KamNcnnzn6tsMhyDIWrMPnc1ClRaAFqVVM+bdA5jNCIrBxeyLdW8B5g
         FHjjfE23IwcFNJP78KV1YZdQkWP5xo0l5oYjnsnfRvPfREpBM6gvm6D+eRj1VbNlSKeA
         a9hQcAcJxU28JXi/yeIxXxerwup164t5t4sUbgCPkRZveCvAK1NhmDi8ImfWBp3Cp8x7
         HEOFkPVuPvrmtIJaXH7H3D9lhH7RkTgevqIahyc2fl0AZzJ2mqTeP1Vh7kZ7W/vzTWQ0
         jJHT54P2H5t2YoMC+dvP8AiuZLzPF0tcfeAzN0HRYaPsfDvFArZZ8NLdj0ca+EUDua2d
         j2XQ==
X-Gm-Message-State: AOAM530TyyaIz3Tby6HYClpUxhIHABv0yL57P896C2Ds1j45weq6Lwye
        PGhgfsu50MB2wsgItsP4TDl+552zDMnwjV4R8jpCRA==
X-Google-Smtp-Source: ABdhPJzbyyXoi9NDlbVAPDoVBPTAabxX2/5GUJ+JN146pOiUVHQdYVzkhciqpV6UCDuoCjuHhKVt/SawdZGF66OCcrQ=
X-Received: by 2002:a19:cc91:: with SMTP id c139mr3613023lfg.31.1607089680010;
 Fri, 04 Dec 2020 05:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20201203141124.7391-1-mgorman@techsingularity.net>
 <20201203141124.7391-7-mgorman@techsingularity.net> <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
 <20201203175204.GY3371@techsingularity.net> <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
 <20201204113030.GZ3371@techsingularity.net> <CAKfTPtDRqwUoX51rU0Xd3H9Dwqf8bLAFBxhoeMF1brKYmAZDJg@mail.gmail.com>
 <CAKfTPtBABBY1QSfFtbhBQ7+a8HOp2YfTyJaMVo07T5GU7sp_MA@mail.gmail.com> <3d8a6d19-afac-dc93-127d-da6505402cdf@linux.intel.com>
In-Reply-To: <3d8a6d19-afac-dc93-127d-da6505402cdf@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Dec 2020 14:47:48 +0100
Message-ID: <CAKfTPtAp+SyjmAsxTpSo5owQq0AeDpBWdo5ds0fVZvDr2OK_iw@mail.gmail.com>
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 at 14:40, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2020/12/4 21:17, Vincent Guittot wrote:
> > On Fri, 4 Dec 2020 at 14:13, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >>
> >> On Fri, 4 Dec 2020 at 12:30, Mel Gorman <mgorman@techsingularity.net> wrote:
> >>>
> >>> On Fri, Dec 04, 2020 at 11:56:36AM +0100, Vincent Guittot wrote:
> >>>>> The intent was that the sibling might still be an idle candidate. In
> >>>>> the current draft of the series, I do not even clear this so that the
> >>>>> SMT sibling is considered as an idle candidate. The reasoning is that if
> >>>>> there are no idle cores then an SMT sibling of the target is as good an
> >>>>> idle CPU to select as any.
> >>>>
> >>>> Isn't the purpose of select_idle_smt ?
> >>>>
> >>>
> >>> Only in part.
> >>>
> >>>> select_idle_core() looks for an idle core and opportunistically saves
> >>>> an idle CPU candidate to skip select_idle_cpu. In this case this is
> >>>> useless loops for select_idle_core() because we are sure that the core
> >>>> is not idle
> >>>>
> >>>
> >>> If select_idle_core() finds an idle candidate other than the sibling,
> >>> it'll use it if there is no idle core -- it picks a busy sibling based
> >>> on a linear walk of the cpumask. Similarly, select_idle_cpu() is not
> >>
> >> My point is that it's a waste of time to loop the sibling cpus of
> >> target in select_idle_core because it will not help to find an idle
> >> core. The sibling  cpus will then be check either by select_idle_cpu
> >> of select_idle_smt
> >
> > also, while looping the cpumask, the sibling cpus of not idle cpu are
> > removed and will not be check
> >
>
> IIUC, select_idle_core and select_idle_cpu share the same cpumask(select_idle_mask)?
> If the target's sibling is removed from select_idle_mask from select_idle_core(),
> select_idle_cpu() will lose the chance to pick it up?

This is only relevant for patch 10 which is not to be included IIUC
what mel said in cover letter : "Patches 9 and 10 are stupid in the
context of this series."

>
> Thanks,
> -Aubrey
