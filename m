Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E82BFD0A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 00:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgKVXfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 18:35:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbgKVXfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 18:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606088130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mIs+lJAS3Q0+HuE+OGL0luVZdhagfm2ch59BDMPDUY=;
        b=X/cF4Nh5i8SJAsJ5SRWKXj6O7wPft5yx7Rnh/Hg4qkSZFYXQTijjMCyRHuZmZPET3rvssN
        pwcZWuOwuHbujs/68J7lLmST8Xts7Y4H51mqn69ulbxNJUmNX6++07o/IOStoqaRvwk4Mk
        fyj9xgMo2hRMrq8zrxwhs0JTl5ZQhpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-7ONJmT5cNQO01DQ-KpGlnw-1; Sun, 22 Nov 2020 18:35:26 -0500
X-MC-Unique: 7ONJmT5cNQO01DQ-KpGlnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5AF780364F;
        Sun, 22 Nov 2020 23:35:24 +0000 (UTC)
Received: from krava (unknown [10.40.192.91])
        by smtp.corp.redhat.com (Postfix) with SMTP id B75795D6D3;
        Sun, 22 Nov 2020 23:35:22 +0000 (UTC)
Date:   Mon, 23 Nov 2020 00:35:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201122233521.GD1902740@krava>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119045046.1491106-2-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:
> BPF programs are useful in perf to profile BPF programs. BPF skeleton is
> by far the easiest way to write BPF tools. Enable building BPF skeletons
> in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
> be added for different use cases.

I was just in a place adding bpf program to perf as well,
so this will save me some time ;-) thanks!

jirka

> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/build/Makefile.feature         |  3 +-
>  tools/perf/Makefile.config           |  7 +++
>  tools/perf/Makefile.perf             | 15 +++++-
>  tools/perf/util/bpf_skel/.gitignore  |  3 ++
>  tools/perf/util/bpf_skel/Makefile    | 71 ++++++++++++++++++++++++++++
>  tools/perf/util/bpf_skel/dummy.bpf.c | 19 ++++++++
>  6 files changed, 115 insertions(+), 3 deletions(-)
>  create mode 100644 tools/perf/util/bpf_skel/.gitignore
>  create mode 100644 tools/perf/util/bpf_skel/Makefile
>  create mode 100644 tools/perf/util/bpf_skel/dummy.bpf.c
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
>  
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
>  
>  $(OUTPUT)%.o: %.c prepare FORCE
>  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
> @@ -1008,7 +1011,15 @@ config-clean:
>  python-clean:
>  	$(python-clean)
>  
> +ifdef BUILD_BPF_SKEL
> +bpf-skel:
> +	$(Q)$(MAKE) -C util/bpf_skel
> +else
> +bpf-skel:
> +endif
> +
>  clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
> +	$(call descend,util/bpf_skel,clean)
>  	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
>  	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>  	$(Q)$(RM) $(OUTPUT).config-detected
> @@ -1071,7 +1082,7 @@ endif
>  
>  FORCE:
>  
> -.PHONY: all install clean config-clean strip install-gtk
> +.PHONY: all install clean config-clean strip install-gtk bpf-skel
>  .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
>  .PHONY: $(GIT-HEAD-PHONY) TAGS tags cscope FORCE prepare
>  .PHONY: libtraceevent_plugins archheaders
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
> diff --git a/tools/perf/util/bpf_skel/Makefile b/tools/perf/util/bpf_skel/Makefile
> new file mode 100644
> index 0000000000000..853bece088f4b
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/Makefile
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +SKEL_OUTPUT := $(abspath .)
> +TMP_OUTPUT := $(abspath .tmp)
> +CLANG ?= clang
> +LLC ?= llc
> +LLVM_STRIP ?= llvm-strip
> +DEFAULT_BPFTOOL := $(TMP_OUTPUT)/sbin/bpftool
> +BPFTOOL ?= $(DEFAULT_BPFTOOL)
> +LIBBPF_SRC := $(abspath ../../../lib/bpf)
> +BPFOBJ := $(TMP_OUTPUT)/libbpf.a
> +BPF_INCLUDE := $(TMP_OUTPUT)
> +INCLUDES := -I$(TMP_OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../../lib)        \
> +       -I$(abspath ../../../include/uapi)
> +CFLAGS := -g -Wall
> +
> +# Try to detect best kernel BTF source
> +KERNEL_REL := $(shell uname -r)
> +VMLINUX_BTF_PATHS := /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_REL)
> +VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword			       \
> +					  $(wildcard $(VMLINUX_BTF_PATHS))))
> +ifeq ($(V),1)
> +Q =
> +msg =
> +else
> +Q = @
> +msg = @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
> +MAKEFLAGS += --no-print-directory
> +submake_extras := feature_display=0
> +endif
> +
> +SKELETONS := $(SKEL_OUTPUT)/dummy.skel.h
> +
> +.DELETE_ON_ERROR:
> +
> +.PHONY: all clean
> +all: $(SKELETONS)
> +
> +clean:
> +	$(call msg,CLEAN,bpf_skel)
> +	$(Q)rm -rf $(TMP_OUTPUT) $(SKELETONS)
> +
> +$(SKEL_OUTPUT)/%.skel.h: $(TMP_OUTPUT)/%.bpf.o | $(BPFTOOL)
> +	$(call msg,GEN-SKEL,$@)
> +	$(Q)$(BPFTOOL) gen skeleton $< > $@
> +
> +$(TMP_OUTPUT)/%.bpf.o: %.bpf.c $(TMP_OUTPUT)/vmlinux.h $(BPFOBJ) | $(TMP_OUTPUT)
> +	$(call msg,BPF,$@)
> +	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)			      \
> +		 -c $(filter %.c,$^) -o $@ &&				      \
> +	$(LLVM_STRIP) -g $@
> +
> +$(TMP_OUTPUT):
> +	$(call msg,MKDIR,$@)
> +	$(Q)mkdir -p $(TMP_OUTPUT)
> +
> +$(TMP_OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(TMP_OUTPUT) $(BPFTOOL)
> +	$(call msg,GEN,$@)
> +	$(Q)if [ ! -e "$(VMLINUX_BTF_PATH)" ] ; then \
> +		echo "Couldn't find kernel BTF; set VMLINUX_BTF to"	       \
> +			"specify its location." >&2;			       \
> +		exit 1;\
> +	fi
> +	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
> +
> +$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(TMP_OUTPUT)
> +	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
> +		    OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
> +
> +$(DEFAULT_BPFTOOL): | $(TMP_OUTPUT)
> +	$(Q)$(MAKE) $(submake_extras) -C ../../../bpf/bpftool		      \
> +		    prefix= OUTPUT=$(TMP_OUTPUT)/ DESTDIR=$(TMP_OUTPUT) install
> diff --git a/tools/perf/util/bpf_skel/dummy.bpf.c b/tools/perf/util/bpf_skel/dummy.bpf.c
> new file mode 100644
> index 0000000000000..085fcee1f52cf
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/dummy.bpf.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +// Copyright (c) 2020 Facebook
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(u32));
> +	__uint(value_size, sizeof(u64));
> +} counts SEC(".maps");
> +
> +SEC("fentry/dummy")
> +int BPF_PROG(fentry_dummy)
> +{
> +	return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "Dual BSD/GPL";
> -- 
> 2.24.1
> 

