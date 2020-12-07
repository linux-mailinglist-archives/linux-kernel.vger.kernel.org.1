Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237012D1A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgLGU0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:26:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbgLGU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607372714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8IQaBsR/9UgyLuBHdG1iJllqzIzZyXMYHOK/VmWH8Hk=;
        b=jDxIJ5kna2t1qG96SiXoFCyhetXpyJ909Uu3AIUWHOMj6jggNjEq8A+tiQ3fm9HquJYojR
        joq5aT9YlhX2AanaJidSlryRkso9Cb0Ipnr/6AUDSVwD/M6S//Uvl2TOjxW3Y2wNY994nC
        w/rtZ4r6KqSh9kKWnd++jF4rhxhS9bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-lad6SMhKOaqQpxqDcf9Lyw-1; Mon, 07 Dec 2020 15:25:12 -0500
X-MC-Unique: lad6SMhKOaqQpxqDcf9Lyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3495D800D53;
        Mon,  7 Dec 2020 20:25:11 +0000 (UTC)
Received: from krava (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4264F19C59;
        Mon,  7 Dec 2020 20:25:09 +0000 (UTC)
Date:   Mon, 7 Dec 2020 21:25:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v2 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201207202508.GA4105119@krava>
References: <20201204061310.3196812-1-songliubraving@fb.com>
 <20201204061310.3196812-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204061310.3196812-2-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 10:13:09PM -0800, Song Liu wrote:

SNIP

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
> @@ -1008,7 +1013,42 @@ config-clean:
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
> +LIBBPF_SRC := $(abspath ../lib/bpf)
> +BPF_INCLUDE := -I$(SKEL_TMP_OUT)/..

it looks good, but I still need to add following includes to compile
for bpf_helper* headers

jirka


---
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index fb7de412152b..1f2fe339be85 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1020,7 +1020,7 @@ SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
 ifdef BUILD_BPF_SKEL
 BPFTOOL := $(SKEL_TMP_OUT)/bpftool-bootstrap
 LIBBPF_SRC := $(abspath ../lib/bpf)
-BPF_INCLUDE := -I$(SKEL_TMP_OUT)/..
+BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(BPF_PATH) -I$(LIBBPF_SRC)/..
 
 $(SKEL_TMP_OUT):
 	$(Q)$(MKDIR) -p $@

