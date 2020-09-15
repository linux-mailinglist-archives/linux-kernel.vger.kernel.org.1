Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FAF26B8DB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIPAvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgIOLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:36:29 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D355C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:36:28 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o8so2901568otl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BTH4hYV4B4dr8UvozyKIS6RwtFNWec8KfhyM0AE6Qc=;
        b=hOwgrJB4oFdOSRj3vyxBUqBo2w70rKKrtDqGxTxuPUHxBSRKqAfaYTSiTsTVjL3QWg
         +SxuVlbaeUK01wBEpy1a7Mv4cN/GW8ibCuDmTv+5/5LSlEakqyfLwzpHQLv2/DYJYekt
         7V9H3bomGcTmIHdO+0J+J20rUugFpv7WctV0SQ/HQ32ceAPS4qf5WU64e35bvSM3A8eD
         zQ6tpOg1hcaoSLhevNSvjWxGwHosppuhr52e9hUxVt0sZcvvi/bsjRSN/1Q5mngOfIlz
         sj7gq0+zdDflbqY7ImsDJxRW2UTMjZpMvSdV7JpSnoWFITXXb/GQgFvqISagP6yoJkS2
         OQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BTH4hYV4B4dr8UvozyKIS6RwtFNWec8KfhyM0AE6Qc=;
        b=nfCEorowKtyxgf3B8IFOzduIsX+/Pe4U0QB/n1cKsqn5ocinOIQ+E9RwZ1Xs07bs0p
         VKQkVyC7shcuaWk5AJ8OCwITFFEWA6B9f8Ij2d3T0iKUlwUSKzs2n4M3+x/xe24vy/gz
         /r9vaZX9XX0d+c1xwHfvseVOKO1f6BEgf8aDnrqnGf9PcckmRnnBem+dWu+DJHF8kjyD
         5lUQ/YOVo54tRY5xqw1UUt8T9JmM0SqgIlkCdPFGcmdEZmh5IoQxvYKyW48dE4JQRpRk
         Ix89rhjoNYKwYTFUbLG7iW7TJ+Va6fSt8EuZM1Nr19Y6Ymoh/XdiUmA+bH+UBUblWfNC
         lIuw==
X-Gm-Message-State: AOAM530tBHUBlKRBFda9G/JpgQ/6zLUd5KDLbbU+5wpjMRyE78wbDBWD
        fcevi88CLlFYXkzkST7TfabSng0OAPTr943O0F4=
X-Google-Smtp-Source: ABdhPJz8e6ND+g18CYru0/1P/vFxdNofaG3uFX6lMhnfzByDW1SMix/YcWhLiyovyHoTtx2bQTYB+qTVAJa/j+740Tw=
X-Received: by 2002:a9d:758c:: with SMTP id s12mr11873480otk.237.1600169787933;
 Tue, 15 Sep 2020 04:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914100340.17608-5-vincent.guittot@linaro.org> <CAPJCdBmNK2ZbvsOkzx=6TnzSD=EN28MjD=4ZsmnWjb907MC41g@mail.gmail.com>
 <CAKfTPtC1Z7bAN6WpgdjzpToExR63NL7rGCUpFzT3O6fM1OECkQ@mail.gmail.com>
In-Reply-To: <CAKfTPtC1Z7bAN6WpgdjzpToExR63NL7rGCUpFzT3O6fM1OECkQ@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Tue, 15 Sep 2020 19:36:16 +0800
Message-ID: <CAPJCdBni3MG2qO-JENao3G0r+q6JjkP3UrX3gxYT0QqRg-bMuw@mail.gmail.com>
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

Hi, Vincent

On Tue, 15 Sep 2020 at 17:28, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 15 Sep 2020 at 11:11, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > Hi, Vincent
> >
> > On Mon, 14 Sep 2020 at 18:07, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > The busy_factor, which increases load balance interval when a cpu is busy,
> > > is set to 32 by default. This value generates some huge LB interval on
> > > large system like the THX2 made of 2 node x 28 cores x 4 threads.
> > > For such system, the interval increases from 112ms to 3584ms at MC level.
> > > And from 228ms to 7168ms at NUMA level.
> > Agreed that the interval is too big for that case.
> > But would it be too small for an AMD environment(like ROME) with 8cpu
> > at MC level(CCX), if we reduce busy_factor?
>
> Are you sure that this is too small ? As mentioned in the commit
> message below, I tested it on small system (2x4 cores Arm64) and i
> have seen some improvements
Not so sure. :)
Small interval means more frequent balances and more cost consumed for
balancing, especially for pinned vm cases.
For our case, we have AMD ROME servers made of 2node x 48cores x
2thread, and 8c at MC level(within a CCX). The 256ms interval seems a
little too big for us, compared to Intel Cascadlake CPU with 48c at MC
level, whose balance interval is 1536ms. 128ms seems a little more
waste. :)
I guess more balance costs may hurt the throughput of sysbench like
benchmark.. Just a guess.

>
> > For that case, the interval could be reduced from 256ms to 128ms.
> > Or should we define an MIN_INTERVAL for MC level to avoid too small interval?
>
> What would be a too small interval ?
That's hard to say. :)
My guess is just for large server system cases.

Thanks.
Regards,
Jiang
