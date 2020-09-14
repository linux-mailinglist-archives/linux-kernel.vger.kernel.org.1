Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84E12695D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgINTpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbgINTpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600112736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O9EeupZxGqiAaLUu6ylggzlQguNqzCnvHeCIMXXYQfs=;
        b=KG+BHMRLsslVt97q7h1u+lDRhGqpIzUwM5D4pwC+KrfV8xyBU7k+2BOAO2frt7mI2TXo1X
        pTTPqaT49UxysvGoRvrw4HOvTg/MCpIiUtCfp8uj6mRHUkTZAZ+oR1eyEu7NmeBaM4+o72
        YnZSF1ox0Tt/J0UBpqNaKrev8fnZQM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-9_JdyIa5MXSsB-6aa9uUBw-1; Mon, 14 Sep 2020 15:45:34 -0400
X-MC-Unique: 9_JdyIa5MXSsB-6aa9uUBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65A141074642;
        Mon, 14 Sep 2020 19:45:32 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id F120D10013BD;
        Mon, 14 Sep 2020 19:45:28 +0000 (UTC)
Date:   Mon, 14 Sep 2020 21:45:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
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
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Message-ID: <20200914194527.GP1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 11:41:00PM -0700, Stephane Eranian wrote:
> On Sun, Sep 13, 2020 at 2:03 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add new version of mmap event. The MMAP3 record is an
> > augmented version of MMAP2, it adds build id value to
> > identify the exact binary object behind memory map:
> >
> >   struct {
> >     struct perf_event_header header;
> >
> >     u32                      pid, tid;
> >     u64                      addr;
> >     u64                      len;
> >     u64                      pgoff;
> >     u32                      maj;
> >     u32                      min;
> >     u64                      ino;
> >     u64                      ino_generation;
> >     u32                      prot, flags;
> >     u32                      reserved;
> >     u8                       buildid[20];
> >     char                     filename[];
> >     struct sample_id         sample_id;
> >   };
> >
> > Adding 4 bytes reserved field to align buildid data to 8 bytes,
> > so sample_id data is properly aligned.
> >
> > The mmap3 event is enabled by new mmap3 bit in perf_event_attr
> > struct.  When set for an event, it enables the build id retrieval
> > and will use mmap3 format for the event.
> >
> > Keeping track of mmap3 events and calling build_id_parse
> > in perf_event_mmap_event only if we have any defined.
> >
> > Having build id attached directly to the mmap event will help
> > tool like perf to skip final search through perf data for
> > binaries that are needed in the report time. Also it prevents
> > possible race when the binary could be removed or replaced
> > during profiling.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/perf_event.h | 27 ++++++++++++++++++++++-
> >  kernel/events/core.c            | 38 +++++++++++++++++++++++++++------
> >  2 files changed, 57 insertions(+), 8 deletions(-)
> >
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
> > +                               __reserved_1   : 29;
> >
> what happens if I set mmap3 and mmap2?

hum bad things probably ;-) I think mmap3 would overload mmap2

> 
> I think using mmap3 for every mmap may be overkill as you add useless
> 20 bytes to an mmap record.
> I am not sure if your code handles the case where mmap3 is not needed
> because there is no buildid, e.g, anonymous memory.
> It seems to me you've written the patch in such a way that if the user
> tool supports mmap3, then it supersedes mmap2, and thus
> you need all the fields of mmap2. But if could be more interesting to
> return either MMAP2 or MMAP3 depending on tool support
> and type of mmap, that would certainly save 20 bytes on any anon mmap.
> But maybe that logic is already in your patch and I missed it.

I like peter's idea of ditching mmap3 and use that maj/min..
area in mmap2 for buildid based on misc bits

jirka

