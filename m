Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A680D2768D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgIXGXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:23:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50598 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgIXGXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:23:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id e17so2276972wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+gWnAMrrCSDKKsDSsLVE5LbgZumVMG6QbyOp56BCl4=;
        b=B+iGEdyZaOH9gjzqyMC4BAqeJAi3jFHwFeU2XMjLsBsVLGevAa3WLZS+BE4jM79x2E
         Ur5Fbj5mmYoJNRfxLaDOUP2LIFc3IBI8VHRSsq6s0jWMIkL2T+eQsGLjmjq/dycuaupp
         e8mD8b1qYraiur4zp8YPFBCiCpjkaZUC1Rfq8AUhMEI1lS3NjW2Fpt/4Usjp8L0auRFC
         5qJ2K4oZoNc5nN8Ta3uguBxyjg4bhakxFYM0N028KT06LoLXb8qREbzUFyxAxesu5y08
         EZYkJ6cC2e3YleL1ryPn36lecYEjyQ1HCBV95NeDPmRgHEQoqV0jMcEC7CI0q4NbSCnl
         lCNw==
X-Gm-Message-State: AOAM530XWTiL5/vp2qKD7U/zre+J/uGaicQ1ivVPzs3MY5LYZAAxUrgL
        dzdZzLGKFCvTzR8cuUImRHeOKfRmznZCpV18WI4=
X-Google-Smtp-Source: ABdhPJxlKWypvkf6VvUi30hFdYfPHEXovD2A/3y0A0Z2JdNrk5motcLSWruVyjElZ04YsYMFskGkzK4uM3FkANvKELE=
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr3090179wmt.92.1600928624175;
 Wed, 23 Sep 2020 23:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200923080537.155264-1-namhyung@kernel.org> <20200923080537.155264-2-namhyung@kernel.org>
 <CAP-5=fUZuRr_FPOkKFbfjhkMKOpBrad95pcv8AjyfPbhz0uDvQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUZuRr_FPOkKFbfjhkMKOpBrad95pcv8AjyfPbhz0uDvQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Sep 2020 15:23:32 +0900
Message-ID: <CAM9d7cimhk0OeOv-LvDJADRf2+jhWhJ4nCO0fO74V4sGJ2ZfhA@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf bench: Add build-id injection benchmark
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, Sep 24, 2020 at 7:13 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Sep 23, 2020 at 1:05 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Sometimes I can see perf record piped with perf inject take long time
> > processing build-id.  So add inject-build-id benchmark to the
> > internals benchmark suite to measure its overhead regularly.
> >
> > It runs perf inject command internally and feeds the given number of
> > synthesized events (MMAP2 + SAMPLE basically).
> >
> >   Usage: perf bench internals inject-build-id <options>
> >
> >     -i, --iterations <n>  Number of iterations used to compute average (default: 100)
> >     -m, --nr-mmaps <n>    Number of mmap events for each iteration (default: 100)
> >     -n, --nr-samples <n>  Number of sample events per mmap event (default: 100)
> >     -v, --verbose         be more verbose (show iteration count, DSO name, etc)
> >
> > By default, it measures average processing time of 100 MMAP2 events
> > and 10000 SAMPLE events.  Below is a result on my laptop.
> >
> >   $ perf bench internals inject-build-id
> >   # Running 'internals/inject-build-id' benchmark:
> >     Average build-id injection took: 22.997 msec (+- 0.067 msec)
> >     Average time per event: 2.255 usec (+- 0.007 usec)
>
> This is great! Some suggestions below.

Thanks!

>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
[SNIP]
> > +
> > +static const char *const bench_usage[] = {
> > +       "perf bench internals inject-build-id <options>",
> > +       NULL
> > +};
> > +
>
> Perhaps a comment:
> /* Helper for collect_dso that adds the given file as a dso to
> dso_list if it contains a buildid. Stops after 4 such dsos.*/

Will add.. please see below.

>
> > +static int add_dso(const char *fpath, const struct stat *sb __maybe_unused,
> > +                  int typeflag, struct FTW *ftwbuf __maybe_unused)
> > +{
> > +       struct bench_dso *dso;
> > +       unsigned char build_id[BUILD_ID_SIZE];
> > +
> > +       if (typeflag == FTW_D || typeflag == FTW_SL) {
> > +               return 0;
> > +       }
> > +
> > +       if (filename__read_build_id(fpath, build_id, BUILD_ID_SIZE) < 0)
> > +               return 0;
> > +
> > +       dso = malloc(sizeof(*dso));
> > +       if (dso == NULL)
> > +               return -1;
> > +
> > +       dso->name = realpath(fpath, NULL);
> > +       if (dso->name == NULL) {
> > +               free(dso);
> > +               return -1;
> > +       }
> > +
> > +       dso->ino = nr_dsos++;
> > +       list_add(&dso->list, &dso_list);
> > +       pr_debug2("  Adding DSO: %s\n", fpath);
> > +
> > +       /* stop if we collected 4x DSOs than needed */
> > +       if ((unsigned)nr_dsos > 4 * nr_mmaps)
> > +               return 1;
> > +
> > +       return 0;
> > +}
> > +
> > +static void collect_dso(void)
> > +{
> > +       if (nftw("/usr/lib/", add_dso, 10, FTW_PHYS) < 0)
> > +               return;
> > +
> > +       pr_debug("  Collected %d DSOs\n", nr_dsos);
>
> Should this fail if the count isn't 4?

The add_dso would stop if it collected enough DSOs.
I chose it as 4 x nr_mmaps (default: 100).

It's gonna pick a DSO in the list randomly during benchmark
and I want to reduce the chance it selects the same one in the
same iteration. So instead of having nr_mmaps DSOs, it keeps
4 times more DSOs than needed.

>
> > +}
> > +
> > +static void release_dso(void)
> > +{
> > +       struct bench_dso *dso;
> > +
> > +       while (!list_empty(&dso_list)) {
> > +               dso = list_first_entry(&dso_list, struct bench_dso, list);
> > +               list_del(&dso->list);
> > +               free(dso->name);
> > +               free(dso);
> > +       }
> > +}
> > +
>
> Perhaps a comment and move next to synthesize_mmap.
> /* Fake address used by mmap events. */

