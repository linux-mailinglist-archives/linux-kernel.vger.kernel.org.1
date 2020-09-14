Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE682695C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgINTjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgINTjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600112359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2dLrjvn975TYJJujpJZWjLnWZO++WMQG/EDi9UWYfd0=;
        b=AQOs2nB13OmWDa0fZV03mfa3NVNa3dqxUHJIEEqKDlK0yqvu04zbuZP7F5yA+eJLH2VfFp
        Bg+fqVJ7IxqAJ4UttF3Q4aIlS9vwAMJnOD7q3C6M3xqJjj07s8nvKR6Doj/RP/vmQ8C/rc
        QNg1mRNbmBbHsqe4gnW9zJJ/kFfjdlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-xSYJoOhAM9ydkTsKSu3cuw-1; Mon, 14 Sep 2020 15:39:15 -0400
X-MC-Unique: xSYJoOhAM9ydkTsKSu3cuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A3B2800683;
        Mon, 14 Sep 2020 19:39:13 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 79E0719C78;
        Mon, 14 Sep 2020 19:39:08 +0000 (UTC)
Date:   Mon, 14 Sep 2020 21:39:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Message-ID: <20200914193907.GO1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
 <20200914152841.GC160517@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914152841.GC160517@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:28:41PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 14, 2020 at 02:38:27PM +0900, Namhyung Kim escreveu:
> > On Mon, Sep 14, 2020 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > Add new version of mmap event. The MMAP3 record is an
> > > augmented version of MMAP2, it adds build id value to
> > > identify the exact binary object behind memory map:
> 
> > >   struct {
> > >     struct perf_event_header header;
> 
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
> What for this reserved? its all nicely aligned already, u64 followed by
> two u32 (prot, flags).
> 
> > >     u8                       buildid[20];
>  
> > Do we need maj, min, ino, ino_generation for mmap3 event?
> > I think they are to compare binaries, then we can do it with
> > build-id (and I think it'd be better)..
> 
> Humm, I thought MMAP2 would be a superset of MMAP and MMAP3 would be a
> superset of MMAP2.
> 
> If we want to ditch useless stuff, then trow away pid, tid too, as we
> can select those via sample_type.
> 
> Having said that, at this point I don't even know if adding new
> PERF_RECORD_ that are an update for a preexisting one is the right way
> to proceed.
> 
> Perhaps we should attach a BPF program to point where a mmap/munmap is
> being done (perf_event_mmap()) and allow userspace to ask for whatever
> it wants?  With a kprobes there right now we can implement this MMAP3
> easily, no?

hmm, I'm always woried about solutions based on kprobes,
because once the function is moved/removed you're screwed
and need to keep up with function name changes and be
backward compatible..

jirka

