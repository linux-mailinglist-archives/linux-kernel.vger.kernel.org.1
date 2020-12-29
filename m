Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C484B2E6EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 08:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgL2HCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 02:02:36 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36347 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgL2HCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 02:02:36 -0500
Received: by mail-lf1-f52.google.com with SMTP id o13so28853868lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 23:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEWs1Wx9e4H9U2/kJndIg2yxYhVtsZivFG1stV2tQSM=;
        b=drB44+8Lx6qd94w3CuR3R6Z/HNlFs/LqROCz+Kx9gYixvojQqF+7383+vXt+enrEc6
         kpXFg3mKRVpqXTAzbhTUMk0UUZU7tBg2HKUOijNpOidJIhHRwIPRoU4sFfIuU/NWn64F
         tO0D5I/TeZI3TY18kJogHc815rjMx9u5XJuuT1E0OhvGBTfx79rUBbxnw33pv3CP7fsn
         P/Q//nh2wbZ2HdbP8TS+FD06wtqVfGNu5hxmxc/OBEvTuNC3aMC2436wD5qmEblSARR+
         KYat/D9ZOwD0Dyf+utHbS/bXZA21ggpHWy3mtycaqBSXicy2/PshWf2KSTN24PNV1vhy
         XaEw==
X-Gm-Message-State: AOAM5318JzkPesZOlCTEvSLe6H6LzFKhy8u5/FT/tfiIhgCAMo+8qvjF
        Q433LwXf19d793Yn9UkjHYLhoAIBvft1xfB0ieY=
X-Google-Smtp-Source: ABdhPJy/Wnvd324r++cJcZYRoF+jE3LzCdVKX3vkimRsigCyPWbTiiH60trHnxlyay/cXo7t0ZtZj/I3DGg9fiVAjWI=
X-Received: by 2002:a2e:9b4f:: with SMTP id o15mr21894888ljj.393.1609225312627;
 Mon, 28 Dec 2020 23:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20201228174054.907740-1-songliubraving@fb.com> <20201228174054.907740-3-songliubraving@fb.com>
In-Reply-To: <20201228174054.907740-3-songliubraving@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Dec 2020 16:01:41 +0900
Message-ID: <CAM9d7chjWMFNeQMBftu725cTbCRauUJinQSqy9E9itv=AJXvyA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] perf: support build BPF skeletons with perf
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 29, 2020 at 2:41 AM Song Liu <songliubraving@fb.com> wrote:
>
> BPF programs are useful in perf to profile BPF programs. BPF skeleton is

I'm having difficulties understanding the first sentence - looks like a
recursion. :)  So do you want to use two (or more) BPF programs?

Thanks,
Namhyung


> by far the easiest way to write BPF tools. Enable building BPF skeletons
> in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
> be added for different use cases.
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/build/Makefile.feature        |  4 ++-
>  tools/perf/Makefile.config          |  9 ++++++
>  tools/perf/Makefile.perf            | 49 +++++++++++++++++++++++++++--
>  tools/perf/util/bpf_skel/.gitignore |  3 ++
>  tools/scripts/Makefile.include      |  1 +
>  5 files changed, 63 insertions(+), 3 deletions(-)
>  create mode 100644 tools/perf/util/bpf_skel/.gitignore
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 97cbfb31b7625..74e255d58d8d0 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -99,7 +99,9 @@ FEATURE_TESTS_EXTRA :=                  \
>           clang                          \
>           libbpf                         \
>           libpfm4                        \
> -         libdebuginfod
> +         libdebuginfod                 \
> +         clang-bpf-co-re
> +
>
>  FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ce8516e4de34f..d8e59d31399a5 100644
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
> +  CFLAGS += -DHAVE_BPF_SKEL
> +endif
> +
>  dwarf-post-unwind := 1
>  dwarf-post-unwind-text := BUG
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 62f3deb1d3a8b..d182a2dbb9bbd 100644
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
> @@ -175,6 +177,12 @@ endef
>
>  LD += $(EXTRA_LDFLAGS)
>
> +HOSTCC  ?= gcc
> +HOSTLD  ?= ld
> +HOSTAR  ?= ar
> +CLANG   ?= clang
> +LLVM_STRIP ?= llvm-strip
> +
>  PKG_CONFIG = $(CROSS_COMPILE)pkg-config
>  LLVM_CONFIG ?= llvm-config
>
> @@ -731,7 +739,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
>         $(x86_arch_prctl_code_array) \
>         $(rename_flags_array) \
>         $(arch_errno_name_array) \
> -       $(sync_file_range_arrays)
> +       $(sync_file_range_arrays) \
> +       bpf-skel
>
>  $(OUTPUT)%.o: %.c prepare FORCE
>         $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
> @@ -1004,7 +1013,43 @@ config-clean:
>  python-clean:
>         $(python-clean)
>
> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
> +SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
> +SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
> +SKELETONS :=
> +
> +ifdef BUILD_BPF_SKEL
> +BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
> +LIBBPF_SRC := $(abspath ../lib/bpf)
> +BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(BPF_PATH) -I$(LIBBPF_SRC)/..
> +
> +$(SKEL_TMP_OUT):
> +       $(Q)$(MKDIR) -p $@
> +
> +$(BPFTOOL): | $(SKEL_TMP_OUT)
> +       CFLAGS= $(MAKE) -C ../bpf/bpftool \
> +               OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
> +
> +$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
> +       $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf $(BPF_INCLUDE) \
> +         -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
> +
> +$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
> +       $(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
> +
> +bpf-skel: $(SKELETONS)
> +
> +.PRECIOUS: $(SKEL_TMP_OUT)/%.bpf.o
> +
> +else # BUILD_BPF_SKEL
> +
> +bpf-skel:
> +
> +endif # BUILD_BPF_SKEL
> +
> +bpf-skel-clean:
> +       $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
> +
> +clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean bpf-skel-clean
>         $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
>         $(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>         $(Q)$(RM) $(OUTPUT).config-detected
> diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/bpf_skel/.gitignore
> new file mode 100644
> index 0000000000000..5263e9e6c5d83
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/.gitignore
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +.tmp
> +*.skel.h
> \ No newline at end of file
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index 1358e89cdf7d6..62119ce69ad9a 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -127,6 +127,7 @@ ifneq ($(silent),1)
>                          $(MAKE) $(PRINT_DIR) -C $$subdir
>         QUIET_FLEX     = @echo '  FLEX     '$@;
>         QUIET_BISON    = @echo '  BISON    '$@;
> +       QUIET_GENSKEL  = @echo '  GEN-SKEL '$@;
>
>         descend = \
>                 +@echo         '  DESCEND  '$(1); \
> --
> 2.24.1
>
