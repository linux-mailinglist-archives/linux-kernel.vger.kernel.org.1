Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3391528BD5F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390616AbgJLQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390043AbgJLQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:17:53 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79315C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:17:53 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id x185so9441447vsb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UH590SySa+dUhViGxqeI7URtsDxP7Tvec2QDZmC0bx4=;
        b=Tz4BFW5SWegF/b/fh2OQzTGKpJ4xYeTWbzSAf073MrrO0v28SRWP0vKiSrmRBOmKcf
         PsVrP1dZ/AKKNfmyxQr2L+vECsgtrU0qek9qJf3gcRmruz5ZvIM2YC6Kro2dMM54ljYA
         sEC3oMS/Y0oIzSo+rhqfTvY2k3lL57HYbWHl+dMLigVPVpRHEhGF2l/cqAIcvRUjKejZ
         fky1vX4e+Awx7goLJWFnaQ3zuptsN1kpJ0ldPV6w1NXYihqtWg+Fn5l6s8OJcUnLOp6Y
         c2dvEWc2QdDL2E4yQICZsPyvZdX7vOB6NDAB8NtLtmqd9vSdTH/3Sei7R2xVaa1T2i7Y
         W7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UH590SySa+dUhViGxqeI7URtsDxP7Tvec2QDZmC0bx4=;
        b=FlO+XHrag6WyKP8xsmRqENJZ6LYXH+EA8E7Z+xP+NjoEOw0a9AfX7qCW7JD2yhcG+a
         8pl8kFg0ENHCmMyXLGKqHIGWiY7J9N72cgxwyRTBlu4hhqvqRY25WxCiDVPcSO6pajxL
         JH0OYlv+WyK1sHPSZ7xBOTjw41mCAKREELsq8gfcE4eWXeVqUzjNSTbSRRxr1ushzva9
         NgqGCQvV6LUYppw5mIIK1/UzlWsdBupmmocd0Fx9ODJJBThP5Qi8ltV8dtyJOGRU2yiH
         ljcCmejA3eODk7zC+cTwLced59vSs/MgROazyqaV9BPXVT6PdZ3zlA25bxKdFkMrgGOa
         Gpgw==
X-Gm-Message-State: AOAM53386DQuifkmnPzUBK5V0pjKwdtqgDgfEOaSCgMuuM37N7Zd88Cs
        tlgmlc3tSKaI7gwaEvC6YK58uN0sA5dbFmGKxT6lhA==
X-Google-Smtp-Source: ABdhPJyMjaK+Lj7BV4fIhDglc34ySiVKztFadCo586/L5ObTAIPv5zy5dx1CxwlCwiW6QmEitKBsQeLCt8JCav6p3RQ=
X-Received: by 2002:a67:c48a:: with SMTP id d10mr14562673vsk.7.1602519472264;
 Mon, 12 Oct 2020 09:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201010064056.3489559-1-irogers@google.com> <20201012094520.GE1099489@krava>
In-Reply-To: <20201012094520.GE1099489@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Oct 2020 09:17:40 -0700
Message-ID: <CAP-5=fWEsU3JcaFHE1Mh-R=d=7-_EZevoQeSuULN0ObpaXgivQ@mail.gmail.com>
Subject: Re: [PATCH] perf bench: Use condition variables in numa.
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 2:45 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Oct 09, 2020 at 11:40:56PM -0700, Ian Rogers wrote:
> > The existing approach to synchronization between threads in the numa
> > benchmark is unbalanced mutexes. This synchronization causes thread
> > sanitizer to warn of locks being taken twice on a thread without an
> > unlock, as well as unlocks with no corresponding locks.
> > This change replaces the synchronization with more regular condition
> > variables. While this fixes one class of thread sanitizer warnings,
> > there still remain warnings of data races due to threads reading and
> > writing shared memory without any atomics.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> hi,
> I'm getting:
>
>   BUILD:   Doing 'make -j8' parallel build
> Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' dif=
fers from latest version at 'include/uapi/linux/perf_event.h'
> diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_eve=
nt.h
>   CC       bench/numa.o
> bench/numa.c: In function =E2=80=98init=E2=80=99:
> bench/numa.c:1461:24: error: =E2=80=98struct global_info=E2=80=99 has no =
member named =E2=80=98startup_done_mutex=E2=80=99; did you mean =E2=80=98st=
artup_mutex=E2=80=99?
>  1461 |  init_global_mutex(&g->startup_done_mutex);
>       |                        ^~~~~~~~~~~~~~~~~~
>       |                        startup_mutex
> bench/numa.c:1462:23: error: =E2=80=98struct global_info=E2=80=99 has no =
member named =E2=80=98startup_done_cond=E2=80=99; did you mean =E2=80=98sta=
rtup_cond=E2=80=99?
>  1462 |  init_global_cond(&g->startup_done_cond);
>       |                       ^~~~~~~~~~~~~~~~~
>       |                       startup_cond
>
> jirka

Sorry was trying to work with two trees, and thought this had
built/tested obviously not given the typo. Fixed in:
https://lore.kernel.org/lkml/20201012161611.366482-1-irogers@google.com/T/#=
u

Thanks,
Ian

