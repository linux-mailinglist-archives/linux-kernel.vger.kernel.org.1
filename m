Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293082695BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgINTjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:39:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725914AbgINTjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600112346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1C8ReAVP9iJ7tu3Zp3XFtgTWDt9VPAWgSvPubq0gHHk=;
        b=AquWfEQUJYWo06KyJZplE/+kr34J3YghWHr3S/OhYKmyiGnOUUfdb+AqyqLbqwkUDQ8gL6
        n+We7XHxfeBXa8OyajCX08ECOvi0gXltlmxw1EbsgJTMqmP+Qa6luQDi9pfbeSv25zsrlG
        wuIzTDrBgQRpF8mLLx3JvOp/HxtVqB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-MzY3j9SPN1CbCuCVLHWzFQ-1; Mon, 14 Sep 2020 15:39:04 -0400
X-MC-Unique: MzY3j9SPN1CbCuCVLHWzFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7243E1005E72;
        Mon, 14 Sep 2020 19:39:02 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9F2E17B7AC;
        Mon, 14 Sep 2020 19:38:57 +0000 (UTC)
Date:   Mon, 14 Sep 2020 21:38:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <song@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20200914193856.GN1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
 <CAPhsuW7sd5wD1a+aeRs+6ppgurxF6QsAcOLSh_JzgZA7AaGCMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7sd5wD1a+aeRs+6ppgurxF6QsAcOLSh_JzgZA7AaGCMQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 11:20:31PM -0700, Song Liu wrote:
> On Sun, Sep 13, 2020 at 10:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Sep 14, 2020 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Add new version of mmap event. The MMAP3 record is an
> > > augmented version of MMAP2, it adds build id value to
> > > identify the exact binary object behind memory map:
> > >
> > >   struct {
> > >     struct perf_event_header header;
> > >
> > >     u32                      pid, tid;
> > >     u64                      addr;
> > >     u64                      len;
> > >     u64                      pgoff;
> > >     u32                      maj;
> > >     u32                      min;
> > >     u64                      ino;
> > >     u64                      ino_generation;
> > >     u32                      prot, flags;
> > >     u32                      reserved;
> 
> I guess we need reserved _after_ buildid, no?

it's there to align the size to 8 bytes,
so the sample_id is in proper place

but yes, perhaps after buildid would make more sense

> 
> > >     u8                       buildid[20];
> >
> > Do we need maj, min, ino, ino_generation for mmap3 event?
> > I think they are to compare binaries, then we can do it with
> > build-id (and I think it'd be better)..
> 
> +1 we shouldn't need maj, min, etc.

right, and as peter already wrote buildid could fit
in that space.. yay :)

thanks,
jirka

> 
> Thanks,
> Song
> 
> [...]
> 

