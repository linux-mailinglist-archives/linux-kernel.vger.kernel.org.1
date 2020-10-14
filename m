Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5610828E369
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgJNPkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgJNPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:40:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B45C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:40:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g12so4407195wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhXc1f25MORIkpm84/TizgfT/f9eKFKeeHKANJK3Stc=;
        b=nwv/OUahcf59CIzR2c0SyMkY7WM9QV8ad0ExX5GavDCFk/VtuovuTfl3BYRqkmtRwr
         BOkeyUTKYrsL4hUBRqTqWame/A3mUQcqE7mx71Im8/67fQZBN4lmZU0R+Wq5JGF2vVGz
         UYP6PGILrqsGw/fSMYyF626VatIcbyI2VT6EZfH4n1c3mRKAMJJzp4C1yXlXlKBa5/4H
         vgcLRh3+ByYlZ8bM0BNbVJ1xqW69nZiPS6j1v8maqDWfSWbviHqBIJmpT/LKHd/GRtV7
         P1j2IokLDqqB4QbL/58Q8rv/0Onnrw59Zfx6kil/7LnR2AoW2P4uNtdq0fVLRovv/lNq
         zwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhXc1f25MORIkpm84/TizgfT/f9eKFKeeHKANJK3Stc=;
        b=dS6a724jeFTCjWJKzEO0ZaiquFlnrEw/EiHGjQFYGX7CMAB6XY8ngVnSccmO7PSSjZ
         INcm1G0sJO2STer+u8Zj63CjU1P8pHbQJ/eSp3hNDye9h+TI+4cb0Oo5prLFlhRunJQz
         Y0o4Bi4cs2OKygRXiEYrHrIS6PPtDcdI8mw07fQxOoo3K6Iyjo+QHlIVaa1Jzp3O0v81
         cE4DbhVbekalKB41JQ4BENxcThzhbXZqGSMYrJWPF9bZGWlR/PARe8owWHssucblIlrn
         X77Ra47fdXrpKRS3x2zr2ukDKyTKAm9tFY7gtn6HGIN6hUeNtDD4BSolVs+TcXLW3akL
         loqQ==
X-Gm-Message-State: AOAM530Dc078K9qVUZTdIEopnUkeMC+qjtmHhasZMetJE0+JKri84o9R
        LTFmcXUXezzmbXVpIAli9lj2OPUOANg5y3wLzqFu4A==
X-Google-Smtp-Source: ABdhPJwh091A3jwd5joReD8iIrQi7iuHPvI7AQaKDwDxs0rqcPqRMYQtNxzbTfsPf1aLYnsnzcm0E6GenX8Ga9rMJYs=
X-Received: by 2002:a5d:4802:: with SMTP id l2mr6146625wrq.282.1602690003118;
 Wed, 14 Oct 2020 08:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201012161611.366482-1-irogers@google.com> <20201014114500.GB1375972@krava>
In-Reply-To: <20201014114500.GB1375972@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Oct 2020 08:39:51 -0700
Message-ID: <CAP-5=fWTvVU+M9P8wrsXXbhQ+uZNtgxpjnJt7YHfvPdw9==uuA@mail.gmail.com>
Subject: Re: [PATCH v2] perf bench: Use condition variables in numa.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peng Fan <fanpeng@loongson.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 4:45 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Oct 12, 2020 at 09:16:11AM -0700, Ian Rogers wrote:
>
> SNIP
>
> > @@ -483,6 +484,18 @@ static void init_global_mutex(pthread_mutex_t *mutex)
> >       pthread_mutex_init(mutex, &attr);
> >  }
> >
> > +/*
> > + * Return a process-shared (global) condition variable:
> > + */
> > +static void init_global_cond(pthread_cond_t *cond)
> > +{
> > +     pthread_condattr_t attr;
> > +
> > +     pthread_condattr_init(&attr);
> > +     pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
> > +     pthread_cond_init(cond, &attr);
> > +}
> > +
> >  static int parse_cpu_list(const char *arg)
> >  {
> >       p0.cpu_list_str = strdup(arg);
> > @@ -1136,15 +1149,18 @@ static void *worker_thread(void *__tdata)
> >       if (g->p.serialize_startup) {
> >               pthread_mutex_lock(&g->startup_mutex);
> >               g->nr_tasks_started++;
> > +             /* The last thread wakes the main process. */
> > +             if (g->nr_tasks_started == g->p.nr_tasks)
> > +                     pthread_cond_signal(&g->startup_cond);
>
> should you remove the condition? it's not necessary
> and making this racy, no?
>
> just single pthread_cond_signal should be enough,
> because the wait code is checking the number of tasks

The pthread_mutex_lock avoids any race on g->nr_tasks_started and
g->p.nr_tasks is set up in init() along with all the global state. I
don't think there's any race on g->nr_tasks_started and doing a signal
for every thread starting will just cause unnecessary wake-ups for the
main thread. I think it is better to keep it. I added loops on all the
pthread_cond_waits so the code is robust against spurious wake ups.

Thanks,
Ian

> jirka
>
