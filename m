Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519EE2B6C14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgKQRnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgKQRng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:43:36 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0EA2083E;
        Tue, 17 Nov 2020 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605635015;
        bh=E6HWsnYm3SnHpM8JEcIpgapNiVSLIULbsQPmNXW/KLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDNZnNxq+YMtlA85kbVAssgE8qQsvSBqMBjwl6QLj/h0mhkiGaM2bLxvu1IWRJRdl
         auPt3EGYltgCb5T36XHnAffSpPgsUE1zsHQChZxR6G0vHyCjB3FtZ5segwBPpDkZAf
         3Uq7CED3K3kxkv+uELx34qjsn/EecrMaPCHXe8go=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 603DE40E29; Tue, 17 Nov 2020 14:43:33 -0300 (-03)
Date:   Tue, 17 Nov 2020 14:43:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 13/24] perf tools: Allow mmap2 event to synthesize kernel
 image
Message-ID: <20201117174333.GU614220@kernel.org>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-14-jolsa@kernel.org>
 <20201117124437.GO614220@kernel.org>
 <20201117151651.GD1216482@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117151651.GD1216482@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 17, 2020 at 04:16:51PM +0100, Jiri Olsa escreveu:
> On Tue, Nov 17, 2020 at 09:44:37AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 17, 2020 at 12:00:42PM +0100, Jiri Olsa escreveu:
> > > Allow mmap2 event to synthesize kernel image,
> > > so we can synthesize kernel build id data in
> > > following changes.
> > > 
> > > It's enabled by new symbol_conf.buildid_mmap2
> > > bool, which will be switched in following
> > > changes.
> > 
> > Why make this an option? MMAP2 goes back years:
> > 
> > 13d7a2410fa637f45 (Stephane Eranian         2013-08-21 12:10:24 +0200  904)      * The MMAP2 records are an augmented version of MMAP, they add
> > 13d7a2410fa637f45 (Stephane Eranian         2013-08-21 12:10:24 +0200  905)      * maj, min, ino numbers to be used to uniquely identify each mapping
> > 
> > Also we unconditionally generate MMAP2 events if the kernel supports it,
> > from evsel__config():
> > 
> >   attr->mmap  = track;
> >   attr->mmap2 = track && !perf_missing_features.mmap2;
> > 
> > So perhaps we should reuse that logic? I.e. use mmap2 if the kernel
> > supports it?
> 
> mmap2 itself is not a problem, the problem is the new
> bit (PERF_RECORD_MISC_MMAP_BUILD_ID) that says there's
> build id in mmap2.. older perf tool won't understand
> that and report will crash

Is this theoretical or have you experienced it?

Would be good to tweak the perf.data reader code to not crash on unknown
bits like that :-\

But by looking at machine__process_mmap2_event() I couldn't imagine how
that would crash.

It would get bogus maj, min, ino, ino_generation, but probably that
wouldn't make it crash.

- Arnaldo

int machine__process_mmap2_event(struct machine *machine,
                                 union perf_event *event,
                                 struct perf_sample *sample)
{                            
        struct thread *thread;
        struct map *map;
        struct dso_id dso_id = {
                .maj = event->mmap2.maj,
                .min = event->mmap2.min,
                .ino = event->mmap2.ino,
                .ino_generation = event->mmap2.ino_generation,
        };             
        int ret = 0;   

        if (dump_trace)
                perf_event__fprintf_mmap2(event, stdout);
                             
        if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
            sample->cpumode == PERF_RECORD_MISC_KERNEL) {
                ret = machine__process_kernel_mmap_event(machine, event);
                if (ret < 0)
                        goto out_problem;
                return 0;
        }
                             
        thread = machine__findnew_thread(machine, event->mmap2.pid,
                                        event->mmap2.tid);
        if (thread == NULL)
                goto out_problem;

        map = map__new(machine, event->mmap2.start,
                        event->mmap2.len, event->mmap2.pgoff,
                        &dso_id, event->mmap2.prot,
                        event->mmap2.flags,
                        event->mmap2.filename, thread);

        if (map == NULL)
                goto out_problem_map;

        ret = thread__insert_map(thread, map);
        if (ret)
                goto out_problem_insert;

        thread__put(thread);
        map__put(map);
        return 0;

out_problem_insert:
        map__put(map);
out_problem_map:
        thread__put(thread);
out_problem:
        dump_printf("problem processing PERF_RECORD_MMAP2, skipping event.\n");
        return 0;
}
