Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E1F2B197E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKMLDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:03:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbgKMLCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605265294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UVE4VAhfFASKDQr/1v00W+jjf/yyMEehnVZpEYjNa+8=;
        b=PH3LGmGs41gXNdDGUZphIfogLSkEp4KNeAHuo7qVz/xNdKua7OY1xO+16bM5/lxhvWEfwt
        1I6R1OdoNlfc66ZciE3g2+UM6S6Sui7XEZOl9B9c8P5oQlHUlKuRfiT2ZHcisbNl1EcyXF
        iT5Qv69MRIBn9r3TMhLNVhagtFyY2zE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-6yUCoA48NmOa_rKiChn_-Q-1; Fri, 13 Nov 2020 06:01:32 -0500
X-MC-Unique: 6yUCoA48NmOa_rKiChn_-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9571D1084D6C;
        Fri, 13 Nov 2020 11:01:29 +0000 (UTC)
Received: from krava (unknown [10.40.195.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 638E473660;
        Fri, 13 Nov 2020 11:01:26 +0000 (UTC)
Date:   Fri, 13 Nov 2020 12:01:25 +0100
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
Subject: Re: [PATCH 03/24] perf: Add build id data in mmap2 event
Message-ID: <20201113110125.GD753418@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-4-jolsa@kernel.org>
 <20201113042935.GA167797@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113042935.GA167797@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 01:29:35PM +0900, Namhyung Kim wrote:

SNIP

> >  
> >  	struct {
> >  		struct perf_event_header	header;
> > @@ -7997,13 +8003,23 @@ static void perf_event_mmap_output(struct perf_event *event,
> >  	mmap_event->event_id.pid = perf_event_pid(event, current);
> >  	mmap_event->event_id.tid = perf_event_tid(event, current);
> >  
> > +	if (event->attr.mmap2 && event->attr.build_id)
> > +		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_BUILD_ID;
> > +
> >  	perf_output_put(&handle, mmap_event->event_id);
> >  
> >  	if (event->attr.mmap2) {
> > -		perf_output_put(&handle, mmap_event->maj);
> > -		perf_output_put(&handle, mmap_event->min);
> > -		perf_output_put(&handle, mmap_event->ino);
> > -		perf_output_put(&handle, mmap_event->ino_generation);
> > +		if (event->attr.build_id) {
> > +			u8 size[4] = { (u8) mmap_event->build_id_size, 0, 0, 0 };
> > +
> > +			__output_copy(&handle, mmap_event->build_id, BUILD_ID_SIZE);
> > +			__output_copy(&handle, size, 4);
> > +		} else {
> > +			perf_output_put(&handle, mmap_event->maj);
> > +			perf_output_put(&handle, mmap_event->min);
> > +			perf_output_put(&handle, mmap_event->ino);
> > +			perf_output_put(&handle, mmap_event->ino_generation);
> > +		}
> >  		perf_output_put(&handle, mmap_event->prot);
> >  		perf_output_put(&handle, mmap_event->flags);
> >  	}
> > @@ -8132,6 +8148,11 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
> >  
> >  	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
> >  
> > +	if (atomic_read(&nr_build_id_events)) {
> > +		build_id_parse_size(vma, mmap_event->build_id,
> > +				    &mmap_event->build_id_size);
> 
> This can fail, right?  Then we need to fallback to use dev/ino..

right, I did not implemented fallback in here, but I think
you are right.. we should try to do the best in fail, I'll add it

thanks,
jirka

