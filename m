Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3030275491
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWJav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgIWJav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600853449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r5p+daryNxkyz0OgmKt+SUjejQfASxt16NwrXrf4GS0=;
        b=buVDudNiN/vITafD+6U9stkfqAjaIifdVZKNnYRrsiuVd73+0ZV6VULFRS+6mcLmorZLZf
        S6zohj7Z140V1gZPI8h6t+Gp+R50U4tchkMBZtbHZYLMP9EY1KD4elW0lvJ0m7Ih+ugtMr
        v3pyTS7xAJxflzXtWXlm13VzsSZs43c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-Br6rjbgmM8itU4ga_0vkuA-1; Wed, 23 Sep 2020 05:30:47 -0400
X-MC-Unique: Br6rjbgmM8itU4ga_0vkuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00133188C126;
        Wed, 23 Sep 2020 09:30:44 +0000 (UTC)
Received: from krava (unknown [10.40.192.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9FE245577B;
        Wed, 23 Sep 2020 09:30:42 +0000 (UTC)
Date:   Wed, 23 Sep 2020 11:30:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/5] perf stat: Add --for-each-cgroup option
Message-ID: <20200923093041.GH2893484@krava>
References: <20200921094610.83736-1-namhyung@kernel.org>
 <20200921094610.83736-3-namhyung@kernel.org>
 <20200922214033.GD2893484@krava>
 <CAM9d7ciL7LmpFyxxD20q+6JM4pE1T9hsMKvOtv-s1r+EamCDpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciL7LmpFyxxD20q+6JM4pE1T9hsMKvOtv-s1r+EamCDpQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 07:51:33AM +0900, Namhyung Kim wrote:
> On Wed, Sep 23, 2020 at 6:40 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Sep 21, 2020 at 06:46:07PM +0900, Namhyung Kim wrote:
> >
> > SNIP
> >
> > > +int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> > > +{
> > > +     struct evlist *orig_list, *tmp_list;
> > > +     struct evsel *pos, *evsel, *leader;
> > > +     struct cgroup *cgrp = NULL;
> > > +     const char *p, *e, *eos = str + strlen(str);
> > > +     int ret = -1;
> > > +
> > > +     if (evlist->core.nr_entries == 0) {
> > > +             fprintf(stderr, "must define events before cgroups\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     orig_list = evlist__new();
> > > +     tmp_list = evlist__new();
> > > +     if (orig_list == NULL || tmp_list == NULL) {
> > > +             fprintf(stderr, "memory allocation failed\n");
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     /* save original events and init evlist */
> > > +     perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
> > > +     evlist->core.nr_entries = 0;
> > > +
> > > +     for (;;) {
> > > +             p = strchr(str, ',');
> > > +             e = p ? p : eos;
> > > +
> > > +             /* allow empty cgroups, i.e., skip */
> > > +             if (e - str) {
> > > +                     /* termination added */
> > > +                     char *name = strndup(str, e - str);
> > > +                     if (!name)
> > > +                             goto out_err;
> > > +
> > > +                     cgrp = cgroup__new(name);
> > > +                     free(name);
> > > +                     if (cgrp == NULL)
> > > +                             goto out_err;
> > > +             } else {
> > > +                     cgrp = NULL;
> > > +             }
> > > +
> > > +             leader = NULL;
> > > +             evlist__for_each_entry(orig_list, pos) {
> > > +                     evsel = evsel__clone(pos);
> > > +                     if (evsel == NULL)
> > > +                             goto out_err;
> > > +
> > > +                     cgroup__put(evsel->cgrp);
> > > +                     evsel->cgrp = cgroup__get(cgrp);
> > > +
> > > +                     if (evsel__is_group_leader(pos))
> > > +                             leader = evsel;
> > > +                     evsel->leader = leader;
> >
> > hum, will this work if there's standalone event after group? like:
> >
> >   {cycles,instructions},cache-misses
> >
> > cache-misses will get cycles as group leader no?
> 
> AFAIK non-group events are treated as a leader of its own group.
> So evsel__is_group_leader() will return true for cache-misses.

right, then it's fine

thanks,
jirka

