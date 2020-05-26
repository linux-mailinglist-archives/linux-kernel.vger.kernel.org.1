Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046831BF872
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 14:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgD3Ms3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 08:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgD3Ms0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:48:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9101C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 05:48:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l19so6307980lje.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnO667q5c5E7TSSxaDJD1U38vb/xALkbQXSs3IL9b34=;
        b=d29VIYMn01wGpc1r/vfro9ApyZNaBYF3i+SxZZyi12h4HX6RzcOIQ6KfYrlUzsqqBA
         3XDTMLY3AMK+tn6GAuWbrbqlxxAG0z5/hHr0T4Rs/PV34bcQNSX9yxHFOAlZXnUAA8ls
         8hdsBwfWbtzOU+qRvpDOpr+srM6wrn2YA9oBjWb0X6uXZOmtbkPktRVaJUi0VhNEx/qr
         CtwhZ9cxUVfGldn7kxVWBnMm+1OwmoYQA/q2Y8Fx0WeXyAVe4piDrWkg7wyNdNijkE1J
         W3sJDCnpeOn44Osjqq/klQLUAAbXnNfQze1e8+tn6d+DXlmneIpxILPKMklLOsv91P+r
         1/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnO667q5c5E7TSSxaDJD1U38vb/xALkbQXSs3IL9b34=;
        b=tKbnxg4X1Krp6ho4YL4OBmydQI4/mNGPWItD5dnToe5NzO5TeB1gpnYlMXiWmW0WFu
         a6p6Mmwj5GTS1OMdaUi2wlbrXGTsWtZv2/QjuN8SOFhlzep+9ZCWVH+o5HxzesaPMKSx
         sav2D1bJHwpTAlABN4OLSjRjw9N3+tTrtkq76pcGgZknUIyYkla0QvxzpVFt1yHYL/tx
         R0qAZgNFoEuhytD/nwha2ikhMc1S9E2H3pOZOA9eX6Xq47DXuM+d80nuDacQ+Y4OZA4B
         cvyGfMmHaX/74W+FIBZJ0Ak49Hp7TjR/JX/1eyhuk/fttG+XKYS6uLSdUaqn8X2nwVv+
         RfWw==
X-Gm-Message-State: AGi0Pubp2pzA1KP2xoQ3WvLItsQHXPEzu5y/ybYvnd8Gf1RZiw70oMRe
        Qjn2wxTItSx/F4oen1QlZf0KnQfEczNNBRBIP8cHQg==
X-Google-Smtp-Source: APiQypK5f0ixXmra0GXhuiax3wj9oASqR/v35hM1Y2OypnXRwuvd+a02m5i8KuNhlCYPTunNiv/q34DZvAXy3ITgzNI=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr1984790ljp.209.1588250902213;
 Thu, 30 Apr 2020 05:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200428050242.17717-1-swood@redhat.com>
In-Reply-To: <20200428050242.17717-1-swood@redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Apr 2020 14:48:11 +0200
Message-ID: <CAKfTPtDfk-aq7PTVmMgJcZSOupXb0SGHS8Fc2k+qTZTsnfiV=A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] newidle_balance() latency mitigation
To:     Scott Wood <swood@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 at 07:02, Scott Wood <swood@redhat.com> wrote:
>
> These patches mitigate latency caused by newidle_balance() on large
> systems, by enabling interrupts when the lock is dropped, and exiting
> early at various points if an RT task is runnable on the current CPU.
>
> When applied to an RT kernel on a 72-core machine (2 threads per core), I
> saw significant reductions in latency as reported by rteval -- from
> over 500us to around 160us with hyperthreading disabled, and from
> over 1400us to around 380us with hyperthreading enabled.

Do you know how each patch contributes to the decrease ? Because patch
3 not only impacts newly idle lb but each and every lb. So most of the
decrease might come from aborting the busy or idle lb at the highest
sched_domai level which scan all cpus and moving newly idle load
balance is not a major part.

>
> This isn't the first time something like this has been tried:
> https://lore.kernel.org/lkml/20121222003019.433916240@goodmis.org/
> That attempt ended up being reverted:
> https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/
>
> The problem in that case was the failure to keep BH disabled, and the
> difficulty of fixing that when called from the post_schedule() hook.
> This patchset uses finish_task_switch() to call newidle_balance(), which
> enters in non-atomic context so we have full control over what we disable
> and when.
>
> There was a note at the end about wanting further discussion on the matter --
> does anyone remember if that ever happened and what the conclusion was?
> Are there any other issues with enabling interrupts here and/or moving
> the newidle_balance() call?
>
> Rik van Riel (1):
>   sched,rt: break out of load balancing if an RT task appears
>
> Scott Wood (2):
>   sched/fair: Call newidle_balance() from finish_task_switch()
>   sched/fair: Enable interrupts when dropping lock in newidle_balance()
>
>  kernel/sched/core.c  |  7 +++--
>  kernel/sched/fair.c  | 72 +++++++++++++++++++++++---------------------
>  kernel/sched/sched.h | 12 +++++---
>  3 files changed, 49 insertions(+), 42 deletions(-)
>
> --
> 2.18.2
>
