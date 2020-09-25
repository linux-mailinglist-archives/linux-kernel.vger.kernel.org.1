Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5922789F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgIYNvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727290AbgIYNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601041907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I3KFTIPLkmuPnc1IqMk/hPgvPxBrU+f5Vu4dTKm6s38=;
        b=QzavQG/kseCihB4ydCY3yZ7WCprHrYp//1C4tPCOwke6liEZrjOmr29y+0AX13ICgUFjN5
        435m1nfv5EtHLSEHpQXrj7ZQVgrp26ypR5hM8nQokJUD9Ex5d21X1vAvAlUSlAGk+vyCoN
        aG9//fX4f1vFxKAg83nLTRbuy6TpQ8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-07OgLh0dNQODWml9FFsw1A-1; Fri, 25 Sep 2020 09:51:45 -0400
X-MC-Unique: 07OgLh0dNQODWml9FFsw1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C41F1022E1D;
        Fri, 25 Sep 2020 13:51:43 +0000 (UTC)
Received: from krava (unknown [10.40.192.203])
        by smtp.corp.redhat.com (Postfix) with SMTP id ACE2473695;
        Fri, 25 Sep 2020 13:51:39 +0000 (UTC)
Date:   Fri, 25 Sep 2020 15:51:33 +0200
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
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH 3/5] perf tools: Copy metric events properly when expand
 cgroups
Message-ID: <20200925135133.GC3273770@krava>
References: <20200924124455.336326-1-namhyung@kernel.org>
 <20200924124455.336326-4-namhyung@kernel.org>
 <20200925132636.GB3273770@krava>
 <CAM9d7cgHBe6-SfCc3RTfLmrvaKr1hSprmJPd2BFnQtMUu_6TFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgHBe6-SfCc3RTfLmrvaKr1hSprmJPd2BFnQtMUu_6TFw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 10:44:53PM +0900, Namhyung Kim wrote:
> On Fri, Sep 25, 2020 at 10:26 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Sep 24, 2020 at 09:44:53PM +0900, Namhyung Kim wrote:
> >
> > SNIP
> >
> > >
> > > +     if (metric_events) {
> > > +             orig_metric_events = *metric_events;
> > > +             rblist__init(metric_events);
> > > +     } else {
> > > +             rblist__init(&orig_metric_events);
> > > +     }
> > > +
> > >       for (;;) {
> > >               p = strchr(str, ',');
> > >               e = p ? p : eos;
> > > @@ -255,6 +267,14 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> > >               cgroup__put(cgrp);
> > >               nr_cgroups++;
> > >
> > > +             if (metric_events) {
> > > +                     perf_stat__collect_metric_expr(tmp_list);
> > > +                     if (metricgroup__copy_metric_events(tmp_list, cgrp,
> > > +                                                         metric_events,
> > > +                                                         &orig_metric_events) < 0)
> > > +                             break;
> > > +             }
> >
> > looks good, do you plan to actualy add support for record?
> 
> No actually, I still think perf record should use --all-cgroups.
> 
> > my ack from last version stays
> 
> Thanks!  But I didn't see your ack for this patch set.
> (I've only seen it for the perf inject patchset..)

ah that was for the build id inject speed up.. too many
patchsets flying around ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

