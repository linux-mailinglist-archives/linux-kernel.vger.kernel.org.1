Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2DA2646D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIJNWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 09:22:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44310 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgIJNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:18:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id s12so6645175wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBLcgxMKAbS1n+eV0fIrOxnLTOdgcrxYXmGgYjmbzNc=;
        b=cYGgBsovPCI9GsQi3tgODPRsJ++Nk/Q1do7WRDofOANKw+ZuAQzf9RtkUVMgzmMGKd
         YULPVk1jC1sTsc8onNX/QUtCqR04n8HTSQdeJfc2Eu+4tZL2mm3/OzGkrv6z4L70kOPB
         J4UteWYTZzAzUfTiOul3mWqUqtadcZ/CRM98MypVbXilRjBEN3tpOUxtpiDZUtdyjf6v
         Vtge5yqh4wVFx3ugkCFeK7Tv4L13YiWe4XThXEi/IB3PORhc7eCGbO5KtKMfRH1ZHQ0d
         rXk+gx8rUC6sY9noBGEZ9JuG+2XpiOoPz6OaFSwiWnikk4QCEmMA6MTuI1XiX9nLjOaM
         E7cw==
X-Gm-Message-State: AOAM533gjDvh948+ws7C3z76X2tAuaZg5zIeNE4zVOcSBHUQz9YEgaUT
        EzSAJIa4s5IvgcqjkrSxjRh7k+WAeVnwg09NdBw=
X-Google-Smtp-Source: ABdhPJzwRRz7MSfItsm5iWwVdskWnMYjeP04rqzvvAMNaPw6svYw4kD6cZVFQAKjysexDmFJVxl8DysHd1uaoDBDmE8=
X-Received: by 2002:adf:a3c9:: with SMTP id m9mr9159127wrb.80.1599743916042;
 Thu, 10 Sep 2020 06:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200908044228.61197-1-namhyung@kernel.org> <20200908044228.61197-2-namhyung@kernel.org>
 <20200910085926.GC1627030@krava>
In-Reply-To: <20200910085926.GC1627030@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Sep 2020 22:18:25 +0900
Message-ID: <CAM9d7chYfxQWNkDVXk2vLPgn4EhkH3WcAve+zzVGc7Jshri5VA@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf evsel: Add evsel__clone() function
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Sep 10, 2020 at 5:59 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Sep 08, 2020 at 01:42:25PM +0900, Namhyung Kim wrote:
> > The evsel__clone() is to create an exactly same evsel from same
> > attributes.  Note that metric events will be handled by later patch.
> >
> > It will be used by perf stat to generate separate events for each
> > cgroup.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/evsel.c | 57 +++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/evsel.h |  1 +
> >  2 files changed, 58 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index fd865002cbbd..4f50f9499973 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -331,6 +331,63 @@ struct evsel *evsel__new_cycles(bool precise)
> >       goto out;
> >  }
> >
> > +/**
> > + * evsel__clone - create a new evsel copied from @orig
> > + * @orig: original evsel
> > + *
> > + * The assumption is that @orig is not configured nor opened yet.
> > + * So we only care about the attributes that can be set while it's parsed.
> > + */
> > +struct evsel *evsel__clone(struct evsel *orig)
> > +{
> > +     struct evsel *evsel;
> > +     struct evsel_config_term *pos, *tmp;
> > +
> > +     BUG_ON(orig->core.fd);
> > +
> > +     evsel = evsel__new(&orig->core.attr);
> > +     if (evsel == NULL)
> > +             return NULL;
> > +
> > +     *evsel = *orig;
>
> this seems wild ;-) I saw that assumption above,
> but I wonder we could add some check or zero/init
> the rest of the fields fields

Alternatively, we could only copy relevant fields explicitly.
Other fields will remain zero by evsel__new() above.
But it might be easy to be missed by future changes..

Thanks
Namhyung
