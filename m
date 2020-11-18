Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478A42B7A79
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKRJf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:35:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgKRJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605692157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7oDgWHxu4+MRhAydEZNRlN5kWaVQTY+ZlvNsq17iNM=;
        b=CH9CFwjoKL4eo+aKdWmS4Q0g5+3K+oL+71T1k8SkoczkJPUE0tdZIXB54MC3YavFCBrjHc
        QYyX2SF/JsVmRnOLEUk1PRurWP2a2UhxFhH8V0iMMeYoc3cV3qZma3058Ztz4URtj9igUC
        l4XtpB6KpdrAIBM/EDnGPyOagCzfJzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-uJbNMfRqM3SELhkJ-tBYXw-1; Wed, 18 Nov 2020 04:35:53 -0500
X-MC-Unique: uJbNMfRqM3SELhkJ-tBYXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F31CB1028D41;
        Wed, 18 Nov 2020 09:35:50 +0000 (UTC)
Received: from krava (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3DECF6B8E5;
        Wed, 18 Nov 2020 09:35:46 +0000 (UTC)
Date:   Wed, 18 Nov 2020 10:35:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 06/24] perf tools: Add build_id__is_defined function
Message-ID: <20201118093545.GB1414446@krava>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-7-jolsa@kernel.org>
 <CAP-5=fUrf9Kq3XwKALSZut3M6NXtnJCAMw0Pe2rh8_31a7tX4w@mail.gmail.com>
 <20201117205359.GJ1216482@krava>
 <20201117233313.GD657351@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117233313.GD657351@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 08:33:13PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 17, 2020 at 09:53:59PM +0100, Jiri Olsa escreveu:
> > On Tue, Nov 17, 2020 at 11:00:37AM -0800, Ian Rogers wrote:
> > > On Tue, Nov 17, 2020 at 3:01 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > 
> > > > Adding build_id__is_defined helper to check build id
> > > > is defined and is != zero build id.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/perf/util/build-id.c | 7 +++++++
> > > >  tools/perf/util/build-id.h | 1 +
> > > >  2 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > > > index 6b410c3d52dc..7d9ecc37849c 100644
> > > > --- a/tools/perf/util/build-id.c
> > > > +++ b/tools/perf/util/build-id.c
> > > > @@ -912,3 +912,10 @@ void build_id__init(struct build_id *bid, const u8
> > > > *data, size_t size)
> > > >         memcpy(bid->data, data, size);
> > > >         bid->size = size;
> > > >  }
> > > > +
> > > > +bool build_id__is_defined(const struct build_id *bid)
> > > > +{
> > > > +       static u8 zero[BUILD_ID_SIZE];
> > > > +
> > > > +       return bid && bid->size ? memcmp(bid->data, &zero, bid->size) :
> > > > false;
> 
> > > Fwiw, I find this method to test for zero a little hard to parse - I'm
> > 
> > heh, it's controversial one, Namhyung commented
> > on this one in previous version, so I changed it ;-)
> >   https://lore.kernel.org/lkml/CAM9d7cjjGjTN8sDgLZ1PoQZ-sUXWjnVaNdyOVE1yHxq46PrPkw@mail.gmail.com/
> 
> So, the kernel has an idiom for this in lib/string.c:
> 
> /**
>  * memchr_inv - Find an unmatching character in an area of memory.
>  * @start: The memory area
>  * @c: Find a character other than c
>  * @bytes: The size of the area.
>  *
>  * returns the address of the first character other than @c, or %NULL
>  * if the whole buffer contains just @c.
>  */
> void *memchr_inv(const void *start, int c, size_t bytes)
> 
> No need for any array of some particular size :-)

ok, will check

thanks,
jirka

