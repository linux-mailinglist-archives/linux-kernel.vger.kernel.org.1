Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABED2773D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgIXOXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:23:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52463 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgIXOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:23:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id q9so3731649wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Xq748Om0JHHZlldM+NMeRfrbEkqKOkW9q4hIroghtE=;
        b=Z6TNgKaKWEaqZmndtwyBDw5VLVN7oJisK9o7UaayGfmsnDMPHUQr5YaJdj5Pkb3aIo
         tBmAzVh1JjhV/4BRtkjvMR5xETMY5XaLBKCGMpc2Iwr0K60TKVYiOvFZ/8JZSWc0Y1b0
         5I070TNcURDWYSjMOaJPSylYkdFY3bUP9adioEWa7cCOu2f5r23MD+odZzGlLwib2xoq
         58BxCfDwTxORNkwY9b3SqPMdEgsN+2ALyqKkFc4PX9q78KhEQOnMJj64bJ+W22ccdXcR
         nNrlhYbAhZ5C8hGS4Mw0tTZnugg8PG8qK5bXbzm1Nahv00KShaGmqPmjr+pqWJTGkdq7
         1+RQ==
X-Gm-Message-State: AOAM530iexGN7ub9zq70YZ3qIPHkOjuhQaPTrKKqGrDOnjUwb07F5day
        7esOiQJ/LHyhadoRH9n+49/BvwZjeHLNBMNl01s=
X-Google-Smtp-Source: ABdhPJxSwDXvCnVK+1WXWK38s8Vn1Pwus6pPEnFaHby0nE4xrE/xZEE0ef0/UG/eSD6YpGi9cNIaLwvQZLjwByxcRqA=
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr5249244wmt.92.1600957402972;
 Thu, 24 Sep 2020 07:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200923080537.155264-1-namhyung@kernel.org> <20200923080537.155264-8-namhyung@kernel.org>
 <20200924133349.GC3150401@krava>
In-Reply-To: <20200924133349.GC3150401@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Sep 2020 23:23:11 +0900
Message-ID: <CAM9d7cg3f_J6QjgZzgcpK46C5Pgpp1KUuMoKSJSK+CqoUx6nCQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] perf inject: Remove stale build-id processing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:34 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 23, 2020 at 05:05:37PM +0900, Namhyung Kim wrote:
> > I think we don't need to call build_id__mark_dso_hit() in the
> > perf_event__repipe_sample() as it's not used by -b option.  In case of
> > the -b option is used, it uses perf_event__inject_buildid() instead.
> > This can remove unnecessary overhead of finding thread/map for each
> > sample event.
> >
> > Also I suspect HEADER_BUILD_ID feature bit setting since we already
> > generated/injected BUILD_ID event into the output stream.  So this
> > header information seems redundant.  I'm not 100% sure about the
> > auxtrace usage, but it looks like not related to this directly.
> >
> > And we now have --buildid-all so users can get the same behavior if
> > they want.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-inject.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index 500428aaa576..0191d72be7c4 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -277,8 +277,6 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
> >               return f(tool, event, sample, evsel, machine);
> >       }
> >
> > -     build_id__mark_dso_hit(tool, event, sample, evsel, machine);
> > -
>
> I recalled using simple 'perf inject -i .. -o .. ' to get uncompressed data
> from 'perf record -z' and I though this change will force inject not to store
> all build ids ... but it's happening even without your change ;-)

I wasn't aware of that use case.  Will check..

Anyway, basically perf record saves build-id in the file header unless -B
option is used.  I think we don't need to update feature data if user didn't
request something explicit (maybe like when -b or --itrace is used).

Now I've realized that current code always updates the feature data
including build-id so it needs to mark dso.  But I think it's meaningless
because 1) if the file already has build-id feature no need to do the
marking again, or 2) if the input is a pipe we need -b option and
then the marking code won't run.

Maybe the only case we are concerned about is that the data file
doesn't have a build-id feature and we don't want to inject build-id
events but want to update the build-id feature data in the header.
I'm not sure if it's a good practice, but if we really want to support
it, I think we should add a dedicated option.

>
>         $ ./perf record ls
>         ...
>         [ perf record: Woken up 1 times to write data ]
>         [ perf record: Captured and wrote 0.016 MB perf.data (15 samples) ]
>
>         $ ./perf inject -o perf.data.new -i perf.data
>
>         $ ./perf buildid-list
>
>         17f4e448cc746582ea1881528deb549f7fdb3fd5 [kernel.kallsyms]
>         b516839521ded07bb1fbd0a0276be9820ee8908e /usr/bin/ls
>         1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
>         f22785ea7e42e8aa9097a567a3cc8ae214cae4b6 [vdso]
>         d278249792061c6b74d1693ca59513be1def13f2 /usr/lib64/libc-2.31.so
>
>         $ ./perf buildid-list -i perf.data.new
>         f22785ea7e42e8aa9097a567a3cc8ae214cae4b6 [vdso]

Oh... I found that the current code doesn't handle mmap events
unless the -b (or other) option is used.  So even if it tries to
mark dso it couldn't find one.  But vdso is created separately
so you can see it only IMHO.

Yes, we need to fix this.. but I'm not sure what's the meaning
of running perf inject without any option. :)

Thanks
Namhyung

>
> jirka
>
>
> >       if (inject->itrace_synth_opts.set && sample->aux_sample.size)
> >               event = perf_inject__cut_auxtrace_sample(inject, event, sample);
> >
> > @@ -767,16 +765,6 @@ static int __cmd_inject(struct perf_inject *inject)
> >               return ret;
> >
> >       if (!data_out->is_pipe) {
> > -             if (inject->build_ids)
> > -                     perf_header__set_feat(&session->header,
> > -                                           HEADER_BUILD_ID);
> > -             /*
> > -              * Keep all buildids when there is unprocessed AUX data because
> > -              * it is not known which ones the AUX trace hits.
> > -              */
> > -             if (perf_header__has_feat(&session->header, HEADER_BUILD_ID) &&
> > -                 inject->have_auxtrace && !inject->itrace_synth_opts.set)
> > -                     dsos__hit_all(session);
> >               /*
> >                * The AUX areas have been removed and replaced with
> >                * synthesized hardware events, so clear the feature flag and
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
>
