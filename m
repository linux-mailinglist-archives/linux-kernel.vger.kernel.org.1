Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0043E2687FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgINJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgINJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:08:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F8AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hXoUqsNRo+6pMZXVZ1O13i0Nd6wRO3cvEeAK3h9XGi0=; b=o36M4ItaaBmYJj0OrZzNSVVQA+
        FzcGjasNLRvf5kGo8/Rpmbcw23y9tQ3xHEkV/DKDTxvoJp38E6+/Z9hse8+1tYknozXtSsaMqOxsc
        tI9mdfUVHl0q1IJL0abZ7FzpKrhiA3STngNeQ9NWTgkQdplAUof+5alP9JvGvgD2+5g2lsxuSZz4D
        tp/uAlbW/05dUKubyeVnLOeSNuBRMb0/xYm/QIWyeX3YI49Lcv1zNzWrEDYawt8vnAi10rlICWO5Y
        gqUDWyEr1dmo0D1dMEG1oznaakDs2i5Vz/Ijo/hk91E3++m4YaRtsV/b+VIOxBLezAz198mKc8Ppj
        VLEBhArQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHkT8-0005qU-U5; Mon, 14 Sep 2020 09:08:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E9733006D0;
        Mon, 14 Sep 2020 11:08:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51ADB2C47815E; Mon, 14 Sep 2020 11:08:11 +0200 (CEST)
Date:   Mon, 14 Sep 2020 11:08:11 +0200
From:   peterz@infradead.org
To:     Stephane Eranian <eranian@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20200914090811.GM1362448@hirez.programming.kicks-ass.net>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 11:41:00PM -0700, Stephane Eranian wrote:
> On Sun, Sep 13, 2020 at 2:03 PM Jiri Olsa <jolsa@kernel.org> wrote:
> what happens if I set mmap3 and mmap2?
> 
> I think using mmap3 for every mmap may be overkill as you add useless
> 20 bytes to an mmap record.
> I am not sure if your code handles the case where mmap3 is not needed
> because there is no buildid, e.g, anonymous memory.
> It seems to me you've written the patch in such a way that if the user
> tool supports mmap3, then it supersedes mmap2, and thus
> you need all the fields of mmap2. But if could be more interesting to
> return either MMAP2 or MMAP3 depending on tool support
> and type of mmap, that would certainly save 20 bytes on any anon mmap.
> But maybe that logic is already in your patch and I missed it.

That, and what if you don't want any of that buildid nonsense at all? I
always kill that because it makes perf pointlessly slow and has
absolutely no upsides for me.

