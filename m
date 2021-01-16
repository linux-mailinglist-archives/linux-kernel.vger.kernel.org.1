Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153642F8D5C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 13:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbhAPMtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 07:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPMtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 07:49:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D3C061793
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 04:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fx62Z007nfHIGbl4rcsP9LfvQotUGJl9LmsZY3stC7U=; b=EBIABI1nI80lMi4cwmLZCfUMka
        h63IQat9ZDwT70MW2YMXOh5aEe/McyASu8vwcpOuCp4jd9vQGsd4cHqTm8Tfn24VqigjJ66qpZSeg
        DLUClalYrR4Lsjo8nwrffiPzwiuXYFmWtNv0rrTL7IXnQS74yvrUiKV47jSrrzabqtZLgu6vXmDMK
        YPxKoxCyZJKhd17esJJ4WzXpMb9H6dzaKwgc95tku+JssK3G7bbaLDiAxemyhBXMLZQgfixUTbz5U
        9OMtOl2D3c0nYmKk2cwRqCNoxwl2nYNz6Eh2eRJz6WpJLhrv+6G3H2SXb73F5krwSGD8KUMEjk7n9
        sxGHeJ2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0l0G-00AGdF-4V; Sat, 16 Jan 2021 12:48:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43627300F7A;
        Sat, 16 Jan 2021 13:48:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C5BE20299B4E; Sat, 16 Jan 2021 13:48:27 +0100 (CET)
Date:   Sat, 16 Jan 2021 13:48:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] perf/x86/rapl: Fix energy counter detection
Message-ID: <YALgm2b0YNkO7Qtd@hirez.programming.kicks-ass.net>
References: <20210115092208.20866-1-rui.zhang@intel.com>
 <20210115092208.20866-2-rui.zhang@intel.com>
 <YAH1DPNLltqN4zFR@hirez.programming.kicks-ass.net>
 <dfc2fc320c96408e86c2f23b21979a5b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc2fc320c96408e86c2f23b21979a5b@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 08:19:35AM +0000, Zhang, Rui wrote:
> 
> 
> > -----Original Message-----
> > From: Peter Zijlstra <peterz@infradead.org>
> > Sent: Saturday, January 16, 2021 4:03 AM
> > To: Zhang, Rui <rui.zhang@intel.com>
> > Cc: mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com;
> > alexander.shishkin@linux.intel.com; jolsa@redhat.com;
> > namhyung@kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org;
> > kan.liang@linux.intel.com; ak@linux.intel.com
> > Subject: Re: [PATCH 2/3] perf/x86/rapl: Fix energy counter detection
> > Importance: High
> > 
> > On Fri, Jan 15, 2021 at 05:22:07PM +0800, Zhang Rui wrote:
> > > In the RAPL ENERGY_COUNTER MSR, only the lower 32bits represent the
> > > energy counter, and the higher 32bits are reserved.
> > >
> > > Add the MSR mask for these MSRs to fix a problem that the RAPL PMU
> > > events are added erroneously when higher 32bits contain non-zero value.
> > 
> > Why would these high bits be non-zero?
> 
> On SPR platform, the high bits of Psys energy counter are reused for other purpose.
> High bits for other RAPL domains energy counters still return 0.
> 
> I didn't mention this because I thought this patch should be okay as a generic fix.

But it doesn't fix anything.. there's not anything broken, except on
that daft SPR thing.
