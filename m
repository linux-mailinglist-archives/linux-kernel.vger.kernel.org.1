Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC73C2CAB7A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgLATLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:11:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgLATLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606849777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jxGy1IU1fFcWp6k3pkgDhm/kEu5lCs4ZoIk7tIztZrU=;
        b=biuGj1jtCKZn+ZO1bDZJyOlMlYzfuCVqHgUuRQNdyx5mWqGo73Cf2vvLbm7cGh2KX10R3d
        OlBO4BqzSkgZETyTHnscDAvapRM0BY5temSrxpM/W9sRJKj+MQg6v1S4ALh1D7z7vME8BX
        yXk9hv/ze+3RFeMah3ExEd50Dv0PHss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-5H57SKGgNzCmFFcCUxpjrw-1; Tue, 01 Dec 2020 14:09:33 -0500
X-MC-Unique: 5H57SKGgNzCmFFcCUxpjrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADFBB185E480;
        Tue,  1 Dec 2020 19:09:31 +0000 (UTC)
Received: from krava (unknown [10.40.193.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 366B619C44;
        Tue,  1 Dec 2020 19:09:28 +0000 (UTC)
Date:   Tue, 1 Dec 2020 20:09:28 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 1/3] Revert "perf session: Fix decompression of
 PERF_RECORD_COMPRESSED records"
Message-ID: <20201201190928.GB3169083@krava>
References: <20201124095923.3683-1-oss@malat.biz>
 <20201124102919.15312-1-oss@malat.biz>
 <20201124143645.GD2088148@krava>
 <20201124181519.GA29264@ntb.petris.klfree.czf>
 <20201130114020.GA29476@ntb.petris.klfree.czf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201130114020.GA29476@ntb.petris.klfree.czf>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 12:40:20PM +0100, Petr Malat wrote:
> Hi Jiří,
> were you able to reproduce the issue? I may also upload perf-archive
> if that would help.

oh yea ;-) seems like those 2 commits you reverted broke 32 bits
perf for data files > 32MB

but the fix you did does not work for Alexey's test he mentioned
in the commit:

      $ perf record -z -- some_long_running_workload
      $ perf report --stdio -vv

it's failing for me with:

	# ./perf report
	Couldn't allocate memory for decompression
	0xfe6f3a [0x60]: failed to process type: 81 [Operation not permitted]
	Error:
	failed to process sample
	# To display the perf.data header info, please use --header/--header-only options.
	#

I think that's why here's special handling for compressed
events, but I'll need to check on that in more detail,
I was hoping for Alexey to answer ;-)

jirka

>   Petr
> 
> On Tue, Nov 24, 2020 at 07:15:19PM +0100, Petr Malat wrote:
> > Hi!
> > On Tue, Nov 24, 2020 at 03:36:45PM +0100, Jiri Olsa wrote:
> > > On Tue, Nov 24, 2020 at 11:29:15AM +0100, Petr Malat wrote:
> > > > Both mmapped and compressed events can be split by the buffer boundary,
> > > > it doesn't make sense to handle them differently.
> > > I'm going to need more than this, if there's a problem
> > > with current code please share more details, what's
> > > broken and how it shows
> > It's easy to trigger the problem - make a perf recording larger than
> > MMAP_SIZE (32MB on 32-bit platform) and run perf report on it. There
> > is a small chance recorded events will be aligned on the 32 MB
> > boundary and in that case just repeat the test.
> > 
> > The problem was introduced by "perf session: Avoid infinite loop when
> > seeing invalid header.size", which instead of aborting the execution
> > when there is a truncated event at the end of the file just terminated
> > execution whenever there is a split event. Later then the problem has
> > been noticed for compressed events and fixed by "perf session: Fix
> > decompression of PERF_RECORD_COMPRESSED records" by effectively
> > reverting "perf session: Avoid infinite loop when seeing invalid
> > header.size" for compressed events, which left uncompressed events
> > broken.
> > 
> > I think the best is to revert these 2 changes and fix the original
> > problem by aborting when there is no actual shift during remapping - as
> > long as we shift, it's clear we must approach the end of the file so
> > such an algorithm can't loop forever.
> > BR,
> >   Petr
> 

