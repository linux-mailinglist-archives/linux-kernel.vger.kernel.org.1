Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8B26900A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgINPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgINPco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:32:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAEB206E9;
        Mon, 14 Sep 2020 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600097564;
        bh=gTKPtzpMtztC4ctRjQPPjEeiA/8BCcW7/oPDOu+9JCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zxVrkaYYu1Fag8lBzLeWxE0v4qmohn6eo8S2oCTGBGk6Yj5cnNybruzMZd0fSlZ/1
         sVESJfG7xVQXAaxSErJNjjrDQi8gDof8zuXSaoBIWuubR5TzyEJpJdGGhHNqh/CE+Z
         2K0pJ3epzyAKS5wz7JuY/bnZlgp6DZbzAMUMkJeg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E29340D3D; Mon, 14 Sep 2020 12:32:42 -0300 (-03)
Date:   Mon, 14 Sep 2020 12:32:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     peterz@infradead.org
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Message-ID: <20200914153242.GE160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com>
 <20200914090811.GM1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914090811.GM1362448@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 11:08:11AM +0200, peterz@infradead.org escreveu:
> On Sun, Sep 13, 2020 at 11:41:00PM -0700, Stephane Eranian wrote:
> > On Sun, Sep 13, 2020 at 2:03 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > what happens if I set mmap3 and mmap2?
> > 
> > I think using mmap3 for every mmap may be overkill as you add useless
> > 20 bytes to an mmap record.
> > I am not sure if your code handles the case where mmap3 is not needed
> > because there is no buildid, e.g, anonymous memory.
> > It seems to me you've written the patch in such a way that if the user
> > tool supports mmap3, then it supersedes mmap2, and thus
> > you need all the fields of mmap2. But if could be more interesting to
> > return either MMAP2 or MMAP3 depending on tool support
> > and type of mmap, that would certainly save 20 bytes on any anon mmap.
> > But maybe that logic is already in your patch and I missed it.
> 
> That, and what if you don't want any of that buildid nonsense at all? I
> always kill that because it makes perf pointlessly slow and has
> absolutely no upsides for me.

So, for you nothing should change, no MMAP3 used, no collection at the
end (which is your pet peeve).

I'm not saying this is what is in his patches right now, but what I
think his patches should be doing.

- Arnaldo
