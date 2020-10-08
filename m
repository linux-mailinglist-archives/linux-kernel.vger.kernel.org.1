Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B8287132
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgJHJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgJHJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602148023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yh3YduTAv6VVdstbWLiFerOf5yVJYIIQ+qTgX6i4ru8=;
        b=Bhx6PdKsLi4nBjwwKR+AivLk5Us9nxlk86znC4xXE4sSr4asSFAs34uepmyQoVE23GTzXY
        ff7WeEKbbMu6UV+p1EhSm2LNTmSyzcs3K+rx6Dqu4eL/dCvje5BjOcULfCyJmEJ7Royxh5
        gaJYZIWncx4eVKug/gyJzZdQapusO2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-YKDwWZF9PXuzxa5LyqALuQ-1; Thu, 08 Oct 2020 05:07:01 -0400
X-MC-Unique: YKDwWZF9PXuzxa5LyqALuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73EA9425D1;
        Thu,  8 Oct 2020 09:06:59 +0000 (UTC)
Received: from krava (unknown [10.40.195.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE45B5C1BD;
        Thu,  8 Oct 2020 09:06:55 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:06:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     namhyung@kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Al Grant <al.grant@foss.arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf inject: Flush ordered events on FINISHED_ROUND
Message-ID: <20201008090654.GA656950@krava>
References: <20201002130317.1356440-1-namhyung@kernel.org>
 <20201004195239.GA217601@krava>
 <CAM9d7cgsxkefHAgyMf-GoP4-OdSsaRmhSGLwPMoYn=-c9YXxDw@mail.gmail.com>
 <20201006023949.GA1682192@google.com>
 <20201006054032.GA1724372@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006054032.GA1724372@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:40:32PM +0900, namhyung@kernel.org wrote:
> On Tue, Oct 06, 2020 at 11:39:49AM +0900, namhyung@kernel.org wrote:
> > > > On Fri, Oct 02, 2020 at 10:03:17PM +0900, Namhyung Kim wrote:
> > > > > Below measures time and memory usage during the perf inject and
> > > > > report using ~190MB data file.
> > > > >
> > > > > Before:
> > > > >   perf inject:  11.09 s,  382148 KB
> > > > >   perf report:   8.05 s,  397440 KB
> > > > >
> > > > > After:
> > > > >   perf inject:  16.24 s,   83376 KB
> > > > >   perf report:   7.96 s,  216184 KB
> > > > >
> > > > > As you can see, it used 2x memory of the input size.  I guess it's
> > > > > because it needs to keep the copy for the whole input.  But I don't
> > > > > understand why processing time of perf inject increased..
> > 
> > Measuring it with time shows:
> > 
> >            before       after
> >   real    11.309s     17.040s
> >   user     8.084s     13.940s
> >   sys      6.535s      6.732s
> > 
> > So it's user space to make the difference.  I've run perf record on
> > both (with cycles:U) and the dominant function is same: queue_event.
> > (46.98% vs 65.87%)
> > 
> > It seems the flushing the queue makes more overhead on sorting.
> 
> So I suspect the cache-miss ratio affects the performance.  With
> flushing, data is processed in the middle and all the entries are
> reused after flush so it would invalidate all the cache lines
> occasionally.
> 
> This is the perf stat result:
> 
> * Before
> 
>      7,167,414,019      L1-dcache-loads                                             
>        337,471,761      L1-dcache-read-misses     #    4.71% of all L1-dcache hits  
> 
>       11.011224671 seconds time elapsed
> 
> 
> * After
> 
>      7,075,556,792      L1-dcache-loads                                             
>        771,810,388      L1-dcache-read-misses     #   10.91% of all L1-dcache hits  
> 
>       17.015901863 seconds time elapsed
> 
> 
> Hmm.. it's a memory & time trade-off then.  Maybe we need a switch to
> select which one?

I'd keep the faster one ;-) so the one before

jirka

