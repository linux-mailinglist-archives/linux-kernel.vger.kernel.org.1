Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6A2B707E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKQUyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:54:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbgKQUyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605646453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Na5qrtekWhtUQWyADlsoTi+TWRlxFpXFSkHs1Gld4JY=;
        b=dg6PqXsT2y6+N26rS3npXlYuY+7qbDXd/kXxtEzw87IOkKFlF6DdMxCsmgHJa056JHhFiO
        zWBLXmNMWKmykS6kXeyVQ4Cb2k7oDS71eVfERrcXAhEQEc7BI0BWcJWpZIciOgCc7G9cmg
        ybhQV73y+QWNGnGYL7pdJd8Xw1jkWcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-WJ5oIdGpNcWrgVNJG58W-g-1; Tue, 17 Nov 2020 15:54:06 -0500
X-MC-Unique: WJ5oIdGpNcWrgVNJG58W-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D5D08030B9;
        Tue, 17 Nov 2020 20:54:04 +0000 (UTC)
Received: from krava (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with SMTP id 660526B8E9;
        Tue, 17 Nov 2020 20:54:00 +0000 (UTC)
Date:   Tue, 17 Nov 2020 21:53:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20201117205359.GJ1216482@krava>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-7-jolsa@kernel.org>
 <CAP-5=fUrf9Kq3XwKALSZut3M6NXtnJCAMw0Pe2rh8_31a7tX4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUrf9Kq3XwKALSZut3M6NXtnJCAMw0Pe2rh8_31a7tX4w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:00:37AM -0800, Ian Rogers wrote:
> On Tue, Nov 17, 2020 at 3:01 AM Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding build_id__is_defined helper to check build id
> > is defined and is != zero build id.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/build-id.c | 7 +++++++
> >  tools/perf/util/build-id.h | 1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > index 6b410c3d52dc..7d9ecc37849c 100644
> > --- a/tools/perf/util/build-id.c
> > +++ b/tools/perf/util/build-id.c
> > @@ -912,3 +912,10 @@ void build_id__init(struct build_id *bid, const u8
> > *data, size_t size)
> >         memcpy(bid->data, data, size);
> >         bid->size = size;
> >  }
> > +
> > +bool build_id__is_defined(const struct build_id *bid)
> > +{
> > +       static u8 zero[BUILD_ID_SIZE];
> > +
> > +       return bid && bid->size ? memcmp(bid->data, &zero, bid->size) :
> > false;
> >
> 
> Fwiw, I find this method to test for zero a little hard to parse - I'm

heh, it's controversial one, Namhyung commented
on this one in previous version, so I changed it ;-)
  https://lore.kernel.org/lkml/CAM9d7cjjGjTN8sDgLZ1PoQZ-sUXWjnVaNdyOVE1yHxq46PrPkw@mail.gmail.com/


> failing as a C programmer :-) Nit, should zero be const?

right, should be const, will change

thanks,
jirka

