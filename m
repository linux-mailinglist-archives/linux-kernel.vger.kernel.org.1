Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9716E2CADE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgLAU4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:56:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgLAU4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606856084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Ksj4wJtdkrbp/nHQqEiVJAVwNM4RHAPJbnuVSxJ2RA=;
        b=Jf+KTuCGoBS3ZjHG5f3BqExJY/iHF1OsuZFXZP7IHS8XsZUD8xzsX7zi7CVH2eEKVyoPbw
        1BpaIL1Zjb3PTsu4UBNARJLnDmnuMQmqCI+/V1JB9/fSQdDU5rMjzDGDmW2Tbx56YTaJYz
        VMYr2k5WuJQ7Shm1XUCFrQCmV08J/WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-ARmqBLeoOb6JlVMTbCUpUQ-1; Tue, 01 Dec 2020 15:54:39 -0500
X-MC-Unique: ARmqBLeoOb6JlVMTbCUpUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C48843E747;
        Tue,  1 Dec 2020 20:54:37 +0000 (UTC)
Received: from krava (unknown [10.40.193.1])
        by smtp.corp.redhat.com (Postfix) with SMTP id 21F9460854;
        Tue,  1 Dec 2020 20:54:33 +0000 (UTC)
Date:   Tue, 1 Dec 2020 21:54:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [RFC v2 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201201205433.GE3169083@krava>
References: <20201201073647.753079-1-songliubraving@fb.com>
 <20201201073647.753079-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201073647.753079-2-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:36:46PM -0800, Song Liu wrote:
> BPF programs are useful in perf to profile BPF programs. BPF skeleton is
> by far the easiest way to write BPF tools. Enable building BPF skeletons
> in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
> be added for different use cases.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/bpf/bpftool/Makefile           |  2 ++
>  tools/build/Makefile.feature         |  3 +-
>  tools/perf/Makefile.config           |  9 +++++
>  tools/perf/Makefile.perf             | 52 ++++++++++++++++++++++++++--
>  tools/perf/util/bpf_skel/.gitignore  |  3 ++
>  tools/perf/util/bpf_skel/dummy.bpf.c | 19 ++++++++++
>  tools/scripts/Makefile.include       |  1 +
>  7 files changed, 86 insertions(+), 3 deletions(-)
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
> index 97cbfb31b7625..95a58b5564218 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -70,7 +70,8 @@ FEATURE_TESTS_BASIC :=                  \
>          libaio				\
>          libzstd				\
>          disassembler-four-args		\
> -        file-handle
> +        file-handle			\
> +        clang-bpf-co-re

this needs to go under FEATURE_TESTS_EXTRA and you need to call
$(call feature_check,clang-bpf-co-re) before checking on $(feature-clang-bpf-co-re)

otherwise the test-all will mark it as detected even if it's not

>  
>  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
>  # of all feature tests
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ce8516e4de34f..cb0cf06e0bb43 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -621,6 +621,15 @@ ifndef NO_LIBBPF
>    endif
>  endif
>  
> +ifeq ($(feature-clang-bpf-co-re), 0)
> +  BUILD_BPF_SKEL := 0
> +endif
> +
> +ifeq ($(BUILD_BPF_SKEL), 1)
> +  $(call detected,CONFIG_PERF_BPF_SKEL)
> +  CFLAGS += -DBUILD_BPF_SKEL
> +endif
> +
>  dwarf-post-unwind := 1
>  dwarf-post-unwind-text := BUG
>  
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 7ce3f2e8b9c74..37b7ffe1db27c 100644
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
> @@ -735,7 +737,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
>  	$(x86_arch_prctl_code_array) \
>  	$(rename_flags_array) \
>  	$(arch_errno_name_array) \
> -	$(sync_file_range_arrays)
> +	$(sync_file_range_arrays) \
> +	bpf-skel

I think the 'prepare' target is misused already with other stuff,
there's generated bpf_counter.c dependency on util/bpf_skel/bpf_prog_profiler.skel.h
in util/.bpf_counter.o.cmd, that should triger the build no?

we have few other dependencies like that for flex/bison generation
perhaps we could follow also that 

>  
>  $(OUTPUT)%.o: %.c prepare FORCE
>  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
> @@ -1008,7 +1011,52 @@ config-clean:
>  python-clean:
>  	$(python-clean)
>  
> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
> +SKEL_OUT := $(abspath util/bpf_skel)
> +SKEL_TMP_OUT := $(abspath util/bpf_skel/.tmp)
> +SKELETONS := $(SKEL_OUT)/dummy.skel.h
> +
> +ifdef BUILD_BPF_SKEL
> +CLANG ?= clang
> +LLVM_STRIP ?= llvm-strip

please move this up where we have similar setup like HOSTCC and others

> +BPFTOOL_CFLAGS := $(filter-out -D_GNU_SOURCE,$(CFLAGS))
> +BPFTOOL := $(SKEL_TMP_OUT)/bpftool-bootstrap
> +LIBBPF_SRC := $(abspath ../lib/bpf)
> +BPFOBJ := $(SKEL_TMP_OUT)/libbpf.a

we already build libbpf.a, chekc 'LIBBPF = $(BPF_PATH)libbpf.a' above

> +BPF_INCLUDE := $(SKEL_TMP_OUT)
> +submake_extras := feature_display=0
> +
> +$(SKEL_TMP_OUT):
> +	$(Q)$(MKDIR) -p $@
> +
> +$(BPFTOOL): | $(SKEL_TMP_OUT)
> +	CFLAGS= $(MAKE) $(submake_extras) -C ../bpf/bpftool \
> +		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
> +
> +$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(BPFOBJ) | $(SKEL_TMP_OUT)
> +	$(call QUIET_CLANG, $@)
> +	$(Q)$(CLANG) -g -O2 -target bpf	-c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && \
> +	$(LLVM_STRIP) -g $@
> +
> +$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
> +	$(call QUIET_GENSKEL, $@)

is there a reason to use call in here? you could define QUIET_GENSKEL
to use $@ and use it the same way as we use the rest of QUIET_* stuf
in Makefile.perf

> new file mode 100644
> index 0000000000000..5263e9e6c5d83
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/.gitignore
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +.tmp
> +*.skel.h
> \ No newline at end of file
> diff --git a/tools/perf/util/bpf_skel/dummy.bpf.c b/tools/perf/util/bpf_skel/dummy.bpf.c
> new file mode 100644
> index 0000000000000..492a43a851deb
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/dummy.bpf.c

hum, what's the reason for dummy skeleton? it just adds
time to compilation no?

thanks,
jirka

