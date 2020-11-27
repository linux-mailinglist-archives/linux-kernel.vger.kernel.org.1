Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB52C6A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbgK0RWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:22:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbgK0RWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:22:05 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B50C221D46;
        Fri, 27 Nov 2020 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606497724;
        bh=CnJ4632WR0kohuOBEJWg/cv0Z9m0md+0Qf5yPiPkNnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRaDVqCL2CrmdycYsJZOLE7hoSB0rmsGahhZcoZ2H8z7yA/Rmrt8iWyAuDn7NjaIB
         4Ul8I1t2nGqIGbfq0Xu4U7uRV4jnZTRIe6wSusb1bJVCigrkLNmm+ifMrowwdjyAsx
         2KhFw6m0N+eyYrwN3+OkFxARddUbLm7peNOwlDTE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9AC8740D0D; Fri, 27 Nov 2020 14:22:02 -0300 (-03)
Date:   Fri, 27 Nov 2020 14:22:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf diff: fix error return value in __cmd_diff()
Message-ID: <20201127172202.GL70905@kernel.org>
References: <20201124103652.438-1-thunder.leizhen@huawei.com>
 <CAM9d7cgKDMCst2jEmHMHT7MC0DaTg1naNTt3cZnRepiNkmF-VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgKDMCst2jEmHMHT7MC0DaTg1naNTt3cZnRepiNkmF-VA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 27, 2020 at 10:35:37PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Tue, Nov 24, 2020 at 7:37 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >
> > An appropriate return value should be set on the failed path.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> > ---
> >  tools/perf/builtin-diff.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> > index 584e2e1a3793..cefc71506409 100644
> > --- a/tools/perf/builtin-diff.c
> > +++ b/tools/perf/builtin-diff.c
> > @@ -1222,8 +1222,10 @@ static int __cmd_diff(void)
> >                 if (compute == COMPUTE_STREAM) {
> >                         d->evlist_streams = evlist__create_streams(
> >                                                 d->session->evlist, 5);
> > -                       if (!d->evlist_streams)
> > +                       if (!d->evlist_streams) {
> > +                               ret = -ENOMEM;
> >                                 goto out_delete;
> > +                       }
> >                 }
> >         }
> >
> > --
> > 2.26.0.106.g9fadedd
> >
> >

-- 

- Arnaldo
