Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C72CE2B6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgLCXdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:33:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbgLCXdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607038319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Y5aAtabZToixQE29rulg3FhlOgphxfybE23QlJHTSQ=;
        b=g8KCicdw7Q1dw2Q6+7Y2YIMEr6afVd7LSooUq2zyRh0E2zFqv8LgOndHIJiPSmiKEk8SiB
        jqxCGMwSjnvtfw8VxhJNo5qwc7+sFPfUAfU8xS8dQSAL3FBNjfxm6JJNeI9bz6LlROeaeD
        89A1j7unKZX2tXQ/TD3bUG1AIcky2+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-03zEdPy9MwuUn3YLwKUxpw-1; Thu, 03 Dec 2020 18:31:57 -0500
X-MC-Unique: 03zEdPy9MwuUn3YLwKUxpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82F66809DC9;
        Thu,  3 Dec 2020 23:31:55 +0000 (UTC)
Received: from krava (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9B5871A8A2;
        Thu,  3 Dec 2020 23:31:53 +0000 (UTC)
Date:   Fri, 4 Dec 2020 00:31:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v1 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201203233152.GF3613628@krava>
References: <20201202093709.3374099-1-songliubraving@fb.com>
 <20201202093709.3374099-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202093709.3374099-2-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 01:37:08AM -0800, Song Liu wrote:
> BPF programs are useful in perf to profile BPF programs. BPF skeleton is
> by far the easiest way to write BPF tools. Enable building BPF skeletons
> in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
> be added for different use cases.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/bpf/bpftool/Makefile           |  2 ++
>  tools/build/Makefile.feature         |  4 ++-
>  tools/perf/Makefile.config           | 10 ++++++
>  tools/perf/Makefile.perf             | 46 ++++++++++++++++++++++++++--
>  tools/perf/util/bpf_skel/.gitignore  |  3 ++
>  tools/perf/util/bpf_skel/dummy.bpf.c | 19 ++++++++++++
>  tools/scripts/Makefile.include       |  1 +
>  7 files changed, 82 insertions(+), 3 deletions(-)
>  create mode 100644 tools/perf/util/bpf_skel/.gitignore
>  create mode 100644 tools/perf/util/bpf_skel/dummy.bpf.c
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index f60e6ad3a1dff..a01407ec78dc5 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -120,6 +120,8 @@ endif
>  
>  BPFTOOL_BOOTSTRAP := $(if $(OUTPUT),$(OUTPUT)bpftool-bootstrap,./bpftool-bootstrap)
>  
> +bootstrap: $(BPFTOOL_BOOTSTRAP)
> +
>  BOOTSTRAP_OBJS = $(addprefix $(OUTPUT),main.o common.o json_writer.o gen.o btf.o)
>  OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
>  
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 97cbfb31b7625..4eeeabbaa2947 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -99,7 +99,9 @@ FEATURE_TESTS_EXTRA :=                  \
>           clang                          \
>           libbpf                         \
>           libpfm4                        \
> -         libdebuginfod
> +         libdebuginfod			\
> +	 clang-bpf-co-re

do not use tabs in here

> +
>  
>  FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
>  
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ce8516e4de34f..c8ff82b4fc1b2 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -621,6 +621,16 @@ ifndef NO_LIBBPF
>    endif
>  endif
>  
> +$(call feature_check,clang-bpf-co-re)
> +ifeq ($(feature-clang-bpf-co-re), 0)
> +  undefine BUILD_BPF_SKEL

we compile with 'make BUILD_BPF_SKEL=1' so we should fail here
with the standard 'please install..' message we use

> +endif
> +
> +ifdef BUILD_BPF_SKEL
> +    $(call detected,CONFIG_PERF_BPF_SKEL)
> +    CFLAGS += -DBUILD_BPF_SKEL
> +endif
> +
>  dwarf-post-unwind := 1
>  dwarf-post-unwind-text := BUG
>  
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 7ce3f2e8b9c74..f46f0cd012b2d 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -126,6 +126,8 @@ include ../scripts/utilities.mak
>  #
>  # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
>  #
> +# Define BUILD_BPF_SKEL to enable BPF skeletons
> +#
>  
>  # As per kernel Makefile, avoid funny character set dependencies
>  unexport LC_ALL
> @@ -178,6 +180,8 @@ LD += $(EXTRA_LDFLAGS)
>  HOSTCC  ?= gcc
>  HOSTLD  ?= ld
>  HOSTAR  ?= ar
> +CLANG ?= clang

please keep the indent with other ?= when possible

> +LLVM_STRIP ?= llvm-strip
>  
>  PKG_CONFIG = $(CROSS_COMPILE)pkg-config
>  LLVM_CONFIG ?= llvm-config
> @@ -735,7 +739,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
>  	$(x86_arch_prctl_code_array) \
>  	$(rename_flags_array) \
>  	$(arch_errno_name_array) \
> -	$(sync_file_range_arrays)
> +	$(sync_file_range_arrays) \
> +	bpf-skel
>  
>  $(OUTPUT)%.o: %.c prepare FORCE
>  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
> @@ -1008,7 +1013,44 @@ config-clean:
>  python-clean:
>  	$(python-clean)
>  
> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
> +SKEL_OUT := $(abspath util/bpf_skel)
> +SKEL_TMP_OUT := $(abspath util/bpf_skel/.tmp)

hum, actualy we use $(OUTPUT) and if it's not defined we build
directly in the tree, this should follow the same


> +SKELETONS := $(SKEL_OUT)/dummy.skel.h
> +
> +ifdef BUILD_BPF_SKEL
> +BPFTOOL := $(SKEL_TMP_OUT)/bpftool-bootstrap
> +LIBBPF_SRC := $(abspath ../lib/bpf)
> +BPF_INCLUDE := -I$(SKEL_TMP_OUT)/..
> +submake_extras := feature_display=0

there's no need for the variable, is there?
also why do we want to hide it?

thanks,
jirka

