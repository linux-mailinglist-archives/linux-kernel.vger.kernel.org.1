Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CF426CA91
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgIPUI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:08:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32598 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727156AbgIPReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600277650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oe2E/0j87SbF8+LWDnatG5uzDl9gHzTaZ0sjQBiPp+U=;
        b=Tsxpr+qEs0KxYcfGUGAsKW6xjJk2NgxziJ6WqrKCD55+QANKpzfHv25FCaAb6HLsqaql1+
        hretkZyx7BGb2UfXpS/09ZHzzVZIRU7CL0UsrE2ZWMAEfdFBCT7usbVDoeAPVy/v54+ZNz
        WSqFdrHFVGtaOFQgjh6lSd581Rce/vA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-8cfANCu1PuamMpyzCO-72g-1; Wed, 16 Sep 2020 11:21:29 -0400
X-MC-Unique: 8cfANCu1PuamMpyzCO-72g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E42C1891E80;
        Wed, 16 Sep 2020 15:21:27 +0000 (UTC)
Received: from krava (ovpn-114-172.ams2.redhat.com [10.36.114.172])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8421275261;
        Wed, 16 Sep 2020 15:21:24 +0000 (UTC)
Date:   Wed, 16 Sep 2020 17:21:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 16/26] perf tools: Synthesize modules with mmap3
Message-ID: <20200916152123.GH2301783@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-17-jolsa@kernel.org>
 <20200914160758.GK160517@kernel.org>
 <CAP-5=fV4Agxe3UMpkbWkh9CuG1tYho413w7xehy0SiMX+tPv1Q@mail.gmail.com>
 <20200916082018.GA2301783@krava>
 <20200916140744.GR720847@kernel.org>
 <20200916141700.GC1362448@hirez.programming.kicks-ass.net>
 <20200916151021.GS720847@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916151021.GS720847@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:10:21PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 16, 2020 at 04:17:00PM +0200, peterz@infradead.org escreveu:
> > On Wed, Sep 16, 2020 at 11:07:44AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Sep 16, 2020 at 10:20:18AM +0200, Jiri Olsa escreveu:
> > 
> > > > > IIRC BUILD_ID_SIZE is 20 bytes which is the correct size for SHA-1. A
> > > > > build ID may be 128-bits (16 bytes) if md5 or uuid hashes are used.
> > > > > Should this test just be "> 0" ?
> > > > 
> > > > ah right, will check on that
> > > 
> > > And how do you deal with this in the kernel? I.e. to inform userspace,
> > > via the PERF_RECORD_MMAP3 (or MMAP2 with that misc bit trick) the size
> > > of the build-id?
> > 
> > The union size is 24 bytes, so there's plenty space to store a length
> > field with the buildid.
> 
> So, I think we should instead use a bit in the misc field, stating the
> kind of build-id, so that we don't waste a byte for that, I think.

not sure there's too many misc bits left if there would be more
build id kinds

jirka

