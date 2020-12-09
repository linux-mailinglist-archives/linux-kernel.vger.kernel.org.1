Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930FC2D4772
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbgLIRGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731241AbgLIRGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607533493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVRiGPRFsIVzMD4puB2r5WoyXKpsbdUMzZ233tMp+1k=;
        b=HkqViNXtgCzA6rk+XfzbmuRcdYnxT2HrgtDCIRiRzgaj7w+e2x7XdlTJrWyXtcq5BfcNDY
        dumuIE7Q3X1koSdeGqm6qT0qgSIbTeG618mT5hngtIRO96OhWH6tZIt42bMY3RDGLBCZqz
        AdJFLk+DupL3g9QMqnakpoGEf16HmXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-4pjpmeKRP42fK6T_7knVAw-1; Wed, 09 Dec 2020 12:03:59 -0500
X-MC-Unique: 4pjpmeKRP42fK6T_7knVAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E221F1005513;
        Wed,  9 Dec 2020 17:03:57 +0000 (UTC)
Received: from krava (unknown [10.40.195.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id 092EE60BFA;
        Wed,  9 Dec 2020 17:03:55 +0000 (UTC)
Date:   Wed, 9 Dec 2020 18:03:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v3 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201209170355.GE69683@krava>
References: <20201208181646.3044417-1-songliubraving@fb.com>
 <20201208181646.3044417-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208181646.3044417-2-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 10:16:45AM -0800, Song Liu wrote:
> BPF programs are useful in perf to profile BPF programs. BPF skeleton is
> by far the easiest way to write BPF tools. Enable building BPF skeletons
> in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
> be added for different use cases.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>

one nit below, but other than that:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/bpf/bpftool/Makefile          |  3 ++
>  tools/build/Makefile.feature        |  4 ++-
>  tools/perf/Makefile.config          |  9 ++++++
>  tools/perf/Makefile.perf            | 48 +++++++++++++++++++++++++++--
>  tools/perf/util/bpf_skel/.gitignore |  3 ++
>  tools/scripts/Makefile.include      |  1 +
>  6 files changed, 65 insertions(+), 3 deletions(-)
>  create mode 100644 tools/perf/util/bpf_skel/.gitignore
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index f897cb5fb12d0..390af1a52601e 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -139,6 +139,9 @@ endif
>  BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
>  
>  BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o)
> +
> +bootstrap: $(BPFTOOL_BOOTSTRAP)
> +
>  OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
>  
>  VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 97cbfb31b7625..74e255d58d8d0 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -99,7 +99,9 @@ FEATURE_TESTS_EXTRA :=                  \
>           clang                          \
>           libbpf                         \
>           libpfm4                        \
> -         libdebuginfod
> +         libdebuginfod			\
> +         clang-bpf-co-re
> +
>  
>  FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
>  
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ce8516e4de34f..fe234b8bfeefb 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -621,6 +621,15 @@ ifndef NO_LIBBPF
>    endif
>  endif
>  
> +ifdef BUILD_BPF_SKEL
> +  $(call feature_check,clang-bpf-co-re)
> +  ifeq ($(feature-clang-bpf-co-re), 0)
> +    dummy := $(error Error: clang too old. Please install recent clang)
> +  endif
> +  $(call detected,CONFIG_PERF_BPF_SKEL)
> +  CFLAGS += -DBUILD_BPF_SKEL

sorry I did not notice before, but we use HAVE_* name style for these C macros 

HAVE_BPF_SKEL should fit

> +endif
> +
>  dwarf-post-unwind := 1
>  dwarf-post-unwind-text := BUG
>  
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 62f3deb1d3a8b..9ea9047a621bc 100644
> --- a/tools/perf/Makefile.perf

SNIP

