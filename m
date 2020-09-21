Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5BF271A83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 07:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIUFtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 01:49:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36191 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgIUFtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:49:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so11342360wrt.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 22:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1a+p+FgNcgXx8Svp1tGxsSJqvQ4ji+J61Fv03brKIlw=;
        b=GwLFMeLGT7gPMNylQw8jZkFn4NQKH+BCgUfKGTqw5Kb7//fZqZoTrqHVzg8N9zN06U
         IlqHBuJM8sbFZh1Bwu7742GMt1K6bHcBAz4ogDCDblb7ed97tH7caCgazlcyyiwaOzRl
         P/FR7GMR9GdG8y8kKCnK/qX5TfIoKKIvdzkzBCIWpHGdj270+4Qn+Qx48jxX7tqsgDpy
         q0dySoqBiRI7DX7/HbsNm75PIjHC/uhl1idq/j0rYinUdlYRLJsZVhrIPzds7SdFhsM/
         hJZ0EydewsR4G1iQmdgrCORzG5VGVH7w7kP05HRdrzQ4/h7Kqcjb//vLTRcsSB9+RcDX
         8A+Q==
X-Gm-Message-State: AOAM5327sxWxwAUf579yY69+ED/5lWzyuVJ6r4FbWlph7MCYBrhrbxCP
        KG8Oqt25CWGoooXCfPpADPVL2pGvhu6ma4Ayeog=
X-Google-Smtp-Source: ABdhPJwSSJauM6Mpyv7p+mLx5wDjfC0lyLhsue5gqohdWiHWkiNn3UXV9RFCczgj9rUXr+LbpAnf+APfAEYC+ua81wU=
X-Received: by 2002:adf:e481:: with SMTP id i1mr50206292wrm.391.1600667360925;
 Sun, 20 Sep 2020 22:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200916063129.1061487-1-namhyung@kernel.org> <20200916063129.1061487-5-namhyung@kernel.org>
 <20200918135120.GD2626435@krava>
In-Reply-To: <20200918135120.GD2626435@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 21 Sep 2020 14:49:10 +0900
Message-ID: <CAM9d7cjJ2Gk_SK_=evG99fYqU5c_E=CBy43nDt+my_v8_T+oJA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf test: Add expand cgroup event test
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 10:52 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 16, 2020 at 03:31:29PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > +++ b/tools/perf/tests/tests.h
> > @@ -123,6 +123,7 @@ const char *test__pfm_subtest_get_desc(int subtest);
> >  int test__pfm_subtest_get_nr(void);
> >  int test__parse_metric(struct test *test, int subtest);
> >  int test__pe_file_parsing(struct test *test, int subtest);
> > +int test__expand_cgroup_events(struct test *test, int subtest);
> >
> >  bool test__bp_signal_is_supported(void);
> >  bool test__bp_account_is_supported(void);
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index a1bf345a770b..eeffa08251b5 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -52,7 +52,7 @@ static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str
> >       return NULL;
> >  }
>
>
> could you please put the do_open change below into separate patch?

Ok, will do.

Thanks
Namhyung

> >
> > -static struct cgroup *cgroup__new(const char *name)
> > +static struct cgroup *cgroup__new(const char *name, bool do_open)
> >  {
> >       struct cgroup *cgroup = zalloc(sizeof(*cgroup));
> >
> > @@ -62,9 +62,14 @@ static struct cgroup *cgroup__new(const char *name)
> >               cgroup->name = strdup(name);
> >               if (!cgroup->name)
> >                       goto out_err;
> > -             cgroup->fd = open_cgroup(name);
> > -             if (cgroup->fd == -1)
> > -                     goto out_free_name;
> > +
> > +             if (do_open) {
> > +                     cgroup->fd = open_cgroup(name);
> > +                     if (cgroup->fd == -1)
> > +                             goto out_free_name;
> > +             } else {
> > +                     cgroup->fd = -1;
> > +             }
> >       }
> >
> >       return cgroup;
> > @@ -80,7 +85,7 @@ struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name)
> >  {
> >       struct cgroup *cgroup = evlist__find_cgroup(evlist, name);
> >
> > -     return cgroup ?: cgroup__new(name);
> > +     return cgroup ?: cgroup__new(name, true);
> >  }
> >
> >  static int add_cgroup(struct evlist *evlist, const char *str)
> > @@ -202,7 +207,7 @@ int parse_cgroups(const struct option *opt, const char *str,
> >  }
> >
> >  int evlist__expand_cgroup(struct evlist *evlist, const char *str,
> > -                       struct rblist *metric_events)
> > +                       struct rblist *metric_events, bool open_cgroup)
> >  {
> >       struct evlist *orig_list, *tmp_list;
> >       struct evsel *pos, *evsel, *leader;
> > @@ -240,7 +245,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
> >                       if (!name)
> >                               break;
> >
> > -                     cgrp = cgroup__new(name);
> > +                     cgrp = cgroup__new(name, open_cgroup);
> >                       free(name);
> >                       if (cgrp == NULL)
> >                               break;
> > diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> > index eea6df8ee373..162906f3412a 100644
> > --- a/tools/perf/util/cgroup.h
> > +++ b/tools/perf/util/cgroup.h
> > @@ -26,7 +26,7 @@ struct rblist;
> >
> >  struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
> >  int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups,
> > -                       struct rblist *metric_events);
> > +                       struct rblist *metric_events, bool open_cgroup);
> >
> >  void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
> >
> > --
> > 2.28.0.618.gf4bc123cb7-goog
> >
>
