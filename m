Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB526B941
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgIPBO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIPBO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:14:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E093C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 18:14:26 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m7so6231620oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 18:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v87Nh8AE0DpjeRCJH6bm7hqXxyzp5YUhTZEJFlXTatU=;
        b=JjU/A1z+h/DKIi8P3H1TilKCQPBw/XaIL/6W9j+UVfswmbbv4jMK5IpjDLHPLgd0qI
         r3uJyVW+luX9kDMealphr3wxAo1g5IdbN9DhLZR0m0SsYyPfcafOz6//Pn763XWeFq5K
         fWvXFeQkCseIbNGlcfZbO4y/6T5lo0pBWfyQtVf99RYzs6FSYeNog56XI4+PybC/kPEY
         9OoounTKcNQU5T0XACfSYyLxsFC8U1YX7uHh8IVuNlt1cA6DF9ExIa2bm33F/u776UlQ
         kmivyQ25al9AtUAjTDdUyCRpDFdDJYhDhvn5AHJRibg6JF2jjIPpHDgc/cdEwOYrBAqB
         K7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v87Nh8AE0DpjeRCJH6bm7hqXxyzp5YUhTZEJFlXTatU=;
        b=pznVbOWrAC0L+1X7fdVOiGwE3kZEw3VptryS6r6rJwePcEJfTYNbMjbj5puKHbz1Os
         gZZ4SA1e2vbSJSGtelcRRqnGlgLT2xITB/3VDGE+anDjwYZ3Yz44U4mMXJECAtAzVVZU
         BBLoDPrC6PcbiuovxS647YzOFJk38NymwlYV+hygDRmf/ODDnabS6ND4ZEuPhEPa+ABW
         6iYzuYsylLuZsM3hsiIxsuHywVMFXp7zL08i4Pqq6Vqz0naDo8m0s1BEmmpXDVOaKBSe
         xnkSeEMdomT3exiNL5+Hpf8HhU0lK1Ey5UNA1tWvsj3aBm1eIigqXcQmikAEX/aH2s9+
         ijDw==
X-Gm-Message-State: AOAM531Pz0EAWiPwRv4NmPAJ05GQftsUfBbRxktz6VaDbeUKUsePa17L
        K7FEi0FtocZYKwV3B6XC2xysA+MxtdoqWLu85uM=
X-Google-Smtp-Source: ABdhPJwGxDZS4E3VS32Y6ul+d2gbDb6g7p40M7QHi4hx1glpq4jTi189IuOlquzAKejflA3tkfIty30t8tYnTpS5bpU=
X-Received: by 2002:aca:3708:: with SMTP id e8mr1427231oia.101.1600218864848;
 Tue, 15 Sep 2020 18:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914100340.17608-5-vincent.guittot@linaro.org> <CAPJCdBmNK2ZbvsOkzx=6TnzSD=EN28MjD=4ZsmnWjb907MC41g@mail.gmail.com>
 <CAKfTPtC1Z7bAN6WpgdjzpToExR63NL7rGCUpFzT3O6fM1OECkQ@mail.gmail.com>
 <CAPJCdBni3MG2qO-JENao3G0r+q6JjkP3UrX3gxYT0QqRg-bMuw@mail.gmail.com> <CAKfTPtB+YM4B1XL5KPNg1pCP1q5z4+=qqDz2_r3v3jZgfXbmsA@mail.gmail.com>
In-Reply-To: <CAKfTPtB+YM4B1XL5KPNg1pCP1q5z4+=qqDz2_r3v3jZgfXbmsA@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Wed, 16 Sep 2020 09:14:13 +0800
Message-ID: <CAPJCdBmy9+0aQuhvxP3vjU+o6XCKpfLDpbesDLsgRrF_xsKCEg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: reduce busy load balance interval
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 15 Sep 2020 at 20:43, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 15 Sep 2020 at 13:36, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > Hi, Vincent
> >
> > On Tue, 15 Sep 2020 at 17:28, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Tue, 15 Sep 2020 at 11:11, Jiang Biao <benbjiang@gmail.com> wrote:
> > > >
> > > > Hi, Vincent
> > > >
> > > > On Mon, 14 Sep 2020 at 18:07, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > The busy_factor, which increases load balance interval when a cpu is busy,
> > > > > is set to 32 by default. This value generates some huge LB interval on
> > > > > large system like the THX2 made of 2 node x 28 cores x 4 threads.
> > > > > For such system, the interval increases from 112ms to 3584ms at MC level.
> > > > > And from 228ms to 7168ms at NUMA level.
> > > > Agreed that the interval is too big for that case.
> > > > But would it be too small for an AMD environment(like ROME) with 8cpu
> > > > at MC level(CCX), if we reduce busy_factor?
> > >
> > > Are you sure that this is too small ? As mentioned in the commit
> > > message below, I tested it on small system (2x4 cores Arm64) and i
> > > have seen some improvements
> > Not so sure. :)
> > Small interval means more frequent balances and more cost consumed for
> > balancing, especially for pinned vm cases.
>
> If you are running only pinned threads, the interval can increase
> above 512ms which means 8sec after applying the busy factor
Yep. :)

>
> > For our case, we have AMD ROME servers made of 2node x 48cores x
> > 2thread, and 8c at MC level(within a CCX). The 256ms interval seems a
> > little too big for us, compared to Intel Cascadlake CPU with 48c at MC
>
> so IIUC your topology is :
> 2 nodes at NUMA
> 6 CCX at DIE level
> 8 cores per CCX at MC
> 2 threads per core at SMT
Yes.

>
> > level, whose balance interval is 1536ms. 128ms seems a little more
> > waste. :)
>
> the 256ms/128ms interval only looks at 8 cores whereas the 1536
> intervall looks for the whole 48 cores
Yes. The real problem for us is the cpu number difference between MC
and DIE level is too big(8 VS. 96), 3072ms for DIE level is too big(reduce
busy_factor is good enough), while 128ms for MC level seems a little waste(
if reduce busy_factor)
And no objection for this patch. It still looks ok for us.

Thx.
Regards,
Jiang
