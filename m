Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D8E2CE89E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgLDH2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:28:41 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:36031 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgLDH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:28:41 -0500
Received: by mail-lf1-f42.google.com with SMTP id v14so6363182lfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 23:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQfkQmSVyPp3fW44lOuphZCCKmXnMCViP4LNaxirrKE=;
        b=ZsSSBdmiG2J4gYlY2aO10f6WvgI/elIldC0TL7jFIPfaArTYHUC97GAq13VOoMfo83
         wKfJtCS5kRSyKjyL8S0J9xYsk1jgEuWY9Zlz5VdDfM7/tJyZ8kd7GyPMp9X3DnkFAvr8
         yr6OCjuf/oyr/YRXalf3IqQ2b250Xyk5O86i9GZAR6WHvaz854sxFUlKEkLqumw+X0qV
         Wg9ubBkUXayP2xSgQPbj0D5n0m2pn4MkRvawYNSvdJHAw4n7ymkEBAj2jD4ifZ26IrKO
         u21DkHlft4fbs4L0TMCMAoUnwDqiznQpL6hF7MlHmG2sZOhKeUU9snGzSCYQ5h9vFUqy
         i6RQ==
X-Gm-Message-State: AOAM531vzmnftNFH37YsEQryDXRuYz03Su4Xwae2z0Sg5Ixn2fz7da0m
        Q2JtAyl5uQ1lXHwvpJubx3QeVjk2amSdqWIqOi8=
X-Google-Smtp-Source: ABdhPJx+ZSKrXAFHdXzEUrnIg6diDgvPvTATOocmw1cSjw8YRlVWb2EGS9d7hgJZKdTnwK3EKfZPPSXHeI+6OtmCDrU=
X-Received: by 2002:a19:4154:: with SMTP id o81mr2654333lfa.540.1607066879301;
 Thu, 03 Dec 2020 23:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.35750-1-namhyung@kernel.org> <20201202192828.GG1363814@tassilo.jf.intel.com>
 <20201203122040.GO3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201203122040.GO3021@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 4 Dec 2020 16:27:47 +0900
Message-ID: <CAM9d7ciinoE9YZYEf3Mp=sJutEzpfhu+pgWeWusirn846t7j3w@mail.gmail.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 9:20 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Dec 02, 2020 at 11:28:28AM -0800, Andi Kleen wrote:
> > > +   prev_cgrp = task_css_check(prev, perf_event_cgrp_id, 1)->cgroup;
> > > +   next_cgrp = task_css_check(next, perf_event_cgrp_id, 1)->cgroup;
> > > +
> > > +   if (prev_cgrp != next_cgrp)
> > > +           perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
> >
> > Seems to be the perf cgroup only, not all cgroups.
> > That's a big difference and needs to be documented properly.
>
> With cgroup-v2 that's all the same, no?

Right, but unfortunately it seems still cgroup v1 is used widely.

Thanks,
Namhyung
