Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF7C2F339A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbhALPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbhALPIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:08:19 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC5CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oct32Bf86zyyfqz9Gx8x1yEBx60WNDRermNMNitH+lo=; b=Y0G4ShsiSprM3W6LwQvg9XRAki
        sM9zIF0zrhxwdY6ZogJmVIRZAxC6VZ9zdC31ohN5zFI0kfmAeHVXEgUy4QnZjfEW/uQkJj31k2bTS
        Yvlo/0Hg9CbqaD8m6G77Pl0rKYxDt5Aq5wWOgFi5psvB/sTh3nvLjqnpqrqym8N3z4oV/odp3wkyh
        0ccjREtFoo4nSDJubYTrQx+ZhInjJ5pGQZedF8BHHKCYc0cCUf9se/pWSztzvuFG2eGQqx5V9c3QS
        tZWRxNhh0QO8e7ByAR/wKtvMHEC7/uGS4WwvO9eybH4dj7pxkxaNk/fD0Gp4hDr5cNnz48ijKsASd
        JR8IEP5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzLGP-0005IS-BZ; Tue, 12 Jan 2021 15:07:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A24A301324;
        Tue, 12 Jan 2021 16:07:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3513720C228D2; Tue, 12 Jan 2021 16:07:15 +0100 (CET)
Date:   Tue, 12 Jan 2021 16:07:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     rja_direct@groups.int.hpe.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [PATCH 2/2] perf/x86/intel/uncore: With > 8 nodes, get pci bus
 die id from NUMA info
Message-ID: <X/27I08f6a6IUp9Z@hirez.programming.kicks-ass.net>
References: <20210108153549.108989-1-steve.wahl@hpe.com>
 <20210108153549.108989-3-steve.wahl@hpe.com>
 <X/xL8d8FXVJHkQUj@hirez.programming.kicks-ass.net>
 <20210111154516.GH144275@swahl-home.5wahls.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111154516.GH144275@swahl-home.5wahls.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:45:16AM -0600, Steve Wahl wrote:
> On Mon, Jan 11, 2021 at 02:00:33PM +0100, Peter Zijlstra wrote:
> > On Fri, Jan 08, 2021 at 09:35:49AM -0600, Steve Wahl wrote:
> > 
> > 
> > > +		/*
> > > +		 * The nodeid and idmap registers only contain enough
> > > +		 * information to handle 8 nodes.  On systems with more
> > > +		 * than 8 nodes, we need to rely on NUMA information,
> > > +		 * filled in from BIOS supplied information, to determine
> > > +		 * the topology.
> > > +		 */
> > 
> > Egads.. do we realy have to trust BIOS data? BIOS crud tends to be
> > bonghits qualitee :/
> 
> I work too close to BIOS people (virtually, at least for the moment)
> to safely make disparaging remarks. :-) While the origin is the BIOS,
> I'm using pieces that were already being pulled from the BIOS tables
> for NUMA purposes.

:-) It's just that we've had too much 'fun' with PCI node bindings in
the past.



