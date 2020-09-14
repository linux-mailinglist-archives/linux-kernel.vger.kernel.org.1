Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D457E269858
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgINVwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgINVv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:51:58 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11775208DB;
        Mon, 14 Sep 2020 21:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600120317;
        bh=1AVQi9i+IaU2iOoMkEHs7qZRDRG3IlwAxAl+7TRTQc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yfr+mH+tLwPjZLhwtzrotSjh6e9HGgFCEdZw6OqICy2nsrovd/lJaCuu/Lg4d7icE
         tjR77gU5Fp4kjk9SCGdrlru7u16z9uTUg1EM1cjKtjj5cT3Q8CekAMq/VTnnbqwPhC
         jpGi7iEy0GAekP1kdTuXTHzRiVMb95tPxy5bnZwU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C7A740D3D; Mon, 14 Sep 2020 18:51:55 -0300 (-03)
Date:   Mon, 14 Sep 2020 18:51:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
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
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 05/26] perf tools: Add build_id__is_defined function
Message-ID: <20200914215155.GG166601@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-6-jolsa@kernel.org>
 <CAM9d7cjjGjTN8sDgLZ1PoQZ-sUXWjnVaNdyOVE1yHxq46PrPkw@mail.gmail.com>
 <20200914204701.GZ1714160@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914204701.GZ1714160@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 10:47:01PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 14, 2020 at 02:44:35PM +0900, Namhyung Kim wrote:
> > On Mon, Sep 14, 2020 at 6:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding build_id__is_defined helper to check build id
> > > is defined and is != zero build id.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/build-id.c | 11 +++++++++++
> > >  tools/perf/util/build-id.h |  1 +
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > > index 31207b6e2066..bdee4e08e60d 100644
> > > --- a/tools/perf/util/build-id.c
> > > +++ b/tools/perf/util/build-id.c
> > > @@ -902,3 +902,14 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
> > >
> > >         return ret;
> > >  }
> > > +
> > > +bool build_id__is_defined(const u8 *build_id)
> > > +{
> > > +       static u8 zero[BUILD_ID_SIZE];
> > > +       int err = 0;
> > > +
> > > +       if (build_id)
> > > +               err = memcmp(build_id, &zero, BUILD_ID_SIZE);
> > > +
> > > +       return err ? true : false;
> > > +}
> > 
> > I think this is a bit confusing.. How about this?
> > 
> >   bool ret = false;
> >   if (build_id)
> >       ret = memcmp(...);
> >   return ret;
> 
> ok
> 
> > 
> > Or, it can be a oneliner..
> 
> everything can be oneliner ;-)

But has to pass checkpatch.pl, so no more than 80 chars.

;-)

- Arnaldo
