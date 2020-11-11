Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF462AF585
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgKKPy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:54:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726274AbgKKPyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605110062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hvDVTWmRbbuIvkOWsqIftQDiojJWKzlEuRre0QQ1HiA=;
        b=G0nMY9E83Z/80hBmA0CNeRR+8eAL0ns1M6T4iklOH+WgL7C/+ld3w5r7BJbd/YqNZrAMNf
        VlbvTs98TVMkNaBBldmlOK3obNwKtI6BIR2SeelkRYjEBZukkXob/DxVYBQ/vLmBLzkOhW
        RPlMGUstWa7uiLg+VzRQmfajL9/zzTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-eouMY3QkOUaK8zKyZWORXA-1; Wed, 11 Nov 2020 10:54:18 -0500
X-MC-Unique: eouMY3QkOUaK8zKyZWORXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49D7A107B277;
        Wed, 11 Nov 2020 15:54:16 +0000 (UTC)
Received: from krava (unknown [10.40.194.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1D04C2C31E;
        Wed, 11 Nov 2020 15:54:12 +0000 (UTC)
Date:   Wed, 11 Nov 2020 16:54:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20201111155411.GA581954@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-4-jolsa@kernel.org>
 <20201110082851.GV2594@hirez.programming.kicks-ass.net>
 <20201110101041.GC387652@krava>
 <20201110182334.GG387652@krava>
 <20201110185506.GB26034@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110185506.GB26034@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:55:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 10, 2020 at 07:23:34PM +0100, Jiri Olsa escreveu:
> > On Tue, Nov 10, 2020 at 11:10:46AM +0100, Jiri Olsa wrote:
> > > On Tue, Nov 10, 2020 at 09:28:51AM +0100, Peter Zijlstra wrote:
> > > > On Mon, Nov 09, 2020 at 10:53:54PM +0100, Jiri Olsa wrote:
> > > > > There's new misc bit for mmap2 to signal there's build
> > > > > id data in it:
> > > > > 
> > > > >   #define PERF_RECORD_MISC_BUILD_ID              (1 << 14)
> > > > 
> > > > PERF_RECORD_MISC_MMAP_BUILD_ID would be consistent with the existing
> > > > PERF_RECORD_MISC_MMAP_DATA naming.
> 
> Agreed.
> 
> > > ok
>  
> > > > 
> > > > Also, AFAICT there's still a bunch of unused bits in misc.
> > > > 
> > > > 	012	    CDEF
> > > > 	|||---------||||
> > > > 
> > > > Where:
> > > > 	0-2	CPUMODE_MASK
> > > > 
> > > > 	C	PROC_MAP_PARSE_TIMEOUT
> > > > 	D	MMAP_DATA / COMM_EXEC / FORK_EXEC / SWITCH_OUT
> > > > 	E	EXACT_IP / SCHED_OUT_PREEMPT
> > > > 	F	(reserved)
> > > > 
> > > > Maybe we should put in a comment to keep track of the hole ?
> > > 
> > > ook
> > 
> > how about the change below.. I also switch the build_id with the size,
> > but I kept the build_id size 20, because I think there's bigger chance
> > we will use those reserved bytes for something, than that we will need
> > those extra 3 bytes in build_id array
> > 
> >   struct {
> >           u8              build_id_size;
> >           u8              __reserved_1;
> >           u16             __reserved_2;
> >           u8              build_id[20];
> >   };
> 
> For "maybe we'll use it for something else" doesn't require that it gets
> before build_id, i.e. to use it for something else it can be as above or
> 
>    struct {
>            u8              build_id_size;
>            u8              build_id[20];
>            u8              __reserved_1;
>            u16             __reserved_2;
>    };
> 
> that groups build_id size with it, but nah, this is getting funny by
> now.

yep, that's why I kept it like above

> 
> My suggestion was not about increasing build_id to 23, just to leave the
> unused (reserved) bytes after it.

ok, thanks

jirka

