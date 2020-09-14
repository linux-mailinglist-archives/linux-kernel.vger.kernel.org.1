Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED412695DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgINTvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgINTu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600113057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Ckdhx/SwxbddCk/MqYKv07k5JNkmWooWLWGErO8zK0=;
        b=UQ1QZCDH/olmADVwXQCHHxhDIeHUASBlkaybuOcAYohQiPK/4IWqpUlOrmLd31lG4KnV7g
        tTKqTvCBwHHXY2onMwVE4kN0p/ET/uuEWX90UaE+uUBdk69AtbuQLq/kxOf0EAFQ01NI4x
        76a79+RXraaAciBmvD5KhHjYrKKiPpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-rM_tGDFKMBOwdYM7f-I-wA-1; Mon, 14 Sep 2020 15:50:53 -0400
X-MC-Unique: rM_tGDFKMBOwdYM7f-I-wA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5556A800C78;
        Mon, 14 Sep 2020 19:50:51 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 06B6D5D994;
        Mon, 14 Sep 2020 19:50:46 +0000 (UTC)
Date:   Mon, 14 Sep 2020 21:50:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20200914195045.GQ1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com>
 <20200914153134.GD160517@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914153134.GD160517@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:31:34PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > > ---
> > >  include/uapi/linux/perf_event.h | 27 ++++++++++++++++++++++-
> > >  kernel/events/core.c            | 38 +++++++++++++++++++++++++++------
> > >  2 files changed, 57 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > index 077e7ee69e3d..facfc3c673ed 100644
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -384,7 +384,8 @@ struct perf_event_attr {
> > >                                 aux_output     :  1, /* generate AUX records instead of events */
> > >                                 cgroup         :  1, /* include cgroup events */
> > >                                 text_poke      :  1, /* include text poke events */
> > > -                               __reserved_1   : 30;
> > > +                               mmap3          :  1, /* include bpf events */
> > > +                               __reserved_1   : 29;
> > >
> > what happens if I set mmap3 and mmap2?
> > 
> > I think using mmap3 for every mmap may be overkill as you add useless
> > 20 bytes to an mmap record.
> 
> So use just PERF_RECORD_MMAP2.
> 
> I think if the user says: I need buildids, then, in kernels with support
> for getting the buildid in MMAP records, use it as its more accurate,
> otherwise fall back to traversing all records at the end to go over lots
> of files haversting those build-ids.

ok, so special record option to enable this

> 
> If the user says I don't want build-ids, nothing changes, no collection
> at the end, perf continues using PERF_RECORD_MMAP2.

and that's -B option in record

> 
> > I am not sure if your code handles the case where mmap3 is not needed
> > because there is no buildid, e.g, anonymous memory.
> > It seems to me you've written the patch in such a way that if the user
> > tool supports mmap3, then it supersedes mmap2, and thus
> > you need all the fields of mmap2. But if could be more interesting to
> > return either MMAP2 or MMAP3 depending on tool support
> > and type of mmap, that would certainly save 20 bytes on any anon mmap.
> > But maybe that logic is already in your patch and I missed it.
> 
> Right, it should take into account if the user asked for build-ids or
> not in addition to checking if the kernel supports MMAP3.

right, thanks,

jirka

