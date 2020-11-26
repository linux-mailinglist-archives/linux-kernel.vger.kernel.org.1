Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C965F2C59A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 17:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403810AbgKZQzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 11:55:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391465AbgKZQzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606409731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ejVbCYJdjLRG6eFb3fkSH48JdLrU0QKXUob82pB3zyo=;
        b=YE1maOJ4k95g6oHKyXydU537z0Pz0/wb8e7pVHJRSj60jNhgaAEMPD1badAN4oYpZhujyh
        ggjsp+x+O8bpZQT5YmzS4nM9gQOfZA+7a6ijhJtVTBa22wUpbZGsF3L9LoTyWvFFUQ66zS
        AFhx+KganWIbf/3kSa2w6vSuvj8saZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-UIeqj8FQMbqjmvwQcsAxFA-1; Thu, 26 Nov 2020 11:55:26 -0500
X-MC-Unique: UIeqj8FQMbqjmvwQcsAxFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB33E804742;
        Thu, 26 Nov 2020 16:55:24 +0000 (UTC)
Received: from krava (unknown [10.40.192.133])
        by smtp.corp.redhat.com (Postfix) with SMTP id 46BBB60855;
        Thu, 26 Nov 2020 16:55:19 +0000 (UTC)
Date:   Thu, 26 Nov 2020 17:55:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH 03/24] perf: Add build id data in mmap2 event
Message-ID: <20201126165518.GQ2164284@krava>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-4-jolsa@kernel.org>
 <20201117111334.GL3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117111334.GL3121392@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 12:13:34PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 12:00:32PM +0100, Jiri Olsa wrote:
> > Adding support to carry build id data in mmap2 event.
> > 
> > The build id data replaces maj/min/ino/ino_generation
> > fields, which are also used to identify map's binary,
> > so it's ok to replace them with build id data:
> > 
> >   union {
> >           struct {
> >                   u32       maj;
> >                   u32       min;
> >                   u64       ino;
> >                   u64       ino_generation;
> >           };
> >           struct {
> >                   u8        build_id_size;
> >                   u8        __reserved_1;
> >                   u16       __reserved_2;
> >                   u8        build_id[20];
> >           };
> >   };
> > 
> > Replaced maj/min/ino/ino_generation fields give us size
> > of 24 bytes. We use 20 bytes for build id data, 1 byte
> > for size and rest is unused.
> > 
> > There's new misc bit for mmap2 to signal there's build
> > id data in it:
> > 
> >   #define PERF_RECORD_MISC_MMAP_BUILD_ID   (1 << 14)
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Seems sane enough; how do we want to route this?
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 

I still need review from bpf folks, but then I guess
Arnaldo's tree would be the best, because it's mostly
tools changes.. I'm sending new version

jirka

