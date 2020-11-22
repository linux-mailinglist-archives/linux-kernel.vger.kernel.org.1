Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C372BFCF7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 00:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgKVX1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 18:27:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbgKVX1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 18:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606087669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mNNvh4+ZNz+ew6BBBK6Oip3bqR9Ii11RceNdZ0HAyvc=;
        b=NxawDSdxp0astJANpkL37rf02mHjNui8XKizTK7nGlMZ8qYO70We3J5+Urwq5lbF3szZLr
        TXhrPffxlmu18EXWxzCIXm/eG+GTttZ4uRLnUFEbExDvNveETVU5HnqWi32cv65UkpGWwc
        dCAOgPtkdB9OzKks13ikoHgsszs4aVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-SOwf2cSyPPyvhS0YQbDf_g-1; Sun, 22 Nov 2020 18:27:47 -0500
X-MC-Unique: SOwf2cSyPPyvhS0YQbDf_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B55301005D71;
        Sun, 22 Nov 2020 23:27:45 +0000 (UTC)
Received: from krava (unknown [10.40.192.91])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9BDEE60BF3;
        Sun, 22 Nov 2020 23:27:43 +0000 (UTC)
Date:   Mon, 23 Nov 2020 00:27:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201122232742.GB1902740@krava>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119045046.1491106-2-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:

SNIP

>  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
>  # of all feature tests
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ce8516e4de34f..1c2c0f4badd85 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -619,6 +619,13 @@ ifndef NO_LIBBPF
>      msg := $(warning BPF API too old. Please install recent kernel headers. BPF support in 'perf record' is disabled.)
>      NO_LIBBPF := 1
>    endif
> +
> +  ifndef NO_BPF_SKEL
> +    ifeq ($(feature-clang-bpf-co-re), 1)
> +      BUILD_BPF_SKEL := 1
> +      $(call detected,CONFIG_PERF_BPF_SKEL)
> +    endif
> +  endif
>  endif
>  
>  dwarf-post-unwind := 1
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 7ce3f2e8b9c74..9a9fc71e2ffa4 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -126,6 +126,8 @@ include ../scripts/utilities.mak
>  #
>  # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
>  #
> +# Define NO_BPF_SKEL if you do not want build BPF skeletons

we will need to make this the other way round and disable it
by default before we figure out al lthe dependencies,
my build's failing on:

	[jolsa@krava perf]$ make JOBS=1
	  BUILD:   Doing 'make -j1' parallel build
	  CC       /home/jolsa/kernel/linux-perf/tools/perf/util/bpf_skel/.tmp/prog.o
	  CLANG    /home/jolsa/kernel/linux-perf/tools/perf/util/bpf_skel/.tmp/pid_iter.bpf.o
	In file included from skeleton/pid_iter.bpf.c:4:
	In file included from /home/jolsa/kernel/linux-perf/tools/lib/bpf/bpf_helpers.h:11:
	/home/jolsa/kernel/linux-perf/tools/lib/bpf/bpf_helper_defs.h:3560:57: warning: declaration of 'struct bpf_redir_neigh' will not be visible outside of this function [-Wvisibility]
	static long (*bpf_redirect_neigh)(__u32 ifindex, struct bpf_redir_neigh *params, int plen, __u64 flags) = (void *) 152;
								^
	skeleton/pid_iter.bpf.c:35:48: error: no member named 'id' in 'struct bpf_link'
			return BPF_CORE_READ((struct bpf_link *)ent, id);
			       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
	/home/jolsa/kernel/linux-perf/tools/lib/bpf/bpf_core_read.h:339:18: note: expanded from macro 'BPF_CORE_READ'
			___type((src), a, ##__VA_ARGS__) __r;                       \
	...


jirka