> > ---
> >  tools/perf/bench/numa.c | 67 ++++++++++++++++++++++++++++-------------
> >  1 file changed, 46 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> > index f85bceccc459..d8c5a674203e 100644
> > --- a/tools/perf/bench/numa.c
> > +++ b/tools/perf/bench/numa.c
> > @@ -137,12 +137,13 @@ struct global_info {
> >       u8                      *data;
> >
> >       pthread_mutex_t         startup_mutex;
> > +     pthread_cond_t          startup_cond;
> >       int                     nr_tasks_started;
> >
> > -     pthread_mutex_t         startup_done_mutex;
> > -
> >       pthread_mutex_t         start_work_mutex;
> > +     pthread_cond_t          start_work_cond;
> >       int                     nr_tasks_working;
> > +     bool                    start_work;
> >
> >       pthread_mutex_t         stop_work_mutex;
> >       u64                     bytes_done;
> > @@ -483,6 +484,18 @@ static void init_global_mutex(pthread_mutex_t *mut=
ex)
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
> >       p0.cpu_list_str =3D strdup(arg);
> > @@ -1136,15 +1149,18 @@ static void *worker_thread(void *__tdata)
> >       if (g->p.serialize_startup) {
> >               pthread_mutex_lock(&g->startup_mutex);
> >               g->nr_tasks_started++;
> > +             /* The last thread wakes the main process. */
> > +             if (g->nr_tasks_started =3D=3D g->p.nr_tasks)
> > +                     pthread_cond_signal(&g->startup_cond);
> > +
> >               pthread_mutex_unlock(&g->startup_mutex);
> >
> >               /* Here we will wait for the main process to start us all=
 at once: */
> >               pthread_mutex_lock(&g->start_work_mutex);
> > +             g->start_work =3D false;
> >               g->nr_tasks_working++;
> > -
> > -             /* Last one wake the main process: */
> > -             if (g->nr_tasks_working =3D=3D g->p.nr_tasks)
> > -                     pthread_mutex_unlock(&g->startup_done_mutex);
> > +             while (!g->start_work)
> > +                     pthread_cond_wait(&g->start_work_cond, &g->start_=
work_mutex);
> >
> >               pthread_mutex_unlock(&g->start_work_mutex);
> >       }
> > @@ -1441,8 +1457,9 @@ static int init(void)
> >
> >       /* Startup serialization: */
> >       init_global_mutex(&g->start_work_mutex);
> > -     init_global_mutex(&g->startup_mutex);
> > +     init_global_cond(&g->start_work_cond);
> >       init_global_mutex(&g->startup_done_mutex);
> > +     init_global_cond(&g->startup_done_cond);
> >       init_global_mutex(&g->stop_work_mutex);
> >
> >       init_thread_data();
> > @@ -1502,9 +1519,6 @@ static int __bench_numa(const char *name)
> >       pids =3D zalloc(g->p.nr_proc * sizeof(*pids));
> >       pid =3D -1;
> >
> > -     /* All threads try to acquire it, this way we can wait for them t=
o start up: */
> > -     pthread_mutex_lock(&g->start_work_mutex);
> > -
> >       if (g->p.serialize_startup) {
> >               tprintf(" #\n");
> >               tprintf(" # Startup synchronization: ..."); fflush(stdout=
);
> > @@ -1526,22 +1540,29 @@ static int __bench_numa(const char *name)
> >               pids[i] =3D pid;
> >
> >       }
> > -     /* Wait for all the threads to start up: */
> > -     while (g->nr_tasks_started !=3D g->p.nr_tasks)
> > -             usleep(USEC_PER_MSEC);
> > -
> > -     BUG_ON(g->nr_tasks_started !=3D g->p.nr_tasks);
> >
> >       if (g->p.serialize_startup) {
> > +             bool threads_ready =3D false;
> >               double startup_sec;
> >
> > -             pthread_mutex_lock(&g->startup_done_mutex);
> > +             /*
> > +              * Wait for all the threads to start up. The last thread =
will
> > +              * signal this process.
> > +              */
> > +             pthread_mutex_lock(&g->startup_mutex);
> > +             while (g->nr_tasks_started !=3D g->p.nr_tasks)
> > +                     pthread_cond_wait(&g->startup_cond, &g->startup_m=
utex);
> >
> > -             /* This will start all threads: */
> > -             pthread_mutex_unlock(&g->start_work_mutex);
> > +             pthread_mutex_unlock(&g->startup_mutex);
> >
> > -             /* This mutex is locked - the last started thread will wa=
ke us: */
> > -             pthread_mutex_lock(&g->startup_done_mutex);
> > +             /* Wait for all threads to be at the start_work_cond. */
> > +             while (!threads_ready) {
> > +                     pthread_mutex_lock(&g->start_work_mutex);
> > +                     threads_ready =3D (g->nr_tasks_working =3D=3D g->=
p.nr_tasks);
> > +                     pthread_mutex_unlock(&g->start_work_mutex);
> > +                     if (!threads_ready)
> > +                             usleep(1);
> > +             }
> >
> >               gettimeofday(&stop, NULL);
> >
> > @@ -1555,7 +1576,11 @@ static int __bench_numa(const char *name)
> >               tprintf(" #\n");
> >
> >               start =3D stop;
> > -             pthread_mutex_unlock(&g->startup_done_mutex);
> > +             /* Start all threads running. */
> > +             pthread_mutex_lock(&g->start_work_mutex);
> > +             g->start_work =3D true;
> > +             pthread_mutex_unlock(&g->start_work_mutex);
> > +             pthread_cond_broadcast(&g->start_work_cond);
> >       } else {
> >               gettimeofday(&start, NULL);
> >       }
> > --
> > 2.28.0.1011.ga647a8990f-goog
> >
>
