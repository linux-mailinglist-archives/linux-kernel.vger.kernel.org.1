Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B277429D33F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgJ1VmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgJ1VmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yb9P6m5kkVWo0GX/RB5L1eIDa/TyiqyibhjodV5SnGA=;
        b=iPYssiYzXfdn5qrPJpNM63g1FS00zVeLaU7uIFlpPTGEWig6YmKyhbLr3I3J7t5zXGR7A2
        XUTM3eT63zeZeHZLnD002/aHIdKAKp5wYqxOdOaiZqK8MBEAoovMZJrQfSZNUiaGA1eTIc
        BPFCo+5NC0IgQNXZUrv4GNJvrKDdq+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-AJ46TYIuMSK8EseU3oVjMw-1; Wed, 28 Oct 2020 11:40:04 -0400
X-MC-Unique: AJ46TYIuMSK8EseU3oVjMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6AA3879529;
        Wed, 28 Oct 2020 15:40:02 +0000 (UTC)
Received: from krava (unknown [10.40.192.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 929205B4AA;
        Wed, 28 Oct 2020 15:40:00 +0000 (UTC)
Date:   Wed, 28 Oct 2020 16:39:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/15] perf session: load data directory into tool
 process memory
Message-ID: <20201028153959.GN2900849@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <d28243e3-3178-d7cd-7b96-7ed63fd83493@linux.intel.com>
 <20201024154349.GC2589351@krava>
 <43d5e54f-b56e-729f-d08e-2c6b6799c797@linux.intel.com>
 <20201027122154.GF2900849@krava>
 <872f5052-788b-fe6d-d0ac-82e9639910d2@linux.intel.com>
 <CAM9d7cifhL--aYn05dYABmqoxGXX6xRC9W+Q+cWSnKqGUPPvzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cifhL--aYn05dYABmqoxGXX6xRC9W+Q+cWSnKqGUPPvzA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 04:22:49PM +0900, Namhyung Kim wrote:
> On Tue, Oct 27, 2020 at 11:43 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
> >
> >
> > On 27.10.2020 15:21, Jiri Olsa wrote:
> > > On Tue, Oct 27, 2020 at 10:37:58AM +0300, Alexey Budankov wrote:
> > >> I agree perf report OOM issue can exist on really-big servers but data
> > >> directories support for report mode for not-so-big servers and desktops
> > >> is already enabled with this smaller change. Also really-big-servers
> > >> come with really-big amount of memory and collection could possibly be
> > >> limited to only interesting phases of execution so the issue could likely
> > >> be avoided. At the same time threaded trace streaming could clarify on
> > >> real use cases that are blocked by perf report OOM issue and that would
> > >> clarify on exact required solution. So perf report OOM issue shouldn't
> > >> be the showstopper for upstream of threaded trace streaming.
> > >
> > > so the short answer is no, right? ;-)
> >
> > Answer to what question? Resolve OOM in perf report for data directories?
> > I don't see a simple solution for that. The next issue after OOM is resolved
> > is a very long processing of data directories. And again there is no simple
> > solution for that as well. But it still need progress in order to be resolved
> > eventually.
> 
> I think we should find a better way than just adding all events to the
> ordered events queue in memory then processing them one by one.
> 
> Separating tracking events (FORK/MMAP/...) might be the first step.

I recall seeing this change before for threaded perf report,
maybe even from you, right? ;-)

jirka

> 
> Thanks
> Namhyung
> 

