Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D032D2C316E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgKXTv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:51:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726799AbgKXTv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606247485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bh3CLv1PBePuZEKF5WrSgOtLjtFxiK4Y+DcOjTV+1QU=;
        b=KCJc+0GJV6mQJcoTRaYDOIPPcfTogKsiducyGyVQngVx7X4gmwzVCCYkdLBYlmG2tw9uuD
        IzEqPFiyZ/NNvil3uknqn/+uO1zY71tdF+1pSoWPcWGu6UVg21iPwH8f4P/9UKhlCNDPxA
        FPwTQsV/0UXHYnYIW9eg3JKGD3tBzBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-oh-IPPxsPXmrlMeSpCVtcA-1; Tue, 24 Nov 2020 14:51:20 -0500
X-MC-Unique: oh-IPPxsPXmrlMeSpCVtcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B8DF18C89DC;
        Tue, 24 Nov 2020 19:51:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5C8C819C45;
        Tue, 24 Nov 2020 19:51:16 +0000 (UTC)
Date:   Tue, 24 Nov 2020 20:51:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201124195115.GC2164284@krava>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119045046.1491106-2-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:

SNIP

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

could we build just the bootstrap version of bpftool?
should be enough for skeleton and vmlinux.h dump, no?

thanks,
jirka

