Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04B2B727D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgKQXdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:33:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgKQXdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:33:18 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA252222E9;
        Tue, 17 Nov 2020 23:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605655997;
        bh=Y6O0hmdHN+QQnB04I7VkG/GmBcbPTiUeyQkoNJTfCXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2OYboSBp/JjJysgOagASPLmEiBKUy7PIMPgkkTRLKAfgdAypk3RLPgC6t9ulrhGcP
         1fxNZ8vVmurejx4nhLoKbI+BAKC9adI/GE+js4+KWqupGMBdhECG/HfO8EL1R3Qbkn
         9YldUHo6+RySh8miCEYCi6ZYS77wl7xtFOXp4a5g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 100A040E29; Tue, 17 Nov 2020 20:33:14 -0300 (-03)
Date:   Tue, 17 Nov 2020 20:33:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 06/24] perf tools: Add build_id__is_defined function
Message-ID: <20201117233313.GD657351@kernel.org>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-7-jolsa@kernel.org>
 <CAP-5=fUrf9Kq3XwKALSZut3M6NXtnJCAMw0Pe2rh8_31a7tX4w@mail.gmail.com>
 <20201117205359.GJ1216482@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117205359.GJ1216482@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 17, 2020 at 09:53:59PM +0100, Jiri Olsa escreveu:
> On Tue, Nov 17, 2020 at 11:00:37AM -0800, Ian Rogers wrote:
> > On Tue, Nov 17, 2020 at 3:01 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > > Adding build_id__is_defined helper to check build id
> > > is defined and is != zero build id.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/build-id.c | 7 +++++++
> > >  tools/perf/util/build-id.h | 1 +
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > > index 6b410c3d52dc..7d9ecc37849c 100644
> > > --- a/tools/perf/util/build-id.c
> > > +++ b/tools/perf/util/build-id.c
> > > @@ -912,3 +912,10 @@ void build_id__init(struct build_id *bid, const u8
> > > *data, size_t size)
> > >         memcpy(bid->data, data, size);
> > >         bid->size = size;
> > >  }
> > > +
> > > +bool build_id__is_defined(const struct build_id *bid)
> > > +{
> > > +       static u8 zero[BUILD_ID_SIZE];
> > > +
> > > +       return bid && bid->size ? memcmp(bid->data, &zero, bid->size) :
> > > false;

> > Fwiw, I find this method to test for zero a little hard to parse - I'm
> 
> heh, it's controversial one, Namhyung commented
> on this one in previous version, so I changed it ;-)
>   https://lore.kernel.org/lkml/CAM9d7cjjGjTN8sDgLZ1PoQZ-sUXWjnVaNdyOVE1yHxq46PrPkw@mail.gmail.com/

So, the kernel has an idiom for this in lib/string.c:

/**
 * memchr_inv - Find an unmatching character in an area of memory.
 * @start: The memory area
 * @c: Find a character other than c
 * @bytes: The size of the area.
 *
 * returns the address of the first character other than @c, or %NULL
 * if the whole buffer contains just @c.
 */
void *memchr_inv(const void *start, int c, size_t bytes)

No need for any array of some particular size :-)

Its been there for a while:

commit 798248206b59acc6e1238c778281419c041891a7
Author: Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon Oct 31 17:08:07 2011 -0700

    lib/string.c: introduce memchr_inv()

    memchr_inv() is mainly used to check whether the whole buffer is filled
    with just a specified byte.

- Arnaldo
 
> 
> > failing as a C programmer :-) Nit, should zero be const?
> 
> right, should be const, will change
