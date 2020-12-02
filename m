Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6965C2CC6F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgLBTsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgLBTsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:48:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6FCC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:47:37 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id o71so2735262ybc.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZkMoo9zU7Z0IHTxK3hjygu7WvHytVEEgLMBaSt4Nzo=;
        b=gXXJrsfhF8RIpunNCHJM/lvvBisznd5+vFHH2rfoSWmYSQOpMzfPZPX9wnc/Uw5GIV
         NLe9cFo3WpGpY/6xZmim04bREhBjikcxSvPBRYUtT5DO5pxppbvAxThdpdpcX63arUrq
         1i+EoAWjRVYtdxXnn2i0w+It6KtAJAnCg1YYzgJX+5Ztpp1bCUoG/tACHM1pLYpvDu3v
         IyYKHA2nQtW3HwSTLjREZ7FbfIQaEVJaos1XVgeqGBR0RoGce6CjNnjpRQFw9bSt5NbH
         BICjOBOPvdjPzFynNlwKZ9iht4uf4DNe5ImwN3lwZa4cgWMOxFwVRMJUMT6z/1oGEhFw
         U2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZkMoo9zU7Z0IHTxK3hjygu7WvHytVEEgLMBaSt4Nzo=;
        b=XUUoLGoB9y+012oXTcLrjBmzFX+IyTnULFOJa7S4TCA9LFxUOnpRFTeBeH124FvYGQ
         AAJgIPM5WgiezXBtO3XNw8XjjJmIusHe6G3ZLwswjd90rqVgidvomxGDzzWiNot2FMmy
         WKoUzRAWmSLE0CnSxj3XWqY6R715+GiS751O/anEfx0WBAFQi+xPQuZZ2npCkWSwv8h1
         mngSkLReOGUmHjWmnpt/lXqwN6YjAHn5gPANL3jMjRFTY5zfYb9NNXnbeeGVF1QCNWLE
         c1EXsDiAzQ8Xy35ATaBP834ODpHrO4CEgfV9+8AmvPR4DWFtFOOphhhUHQIY11dqN8VG
         Sb8g==
X-Gm-Message-State: AOAM5334Jt6KYSvuHIdkrWfsXE272YFY02HsgcdF0qPab+gyn7K8OmWG
        vlKnWiQokyiQ9aAKp4MPdL8PFgHlMkfedGGDo7/RBA==
X-Google-Smtp-Source: ABdhPJzGyK0G10MB5JEUvEIcWkOZgFD3rircP9jQhZ8dl24LE5mjSMS8ZkbGjNaXZfq1D2CFXOoTiU87kP7FBtujcnQ=
X-Received: by 2002:a25:d46:: with SMTP id 67mr4490893ybn.155.1606938456429;
 Wed, 02 Dec 2020 11:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.35750-1-namhyung@kernel.org> <20201202192828.GG1363814@tassilo.jf.intel.com>
In-Reply-To: <20201202192828.GG1363814@tassilo.jf.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 2 Dec 2020 11:47:25 -0800
Message-ID: <CABPqkBR5nCfn756Wb8xQEb9Xse+UQPAbGy969cP4sxO78-Nq4g@mail.gmail.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 11:28 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> > +     prev_cgrp = task_css_check(prev, perf_event_cgrp_id, 1)->cgroup;
> > +     next_cgrp = task_css_check(next, perf_event_cgrp_id, 1)->cgroup;
> > +
> > +     if (prev_cgrp != next_cgrp)
> > +             perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
>
> Seems to be the perf cgroup only, not all cgroups.
> That's a big difference and needs to be documented properly.
>
We care about the all-cgroup case.

> Probably would make sense to have two events for both, one for
> all cgroups and one for perf only.
>
>
>
> -Andi
