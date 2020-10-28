Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D822629D2B2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgJ1VeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgJ1VeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603920845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=em9NSnSfYtBwnUrHbtl7Uc7Gjk0Lxoi5sqGFBDm80lk=;
        b=eV+w4kBkTfRwUuqd8AdCdesVcL8XE7A8V1j+u3WKrnMS3vEG6ISX0ugbjrsVYVIati+uEd
        pkhJ+mXYbH4udi+16f6tT1qLBALZU2D74shlxgFVjsuF4xi6LzCKTNzwC7pFj5PuqcbZlk
        q7yLIYKCNKP1Burb2SeNo1MbBUdzAvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-pRc3BdCmPFGCt4Hves5fEg-1; Wed, 28 Oct 2020 11:32:24 -0400
X-MC-Unique: pRc3BdCmPFGCt4Hves5fEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98083E9003;
        Wed, 28 Oct 2020 15:32:22 +0000 (UTC)
Received: from krava (unknown [10.40.192.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id A204760C04;
        Wed, 28 Oct 2020 15:32:20 +0000 (UTC)
Date:   Wed, 28 Oct 2020 16:32:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/15] Introduce threaded trace streaming for basic
 perf record operation
Message-ID: <20201028153219.GL2900849@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <20201024154309.GA2589351@krava>
 <01bad2c4-4188-f5f5-452e-a0ea0672a187@linux.intel.com>
 <20201027121013.GE2900849@krava>
 <9c76b415-2610-14f8-37d4-461d0d5c078b@linux.intel.com>
 <CAM9d7checZ0j9BfpXhoH27GVB-OnGvjWCDnsai_Bu5VgAeuZeA@mail.gmail.com>
 <b6150d2f-04a6-9204-59ac-c31c8697c630@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6150d2f-04a6-9204-59ac-c31c8697c630@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:35:08AM +0300, Alexey Budankov wrote:
> 
> On 28.10.2020 10:08, Namhyung Kim wrote:
> > Hi,
> > 
> > On Wed, Oct 28, 2020 at 1:02 AM Alexey Budankov
> > <alexey.budankov@linux.intel.com> wrote:
> >>
> >>
> >> On 27.10.2020 15:10, Jiri Olsa wrote:
> >>> On Mon, Oct 26, 2020 at 08:59:01PM +0300, Alexey Budankov wrote:
> >>>>
> >>>> On 24.10.2020 18:43, Jiri Olsa wrote:
> >>>>> On Wed, Oct 21, 2020 at 06:52:43PM +0300, Alexey Budankov wrote:
> >>>>>>
> >>>>>> Changes in v2:
> >>>>>> - explicitly added credit tags to patches 6/15 and 15/15,
> >>>>>>   additionally to cites [1], [2]
> >>>>>> - updated description of 3/15 to explicitly mention the reason
> >>>>>>   to open data directories in read access mode (e.g. for perf report)
> >>>>>> - implemented fix for compilation error of 2/15
> >>>>>> - explicitly elaborated on found issues to be resolved for
> >>>>>>   threaded AUX trace capture
> >>>>>>
> >>>>>> v1: https://lore.kernel.org/lkml/810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com/
> >>>>>>
> >>>>>> Patch set provides threaded trace streaming for base perf record
> >>>>>> operation. Provided streaming mode (--threads) mitigates profiling
> >>>>>> data losses and resolves scalability issues of serial and asynchronous
> >>>>>> (--aio) trace streaming modes on multicore server systems. The patch
> >>>>>> set is based on the prototype [1], [2] and the most closely relates
> >>>>>> to mode 3) "mode that creates thread for every monitored memory map".
> >>>>>
> >>>>> so what I liked about the previous code was that you could
> >>>>> configure how the threads would be created
> >>>>>
> >>>>> default --threads options created thread for each cpu like
> >>>>> in your change:
> >>>>>
> >>>>>   $ perf record -v --threads ...
> >>>>>   ...
> >>>>>   thread 0 monitor: 0 allowed: 0
> >>>>>   thread 1 monitor: 1 allowed: 1
> >>>>>   thread 2 monitor: 2 allowed: 2
> >>>>>   thread 3 monitor: 3 allowed: 3
> >>>>>   thread 4 monitor: 4 allowed: 4
> >>>>>   thread 5 monitor: 5 allowed: 5
> >>>>>   thread 6 monitor: 6 allowed: 6
> >>>>>   thread 7 monitor: 7 allowed: 7
> >>>>
> >>>> Yes, it is configurable in the prototype. Even though this patch set
> >>>> doesn't implement that parameters for --thread option, just because
> >>>> VTune doesn't have use cases for that yet, it has still been designed
> >>>> and implemented with that possible extension in mind so it could then
> >>>> be easily added on top of it.
> >>>
> >>> I'm not sure about vtune extensions, but if we are going to
> >>> have --threads option I believe we should make it configurable
> >>> at least to the extend descibed below
> >>
> >> It employs --threads mode only and there are no use cases
> >> observed so far beyond this mode. Do you have or see such
> >> use cases?
> > 
> > I don't know about vtune and other users, but it's an important
> > feature for better performance so I agree with Jiri's opinion to
> > make it flexible for the system requirement.
> 
> For sure, vtune is not the only one for this threaded streaming
> and it should be well suited for perf tool use cases equally.
> And for perf it would be beneficial to document some examples in
> perf-record.txt as a part of this configuration implementation.
> I am not just aware of such examples and that is why I am asking
> you guys.

I saw no LOST events on big servers for some tests with --threads=numa
option, so there was no reason to spawn 200+ threads

jirka

