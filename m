Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B233269907
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgINWjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgINWjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:39:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E1CE20732;
        Mon, 14 Sep 2020 22:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600123140;
        bh=wjmspuEMssYc9ED3xKlxbWHRGBVIKDlfpMgFfWNfVMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKV6/GRmmwf0SqxcwVp1e/npQy20IVHI/x4VgPzkSaWr6rSwLgRAnuQUvG1/wTjpT
         /hZMfUF86M8P/p/liRNXAOO0DFk/ed/f3ydUerQPu2wx7iCbCU+67CvYuWS8aqrv7q
         AICALaZZrtahJeyEz9Nqor9P6c/5HTFZJWo/DpqA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7088F40D3D; Mon, 14 Sep 2020 19:38:58 -0300 (-03)
Date:   Mon, 14 Sep 2020 19:38:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
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
Message-ID: <20200914223858.GL166601@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com>
 <20200914153134.GD160517@kernel.org>
 <20200914195045.GQ1714160@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914195045.GQ1714160@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 09:50:45PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 14, 2020 at 12:31:34PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > > > ---
> > > >  include/uapi/linux/perf_event.h | 27 ++++++++++++++++++++++-
> > > >  kernel/events/core.c            | 38 +++++++++++++++++++++++++++------
> > > >  2 files changed, 57 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > > index 077e7ee69e3d..facfc3c673ed 100644
> > > > --- a/include/uapi/linux/perf_event.h
> > > > +++ b/include/uapi/linux/perf_event.h
> > > > @@ -384,7 +384,8 @@ struct perf_event_attr {
> > > >                                 aux_output     :  1, /* generate AUX records instead of events */
> > > >                                 cgroup         :  1, /* include cgroup events */
> > > >                                 text_poke      :  1, /* include text poke events */
> > > > -                               __reserved_1   : 30;
> > > > +                               mmap3          :  1, /* include bpf events */
> > > > +                               __reserved_1   : 29;
> > > >
> > > what happens if I set mmap3 and mmap2?
> > > 
> > > I think using mmap3 for every mmap may be overkill as you add useless
> > > 20 bytes to an mmap record.
> > 
> > So use just PERF_RECORD_MMAP2.
> > 
> > I think if the user says: I need buildids, then, in kernels with support
> > for getting the buildid in MMAP records, use it as its more accurate,
> > otherwise fall back to traversing all records at the end to go over lots
> > of files haversting those build-ids.
> 
> ok, so special record option to enable this
> 
> > 
> > If the user says I don't want build-ids, nothing changes, no collection
> > at the end, perf continues using PERF_RECORD_MMAP2.
> 
> and that's -B option in record

Yeah, so if -B is used, MMAP2, otherwise, the best available option,
which is MMAP3, which by now means more how you  tweak the misc bits and
what you collect, buildids or just the maj/min/ino :)

- Arnaldo
 
> > 
> > > I am not sure if your code handles the case where mmap3 is not needed
> > > because there is no buildid, e.g, anonymous memory.
> > > It seems to me you've written the patch in such a way that if the user
> > > tool supports mmap3, then it supersedes mmap2, and thus
> > > you need all the fields of mmap2. But if could be more interesting to
> > > return either MMAP2 or MMAP3 depending on tool support
> > > and type of mmap, that would certainly save 20 bytes on any anon mmap.
> > > But maybe that logic is already in your patch and I missed it.
> > 
> > Right, it should take into account if the user asked for build-ids or
> > not in addition to checking if the kernel supports MMAP3.
> 
> right, thanks,
> 
> jirka
> 

-- 

- Arnaldo
