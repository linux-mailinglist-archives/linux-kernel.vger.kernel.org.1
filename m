Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385F22E1C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgLWNYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgLWNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:24:35 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A36C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 05:23:54 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 23so39988594lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 05:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mQOsLY5Lqyz1lissRr9BMns7DLVfs/3Tiw8XGDEGTY=;
        b=w9duCLlsE3N4jkIOeIjd9GDkZLicBmib/ehYqCEFoUz3MNFxu07QudEQxzxOD3ksip
         Uc3Nyw1uAtjeYjCqcCaBRx/epGdkK/ZNYKqJ3JS8Ksnw8guz5KQvEnV3UBQiW6ZFnktV
         BGur5qTOaKy7/jZGEkd5cFtjVxdjkRwADJXpZNQCPWoFIjsOSmLHKXClxO0OZEtn0Ie6
         HQciA+CqfSmZFdXDBzS0VwnaH7oxRn226nNZuPRTfu9a0/OetfMT5KvAYAD8KbLwspFd
         C1tIKxF72cVhdbcjG0pEs5GHCNu06bGr0m+OC0/L/hn2tpNiBTjAOOj0/UUXszwzi835
         u0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mQOsLY5Lqyz1lissRr9BMns7DLVfs/3Tiw8XGDEGTY=;
        b=Sjes9Ise12A1zOzoIN502+sr5Oi6fN5Z2dLZHBjjJVTfsLzTvmSq1K2iwxmPUohpXm
         mPHPi55IiXXj+S9R8eSE0StHbIPNjBiEwlE5lsDVzsm4tbRj9bnalcrIFWvSb6etzSBy
         oa/uo6PPGKLgrCGPl6KBLuNRukN274CiBzuHTLYd3+X8iPf5Avfd9c/5qWzruCO8a3In
         fOfCsWpTCwtPaeEfg1BeEFdpbdJDEnxiQbnACMWpkKtz21ItPWUWeI1gcW/xSvHMgNwh
         Td48sbrqx6SPU6l06kOsZtzkxpNkhDrWZfcgqWWw2dkg48Br9QhXeSUdPka5Zxaii2hh
         52eA==
X-Gm-Message-State: AOAM532LAh+0p2Ak6dAMwLdJvf+FWZLS4bveA80nP4MDtiomQZgz9OoN
        5eNYW3PpPbVY2Zh4OmftCQrzcTCGNuAjykVv2T2rPA==
X-Google-Smtp-Source: ABdhPJyXdtRi5c3MCag6L0LRBicpk/133HoJtZ0UB8zeQxJDN2S75iL77NQu3FrGlzkfVj2wKZAc8PH+MuJfderGLEg=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr11088403ljn.176.1608729833264;
 Wed, 23 Dec 2020 05:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20201214164822.402812729@infradead.org> <d2359aa2-1771-30f1-1fe4-4f07c6083b2c@linux.intel.com>
 <CAKfTPtAvTwsPypaTy-UaxACV1xDB-JpyNrNeSBCnHaZjf-V7VA@mail.gmail.com>
In-Reply-To: <CAKfTPtAvTwsPypaTy-UaxACV1xDB-JpyNrNeSBCnHaZjf-V7VA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 23 Dec 2020 14:23:41 +0100
Message-ID: <CAKfTPtAgaK-EtQp_tzxM5Rcw=LORnrrZBbh24C8bqQ4m1u_-rQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5] select_idle_sibling() wreckage
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 at 19:07, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 16 Dec 2020 at 14:00, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
> >
> > Hi Peter,
> >
> > On 2020/12/15 0:48, Peter Zijlstra wrote:
> > > Hai, here them patches Mel asked for. They've not (yet) been through the
> > > robots, so there might be some build fail for configs I've not used.
> > >
> > > Benchmark time :-)
> > >
> >
> > Here is the data on my side, benchmarks were tested on a x86 4 sockets system
> > with 24 cores per socket and 2 hyperthreads per core, total 192 CPUs.
> >
> > uperf throughput: netperf workload, tcp_nodelay, r/w size = 90
> >
> >   threads       baseline-avg    %std    patch-avg       %std
> >   96            1               0.78    1.0072          1.09
> >   144           1               0.58    1.0204          0.83
> >   192           1               0.66    1.0151          0.52
> >   240           1               2.08    0.8990          0.75
> >
> > hackbench: process mode, 25600 loops, 40 file descriptors per group
> >
> >   group         baseline-avg    %std    patch-avg       %std
> >   2(80)         1               10.02   1.0339          9.94
> >   3(120)        1               6.69    1.0049          6.92
> >   4(160)        1               6.76    0.8663          8.74
> >   5(200)        1               2.96    0.9651          4.28
> >
> > schbench: 99th percentile latency, 16 workers per message thread
> >
> >   mthread       baseline-avg    %std    patch-avg       %std
> >   6(96)         1               0.88    1.0055          0.81
> >   9(144)        1               0.59    1.0007          0.37
> >   12(192)       1               0.61    0.9973          0.82
> >   15(240)       1               25.05   0.9251          18.36
> >
> > sysbench mysql throughput: read/write, table size = 10,000,000
> >
> >   thread        baseline-avg    %std    patch-avg       %std
> >   96            1               6.62    0.9668          4.04
> >   144           1               9.29    0.9579          6.53
> >   192           1               9.52    0.9503          5.35
> >   240           1               8.55    0.9657          3.34
> >
> > It looks like
> > - hackbench has a significant improvement of 4 groups
> > - uperf has a significant regression of 240 threads
>
> Tests are still running on my side but early results shows perf
> regression for hackbench

Few more results before being off:
On small embedded system, the problem seems to be mainly a matter of
setting the right number of loops.

On large smt system, The system on which  I usually run my tests  if
off for now so i haven't been able to finalize tests yet but the
problem might be that we don't loop all core anymore with this
patchset compare to current algorithm

>
> >
> > Please let me know if you have any interested cases I can run/rerun.
> >
> > Thanks,
> > -Aubrey
