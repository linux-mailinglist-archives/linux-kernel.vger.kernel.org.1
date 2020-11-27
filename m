Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C704F2C7533
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgK1Vt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729700AbgK0TrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zLd+09Z4+69S8sedgdRcQGcUngaZ+JS9VltxdPK7hqU=;
        b=SiuW2Uaa5VLLgR4HbLzlqAU5q8Ow7+ezskb1YS0L9hOJYHCpQibirjatajG+f6Tj5JgbRS
        limucsXlRxKhTkarT/LpkZqtXHw8wor3C+fIeNjtyYAs2YEcTJvEBXwnIOqyriJqxkljvs
        hV3ThWWkXWY1rmzvNrzo6GQ+rd/yIEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-NnPuJUfEMSat1pPKTINTUA-1; Fri, 27 Nov 2020 14:46:57 -0500
X-MC-Unique: NnPuJUfEMSat1pPKTINTUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56A528049C3;
        Fri, 27 Nov 2020 19:46:55 +0000 (UTC)
Received: from krava (unknown [10.40.194.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3887E5C1C2;
        Fri, 27 Nov 2020 19:46:52 +0000 (UTC)
Date:   Fri, 27 Nov 2020 20:46:51 +0100
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
Subject: Re: [PATCH 06/25] perf tools: Do not swap mmap2 fields in case it
 contains build id
Message-ID: <20201127194651.GB2788968@krava>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-7-jolsa@kernel.org>
 <20201126173042.GF53384@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126173042.GF53384@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 02:30:42PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 26, 2020 at 06:00:07PM +0100, Jiri Olsa escreveu:
> > If PERF_RECORD_MISC_MMAP_BUILD_ID misc bit is set,
> > mmap2 event carries build id, placed in following union:
> > 
> >   union {
> >           struct {
> >                   u32       maj;
> >                   u32       min;
> >                   u64       ino;
> >                   u64       ino_generation;
> >           };
> >           struct {
> >                   u8        build_id[20];
> >                   u8        build_id_size;
> >                   u8        __reserved_1;
> >                   u16       __reserved_2;
> >           };
> >   };
> 
> Did you forgot to update just this cset comment?

ah yes, will fix

thanks,
jirka

> 
> - Arnaldo
>  
> > In this case we can't swap above fields.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/session.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 5cc722b6fe7c..cc1c11ca94fd 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -592,10 +592,13 @@ static void perf_event__mmap2_swap(union perf_event *event,
> >  	event->mmap2.start = bswap_64(event->mmap2.start);
> >  	event->mmap2.len   = bswap_64(event->mmap2.len);
> >  	event->mmap2.pgoff = bswap_64(event->mmap2.pgoff);
> > -	event->mmap2.maj   = bswap_32(event->mmap2.maj);
> > -	event->mmap2.min   = bswap_32(event->mmap2.min);
> > -	event->mmap2.ino   = bswap_64(event->mmap2.ino);
> > -	event->mmap2.ino_generation = bswap_64(event->mmap2.ino_generation);
> > +
> > +	if (!(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
> > +		event->mmap2.maj   = bswap_32(event->mmap2.maj);
> > +		event->mmap2.min   = bswap_32(event->mmap2.min);
> > +		event->mmap2.ino   = bswap_64(event->mmap2.ino);
> > +		event->mmap2.ino_generation = bswap_64(event->mmap2.ino_generation);
> > +	}
> >  
> >  	if (sample_id_all) {
> >  		void *data = &event->mmap2.filename;
> > -- 
> > 2.26.2
> > 
> 
> -- 
> 
> - Arnaldo
> 

