Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5D9276775
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 05:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIXDvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 23:51:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37200 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgIXDvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 23:51:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id a9so2090457wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 20:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8f2LBiTZl+/qUNvQ2VOFRQievKIvRxCo/jzrv3u83I=;
        b=sWFoqf0c6YKrvUncjOMhrpuTzTQx+KZrDPWYNQnP5npInzUxktLEEvVIqIz9niwDWD
         XnBx8JNngTpzC1i/HOuaxvfBmlErGIBfWToHXJh9ZJD6n1+4+4BV+S/tWADJg0hSHL7l
         Zdy28I3QI6vmB5UWMxM9wEPA1C+OnHmd0xJasRVYac8cVsTnb0xzC9vDXges1uLKaP4V
         iABAvjITxKtDlq19q0W+cXgKfNsxSi7z70evynI/YB2Lhh7cmQ9Wj4n7ZsnRpxU7APp7
         UX5cc3IeyxDYiGX32k768JQBVN8vmU8RC4re7xvzBaJ2TYBO9jRBcOssOWoNXLYvvTRP
         Xxcw==
X-Gm-Message-State: AOAM531i3lFtPb6wGX0k3lOmPl+qxUMKqsKkh1+BakqLSTANUIjXlaEf
        bJI5d0LmBF0vixsXchNJ+QTArlkiJDeDqdgQxmY=
X-Google-Smtp-Source: ABdhPJzY0uI7Eva5To1ib3wj1Px6XPhB6YP+RLM2s3lPDxxx5fpOIORv/fYW4BKVzdsi60LCJVstPzICmfUTsi/+LM8=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr2500148wmb.70.1600919502706;
 Wed, 23 Sep 2020 20:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200923080537.155264-1-namhyung@kernel.org> <20200923080537.155264-8-namhyung@kernel.org>
 <91de4a5d-2646-0522-92a6-6c0de69ed007@intel.com>
In-Reply-To: <91de4a5d-2646-0522-92a6-6c0de69ed007@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Sep 2020 12:51:31 +0900
Message-ID: <CAM9d7ch0cyBjQ6DbaaQW-embfwQJQdvu43qOJQbF4wiezih0wg@mail.gmail.com>
Subject: Re: [PATCH 7/7] perf inject: Remove stale build-id processing
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Thanks for your review!

On Wed, Sep 23, 2020 at 11:36 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 23/09/20 11:05 am, Namhyung Kim wrote:
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
>
> For a perf.data file, don't buildids get written to the HEADER_BUILD_ID
> feature section by perf_session__write_header() if the feature flag is set
> and if they are hit?

Right, that's what perf record does unless -B option is used.
But I'm more concerned about the pipe usage which doesn't use the header.

>
> So, unless -b is used, anything you don't hit you lose i.e. a buildid in the
> HEADER_BUILD_ID feature section of the input file, will not be written to
> the output file.

But perf inject generates PERF_RECORD_HEADER_BUILD_ID events
and puts them into the data stream when -b option is used.

Do you say perf inject should process build-id even when -b is not used?

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
> I guess that chunk would prevent losing a buildid in a perf.data file?
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
>
> That could be due to confusion with 'perf buildid-list' which will not show
> any buildids from synthesized buildid events unless "with hits" is selected,
> so then it looks like there are no buildids.

Yeah, it's confusing.. I think we should change the behavior to handle
the pipe case properly.

>
> It could be an advantage to have the buildids also in the HEADER_BUILD_ID
> feature section, because then then build-list can list them quickly.

I'm not sure it's good to have duplicate build-id info.
We may add an option just to update the header section and
not inject BUILD_ID events.

>
> > -             /*
> > -              * Keep all buildids when there is unprocessed AUX data because
> > -              * it is not known which ones the AUX trace hits.
> > -              */
> > -             if (perf_header__has_feat(&session->header, HEADER_BUILD_ID) &&
> > -                 inject->have_auxtrace && !inject->itrace_synth_opts.set)
> > -                     dsos__hit_all(session);
>
> I expect that is definitely needed.

OK.

Thanks
Namhyung

>
> >               /*
> >                * The AUX areas have been removed and replaced with
> >                * synthesized hardware events, so clear the feature flag and
> >
>
