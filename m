Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865402C4569
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbgKYQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730249AbgKYQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606322323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzvKWK8iGxvC/U9g2qyJ8S6LnmjAdJDOCFk+J07yIzg=;
        b=CRzIO9hhcB9p58lELyGCtsAJRqUP5TJzxD/ucSrs2TgvIEufVyjgDD+z/cYJg6+wac7VBi
        c/BVYbGffoR1dstaFM8rq6JK0KzaLy2aXlxYbPvcx0zQB/t9/VJm+MSZ766627CT0IBcoc
        cyKGEzM3i3VfDFwcEXQWkLACvjyFrYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-QjOk6xdoPsC7xHrwTDkccA-1; Wed, 25 Nov 2020 11:38:39 -0500
X-MC-Unique: QjOk6xdoPsC7xHrwTDkccA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56DEE18C8C04;
        Wed, 25 Nov 2020 16:38:38 +0000 (UTC)
Received: from krava (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id D5F3760BE5;
        Wed, 25 Nov 2020 16:38:35 +0000 (UTC)
Date:   Wed, 25 Nov 2020 17:38:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201125163834.GK2164284@krava>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
 <20201122232742.GB1902740@krava>
 <0E8E3EDE-5BF4-4D34-A728-2AA935B29050@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E8E3EDE-5BF4-4D34-A728-2AA935B29050@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:47:05PM +0000, Song Liu wrote:
> 
> 
> > On Nov 22, 2020, at 3:27 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:
> > 
> > SNIP
> > 
> >> # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> >> # of all feature tests
> >> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> >> index ce8516e4de34f..1c2c0f4badd85 100644
> >> --- a/tools/perf/Makefile.config
> >> +++ b/tools/perf/Makefile.config
> >> @@ -619,6 +619,13 @@ ifndef NO_LIBBPF
> >>     msg := $(warning BPF API too old. Please install recent kernel headers. BPF support in 'perf record' is disabled.)
> >>     NO_LIBBPF := 1
> >>   endif
> >> +
> >> +  ifndef NO_BPF_SKEL
> >> +    ifeq ($(feature-clang-bpf-co-re), 1)
> >> +      BUILD_BPF_SKEL := 1
> >> +      $(call detected,CONFIG_PERF_BPF_SKEL)
> >> +    endif
> >> +  endif
> >> endif
> >> 
> >> dwarf-post-unwind := 1
> >> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> >> index 7ce3f2e8b9c74..9a9fc71e2ffa4 100644
> >> --- a/tools/perf/Makefile.perf
> >> +++ b/tools/perf/Makefile.perf
> >> @@ -126,6 +126,8 @@ include ../scripts/utilities.mak
> >> #
> >> # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
> >> #
> >> +# Define NO_BPF_SKEL if you do not want build BPF skeletons
> > 
> > we will need to make this the other way round and disable it
> > by default before we figure out al lthe dependencies,
> > my build's failing on:
> > 
> > 	[jolsa@krava perf]$ make JOBS=1
> > 	  BUILD:   Doing 'make -j1' parallel build
> > 	  CC       /home/jolsa/kernel/linux-perf/tools/perf/util/bpf_skel/.tmp/prog.o
> > 	  CLANG    /home/jolsa/kernel/linux-perf/tools/perf/util/bpf_skel/.tmp/pid_iter.bpf.o
> > 	In file included from skeleton/pid_iter.bpf.c:4:
> > 	In file included from /home/jolsa/kernel/linux-perf/tools/lib/bpf/bpf_helpers.h:11:
> > 	/home/jolsa/kernel/linux-perf/tools/lib/bpf/bpf_helper_defs.h:3560:57: warning: declaration of 'struct bpf_redir_neigh' will not be visible outside of this function [-Wvisibility]
> > 	static long (*bpf_redirect_neigh)(__u32 ifindex, struct bpf_redir_neigh *params, int plen, __u64 flags) = (void *) 152;
> > 								^
> > 	skeleton/pid_iter.bpf.c:35:48: error: no member named 'id' in 'struct bpf_link'
> > 			return BPF_CORE_READ((struct bpf_link *)ent, id);
> > 			       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> > 	/home/jolsa/kernel/linux-perf/tools/lib/bpf/bpf_core_read.h:339:18: note: expanded from macro 'BPF_CORE_READ'
> > 			___type((src), a, ##__VA_ARGS__) __r;                       \
> > 	...
> 
> I guess this was caused by older vmlinux.h. Could you please try build 
> vmlinux first? 

yes, that helped, but I think that's the one of the reasons
we need to make this to be built in conditionaly

thanks,
jirka

