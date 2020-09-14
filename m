Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAADF2695BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgINTiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgINTiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600112332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vmY3KqhhGvzV+d5TP9N2N7K426wvJo+nZ3Drl42v3nI=;
        b=F6tVZrBa8P3bcstN1qylkOabQ8XOKORBDy147BtzE7UnExQlsmOWZM1Eq/r80HiIO0jJFb
        cXWPqg9GgSiXGBVkflJ5PTwRONYpBb8+gj34FGPxmIhTxtiu3Xp6JeS/T0Z1cbVnWEDUCi
        +uowVEvzyFXspcV8e/4pIIyB4Y5zIPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-kSYcYa3PPQqkzgxPKq5kqg-1; Mon, 14 Sep 2020 15:38:50 -0400
X-MC-Unique: kSYcYa3PPQqkzgxPKq5kqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEC181882FBB;
        Mon, 14 Sep 2020 19:38:47 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4BDF95F9C1;
        Mon, 14 Sep 2020 19:38:42 +0000 (UTC)
Date:   Mon, 14 Sep 2020 21:38:41 +0200
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
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Message-ID: <20200914193841.GM1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 02:38:27PM +0900, Namhyung Kim wrote:

SNIP

> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index 077e7ee69e3d..facfc3c673ed 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -384,7 +384,8 @@ struct perf_event_attr {
> >                                 aux_output     :  1, /* generate AUX records instead of events */
> >                                 cgroup         :  1, /* include cgroup events */
> >                                 text_poke      :  1, /* include text poke events */
> > -                               __reserved_1   : 30;
> > +                               mmap3          :  1, /* include bpf events */
> 
> ???
> 
> > +                               __reserved_1   : 29;
> >
> >         union {
> >                 __u32           wakeup_events;    /* wakeup every n events */
> > @@ -1060,6 +1061,30 @@ enum perf_event_type {
> >          */
> >         PERF_RECORD_TEXT_POKE                   = 20,
> >
> > +       /*
> > +        * The MMAP3 records are an augmented version of MMAP2, they add
> > +        * build id value to identify the exact binary behind map
> > +        *
> > +        * struct {
> > +        *      struct perf_event_header        header;
> > +        *
> > +        *      u32                             pid, tid;
> > +        *      u64                             addr;
> > +        *      u64                             len;
> > +        *      u64                             pgoff;
> > +        *      u32                             maj;
> > +        *      u32                             min;
> > +        *      u64                             ino;
> > +        *      u64                             ino_generation;
> > +        *      u32                             prot, flags;
> > +        *      u32                             reserved;
> > +        *      u8                              buildid[20];
> > +        *      char                            filename[];
> > +        *      struct sample_id                sample_id;
> > +        * };
> > +        */
> > +       PERF_RECORD_MMAP3                       = 21,
> > +
> >         PERF_RECORD_MAX,                        /* non-ABI */
> >  };
> >
> [SNIP]
> > @@ -8098,6 +8116,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
> >         mmap_event->prot = prot;
> >         mmap_event->flags = flags;
> >
> > +       if (atomic_read(&nr_mmap3_events))
> > +               build_id_parse(vma, mmap_event->buildid);
> 
> What about if it failed?  We should zero out the build-id..

it is initialized to zero in perf_event_mmap

        mmap_event = (struct perf_mmap_event){
                .vma    = vma,
	...

I'll double check build_id_parse won't leave anything half
baked there, but I dont think so

thanks,
jirka

