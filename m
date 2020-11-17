Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1292B67A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgKQOik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728383AbgKQOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605623917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zhw8Va7jc+sGErE7u00ZQprK52S4ocr7vD7MstBtcMo=;
        b=PXA9pD377yi+CwIFqTOBXM8hLlb4Ri0+RPsNuH1JdPx7X2jLogmhrjFAZXG+Ln/DLLPBK3
        GBc4Ke4PPNCJ1y9INQ+9gccuSP/SOxWp0WwLkYp20ebxb0HiCkPWDwSwy9pMqwND3kpNpT
        uVBv4zLdnj0zB0+tR/Vsq345FH/+Oq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-64W174LXMX6K4bvlaVzkGw-1; Tue, 17 Nov 2020 09:38:19 -0500
X-MC-Unique: 64W174LXMX6K4bvlaVzkGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEB2064144;
        Tue, 17 Nov 2020 14:38:17 +0000 (UTC)
Received: from krava (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with SMTP id 93AED19746;
        Tue, 17 Nov 2020 14:38:09 +0000 (UTC)
Date:   Tue, 17 Nov 2020 15:38:04 +0100
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
Subject: Re: [PATCH 12/24] perf tools: Store build id from mmap2 events
Message-ID: <20201117143804.GC1216482@krava>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-13-jolsa@kernel.org>
 <20201117123805.GN614220@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117123805.GN614220@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:38:05AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 17, 2020 at 12:00:41PM +0100, Jiri Olsa escreveu:
> > When processing mmap2 event, check on the build id
> > misc bit: PERF_RECORD_MISC_BUILD_ID and if it's set,
> > store the build id in mmap's dso object.
> > 
> > Also adding the build id data arts to struct
> > perf_record_mmap2 event definition.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/events/core.c                |  4 ++++
> >  tools/lib/perf/include/perf/event.h | 18 ++++++++++++++----
> >  tools/perf/util/machine.c           | 24 +++++++++++++++++++-----
> >  tools/perf/util/map.c               |  8 ++++++--
> >  tools/perf/util/map.h               |  3 ++-
> >  5 files changed, 45 insertions(+), 12 deletions(-)
> 
> You mixed up kernel changes with tools/ changes, can you please split
> this up?
> 
> Also there is an indentation problem in the kernel changes, which, I
> think, is just debugging cruft that you forgot to excise? :-)

mama mia.. sry, that's debug that slipped, there will
be new version for sure ;-)

jirka

