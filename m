Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49D42695BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgINTij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgINTii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600112316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rX44fORneLTrsGw8dMUWqFurvE6jUJfJ/7J84+5FHc=;
        b=GoQjXQAmWhGdQTioYVPpReyo59XV7os8cXkFCN8DCsp8KoVAS4Fct/VRZIIdNhw52fOKBH
        8RDYEdp2M5gH/7iPXkPpx4j2wLfgzLbrYwvsPPKKsJhcL+dn1vYovHoWfhQAJKb5IF9alI
        LgoiiLgIw97kkrA5xw6Royw5kKAIPyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-quM1a3E8OWmgGo6w2YOn6g-1; Mon, 14 Sep 2020 15:38:32 -0400
X-MC-Unique: quM1a3E8OWmgGo6w2YOn6g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D7D8800683;
        Mon, 14 Sep 2020 19:38:30 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 34D6510013BD;
        Mon, 14 Sep 2020 19:38:26 +0000 (UTC)
Date:   Mon, 14 Sep 2020 21:38:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     peterz@infradead.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Message-ID: <20200914193825.GL1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
 <20200914152841.GC160517@kernel.org>
 <20200914163534.GT1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914163534.GT1362448@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 06:35:34PM +0200, peterz@infradead.org wrote:
> On Mon, Sep 14, 2020 at 12:28:41PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> > > >   struct {
> > > >     struct perf_event_header header;
> > 
> > > >     u32                      pid, tid;
> > > >     u64                      addr;
> > > >     u64                      len;
> > > >     u64                      pgoff;
> > > >     u32                      maj;
> > > >     u32                      min;
> > > >     u64                      ino;
> > > >     u64                      ino_generation;
> > > >     u32                      prot, flags;
> > > >     u32                      reserved;
> > 
> > What for this reserved? its all nicely aligned already, u64 followed by
> > two u32 (prot, flags).
> 
> I suspect it is so that sizeof(reserve+buildid) is a multiple of 8. But
> yes, that's a wee bit daft, since the next field is a variable length
> character array.
> 
> > > >     u8                       buildid[20];
> >  
> > > Do we need maj, min, ino, ino_generation for mmap3 event?
> > > I think they are to compare binaries, then we can do it with
> > > build-id (and I think it'd be better)..
> > 
> > Humm, I thought MMAP2 would be a superset of MMAP and MMAP3 would be a
> > superset of MMAP2.
> 
> Well, the 'funny' thing is that if you do use buildid, then
> {maj,min,ino,ino_generation} are indeed superfluous, but are combined
> also large enough to contain buildid.

yay! nice

> 
> > If we want to ditch useless stuff, then trow away pid, tid too, as we
> > can select those via sample_type.
> 
> Correct.

can we? I think you could disable sample_id then
you won't have pid/tid in mmap event

> 
> So something like:
> 
> struct {
>   struct perf_event_header header;
> 
>   u64                      addr;
>   u64                      len;
>   u64                      pgoff;
>   union {
>     struct {
>       u32                  maj;
>       u32                  min;
>       u64                  ino;
>       u64                  ino_generation;
>     };
>     u8                     buildid[20];
>   };
>   u32                      prot, flags;
>   char			   filename[];
>   struct sample_id         sample_id;
> };
> 
> Using one of the MISC bits to resolve the union. Might actually bring
> benefit to everyone. Us normal people get to have a smaller MMAP record,
> while the buildid folks can have it too.
> 
> Even more extreme would be using 2 MISC bits and allowing the union to
> be 0 sized for anon.

I like that idea, I'll check on it

thanks,
jirka

