Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5A2CAD29
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgLAUS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbgLAUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606853822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N6d4UVnO3CZLtTuzWSoIguWFEpopUp27GR0Tc8SkIac=;
        b=SXC9dq2h0wtvdRRl+RfqscDubfbQMp5LKyD22q2FKzuuP69bPVS2tInAtdchZ4MtPOVvxF
        1pj4Yify33DjiPE/RjxRIaFLn6fFs7/h+2vyjPRLKiyrSAxQD2GojBlYV/yW5an+8u7rjY
        56gDBmYRwpSyoZhm1JS+75LKO/CXi3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-RRr1OG-wOT-78cy__XSNbA-1; Tue, 01 Dec 2020 15:16:59 -0500
X-MC-Unique: RRr1OG-wOT-78cy__XSNbA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94A5D100E420;
        Tue,  1 Dec 2020 20:16:57 +0000 (UTC)
Received: from krava (unknown [10.40.193.1])
        by smtp.corp.redhat.com (Postfix) with SMTP id 423D05D6AD;
        Tue,  1 Dec 2020 20:16:55 +0000 (UTC)
Date:   Tue, 1 Dec 2020 21:16:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [RFC v2 0/2] Introduce perf-stat -b for BPF programs
Message-ID: <20201201201654.GD3169083@krava>
References: <20201201073647.753079-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201073647.753079-1-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:36:45PM -0800, Song Liu wrote:
> This set introduces perf-stat -b option to count events for BPF programs.
> This is similar to bpftool-prog-profile. But perf-stat makes it much more
> flexible.
> 
> Sending as RFC because I haven't addressed some known limitations:
>   1. Only counting events for one BPF program at a time.
>   2. Need extra logic in target__validate().

hi,
I'm getting this eror:

	  CLANG    /home/jolsa/linux-perf/tools/perf/util/bpf_skel/.tmp/dummy.bpf.o
	util/bpf_skel/dummy.bpf.c:4:10: fatal error: 'bpf/bpf_helpers.h' file not found
	#include <bpf/bpf_helpers.h>
		 ^~~~~~~~~~~~~~~~~~~
	1 error generated.

I added change below to fix it, but not sure it's the best fix

jirka


---
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d926f0c35ed4..c8f012132d19 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1022,7 +1022,7 @@ BPFTOOL_CFLAGS := $(filter-out -D_GNU_SOURCE,$(CFLAGS))
 BPFTOOL := $(SKEL_TMP_OUT)/bpftool-bootstrap
 LIBBPF_SRC := $(abspath ../lib/bpf)
 BPFOBJ := $(SKEL_TMP_OUT)/libbpf.a
-BPF_INCLUDE := $(SKEL_TMP_OUT)
+BPF_INCLUDE := -I$(LIBBPF_SRC)/..
 submake_extras := feature_display=0
 
 $(SKEL_TMP_OUT):
@@ -1034,7 +1034,7 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
 
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(BPFOBJ) | $(SKEL_TMP_OUT)
 	$(call QUIET_CLANG, $@)
-	$(Q)$(CLANG) -g -O2 -target bpf	-c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && \
+	$(Q)$(CLANG) -g -O2 -target bpf	$(BPF_INCLUDE) -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && \
 	$(LLVM_STRIP) -g $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)