> 
> - Arnaldo
>  
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 5841b5bca68d..fa7f392c6c0c 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8017,6 +8017,10 @@ static void perf_event_mmap_output(struct perf_event *event,
> >  
> >  			__output_copy(&handle, size, 4);
> >  			__output_copy(&handle, mmap_event->build_id, BUILD_ID_SIZE);
> > +
> > +if (mmap_event->build_id_size > 20)
> > +	trace_printk("build_id_size %u %s\n", mmap_event->build_id_size, mmap_event->file_name);
> > +
> >  		} else {
> >  			perf_output_put(&handle, mmap_event->maj);
> >  			perf_output_put(&handle, mmap_event->min);
> > diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> > index 988c539bedb6..d82054225fcc 100644
> > --- a/tools/lib/perf/include/perf/event.h
> > +++ b/tools/lib/perf/include/perf/event.h
> > @@ -23,10 +23,20 @@ struct perf_record_mmap2 {
> >  	__u64			 start;
> >  	__u64			 len;
> >  	__u64			 pgoff;
> > -	__u32			 maj;
> > -	__u32			 min;
> > -	__u64			 ino;
> > -	__u64			 ino_generation;
> > +	union {
> > +		struct {
> > +			__u32	 maj;
> > +			__u32	 min;
> > +			__u64	 ino;
> > +			__u64	 ino_generation;
> > +		};
> > +		struct {
> > +			__u8	 build_id_size;
> > +			__u8	 __reserved_1;
> > +			__u16	 __reserved_2;
> > +			__u8	 build_id[20];
> > +		};
> > +	};
> >  	__u32			 prot;
> >  	__u32			 flags;
> >  	char			 filename[PATH_MAX];
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 1ae32a81639c..1edb7d10b042 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1599,7 +1599,8 @@ static int machine__process_extra_kernel_map(struct machine *machine,
> >  }
> >  
> >  static int machine__process_kernel_mmap_event(struct machine *machine,
> > -					      struct extra_kernel_map *xm)
> > +					      struct extra_kernel_map *xm,
> > +					      struct build_id *bid)
> >  {
> >  	struct map *map;
> >  	enum dso_space_type dso_space;
> > @@ -1624,6 +1625,10 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
> >  			goto out_problem;
> >  
> >  		map->end = map->start + xm->end - xm->start;
> > +
> > +		if (build_id__is_defined(bid))
> > +			dso__set_build_id(map->dso, bid);
> > +
> >  	} else if (is_kernel_mmap) {
> >  		const char *symbol_name = (xm->name + strlen(machine->mmap_name));
> >  		/*
> > @@ -1681,6 +1686,9 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
> >  
> >  		machine__update_kernel_mmap(machine, xm->start, xm->end);
> >  
> > +		if (build_id__is_defined(bid))
> > +			dso__set_build_id(kernel, bid);
> > +
> >  		/*
> >  		 * Avoid using a zero address (kptr_restrict) for the ref reloc
> >  		 * symbol. Effectively having zero here means that at record
> > @@ -1718,11 +1726,17 @@ int machine__process_mmap2_event(struct machine *machine,
> >  		.ino = event->mmap2.ino,
> >  		.ino_generation = event->mmap2.ino_generation,
> >  	};
> > +	struct build_id __bid, *bid = NULL;
> >  	int ret = 0;
> >  
> >  	if (dump_trace)
> >  		perf_event__fprintf_mmap2(event, stdout);
> >  
> > +	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
> > +		bid = &__bid;
> > +		build_id__init(bid, event->mmap2.build_id, event->mmap2.build_id_size);
> > +	}
> > +
> >  	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
> >  	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
> >  		struct extra_kernel_map xm = {
> > @@ -1732,7 +1746,7 @@ int machine__process_mmap2_event(struct machine *machine,
> >  		};
> >  
> >  		strlcpy(xm.name, event->mmap2.filename, KMAP_NAME_LEN);
> > -		ret = machine__process_kernel_mmap_event(machine, &xm);
> > +		ret = machine__process_kernel_mmap_event(machine, &xm, bid);
> >  		if (ret < 0)
> >  			goto out_problem;
> >  		return 0;
> > @@ -1746,7 +1760,7 @@ int machine__process_mmap2_event(struct machine *machine,
> >  	map = map__new(machine, event->mmap2.start,
> >  			event->mmap2.len, event->mmap2.pgoff,
> >  			&dso_id, event->mmap2.prot,
> > -			event->mmap2.flags,
> > +			event->mmap2.flags, bid,
> >  			event->mmap2.filename, thread);
> >  
> >  	if (map == NULL)
> > @@ -1789,7 +1803,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
> >  		};
> >  
> >  		strlcpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
> > -		ret = machine__process_kernel_mmap_event(machine, &xm);
> > +		ret = machine__process_kernel_mmap_event(machine, &xm, NULL);
> >  		if (ret < 0)
> >  			goto out_problem;
> >  		return 0;
> > @@ -1805,7 +1819,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
> >  
> >  	map = map__new(machine, event->mmap.start,
> >  			event->mmap.len, event->mmap.pgoff,
> > -			NULL, prot, 0, event->mmap.filename, thread);
> > +			NULL, prot, 0, NULL, event->mmap.filename, thread);
> >  
> >  	if (map == NULL)
> >  		goto out_problem_map;
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index f44ede437dc7..692e56dc832e 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -130,8 +130,8 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
> >  
> >  struct map *map__new(struct machine *machine, u64 start, u64 len,
> >  		     u64 pgoff, struct dso_id *id,
> > -		     u32 prot, u32 flags, char *filename,
> > -		     struct thread *thread)
> > +		     u32 prot, u32 flags, struct build_id *bid,
> > +		     char *filename, struct thread *thread)
> >  {
> >  	struct map *map = malloc(sizeof(*map));
> >  	struct nsinfo *nsi = NULL;
> > @@ -194,6 +194,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> >  				dso__set_loaded(dso);
> >  		}
> >  		dso->nsinfo = nsi;
> > +
> > +		if (build_id__is_defined(bid))
> > +			dso__set_build_id(dso, bid);
> > +
> >  		dso__put(dso);
> >  	}
> >  	return map;
> > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > index b1c0686db1b7..9f32825c98d8 100644
> > --- a/tools/perf/util/map.h
> > +++ b/tools/perf/util/map.h
> > @@ -104,10 +104,11 @@ void map__init(struct map *map,
> >  	       u64 start, u64 end, u64 pgoff, struct dso *dso);
> >  
> >  struct dso_id;
> > +struct build_id;
> >  
> >  struct map *map__new(struct machine *machine, u64 start, u64 len,
> >  		     u64 pgoff, struct dso_id *id, u32 prot, u32 flags,
> > -		     char *filename, struct thread *thread);
> > +		     struct build_id *bid, char *filename, struct thread *thread);
> >  struct map *map__new2(u64 start, struct dso *dso);
> >  void map__delete(struct map *map);
> >  struct map *map__clone(struct map *map);
> > -- 
> > 2.26.2
> > 
> 
> -- 
> 
> - Arnaldo
> 

