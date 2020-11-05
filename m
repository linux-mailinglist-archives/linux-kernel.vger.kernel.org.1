Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650142A794D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgKEIaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgKEIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:30:06 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3412FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:30:06 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id a4so609770ybq.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=264wdrikSygrgRX7gnlG58YTkPsCHu6frlnu5l84msg=;
        b=ZujLkERmMZk6Ns2h42kACmMmDk2/V3/OlDZv0fGlZB2SHvVthIIX0kbWZv89IOpVKE
         Vxdh4fabAgv6OX/FCklXzAJvy99rFlc8ytr/X7rzNiMnKloi7CeZpkXU2JAvcoJG24Z/
         NjPYGZx9Yez4+knY6/2dE7+FLZWtzbFe96+TpMrJK0jk7w74ikDFioQPIbrXSFB9f2TQ
         eq7eDjPbBKl6UTZFZNjtkjYBxPio03HSjed6aRwVwMofLZ4D3wCsh0nZbkY40yKlaNW6
         AublFP/IYeFezCV49NEUdgZWem/4ueZf8kpGwJ675cVJfEGYtcAmyiv3h/UWWQnXUnFk
         XW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=264wdrikSygrgRX7gnlG58YTkPsCHu6frlnu5l84msg=;
        b=BTEa0cXq5lplAFVe8s1tDe8VKIL/tqQp427cer37ZbJh2IJ1QGmYV8cu+c1GM9U+TN
         Q1wYMdZQjqDnIsrkloMvsJ+hVHqfnyOJ9PGTWYDirQ8rkZCGumAMKdqnJatys3b2dzoh
         28hACKY6gAcVeMRLW9k9jWHi7rwvzC4e0NAs4H215Gm5lb7/6bAK9ZBiu8IXVa/8sRJE
         svKuWvxokbt/ea6l++CiF/mFX18QMV/YCcnKB+Av6UJw3NOytJlVFzPvlP0rBgGgron8
         yX6jrDAFHqf8SOb/jtL8XF0bBHHhxxFeeLypVsyZTq/8KTToINYfp4j0sZeiP+ikFuiQ
         q1Pg==
X-Gm-Message-State: AOAM532K1HDkznu03d39++W1nLtjkjTRcdH7cJ9Rr7uifxEXGhqxNJbk
        ojD+e1deSs9u7agnqz4vdNXzpk9uEU+W/n49gIjjnA==
X-Google-Smtp-Source: ABdhPJx0Vd9PUEuMIAv5D+Z0+2O4wPBSIPfuS2JrsSiELE5Mh6V906iztJmtI/LXbq0Fma8GvyKcke5pr6GpdIEwR8c=
X-Received: by 2002:a25:20d5:: with SMTP id g204mr1900863ybg.136.1604565005158;
 Thu, 05 Nov 2020 00:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20201102145221.309001-1-namhyung@kernel.org>
In-Reply-To: <20201102145221.309001-1-namhyung@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 5 Nov 2020 00:29:54 -0800
Message-ID: <CABPqkBQUuX32dzFAQ2pVWgohGx+fRj54_PrcuKBJgjapE4vc9w@mail.gmail.com>
Subject: Re: [RFC 0/2] perf/core: Invoke pmu::sched_task callback for cpu events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Gabriel Marin <gmx@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 6:52 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> It was reported that system-wide events with precise_ip set have a lot
> of unknown symbols on Intel machines.  Depending on the system load I
> can see more than 30% of total symbols are not resolved (actually
> don't have DSO mappings).
>
> I found that it's only large PEBS is enabled - using call-graph or the
> frequency mode will disable it and have valid results.  I've verified
> it by checking intel_pmu_pebs_sched_task() is called like below:
>
>   # perf probe -a intel_pmu_pebs_sched_task
>
>   # perf stat -a -e probe:intel_pmu_pebs_sched_task \
>   >   perf record -a -e cycles:ppp -c 100001 sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 2.625 MB perf.data (10345 samples) ]
>
>    Performance counter stats for 'system wide':
>
>                  0      probe:intel_pmu_pebs_sched_task
>
>        2.157533991 seconds time elapsed
>
>
> Looking at the code, I found out that the pmu::sched_task callback was
> changed recently that it's called only for task events.  So cpu events
> with large PEBS didn't flush the buffer and they are attributed to
> unrelated tasks later resulted in unresolved symbols.
>
> This patch reverts it and keeps the optimization for task events.
> While at it, I also found the context switch callback was not enabled
> for cpu events from the beginning.  So I've added it too.  With this
> applied, I can see the above callbacks are hit as expected and perf
> report has valid symbols.
>
This is a serious bug that impacts many kernel versions as soon as
multi-entry PEBS is activated by the kernel in system-wide mode.
I remember this was working in the past so it must have been broken by
some code refactoring or optimization or extension of sched_task
to other features. PEBS must be flushed on context switch in per-cpu
mode, otherwise you may report samples in locations that do not belong
to the process where they are processed in. PEBS does not tag samples
with PID/TID.
