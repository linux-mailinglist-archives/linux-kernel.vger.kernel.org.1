Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A14E2AD32C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKJKJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:09:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbgKJKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605002939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KjgpKN0NiWWmqyj7Z+tNpUPUWNuVfJKpe/KqYlRbWf4=;
        b=DgZqYrQzNggU84URPy5BLn/wv837ZIgLy+OBfPnhBAMwRqJuxCEygc/Y+ezHcFHZdm/2Z5
        v8TzWtNKmUV85M0Zp3a1022EvFPbH9Xx2O5iEam0mgnLPo5sip2MAbqX9aYm2KSUsvXm2O
        uiKB4RiB3Cg+276cTjAQxDpQRa2+7B4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-SHgbnNDRMXSrreFRTGbONA-1; Tue, 10 Nov 2020 05:08:55 -0500
X-MC-Unique: SHgbnNDRMXSrreFRTGbONA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 237861006C9A;
        Tue, 10 Nov 2020 10:08:53 +0000 (UTC)
Received: from krava (unknown [10.40.195.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9D76F6EF7B;
        Tue, 10 Nov 2020 10:08:49 +0000 (UTC)
Date:   Tue, 10 Nov 2020 11:08:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH 03/24] perf: Add build id data in mmap2 event
Message-ID: <20201110100848.GB387652@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-4-jolsa@kernel.org>
 <20201110080716.GU2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110080716.GU2594@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:07:16AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2020 at 10:53:54PM +0100, Jiri Olsa wrote:
> > Adding support to carry build id data in mmap2 event.
> > 
> > The build id data replaces maj/min/ino/ino_generation
> > fields, whichc are also used to identify map's binary,
> > so it's ok to replace them with build id data:
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
> 
> What's the purpose of a size field for a fixed size array? Also, I'd

at the moment there's SHA build id using 20 bytes and MD5 is using 16
bytes, so build_id_size tells which one is in

I was considering adding another enum instead, but buildid is defined
just by the size of the hash, so size seemed better.. if in future
there's another type added and fits within 20 bytes we're ok, if it's
bigger we're screwed anyway

> flip the order of these fields, first have the size and then the array.

ok

jirka

> 
> >                   u8        __reserved_1;
> >                   u16       __reserved_2;
> >           };
> >   };
> > 
> > Replaced maj/min/ino/ino_generation fields give us size
> > of 24 bytes. We use 20 bytes for build id data, 1 byte
> > for size and rest is unused.
> 

