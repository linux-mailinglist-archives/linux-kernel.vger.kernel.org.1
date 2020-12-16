Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6A22DC5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgLPSIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgLPSIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:08:02 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98016C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:07:21 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a9so50651951lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftyVekEQUWj0XLEj2R0kKRubbFOiCpA5xWJjszELmT4=;
        b=ePxcMM0M4xLTQBpeQE7v+hVppOfaWcS+Up8F2kyKYGVK127WuGZD7Ky/+IJnauNUKY
         0sPnE5Dg/FKhxgOYjWPu+It+hHSfdQ5ezixPoWFW4z/ENM2xlkXh10WduO6i4SkcKlWv
         zZi2EtFVCsOLO5hgFTte1oNS6zHspjIlqF7YHO886GCr5LP0k5+qlSq6AoRV6FYAA4re
         7TCSNc6owGegShiaCpXNsJTtX88gqqKBE0BBTo0DbLMmRixhbf5mY0v1pKpWXcKUJbE6
         C84ClOOTOTCq4sj1pt7aBZq7Fbp3weysiu7T7ao14pYKxKFJanygciVKmXoDXVfwnKPR
         Nxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftyVekEQUWj0XLEj2R0kKRubbFOiCpA5xWJjszELmT4=;
        b=I8rqnn8zN7QpoXaCbj2xJDYMIDNDZUZlJtobjgFifXVsfX0P0HiHHp0p9TNksMib7w
         FMm2gzYhNQI/4uHXGEQimLh3ln3lSGpZG3qwKPpWCFfeirKe/oQzB7yw8ppxD1QPQ26I
         Iu+ITvEbHYhj1+ReQHfq5BjS4mNxApE+xOf5s5h3I1GQGhcA1bMUoHftsO25Fbk3Pifx
         Yd1NqQmRHDCXfXSdXCJoUAzOqltsPne25OWoUmlo7ta3eDXMasm/TcdH3FQ3X5ZKnzWT
         I/GR12PVeXqt5To+5/O5NmZcB0fLq1DGdq15HhNfPtmBMq6PywLXCET/dpLs2tJT32tV
         0j+A==
X-Gm-Message-State: AOAM533VQEzHX1wA+iAsBhJDampElaqnEj4Zm7dyMx8k4zqmL0VKuPHU
        unDukJ6LQhLASZ1GEkB6cpN5WcpF+j7QCxCDU5Tw9g==
X-Google-Smtp-Source: ABdhPJz0b5YgfpKrJFAstYu6ylt6g8zmK1Iy0krsW6FOqGgz4D4+T5wyvk7pe9rjE4vfAuJVsJas64JvabYmszlqAF0=
X-Received: by 2002:ac2:5dfa:: with SMTP id z26mr14552304lfq.286.1608142039027;
 Wed, 16 Dec 2020 10:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20201214164822.402812729@infradead.org> <d2359aa2-1771-30f1-1fe4-4f07c6083b2c@linux.intel.com>
In-Reply-To: <d2359aa2-1771-30f1-1fe4-4f07c6083b2c@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Dec 2020 19:07:08 +0100
Message-ID: <CAKfTPtAvTwsPypaTy-UaxACV1xDB-JpyNrNeSBCnHaZjf-V7VA@mail.gmail.com>
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

On Wed, 16 Dec 2020 at 14:00, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> Hi Peter,
>
> On 2020/12/15 0:48, Peter Zijlstra wrote:
> > Hai, here them patches Mel asked for. They've not (yet) been through the
> > robots, so there might be some build fail for configs I've not used.
> >
> > Benchmark time :-)
> >
>
> Here is the data on my side, benchmarks were tested on a x86 4 sockets system
> with 24 cores per socket and 2 hyperthreads per core, total 192 CPUs.
>
> uperf throughput: netperf workload, tcp_nodelay, r/w size = 90
>
>   threads       baseline-avg    %std    patch-avg       %std
>   96            1               0.78    1.0072          1.09
>   144           1               0.58    1.0204          0.83
>   192           1               0.66    1.0151          0.52
>   240           1               2.08    0.8990          0.75
>
> hackbench: process mode, 25600 loops, 40 file descriptors per group
>
>   group         baseline-avg    %std    patch-avg       %std
>   2(80)         1               10.02   1.0339          9.94
>   3(120)        1               6.69    1.0049          6.92
>   4(160)        1               6.76    0.8663          8.74
>   5(200)        1               2.96    0.9651          4.28
>
> schbench: 99th percentile latency, 16 workers per message thread
>
>   mthread       baseline-avg    %std    patch-avg       %std
>   6(96)         1               0.88    1.0055          0.81
>   9(144)        1               0.59    1.0007          0.37
>   12(192)       1               0.61    0.9973          0.82
>   15(240)       1               25.05   0.9251          18.36
>
> sysbench mysql throughput: read/write, table size = 10,000,000
>
>   thread        baseline-avg    %std    patch-avg       %std
>   96            1               6.62    0.9668          4.04
>   144           1               9.29    0.9579          6.53
>   192           1               9.52    0.9503          5.35
>   240           1               8.55    0.9657          3.34
>
> It looks like
> - hackbench has a significant improvement of 4 groups
> - uperf has a significant regression of 240 threads

Tests are still running on my side but early results shows perf
regression for hackbench

>
> Please let me know if you have any interested cases I can run/rerun.
>
> Thanks,
> -Aubrey
