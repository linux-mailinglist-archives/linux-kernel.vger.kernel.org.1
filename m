Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E828269717
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgINUwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:52:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26577 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbgINUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600116721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdR+cMNYakSsSzOJ13pwg3JzHjsrpMrZyrN1lwqXeTQ=;
        b=h0OFv+HySBQcjLq2n/MzQDnDvU98WgVMXEXIE4BUTGtJ/cmiWjmcRREGj4tIOQN95eYuDa
        hoQvAPQczQGglZ/WRSxPB74aOyDnprfR/9f4rRrrYJYrihz67iVOgI8dI1fG5gnELCmiWZ
        d+/NWFMMBEgLi00zl9K39p1TcreS5co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-xZOsD-92Oi6Um44-kN2YeA-1; Mon, 14 Sep 2020 16:51:57 -0400
X-MC-Unique: xZOsD-92Oi6Um44-kN2YeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 227BC1882FB5;
        Mon, 14 Sep 2020 20:51:55 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6793360C0F;
        Mon, 14 Sep 2020 20:51:51 +0000 (UTC)
Date:   Mon, 14 Sep 2020 22:51:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 15/26] perf tools: Synthesize proc tasks with mmap3
Message-ID: <20200914205150.GC1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-16-jolsa@kernel.org>
 <20200914160738.GJ160517@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914160738.GJ160517@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 01:07:38PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Sep 13, 2020 at 11:03:02PM +0200, Jiri Olsa escreveu:
> > Synthesizing proc tasks with mmap3 events so we can
> > get build id data for synthesized maps as well.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/mmap.c             |  2 +-
> >  tools/perf/util/synthetic-events.c | 72 +++++++++++++++++-------------
> >  2 files changed, 43 insertions(+), 31 deletions(-)
> > 
> > diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> > index ab7108d22428..51f6f86580a9 100644
> > --- a/tools/perf/util/mmap.c
> > +++ b/tools/perf/util/mmap.c
> > @@ -33,7 +33,7 @@ void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag)
> >  
> >  	len = bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
> >  	buf[len] = '\0';
> > -	pr_debug("%p: %s mask[%zd]: %s\n", mask, tag, mask->nbits, buf);
> > +	pr_debug2("%p: %s mask[%zd]: %s\n", mask, tag, mask->nbits, buf);
> >  }
> 
> Can this be in a separate patch?

ok

>   
> >  size_t mmap__mmap_len(struct mmap *map)
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index 89b390623b63..bd6e7b84283d 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -379,7 +379,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
> >  	}
> >  	io__init(&io, io.fd, bf, sizeof(bf));
> >  
> > -	event->header.type = PERF_RECORD_MMAP2;
> > +	event->header.type = PERF_RECORD_MMAP3;
> 
> This also needs to check if the user is interested in build-id records.
> If it is disabled, then using this new tool with mmap3 support will
> generate perf.data files that will bot be grokked by older tools,
> introducing an annoyance for people not interested in build-ids.

ok, this should disappear with if we stay with mmap2
and do that union stuff

thanks,
jirka

