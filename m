Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368202780E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgIYGvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgIYGvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:51:08 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CFBC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 23:51:08 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b22so1551713lfs.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMULH01Wq7nTloeFkP19h8fM7ByqolfRu/BqukyTcPQ=;
        b=fAXscyKKYhC2jxJ7WxAKHgsKNDvga6TN7EyNw5EH0tMyvLsP7DIwYs3QBXeU5KXvJP
         9kovWLLhlprZyX68eEBUjfTcHLtrQDBCCGKoMqvxjhJTf3LK7isnYM7/JHAqdVsfZqp3
         Fre61Ei8jzsbQe3Z7zEI8zv1KJrTJ+yrVVNn3aARHkunJovO0fldZdLOHCnbD22TUm7m
         k4r9izC/2Cu6tPuf11qpE4ayJcK5skOKEz2XWHyuiuJqzmGQgckHUXW7HSSI4GmFL/ci
         J7ufnQsk045N671XDE2SuSjNM63aW9rbyge3RbopcpzBAgIt7Ako6VAwsOUSh7JFw8l5
         DEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMULH01Wq7nTloeFkP19h8fM7ByqolfRu/BqukyTcPQ=;
        b=Z5eKPaAZjobe0XP9iETOL6fmSSCUc/3FCe0+Ou/863Y16jCwVeoflxRd9E8PV+4vmg
         Q6t5T8ORlSOyaglYeGnXU3Lg/4K4NVgHvIKmp3Ct1nCupJE3XMpbsBZlhtj89ptj8wXm
         2ROhSRoxWWoPPWOFqNUhQpEAdOT9OlF6VOONB+8F1P8bMPdm0h5JM5mbeBUeBev854e5
         GaExoe79qTvKLWvsMfkHlDG1C1Jkq47nSQqQEVSyr1xAq/AU36YQCsfNYcz/7XYriKkU
         gSbvidzSOj1BvkgWS8K7EHlY7eVUoPQLDhyaNdJWqbziQztOriJ8M8ityoTBPgZi3e+i
         nHog==
X-Gm-Message-State: AOAM5328KQxcrezvyvsq0CFIVnAFn1nGbr8kjVI/lFVbvbTbsHPoguxx
        J0K4qzAXezQ/G68BvySc80NBebBaM70ZCNUSUJhmuw==
X-Google-Smtp-Source: ABdhPJxrtgtXWdAgLSGmTRS1MGIMO8Yckz8P7xWJyBKOYvU5U6/hkA9wFc3kz/BVJvE+lyC/pw7DGFgK36Txhp27a60=
X-Received: by 2002:a19:7006:: with SMTP id h6mr763893lfc.83.1601016666611;
 Thu, 24 Sep 2020 23:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200916043103.606132-1-aubrey.li@linux.intel.com>
 <20200916110039.GG3117@suse.de> <78d608f2-b974-e940-da32-b37777bc405a@linux.intel.com>
 <CAKfTPtAVkg081VEGp3Hx3i7D+jxRJcyBi2=NJypvHH6HVJ8Nwg@mail.gmail.com>
 <CAKfTPtA2yE_sFfP5MFN=K+ph7rqpYUhapUdDBJ5hFLxnQPktJw@mail.gmail.com>
 <af0237e0-1451-9d11-2ee2-1468a8bb6180@linux.intel.com> <CAKfTPtD71z-n2dVTpZk5tLwy5OZjkju9v5vJ-3QNHhw8Grhc_Q@mail.gmail.com>
 <40ee756f-1f27-b17e-6292-d8069a56e3c8@linux.intel.com>
In-Reply-To: <40ee756f-1f27-b17e-6292-d8069a56e3c8@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 25 Sep 2020 08:50:55 +0200
Message-ID: <CAKfTPtCvQ41-mqvYXc-DWnz3y5byw_OsmHNfc7UvczC-nwWMUg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in
 sched domain
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim

On Thu, 24 Sep 2020 at 18:37, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>
>
> On 9/22/20 12:14 AM, Vincent Guittot wrote:
>
> >>
> >>>>
> >>>> And a quick test with hackbench on my octo cores arm64 gives for 12
>
> Vincent,
>
> Is it octo (=10) or octa (=8) cores on a single socket for your system?

it's a 8 cores and the cores are splitted in 2 cache domains

> The L2 is per core or there are multiple L2s shared among groups of cores?
>
> Wonder if placing the threads within a L2 or not within
> an L2 could cause differences seen with Aubrey's test.

I haven't checked recently but the 2 tasks involved in sched pipe run
on CPUs which belong to the same cache domain

Vincent

>
> Tim
>
