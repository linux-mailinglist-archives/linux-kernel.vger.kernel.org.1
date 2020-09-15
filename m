Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0B26B89B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgIPAro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIOMnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:43:52 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572D6C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:43:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m5so2926839lfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdnoGvZZuoDjK+pBPUE+py7ccuXjxQJ7tk3copblC6A=;
        b=uOYCDLlXsYlH9NvcGQdPbsHJPYmVDQYAf6rOoST9bWAjlwz80UJ323kBuYRL/OCjYT
         aSuSUYPGWm15SIF+BsFtjFd7z0b0rD3v9ldC64PCZgFKMwDD4j2fOCdfXsGkAq1crJOn
         zbioyIkq8FI6m2+dBf5aQaf4S8IYtHwkYhVamgvFIr9SKjdTq4LUkkbRp8SIi8PqkSys
         dsEcBAA4YdrUusqQ/eoWpaBZDqr+28EfAjJVyLbqzTe1WdA3wbebV88NlRivjFkYwtpF
         VyOJf7/TVSkecqVL30r7AJfCPSq/XZL8BAzJcgZpMgv5O7VBwDCl2CSZTcViBsFpiwzq
         Ysrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdnoGvZZuoDjK+pBPUE+py7ccuXjxQJ7tk3copblC6A=;
        b=RDl01/Vzj0w8D8UYpWecBaE46lcjO3K1t3nmKYhCypGKnHml8VEU3egzr4x95pwOAs
         GKogOsav270mODl7R8NKYEAn9X6/xaX9ZvrOxO6jR8FRrUF5ba8Q/JIg2ipjVJD0XdzK
         hfnTd8eN9mWFj3kiqrVHQwSveSFYF9ZF9Tju/aTqpBx4juw5fU4DvbAhM2l3c8+hB5Xl
         EnWweY8yoHJ7ePmjGgA4KP9wzfm9gJY7bjCf5WGB/M82gd07SkDLvJctt0zDbtj3xQjq
         IMBC5cs6uksSEVyv39b/Xa/mGJu09vdWTbGISsByrgpf1VBy2E/PPtjT9DE1vvkiGAEy
         e3OA==
X-Gm-Message-State: AOAM5305ACFLBmb/Gt5fADcOheGNtdBRorjaXSaMHCH7FsaDLzmQOxJ0
        0vTaMIq5I8fcSwr97wQsk9xMoQtlQpGby8PhYfpaUQ==
X-Google-Smtp-Source: ABdhPJzcvtJMAdMGBoF4mUQzW3NOK49CsNOtHGKfGN7Y48QXCDpe9SuGGLrLrBSn0MIywvp2Uu3vOCidWQQO2ptrdKA=
X-Received: by 2002:a19:604e:: with SMTP id p14mr5720253lfk.385.1600173790755;
 Tue, 15 Sep 2020 05:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914100340.17608-5-vincent.guittot@linaro.org> <CAPJCdBmNK2ZbvsOkzx=6TnzSD=EN28MjD=4ZsmnWjb907MC41g@mail.gmail.com>
 <CAKfTPtC1Z7bAN6WpgdjzpToExR63NL7rGCUpFzT3O6fM1OECkQ@mail.gmail.com> <CAPJCdBni3MG2qO-JENao3G0r+q6JjkP3UrX3gxYT0QqRg-bMuw@mail.gmail.com>
In-Reply-To: <CAPJCdBni3MG2qO-JENao3G0r+q6JjkP3UrX3gxYT0QqRg-bMuw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Sep 2020 14:42:49 +0200
Message-ID: <CAKfTPtB+YM4B1XL5KPNg1pCP1q5z4+=qqDz2_r3v3jZgfXbmsA@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: reduce busy load balance interval
To:     Jiang Biao <benbjiang@gmail.com>
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

On Tue, 15 Sep 2020 at 13:36, Jiang Biao <benbjiang@gmail.com> wrote:
>
> Hi, Vincent
>
> On Tue, 15 Sep 2020 at 17:28, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Tue, 15 Sep 2020 at 11:11, Jiang Biao <benbjiang@gmail.com> wrote:
> > >
> > > Hi, Vincent
> > >
> > > On Mon, 14 Sep 2020 at 18:07, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > The busy_factor, which increases load balance interval when a cpu is busy,
> > > > is set to 32 by default. This value generates some huge LB interval on
> > > > large system like the THX2 made of 2 node x 28 cores x 4 threads.
> > > > For such system, the interval increases from 112ms to 3584ms at MC level.
> > > > And from 228ms to 7168ms at NUMA level.
> > > Agreed that the interval is too big for that case.
> > > But would it be too small for an AMD environment(like ROME) with 8cpu
> > > at MC level(CCX), if we reduce busy_factor?
> >
> > Are you sure that this is too small ? As mentioned in the commit
> > message below, I tested it on small system (2x4 cores Arm64) and i
> > have seen some improvements
> Not so sure. :)
> Small interval means more frequent balances and more cost consumed for
> balancing, especially for pinned vm cases.

If you are running only pinned threads, the interval can increase
above 512ms which means 8sec after applying the busy factor

> For our case, we have AMD ROME servers made of 2node x 48cores x
> 2thread, and 8c at MC level(within a CCX). The 256ms interval seems a
> little too big for us, compared to Intel Cascadlake CPU with 48c at MC

so IIUC your topology is :
2 nodes at NUMA
6 CCX at DIE level
8 cores per CCX at MC
2 threads per core at SMT

> level, whose balance interval is 1536ms. 128ms seems a little more
> waste. :)

the 256ms/128ms interval only looks at 8 cores whereas the 1536
intervall looks for the whole 48 cores

> I guess more balance costs may hurt the throughput of sysbench like
> benchmark.. Just a guess.
>
> >
> > > For that case, the interval could be reduced from 256ms to 128ms.
> > > Or should we define an MIN_INTERVAL for MC level to avoid too small interval?
> >
> > What would be a too small interval ?
> That's hard to say. :)
> My guess is just for large server system cases.
>
> Thanks.
> Regards,
> Jiang
