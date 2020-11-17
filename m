Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AC82B707A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgKQUur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:50:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgKQUuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605646245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QUveV16zNvlFBBnzOWos3Wr505B8TkweEbKdyMOMAAI=;
        b=LkaoGaaaidl5QSFBT1BpY20N4dRZZJYljOhEJm9E5sF2Qcj713ijaK994v+B4jI7wG8lHh
        Mikn5oagsnQ4KJ+I7O7a3MuFRLMnGJExQ541e4YzW0Kg5jxnvUsnTtkZiXoGaqedRRMK15
        A19HzlgatQhD2aOS8JhhobdVF4iGD4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-pqG8KAR_Pgmjt0oVHLPtvw-1; Tue, 17 Nov 2020 15:50:43 -0500
X-MC-Unique: pqG8KAR_Pgmjt0oVHLPtvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD2581008550;
        Tue, 17 Nov 2020 20:50:40 +0000 (UTC)
Received: from krava (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with SMTP id E097A5C1D7;
        Tue, 17 Nov 2020 20:50:37 +0000 (UTC)
Date:   Tue, 17 Nov 2020 21:50:37 +0100
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
Subject: Re: [PATCH 23/24] perf buildid-list: Add support for mmap2's buildid
 events
Message-ID: <20201117205037.GI1216482@krava>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-24-jolsa@kernel.org>
 <20201117125040.GT614220@kernel.org>
 <20201117152140.GE1216482@krava>
 <20201117175400.GV614220@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117175400.GV614220@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 02:54:00PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 17, 2020 at 04:21:40PM +0100, Jiri Olsa escreveu:
> > On Tue, Nov 17, 2020 at 09:50:40AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Nov 17, 2020 at 12:00:52PM +0100, Jiri Olsa escreveu:
> > > > Add buildid-list support for mmap2's build id data, so we can
> > > > display build ids for dso objects for data without the build
> > > > id cache update.
> > > 
> > > >   $ perf buildid-list
> > > >   1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
> > > >   d278249792061c6b74d1693ca59513be1def13f2 /usr/lib64/libc-2.31.so
> > > > 
> > > > By default only dso objects with hits are shown.
> > > 
> > > Would be interesting to be able to show all the build ids that are
> > > there. a 'perf buildid-list --all' or make this under --force?
> > 
> > ok, will check.. one other tool I think would be handy is
> > to show which debuginfo is not available, because it can
> > change the report a lot - missing symbols are not getting
> > accounted, and their hits are accounted only as separated
> > addresses
> 
> Right, as below.
> 
> So you suggest something like:
> 
>   # perf buildid-cache --fetch-missing-debuginfo

haven't thought about interface yet, just noticed it's something
that's not so easy to find out while we can present it to user quite
easily

the interface needs to have perf.data in it, because buildid-cache
does not work on top of perf.data, perhaps something like:

   # perf report --show-missing-debuginfo

or on top of current interface:

   # perf buildid-cache -a perf.data --show-missing-debuginfo

jirka

