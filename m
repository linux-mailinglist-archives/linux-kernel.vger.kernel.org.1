Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3117D26BF05
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIPIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgIPIUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600244435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xewwfAsrvn/mfwIwbx62LMEfkW4MFT2Bw30SDL187ec=;
        b=Anu7I5fQHD58B0N40JT6C7Y2xkG1OqmcUlufYAJX1JkGF1JGQ8SeKv8cBvE76tIVPmOsMc
        D5oVxyU+bZ27l58+eJyN4pq0lvwKMkteCtxPAvkSIqNRmOi6jmrVRl62iHkLO9jChmDFX1
        WiubRmvjh/j2ztoMYVRNXFJfyFM68xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-a19z9PCnMeeCgkxL1Krkhg-1; Wed, 16 Sep 2020 04:20:28 -0400
X-MC-Unique: a19z9PCnMeeCgkxL1Krkhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 402A581F010;
        Wed, 16 Sep 2020 08:20:25 +0000 (UTC)
Received: from krava (ovpn-114-172.ams2.redhat.com [10.36.114.172])
        by smtp.corp.redhat.com (Postfix) with SMTP id B0A267EB7C;
        Wed, 16 Sep 2020 08:20:19 +0000 (UTC)
Date:   Wed, 16 Sep 2020 10:20:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 16/26] perf tools: Synthesize modules with mmap3
Message-ID: <20200916082018.GA2301783@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-17-jolsa@kernel.org>
 <20200914160758.GK160517@kernel.org>
 <CAP-5=fV4Agxe3UMpkbWkh9CuG1tYho413w7xehy0SiMX+tPv1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV4Agxe3UMpkbWkh9CuG1tYho413w7xehy0SiMX+tPv1Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 01:17:44PM -0700, Ian Rogers wrote:

SNIP

> > >       /*
> > >        * kernel uses 0 for user space maps, see kernel/perf_event.c
> > >        * __perf_event_mmap
> > > @@ -631,17 +629,30 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
> > >                       continue;
> > >
> > >               size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
> > > -             event->mmap.header.type = PERF_RECORD_MMAP;
> > > -             event->mmap.header.size = (sizeof(event->mmap) -
> > > -                                     (sizeof(event->mmap.filename) - size));
> > > -             memset(event->mmap.filename + size, 0, machine->id_hdr_size);
> > > -             event->mmap.header.size += machine->id_hdr_size;
> > > -             event->mmap.start = pos->start;
> > > -             event->mmap.len   = pos->end - pos->start;
> > > -             event->mmap.pid   = machine->pid;
> > > -
> > > -             memcpy(event->mmap.filename, pos->dso->long_name,
> > > +             event->mmap3.header.type = PERF_RECORD_MMAP3;
> > > +             event->mmap3.header.size = (sizeof(event->mmap3) -
> > > +                                        (sizeof(event->mmap3.filename) - size));
> > > +             memset(event->mmap3.filename + size, 0, machine->id_hdr_size);
> > > +             event->mmap3.header.size += machine->id_hdr_size;
> > > +             event->mmap3.start = pos->start;
> > > +             event->mmap3.len   = pos->end - pos->start;
> > > +             event->mmap3.pid   = machine->pid;
> > > +
> > > +             memcpy(event->mmap3.filename, pos->dso->long_name,
> > >                      pos->dso->long_name_len + 1);
> > > +
> > > +             rc = filename__read_build_id(event->mmap3.filename, event->mmap3.buildid,
> > > +                                          BUILD_ID_SIZE);
> > > +             if (rc != BUILD_ID_SIZE) {
> 
> IIRC BUILD_ID_SIZE is 20 bytes which is the correct size for SHA-1. A
> build ID may be 128-bits (16 bytes) if md5 or uuid hashes are used.
> Should this test just be "> 0" ?

ah right, will check on that

thanks,
jirka

