Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC222B688E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbgKQPVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:21:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729474AbgKQPVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605626512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jR7aAwBFoMkDOKbYfk5oE2u3r5jLhu+r7XSshNfCDcQ=;
        b=Rm2Kyw1Kg0H/qDlo76/sELFTLZMoiWrbR1t0mpuuPHHFKJl0i40YWA0bZxm3iJrEQunSv/
        c269A0WZTu+3f1cUs4rBKhGXVhmSZl/XrDpRzJwoucA8F9GeqeSL61ZXJ1gqZ/lCWgRF/4
        0sXKaXozTIVxn1e0zbA7HpdYtMFn/zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-gWumX4JGPuaPFXuQrhUj8w-1; Tue, 17 Nov 2020 10:21:46 -0500
X-MC-Unique: gWumX4JGPuaPFXuQrhUj8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C1721084CA3;
        Tue, 17 Nov 2020 15:21:44 +0000 (UTC)
Received: from krava (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1C86A5C1CF;
        Tue, 17 Nov 2020 15:21:40 +0000 (UTC)
Date:   Tue, 17 Nov 2020 16:21:40 +0100
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
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 23/24] perf buildid-list: Add support for mmap2's buildid
 events
Message-ID: <20201117152140.GE1216482@krava>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-24-jolsa@kernel.org>
 <20201117125040.GT614220@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117125040.GT614220@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:50:40AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 17, 2020 at 12:00:52PM +0100, Jiri Olsa escreveu:
> > Add buildid-list support for mmap2's build id data, so we can
> > display build ids for dso objects for data without the build
> > id cache update.
> 
> >   $ perf buildid-list
> >   1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
> >   d278249792061c6b74d1693ca59513be1def13f2 /usr/lib64/libc-2.31.so
> > 
> > By default only dso objects with hits are shown.
> 
> Would be interesting to be able to show all the build ids that are
> there. a 'perf buildid-list --all' or make this under --force?

ok, will check.. one other tool I think would be handy is
to show which debuginfo is not available, because it can
change the report a lot - missing symbols are not getting
accounted, and their hits are accounted only as separated
addresses

jirka

> 
> - Arnaldo
>  
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-buildid-list.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
> > index e3ef75583514..87f5b1a4a7fa 100644
> > --- a/tools/perf/builtin-buildid-list.c
> > +++ b/tools/perf/builtin-buildid-list.c
> > @@ -77,6 +77,9 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
> >  	    perf_header__has_feat(&session->header, HEADER_AUXTRACE))
> >  		with_hits = false;
> >  
> > +	if (!perf_header__has_feat(&session->header, HEADER_BUILD_ID))
> > +		with_hits = true;
> > +
> >  	/*
> >  	 * in pipe-mode, the only way to get the buildids is to parse
> >  	 * the record stream. Buildids are stored as RECORD_HEADER_BUILD_ID
> > -- 
> > 2.26.2
> > 
> 
> -- 
> 
> - Arnaldo
> 

