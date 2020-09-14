Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A4826969D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgINUaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgINU36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600115397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mRspSc9qiotoAKWbxMv+sbblXzZThc8xTFk2VFD5lmQ=;
        b=BuNSAOd3rxh5vyMyuH0OPNzSNAQve2N1eQ7H5Zls2jQpi8qy3eHL/osbi03fVqat6KIZCB
        kKjPNWFX/8wzK/Kuo+ahxjB8rPP+zx5zM8BJQ8uNTNw6VN0MPUPEwimZS2UCMkn0Ua2wXb
        5qiEgApadYUWkJaw0GndARbWPNcU5+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-mqk5-4H9MRaRmpCKlV3kjQ-1; Mon, 14 Sep 2020 16:29:53 -0400
X-MC-Unique: mqk5-4H9MRaRmpCKlV3kjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07F71801F9A;
        Mon, 14 Sep 2020 20:29:52 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B17819C78;
        Mon, 14 Sep 2020 20:29:48 +0000 (UTC)
Date:   Mon, 14 Sep 2020 22:29:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 14/26] perf tools: Add mmap3 events to --show-mmap-events
 option
Message-ID: <20200914202947.GV1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-15-jolsa@kernel.org>
 <CAM9d7ciCCHRW2zs8LNCSsCBSgsLgK-CkyAzQjqXxFj+Y5Ss2-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciCCHRW2zs8LNCSsCBSgsLgK-CkyAzQjqXxFj+Y5Ss2-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:30:53PM +0900, Namhyung Kim wrote:
> On Mon, Sep 14, 2020 at 6:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Displaying mmap3 events for --show-mmap-events option,
> > the build id is displayed within <> braces:
> >
> >   $ perf script --show-mmap-events
> >   kill 12148 13893.519014: PERF_RECORD_MMAP3 12148/12148: <43938d0803c5e3130ea679cd569aaf44b98d9ae8> [0x560e7d7f..
> >   kill 12148 13893.519420: PERF_RECORD_MMAP3 12148/12148: <1805c738c8f3ec0f47b7ea09080c28f34d18a82b> [0x7f9e7dfc..
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-script.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index d839983cfb88..9c09581d5cb0 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -2342,6 +2342,38 @@ static int process_mmap2_event(struct perf_tool *tool,
> >                            event->mmap2.tid);
> >  }
> >
> > +static int process_mmap3_event(struct perf_tool *tool,
> > +                             union perf_event *event,
> > +                             struct perf_sample *sample,
> > +                             struct machine *machine)
> > +{
> > +       struct thread *thread;
> > +       struct perf_script *script = container_of(tool, struct perf_script, tool);
> > +       struct perf_session *session = script->session;
> > +       struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> > +
> > +       if (perf_event__process_mmap3(tool, event, sample, machine) < 0)
> > +               return -1;
> > +
> > +       thread = machine__findnew_thread(machine, event->mmap3.pid, event->mmap3.tid);
> > +       if (thread == NULL) {
> > +               pr_debug("problem processing MMAP2 event, skipping it.\n");
> 
> MMAP3 ?

yes, thanks,
jirka

