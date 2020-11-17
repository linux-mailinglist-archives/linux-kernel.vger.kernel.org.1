Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B786F2B7073
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgKQUpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgKQUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605645948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gASke7Kz5tgOcaqYjUaf5uexfUJxIKQ7Onx3b8uucCc=;
        b=FiNJf6r+hx/NL3Un26Ojk/Ca6xkFSq2oa2YjOklqlhqfcY8DEBglKilweUSudJ/G7DgioW
        OTY1ZXg7xhugn3pnn8FsXzNXuopuOF+5c5lV3qFUu9t/xzeins13ZsNRK9bKiOIj3wkQRR
        5/hQslCziLklLdUBoP+YsjO88Mf2iMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-XdgjwxwNPma8j7lhaxmbLw-1; Tue, 17 Nov 2020 15:45:44 -0500
X-MC-Unique: XdgjwxwNPma8j7lhaxmbLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4CCD5F9D1;
        Tue, 17 Nov 2020 20:45:41 +0000 (UTC)
Received: from krava (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9419D19930;
        Tue, 17 Nov 2020 20:45:38 +0000 (UTC)
Date:   Tue, 17 Nov 2020 21:45:37 +0100
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
Message-ID: <20201117204537.GH1216482@krava>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-14-jolsa@kernel.org>
 <20201117124437.GO614220@kernel.org>
 <20201117151651.GD1216482@krava>
 <20201117174333.GU614220@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117174333.GU614220@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 02:43:33PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 17, 2020 at 04:16:51PM +0100, Jiri Olsa escreveu:
> > On Tue, Nov 17, 2020 at 09:44:37AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Nov 17, 2020 at 12:00:42PM +0100, Jiri Olsa escreveu:
> > > > Allow mmap2 event to synthesize kernel image,
> > > > so we can synthesize kernel build id data in
> > > > following changes.
> > > > 
> > > > It's enabled by new symbol_conf.buildid_mmap2
> > > > bool, which will be switched in following
> > > > changes.
> > > 
> > > Why make this an option? MMAP2 goes back years:
> > > 
> > > 13d7a2410fa637f45 (Stephane Eranian         2013-08-21 12:10:24 +0200  904)      * The MMAP2 records are an augmented version of MMAP, they add
> > > 13d7a2410fa637f45 (Stephane Eranian         2013-08-21 12:10:24 +0200  905)      * maj, min, ino numbers to be used to uniquely identify each mapping
> > > 
> > > Also we unconditionally generate MMAP2 events if the kernel supports it,
> > > from evsel__config():
> > > 
> > >   attr->mmap  = track;
> > >   attr->mmap2 = track && !perf_missing_features.mmap2;
> > > 
> > > So perhaps we should reuse that logic? I.e. use mmap2 if the kernel
> > > supports it?
> > 
> > mmap2 itself is not a problem, the problem is the new
> > bit (PERF_RECORD_MISC_MMAP_BUILD_ID) that says there's
> > build id in mmap2.. older perf tool won't understand
> > that and report will crash
> 
> Is this theoretical or have you experienced it?
> 
> Would be good to tweak the perf.data reader code to not crash on unknown
> bits like that :-\
> 
> But by looking at machine__process_mmap2_event() I couldn't imagine how
> that would crash.
> 
> It would get bogus maj, min, ino, ino_generation, but probably that
> wouldn't make it crash.

right, I shouldn't said crash, sry ;-) but bogus values are worse
than that anyway

jirka

