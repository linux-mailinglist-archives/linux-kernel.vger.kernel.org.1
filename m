Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9DF2E7338
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 20:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgL2TYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 14:24:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2TYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 14:24:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A721C207B1;
        Tue, 29 Dec 2020 19:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609269809;
        bh=n/EdDOa682PUbMOrgD+PJ8aWo2J6NcbuBt8RNvOOOzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnBqgFU2qft8enK7czGrt5kRddE6AYie3rARAeUeWdjs9gnlvKhwdPrG/aB8YhoXH
         69E9TTzMf/9sUIZIUURqEQx8w8xU10XGvrHyoqbHRkgKNfFSAOSTU3ek4MfqpBueOR
         5wZ4EJ8hC0GrgtCGJoN1hX0+nRnsgH91B87SUo9t8yayariDg4swJW0FCzka+0D0x3
         q0+8C5/s80EhOgjfTiCC0kBlZ7EzKOGD+Ut7e5ql5GWsZm0ePZSc0OhQtWxvS7aT1f
         z8hudEfV7JfpkiKhKB6j8dGbXK4XlBHwX7YSZH8+2TMkrpzT+6M4RKOyY7hM+hkxWz
         ycxuGmMAuNsUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 90E7F411E9; Tue, 29 Dec 2020 16:23:47 -0300 (-03)
Date:   Tue, 29 Dec 2020 16:23:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 3/4] perf-stat: enable counting events for BPF programs
Message-ID: <20201229192347.GM521329@kernel.org>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
 <20201228201159.GF521329@kernel.org>
 <6CB86649-9A1B-4585-8E1F-611F25935041@fb.com>
 <20201229151504.GI521329@kernel.org>
 <3E293E73-ECB7-48E0-8A6E-337988218299@fb.com>
 <20201229184829.GK521329@kernel.org>
 <9BDC4556-E802-4152-91E1-1A4696F62AAE@fb.com>
 <20201229191848.GL521329@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229191848.GL521329@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 29, 2020 at 04:18:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 29, 2020 at 07:11:12PM +0000, Song Liu escreveu:
> > > On Dec 29, 2020, at 10:48 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > I'll check this one to get a patch that at least moves the needle here,
> > > i.e. probably we can leave supporting bpf counters in the python binding
> > > for a later step.

> > Thanks Arnaldo!

> > Currently, I have:
> > 1. Fixed issues highlighted by Namhyung;
> > 2. Merged 3/4 and 4/4;
> > 3. NOT found segfault;
> > 4. NOT fixed python import perf. 

> > I don't have good ideas with 3 and 4... Shall I send current code as v7?

> For 4, please fold the patch below into the relevant patch, we don't
> need bpf_counter.h included in util/evsel.h, you even added a forward
> declaration for that 'struct bpf_counter_ops'.
 
> And in general we should refrain from adding extra includes to header
> files, .h-ell is not good.
> 
> Then we provide a stub for that bpf_counter__destroy() so that
> util/evsel.o when linked into the perf python biding find it there,
> links ok.

Ok, one more stub is needed, I wasn't building all the time with 

  $ make BUILD_BPF_SKEL=1

Ditch the previous patch please, use the one below instead:

- Arnaldo

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 40e3946cd7518113..8226b1fefa8cf2a3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -10,7 +10,6 @@
 #include <internal/evsel.h>
 #include <perf/evsel.h>
 #include "symbol_conf.h"
-#include "bpf_counter.h"
 #include <internal/cpumap.h>
 
 struct bpf_object;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc5ade85a33fc999..278abecb5bdfc0d2 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -79,6 +79,27 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 	return 0;
 }
 
+/*
+ * XXX: All these evsel destructors need some better mechanism, like a linked
+ * list of destructors registered when the relevant code indeed is used instead
+ * of having more and more calls in perf_evsel__delete(). -- acme
+ *
+ * For now, add some more:
+ *
+ * Not to drag the BPF bandwagon...
+ */
+void bpf_counter__destroy(struct evsel *evsel);
+int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
+
+void bpf_counter__destroy(struct evsel *evsel __maybe_unused)
+{
+}
+
+int bpf_counter__install_pe(struct evsel *evsel __maybe_unused, int cpu __maybe_unused, int fd __maybe_unused)
+{
+	return 0;
+}
+
 /*
  * Support debug printing even though util/debug.c is not linked.  That means
  * implementing 'verbose' and 'eprintf'.
