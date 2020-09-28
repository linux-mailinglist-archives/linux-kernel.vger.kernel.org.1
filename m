Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A009027ADD0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1MbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgI1MbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:31:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180F721531;
        Mon, 28 Sep 2020 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601296282;
        bh=OcZ5s+aqAAshBwhs3BEoWgNRrIfkR0TKEbwFZHFx4k0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIzJM/dYcBvK2p6okMSObXsSI9VRbPRGMqf9+W2RWSHms75Yn62I1yKLd5uLLjs2f
         CfizEbClt3FfnDC9UuCkBgYx6z4q19fe1UD2gR24YQW1fKtIvh9wjYnjKBTvhn4nAT
         Gc8amDpkGNlyBBm7JuYAIZxRdnzZIuUxouhGZzFw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C0DB400E9; Mon, 28 Sep 2020 09:31:20 -0300 (-03)
Date:   Mon, 28 Sep 2020 09:31:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 4/7] perf inject: Do not load map/dso when injecting
 build-id
Message-ID: <20200928123120.GE3087422@kernel.org>
References: <20200923080537.155264-1-namhyung@kernel.org>
 <20200923080537.155264-5-namhyung@kernel.org>
 <20200924130909.GB3150401@krava>
 <CAM9d7ciWQa8rC91nOiak1ephg-+SfFXVkFLtU4H4Snaw2i_pWA@mail.gmail.com>
 <20200924134444.GE3150401@krava>
 <20200924144632.GA357981@google.com>
 <20200925142619.GD3273770@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925142619.GD3273770@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 25, 2020 at 04:26:19PM +0200, Jiri Olsa escreveu:
> On Thu, Sep 24, 2020 at 11:46:32PM +0900, Namhyung Kim wrote:
> > On Thu, Sep 24, 2020 at 03:44:44PM +0200, Jiri Olsa wrote:
> > > On Thu, Sep 24, 2020 at 10:20:51PM +0900, Namhyung Kim wrote:
> > > > On Thu, Sep 24, 2020 at 10:09 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > On Wed, Sep 23, 2020 at 05:05:34PM +0900, Namhyung Kim wrote:
> > > > >
> > > > > SNIP
> > > > >
> > > > > > -static inline int is_no_dso_memory(const char *filename)
> > > > > > -{
> > > > > > -     return !strncmp(filename, "[stack", 6) ||
> > > > > > -            !strncmp(filename, "/SYSV",5)   ||
> > > > > > -            !strcmp(filename, "[heap]");
> > > > > > -}
> > > > > > -
> > > > > >  static inline int is_android_lib(const char *filename)
> > > > > >  {
> > > > > >       return strstarts(filename, "/data/app-lib/") ||
> > > > > > @@ -158,7 +143,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> > > > > >               int anon, no_dso, vdso, android;
> > > > > >
> > > > > >               android = is_android_lib(filename);
> > > > > > -             anon = is_anon_memory(filename, flags);
> > > > > > +             anon = is_anon_memory(filename) || flags & MAP_HUGETLB;
> > > > >
> > > > > what's the reason to take 'flags & MAP_HUGETLB' out of is_anon_memory?
> > > > 
> > > > The MAP_HUGETLB is defined in uapi/linux/mman.h and I had trouble
> > > > when including the header in the map.h file.
> > > 
> > > could you share the error? it might be corner case, but it
> > > could bite us in future
> > 
> > Sure.
> > 
> >   CC       util/session.o
> > In file included from /home/namhyung/project/linux/tools/include/uapi/asm-generic/mman-common-tools.h:5,
> >                  from /home/namhyung/project/linux/tools/include/uapi/asm-generic/mman.h:5,
> >                  from /home/namhyung/project/linux/tools/arch/x86/include/uapi/asm/mman.h:5,
> >                  from /home/namhyung/project/linux/tools/include/uapi/linux/mman.h:5,
> >                  from util/map.h:13,
> >                  from util/session.c:21:
> > /home/namhyung/project/linux/tools/include/uapi/asm-generic/mman-common.h:26: error: "MAP_POPULATE" redefined [-Werror]
> >    26 | #define MAP_POPULATE  0x008000 /* populate (prefault) pagetables */
> >       | 
> > In file included from /usr/include/x86_64-linux-gnu/bits/mman.h:31,
> >                  from /usr/include/x86_64-linux-gnu/sys/mman.h:41,
> >                  from util/session.c:12:
> > /usr/include/x86_64-linux-gnu/bits/mman-map-flags-generic.h:34: note: this is the location of the previous definition
> >    34 | # define MAP_POPULATE 0x08000  /* Populate (prefault) pagetables.  */
> >       | 
> > 
> > This is repeated for each macro definitions..
> 
> hm, some black magic happened in the past and it looks like now we
> can't have <sys/mman.h> and <linux/mman.h> includes together
> 
> it looks related to this commit:
>   be709d48329a tools headers uapi: Sync asm-generic/mman-common.h and linux/mman.h
> 
> I'm not sure I understand the purpose of asm-generic/mman-common-tools.h file
> 
> Arnaldo,
> any chance you might have some quick solution before I dive in?
> you can reproduce the issue with change below

So, some of the headers in tools/include/ are for
tools/perf/trace/beauty/ to auto-generate tables, like described in the
be709d48329a cset.

This causes problems like the one you're describing, that is why I'm now
using tools/perf/trace/beauty/include/ for these purposes, and that is
not used in building source code, just in autogenerating such tables and
helping us to notice when changes were made in the kernel that may break
those autogeneration scripts, all under that tools/perf/check_patch.sh
build checks.

I'll look into this mmap case and try to get this resolved and then
build it on all the containers to make sure everything continues to work
as expected.

- Arnaldo
