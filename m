Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38AA2E68DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgL1M5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 07:57:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727767AbgL1M52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 07:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609160162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szGzwTX3TMMz3cB+34eyrkW/jguWKTDO9ZQwwyq1kfc=;
        b=K8LLIHr+yw0ZHR0ldwBrf3NFY1yHe3RduOP4tbdI+cGDNsNDW0GpGC/xo1pVfoSYs3aIHe
        Re0PTivJgndfu3JxBCqvU2ghK249j3bdldIpNdKMJHNvarw1v9RY2AH3qzjTZO893obZdP
        6DEfEFtif941BmeMtfttP9DBIXvvifE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-gDs2YLjTMdK-skPE3yw6_A-1; Mon, 28 Dec 2020 07:56:00 -0500
X-MC-Unique: gDs2YLjTMdK-skPE3yw6_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F071107ACE4;
        Mon, 28 Dec 2020 12:55:58 +0000 (UTC)
Received: from krava (unknown [10.40.192.122])
        by smtp.corp.redhat.com (Postfix) with SMTP id 059117047C;
        Mon, 28 Dec 2020 12:55:55 +0000 (UTC)
Date:   Mon, 28 Dec 2020 13:55:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mark.rutland@arm.com, kernel-team@fb.com
Subject: Re: [PATCH v5 2/4] perf: support build BPF skeletons with perf
Message-ID: <20201228125554.GC450923@krava>
References: <20201215181412.1730974-1-songliubraving@fb.com>
 <20201215181412.1730974-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215181412.1730974-3-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:14:10AM -0800, Song Liu wrote:

SNIP

>  HOSTCC  ?= gcc
>  HOSTLD  ?= ld
>  HOSTAR  ?= ar
> +CLANG   ?= clang
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
> @@ -1008,7 +1013,43 @@ config-clean:
>  python-clean:
>  	$(python-clean)
>  
> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
> +SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
> +SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
> +SKELETONS :=
> +
> +ifdef BUILD_BPF_SKEL
> +BPFTOOL := $(SKEL_TMP_OUT)/bpftool-bootstrap

I think this needs to be:

  BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool

otherwise it won't compile for me

jirka

