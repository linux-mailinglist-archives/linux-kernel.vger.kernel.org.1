Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532622C316F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgKXTvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726805AbgKXTvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606247492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxkQ8Tlf0hKkD3RN13+XlbmnHIj3jkATrZp4r/utqRE=;
        b=huei2LxCt21cdEqCCRWTIos0zuN0Gw4Uame4l4q3StbnBfsdeIIoyA9HINRoEPB5RZB5EE
        HurPRk7C74NsTDrXqJA5TaPwTyuZd6rVGNY3+zgDsrGUgRbZhsZtoxk4pabqA3YVeaJdfO
        A7OLDHZ8BHitAlaetK1sHB00dDEstyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-2sWrXzc_PdSjtLyLlKaOPQ-1; Tue, 24 Nov 2020 14:51:27 -0500
X-MC-Unique: 2sWrXzc_PdSjtLyLlKaOPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A97D1074640;
        Tue, 24 Nov 2020 19:51:25 +0000 (UTC)
Received: from krava (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id A1C7560864;
        Tue, 24 Nov 2020 19:51:23 +0000 (UTC)
Date:   Tue, 24 Nov 2020 20:51:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201124195122.GD2164284@krava>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119045046.1491106-2-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:

SNIP

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

please add support to specify VMLINUX_H as it is in selftests
or bpftool, we will need it in out building setup

thanks,
jirka

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