OK, will do.  (and it's used by sample events too)

>
> > +static u64 dso_map_addr(struct bench_dso *dso)
> > +{
> > +       return 0x400000ULL + dso->ino * 8192ULL;
> > +}
[SNIP]

> > +static int setup_injection(struct bench_data *data)
> > +{
> > +       int ready_pipe[2];
> > +       int dev_null_fd;
> > +       char buf;
> > +
> > +       if (pipe(ready_pipe) < 0)
> > +               return -1;
> > +
> > +       if (pipe(data->input_pipe) < 0)
> > +               return -1;
> > +
> > +       if (pipe(data->output_pipe) < 0)
> > +               return -1;
> > +
> > +       data->pid = fork();
> > +       if (data->pid < 0)
> > +               return -1;
> > +
> > +       if (data->pid == 0) {
> > +               const char **inject_argv;
> > +
> > +               close(data->input_pipe[1]);
> > +               close(data->output_pipe[0]);
> > +               close(ready_pipe[0]);
> > +
> > +               dup2(data->input_pipe[0], STDIN_FILENO);
> > +               close(data->input_pipe[0]);
> > +               dup2(data->output_pipe[1], STDOUT_FILENO);
> > +               close(data->output_pipe[1]);
> > +
> > +               dev_null_fd = open("/dev/null", O_WRONLY);
> > +               if (dev_null_fd < 0)
> > +                       exit(1);
> > +
> > +               dup2(dev_null_fd, STDERR_FILENO);
> > +
> > +               inject_argv = calloc(3, sizeof(*inject_argv));
> > +               if (inject_argv == NULL)
> > +                       exit(1);
> > +
> > +               inject_argv[0] = strdup("inject");
> > +               inject_argv[1] = strdup("-b");
> > +
> > +               /* signal that we're ready to go */
> > +               close(ready_pipe[1]);
> > +
> > +               cmd_inject(2, inject_argv);
> > +
> > +               exit(0);
> > +       }
> > +
> > +       signal(SIGPIPE, sigpipe_handler);
> > +
> > +       close(ready_pipe[1]);
> > +       close(data->input_pipe[0]);
> > +       close(data->output_pipe[1]);
> > +
> > +       /* wait for child ready */
> > +       if (read(ready_pipe[0], &buf, 1) < 0)
> > +               return -1;
> > +       close(ready_pipe[0]);
> > +
> > +       return 0;
> > +}
>
> This feels like generic scaffolding that could be shared by other perf
> command benchmarks.

Maybe.. the thing is perf inject usually works on pipes so it needed
a new process to run the test.  Probably we can simply run others
in the same process.

>
> > +
> > +static int inject_build_id(struct bench_data *data)
> > +{
> > +       int flag, status;
> > +       unsigned int i, k;
> > +       char buf[8192];
> > +       u64 nread = 0;
> > +       u64 len = nr_mmaps / 2 * sizeof(struct perf_record_header_build_id);
> > +
> > +       flag = fcntl(data->output_pipe[0], F_GETFL, 0);
> > +       if (fcntl(data->output_pipe[0], F_SETFL, flag | O_NONBLOCK) < 0)
> > +               return -1;
> > +
> > +       /* this makes the child to run */
> > +       if (perf_header__write_pipe(data->input_pipe[1]) < 0)
> > +               return -1;
> > +
> > +       len += synthesize_attr(data);
> > +       len += synthesize_fork(data);
> > +
> > +       for (i = 0; i < nr_mmaps; i++) {
> > +               struct bench_dso *dso;
> > +               int idx = rand() % (nr_dsos - 1);
> > +
> > +               dso = list_first_entry(&dso_list, struct bench_dso, list);
> > +               while (idx--)
> > +                       dso = list_next_entry(dso, list);
> > +
> > +               pr_debug("   [%2d] injecting: %s\n", i+1, dso->name);
> > +               len += synthesize_mmap(data, dso);
> > +
> > +               for (k = 0; k < nr_samples; k++)
> > +                       len += synthesize_sample(data, dso);
> > +
> > +               /* read out data from child */
> > +               while (true) {
> > +                       int n;
> > +
> > +                       n = read(data->output_pipe[0], buf, sizeof(buf));
> > +                       if (n <= 0)
> > +                               break;
> > +                       nread += n;
> > +               }
> > +       }
> > +
> > +       /* wait to read data at least as we wrote + some build-ids */
> > +       while (nread < len) {
> > +               int n;
> > +
> > +               n = read(data->output_pipe[0], buf, sizeof(buf));
> > +               if (n < 0)
> > +                       break;
> > +               nread += n;
> > +       }
> > +       close(data->input_pipe[1]);
> > +       close(data->output_pipe[0]);
> > +
> > +       wait(&status);
> > +       pr_debug("   Child %d exited with %d\n", data->pid, status);
> > +
> > +       return 0;
> > +}
> >
>
> Perhaps we can read the highwater mark (VmHWM) from /proc/[pid]/status
> as this would capture cases like buildid injection doing unnecessary
> symbol generation.

Good idea!  I'll add it and check we can see the difference.

Thanks
Namhyung
