Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D032FBD38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbhASRKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbhASRHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:07:40 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2CDC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:06:59 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f17so22709611ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXpwPzJZwlc0UGc7Um9uNThZerXWsK0tXXGfexQ/3xA=;
        b=fB4JLW9yzfNNlZRoiqr/Fvop0PO1e/SGB0R17OsGQ47+M3dTGfKockfG91oqUMAIPx
         FL8k5WeXWD/yphfOpJtwNp8U0FMUpXmq8dt1jxVqmJSxF5KXugoSnXMWjeqn3VIPCYHz
         gWblAgLBHo0d1gapim/tHGlzMj6dP4YtSSHgnPuwC9rDVx6FIFdYAjMg9v/aTVdpC2fA
         WUgV5uvfIJ/XhGXAx5H0IEeyjXpDhDs5e8tvjHc5QM7NwwcSsEYyDM1otJ9tQrBOx1Se
         eqmzzBzHAvQPMTzQkgglmG+SVim+cQUpxXyclQALANbob+gzvM8PTHrdLJHcI7T26+TU
         CdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXpwPzJZwlc0UGc7Um9uNThZerXWsK0tXXGfexQ/3xA=;
        b=n4gc/ETHYKBwC9fdOj+o9WpINUGH/zXmed2T+BWlr8+4K44t9ykowQODpPd0HthiiG
         bnggjga3Y9J5Op8Qk44MOJsY/6JrsPvPU6JBctsrFmVmVaKA96gA1fAfMyHptHcvVYsK
         bgJpZ4GEmZunVh76L8CN4uh8MKrBGNNYp8464b5wF+TUwYWS4EE6HprdoOmO1051/dcB
         OXcLRf1AaL4KDEAYUbZ29XlIGLv+1NjzMm3delM4PwUf8kiOCrgUSM9NI9IJuWHhiHex
         XucA5MiPO1LCmyC/QF8NffIeuJy0LBmKHu+V/jx9bNbltje7kb06KpXMXW+Imjz2sBZi
         jiug==
X-Gm-Message-State: AOAM533tN1o3eCbEHMeAtrhvN2Tun2BUjQ8wQGYsDsQZdZ5+SFlIua/o
        y59eQgxa6bW3x0NshuJAHlwfnI+1GwMAnox1D/Zmzw==
X-Google-Smtp-Source: ABdhPJxdwQ2DlJeyKpeq0cCcH32BQ7HUKCPFs+BAbKUP9ue/PrD/TnCl44tvCl8YWjqfZfeTZv0rr3HEzH+FpduILps=
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr2198887ljk.299.1611076017597;
 Tue, 19 Jan 2021 09:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20210119120755.2425264-1-qais.yousef@arm.com> <CAKfTPtD+wU9-UitvnBmZFeAgXbsDO+qcsv-hYr0xxuewB_Kp+A@mail.gmail.com>
 <jhjmtx53ucp.mognet@arm.com> <CAKfTPtCRPViF7B1iqeNVDi31X2sgOWKDJSGCBSzbj0c_Zb=mzA@mail.gmail.com>
 <jhjim7s50j4.mognet@arm.com>
In-Reply-To: <jhjim7s50j4.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Jan 2021 18:06:46 +0100
Message-ID: <CAKfTPtAyiKtbXb6s-GV3g=G0e7ipK6vZJFoOKno5tmntyJsCOQ@mail.gmail.com>
Subject: Re: [PATCH] sched/eas: Don't update misfit status if the task is pinned
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 at 17:55, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 19/01/21 15:19, Vincent Guittot wrote:
> > On Tue, 19 Jan 2021 at 14:54, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >> On 19/01/21 14:34, Vincent Guittot wrote:
> >> >> -       if (!p) {
> >> >> +       if (!p || p->nr_cpus_allowed == 1) {
> >> >
> >> > Side question: What happens if there is 2 misfit tasks and the current
> >> > one is pinned but not the other waiting one
> >> >
> >>
> >> update_misfit_status() is called either on the current task (at tick) or
> >> on the task picked by pick_next_task_fair() - i.e. CFS current or
> >> about-to-be-current.
> >>
> >> So if you have 2 CPU hogs enqueued on a single LITTLE, and one of them
> >> is pinned, the other one will be moved away either via regular load
> >
> > This doesn't seem reliable because it uses load or nr_running
> >
>
> Right
>
> >> balance, or via misfit balance sometime after it's picked as the next
> >> task to run.
> >>
> >> Admittedly that second case suffers from unfortunate timing mostly
> >> related to the load balance interval. There was an old patch in the
> >> Android stack that would reduce the balance interval upon detecting a
> >
> > Shouldn't we keep track of enqueue misfit tasks instead ?
> >
>
> That might help. This being CFS however, the maintenance of it might
> prove prohibitive. I faintly recall having concerns about expanding the
> misfit logic to non-current tasks, but nothing comes to mind right
> now...
>
> Historically (before PELT time scaling) I think it wasn't possible to
> have a steady state with more than one misfit task on a rq, as two
> similar CPU hogs would end up with a utilization value of at most half
> the CPU's capacity. If those were at e.g. opposite ends of the NICE
> spectrum, if one would be flagged as misfit then the other wouldn't
> (can't have two slices greater than 80%!)

I remember this

>
> I *think* that's still true with timescaling, but then we did add the
> uclamp stuff to make tasks look bigger than they are...

Yeah, uclamp makes it possible now

>
> >> misfit task to "accelerate" its upmigration; this might need to be
> >> revisited...
> >>
> >> >>                 rq->misfit_task_load = 0;
> >> >>                 return;
> >> >>         }
> >> >> --
> >> >> 2.25.1
> >> >>
