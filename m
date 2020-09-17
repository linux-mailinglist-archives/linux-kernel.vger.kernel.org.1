Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D577E26D5D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIQIKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgIQIKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:10:03 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:10:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600330201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFNGAq00DjWVmvAmY4dKhVrs1LkCmMlaSkXK/+6ytzo=;
        b=iVZOEj06ZFOLuzTJjXDz4MEOLnJUFrxLcRLI+5yihb5r2C07Gny2hBJWYIE31ig8AHViGm
        ZJbpa9q/Iux1ngi9D4PP9ilMCQVV5vAJey6mZ8erVD/nuhMCdqFzJgOYU+xCxc8A897p5y
        1jl7e9GtMGOBO02lX3I8WihGgpBXe+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-w3-B7QN-OMmimUabkW5kAQ-1; Thu, 17 Sep 2020 04:01:56 -0400
X-MC-Unique: w3-B7QN-OMmimUabkW5kAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A40E680EF84;
        Thu, 17 Sep 2020 08:01:54 +0000 (UTC)
Received: from krava (ovpn-114-176.ams2.redhat.com [10.36.114.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3EDE878805;
        Thu, 17 Sep 2020 08:01:52 +0000 (UTC)
Date:   Thu, 17 Sep 2020 10:01:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 3/3] perf inject: Do not load map/dso when injecting
 build-id
Message-ID: <20200917080151.GA2411168@krava>
References: <20200914141859.332459-1-namhyung@kernel.org>
 <20200914141859.332459-3-namhyung@kernel.org>
 <20200915100533.GC2171499@krava>
 <CAM9d7cjHzbamDDQRmBQ_UydbkUCNA5MZfPj4fGCbb7O9m3KOgA@mail.gmail.com>
 <20200916082443.GB2301783@krava>
 <CAM9d7cjLdRDLtgSYqZW1mwCxbBe28tjUjzEDjaBcnV6W0jdQzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjLdRDLtgSYqZW1mwCxbBe28tjUjzEDjaBcnV6W0jdQzA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:27:41AM +0900, Namhyung Kim wrote:
> On Wed, Sep 16, 2020 at 5:24 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Sep 15, 2020 at 11:55:34PM +0900, Namhyung Kim wrote:
> > > On Tue, Sep 15, 2020 at 7:05 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Mon, Sep 14, 2020 at 11:18:59PM +0900, Namhyung Kim wrote:
> > > > > No need to load symbols in a DSO when injecting build-id.  I guess the
> > > > > reason was to check the DSO is a special file like anon files.  Use
> > > > > some helper functions in map.c to check them before reading build-id.
> > > > > Also pass sample event's cpumode to a new build-id event.
> > > > >
> > > > > Original-patch-by: Stephane Eranian <eranian@google.com>
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  tools/perf/builtin-inject.c | 30 ++++++++++--------------------
> > > > >  tools/perf/util/map.c       | 17 +----------------
> > > > >  tools/perf/util/map.h       | 14 ++++++++++++++
> > > > >  3 files changed, 25 insertions(+), 36 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > > > > index a2804d906d2a..6d4e6833efed 100644
> > > > > --- a/tools/perf/builtin-inject.c
> > > > > +++ b/tools/perf/builtin-inject.c
> > > > > @@ -436,21 +436,22 @@ static int dso__read_build_id(struct dso *dso)
> > > > >  }
> > > > >
> > > > >  static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
> > > > > -                             struct machine *machine)
> > > > > +                             struct machine *machine, u8 cpumode)
> > > > >  {
> > > > > -     u16 misc = PERF_RECORD_MISC_USER;
> > > > >       int err;
> > > > >
> > > > > +     if (is_anon_memory(dso->long_name))
> > > > > +             return 0;
> > > > > +     if (is_no_dso_memory(dso->long_name))
> > > > > +             return 0;
> > > >
> > > > should we check for vdso as well? I don't think it has build id
> > >
> > > I don't know.. But I guess there's no reason it shouldn't?
> >
> > I haven't checked, it's just I always saw only zeros for vdso build ids
> 
> I found this in arch/x86/entry/vdso/Makefile.  It seems to have one..
> 
> quiet_cmd_vdso = VDSO    $@
>       cmd_vdso = $(LD) -nostdlib -o $@ \
>                $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
>                -T $(filter %.lds,$^) $(filter %.o,$^) && \
>          sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
> 
> VDSO_LDFLAGS = -shared --hash-style=both --build-id \
>     $(call ld-option, --eh-frame-hdr) -Bsymbolic

I see, I'll check why I'm getting zeros

thanks,
jirka

