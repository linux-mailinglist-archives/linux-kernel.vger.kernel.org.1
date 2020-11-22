Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D942BFD07
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 00:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgKVXcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 18:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbgKVXcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 18:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606087941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Ds71yCP0HKWUhA+Q+MPw2m7O3nMi8bRnFOr5gb/o4o=;
        b=KPo9AGESFnPjhVIMHKimIRZetPVLy79Sg0Tm5MDThtPNQq3coPZ/Afoq/GFsvkcgEVZklE
        J/hFRWGMSpgNal4cMP21+TRq+kfSEvqvLkxK9Peza8I9nZQQAis9mz0C6t+fCBGS7BbafB
        eDatl0iModo2vkAMMJKzfBqk+pyqLhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-LF0JfZYkPOyIAfc6KVbhjA-1; Sun, 22 Nov 2020 18:32:19 -0500
X-MC-Unique: LF0JfZYkPOyIAfc6KVbhjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1F3D803655;
        Sun, 22 Nov 2020 23:32:17 +0000 (UTC)
Received: from krava (unknown [10.40.192.91])
        by smtp.corp.redhat.com (Postfix) with SMTP id BA68C5D6D3;
        Sun, 22 Nov 2020 23:32:15 +0000 (UTC)
Date:   Mon, 23 Nov 2020 00:32:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201122233214.GC1902740@krava>
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

SNIP

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

some of the above should already be defined in the base Makefile.perf
we should use that, I think it'd fit better in the Makefile.perf itself

jirka

