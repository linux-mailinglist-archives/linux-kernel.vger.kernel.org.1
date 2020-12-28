Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CF2E6B56
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgL1XEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 18:04:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728341AbgL1XEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 18:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609196555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ashoGHECsQsN01wb5y+Je2kwK42M6+y2BARQtOrVvO4=;
        b=ZnJ79TBk7DnG3jzjzsYprF9Ds/0E6ij3/u668Dv7atDBTMexvXtNK9xhqnJBuY66SejWN9
        UDsJFX0uB82WUuIIdwJnDVxyzIAPALBRyEZXZHX7y15KN4C4/22AMMBvS7TKqSUD3yriSf
        PErcW1ouD2xG0bfkb5I992TPIPOXnx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Cxk9tZfWMbu9BIYZ2iD4QQ-1; Mon, 28 Dec 2020 18:02:31 -0500
X-MC-Unique: Cxk9tZfWMbu9BIYZ2iD4QQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE2F4107ACE3;
        Mon, 28 Dec 2020 23:02:28 +0000 (UTC)
Received: from krava (unknown [10.40.192.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3BBF160BE5;
        Mon, 28 Dec 2020 23:02:25 +0000 (UTC)
Date:   Tue, 29 Dec 2020 00:02:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 15/15] perf record: Add --buildid-mmap option to enable
 mmap's build id
Message-ID: <20201228230224.GE450923@krava>
References: <20201214105457.543111-1-jolsa@kernel.org>
 <20201214105457.543111-16-jolsa@kernel.org>
 <20201228134437.GC521329@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228134437.GC521329@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 10:44:37AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Dec 14, 2020 at 11:54:57AM +0100, Jiri Olsa escreveu:
> > Adding --buildid-mmap option to enable build id in mmap2 events.
> > It will only work if there's kernel support for that and it disables
> > build id cache (implies --no-buildid).
> > 
> > It's also possible to enable it permanently via config option
> > in ~.perfconfig file:
> > 
> >   [record]
> >   build-id=mmap
> > 
> > Also added build_id bit in the verbose output for perf_event_attr:
> > 
> >   # perf record --buildid-mmap -vv
> >   ...
> >   perf_event_attr:
> >     type                             1
> >     size                             120
> >     ...
> >     build_id                         1
> > 
> > Adding also missing text_poke bit.
> 
> I'm moving this to just before the:
> 
>   perf tools: Add support to display build id when available in PERF_RECORD_MMAP2 events
> 
> So that I can actually print the synthesized/obtained from the kernel
> build-ids, i.e. this:
> 
>   perf report -D | grep MMAP2 | head -4
> 
> Will work at that point.

ok, thanks

jirka

