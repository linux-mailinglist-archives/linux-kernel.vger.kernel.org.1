Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51F2ADED6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgKJSzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbgKJSzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:55:09 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25A27206F1;
        Tue, 10 Nov 2020 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605034508;
        bh=jGMJQVhOYYbu7V3KA7lkuZA03vlDOae9KFulBxXATsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyeasDgMpFMhwi4L4dxPrzhjp+0Yom/pzkyA7ZyoXSWyRGQIWX/ldDCQFi2fHVXBI
         XyDjKj/7sETDCEAbCDVhD/lOkHtfgcHj+H19C0YE5UlY5DiT3zT7Y+vAZOoEI1AM7f
         5INt1AT7gAK2y5iWgwTcIPhBasJ3/FByhoMnisUM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 20B8D411D1; Tue, 10 Nov 2020 15:55:06 -0300 (-03)
Date:   Tue, 10 Nov 2020 15:55:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 03/24] perf: Add build id data in mmap2 event
Message-ID: <20201110185506.GB26034@kernel.org>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-4-jolsa@kernel.org>
 <20201110082851.GV2594@hirez.programming.kicks-ass.net>
 <20201110101041.GC387652@krava>
 <20201110182334.GG387652@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110182334.GG387652@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 10, 2020 at 07:23:34PM +0100, Jiri Olsa escreveu:
> On Tue, Nov 10, 2020 at 11:10:46AM +0100, Jiri Olsa wrote:
> > On Tue, Nov 10, 2020 at 09:28:51AM +0100, Peter Zijlstra wrote:
> > > On Mon, Nov 09, 2020 at 10:53:54PM +0100, Jiri Olsa wrote:
> > > > There's new misc bit for mmap2 to signal there's build
> > > > id data in it:
> > > > 
> > > >   #define PERF_RECORD_MISC_BUILD_ID              (1 << 14)
> > > 
> > > PERF_RECORD_MISC_MMAP_BUILD_ID would be consistent with the existing
> > > PERF_RECORD_MISC_MMAP_DATA naming.

Agreed.

> > ok
 
> > > 
> > > Also, AFAICT there's still a bunch of unused bits in misc.
> > > 
> > > 	012	    CDEF
> > > 	|||---------||||
> > > 
> > > Where:
> > > 	0-2	CPUMODE_MASK
> > > 
> > > 	C	PROC_MAP_PARSE_TIMEOUT
> > > 	D	MMAP_DATA / COMM_EXEC / FORK_EXEC / SWITCH_OUT
> > > 	E	EXACT_IP / SCHED_OUT_PREEMPT
> > > 	F	(reserved)
> > > 
> > > Maybe we should put in a comment to keep track of the hole ?
> > 
> > ook
> 
> how about the change below.. I also switch the build_id with the size,
> but I kept the build_id size 20, because I think there's bigger chance
> we will use those reserved bytes for something, than that we will need
> those extra 3 bytes in build_id array
> 
>   struct {
>           u8              build_id_size;
>           u8              __reserved_1;
>           u16             __reserved_2;
>           u8              build_id[20];
>   };

For "maybe we'll use it for something else" doesn't require that it gets
before build_id, i.e. to use it for something else it can be as above or

   struct {
           u8              build_id_size;
           u8              build_id[20];
           u8              __reserved_1;
           u16             __reserved_2;
   };

that groups build_id size with it, but nah, this is getting funny by
now.

My suggestion was not about increasing build_id to 23, just to leave the
unused (reserved) bytes after it.

- Arnaldo
