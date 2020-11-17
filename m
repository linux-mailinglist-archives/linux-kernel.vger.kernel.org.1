Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723412B687C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbgKQPRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:17:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730176AbgKQPRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605626223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DMDfrC6Y9y2EX4eypwzPOghUcdUbHtNjrmkruZ09tNA=;
        b=KCLG8HmsWW0/7SSWRUzICgVNi+eXOdCEdUaJshMYlXKpt9RRUxN3n6n2poBdmWAGUe+bqm
        uHOb7lFiLRTiBznUGNBRQyBuQrzdHf7sg/ka3HWlFZRVmWg9W4UIe8mgq0yzljyFn2S0Bt
        hh/VSMupT/A56JXyx78bNLCWGeHCpEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-xpdof_P0M8-f6UsJXreS4Q-1; Tue, 17 Nov 2020 10:16:58 -0500
X-MC-Unique: xpdof_P0M8-f6UsJXreS4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 525DC10866A3;
        Tue, 17 Nov 2020 15:16:56 +0000 (UTC)
Received: from krava (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with SMTP id D99AA10013BD;
        Tue, 17 Nov 2020 15:16:52 +0000 (UTC)
Date:   Tue, 17 Nov 2020 16:16:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20201117151651.GD1216482@krava>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-14-jolsa@kernel.org>
 <20201117124437.GO614220@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117124437.GO614220@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:44:37AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 17, 2020 at 12:00:42PM +0100, Jiri Olsa escreveu:
> > Allow mmap2 event to synthesize kernel image,
> > so we can synthesize kernel build id data in
> > following changes.
> > 
> > It's enabled by new symbol_conf.buildid_mmap2
> > bool, which will be switched in following
> > changes.
> 
> Why make this an option? MMAP2 goes back years:
> 
> 13d7a2410fa637f45 (Stephane Eranian         2013-08-21 12:10:24 +0200  904)      * The MMAP2 records are an augmented version of MMAP, they add
> 13d7a2410fa637f45 (Stephane Eranian         2013-08-21 12:10:24 +0200  905)      * maj, min, ino numbers to be used to uniquely identify each mapping
> 
> Also we unconditionally generate MMAP2 events if the kernel supports it,
> from evsel__config():
> 
>   attr->mmap  = track;
>   attr->mmap2 = track && !perf_missing_features.mmap2;
> 
> So perhaps we should reuse that logic? I.e. use mmap2 if the kernel
> supports it?

mmap2 itself is not a problem, the problem is the new
bit (PERF_RECORD_MISC_MMAP_BUILD_ID) that says there's
build id in mmap2.. older perf tool won't understand
that and report will crash

jirka

