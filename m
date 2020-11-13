Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C6F2B19B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKMLML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:12:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726629AbgKMLKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605265822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xk+V7EV4JI6HGoh34X7wSjp5h6BjQD40ushemGIgOxE=;
        b=f5VjDPjAoChlDuwirGX+P9Wk1WEKBdEUOAXbZpp+NMibzCTLIowU1YlAWih86YIZohU0ie
        ncocFY40qq5SJ7sLKynNlxwjApnKLwMyxBoWULmZVlVyGPLyjLA3Z3gnVuJ3bnejaD5URt
        +KQG77lwgjdSCcbn1vvti5rxCW+b2NQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-TYjYoVW7N3SHNQzocCV3Xg-1; Fri, 13 Nov 2020 06:10:18 -0500
X-MC-Unique: TYjYoVW7N3SHNQzocCV3Xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C4AD18B9F36;
        Fri, 13 Nov 2020 11:10:15 +0000 (UTC)
Received: from krava (unknown [10.40.195.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id B1E866EF66;
        Fri, 13 Nov 2020 11:10:12 +0000 (UTC)
Date:   Fri, 13 Nov 2020 12:10:11 +0100
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
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 15/24] perf tools: Synthesize build id for
 kernel/modules/tasks
Message-ID: <20201113111011.GF753418@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-16-jolsa@kernel.org>
 <20201113043222.GB167797@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113043222.GB167797@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 01:32:22PM +0900, Namhyung Kim wrote:
> On Mon, Nov 09, 2020 at 10:54:06PM +0100, Jiri Olsa wrote:
> > Adding build id to synthesized mmap2 events for
> > everything - kernel/modules/tasks.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/synthetic-events.c | 33 ++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index a18ae502d765..a9d5d1ff2cad 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -347,6 +347,32 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
> >  	}
> >  }
> >  
> > +static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
> > +					     bool is_kernel)
> > +{
> > +	struct build_id bid;
> > +	int rc;
> > +
> > +	if (is_kernel)
> > +		rc = sysfs__read_build_id("/sys/kernel/notes", &bid);
> > +	else
> > +		rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
> > +
> > +	if (rc == 0) {
> > +		memcpy(event->build_id, bid.data, sizeof(bid.data));
> > +		event->build_id_size = (u8) bid.size;
> > +	} else {
> > +		if (event->filename[0] == '/') {
> > +			pr_debug2("Failed to read build ID for %s\n",
> > +				  event->filename);
> > +		}
> > +		memset(event->build_id, 0x0, sizeof(event->build_id));
> 
> Likewise, we should not set the misc bit here IMHO.

right, will implement the fallback

jirka

