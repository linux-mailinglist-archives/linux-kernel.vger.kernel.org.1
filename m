Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615D2303C00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405390AbhAZLrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405419AbhAZLmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:42:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9884C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AbnKjRHoewJ2viG2j8Rr6WGPjsCo5Vt+p9CXyMcwXOk=; b=oH9KAHVUh9+wpMxSKtW92vpsOb
        9gP3FfICNKOt5B4iPRZidUc/sVYaA7745HMvHOMwEW/TR8H6n3NDdlA0uWbUUg4cfOm1gggN8+6Y3
        xUH9uAf5+JLRhAAZWDZyRnaP2GMNBGVxnybANESjkLhR7kFC/8ygE0ze4A2EXYLtnUTJN5++3s8RO
        WjUtE5HcYQy8aIe2V+uOMhTuwvrnkVIZhvsZo+fl9GJ7PqQfd0Ew4lX9No1SW2Q4iMUmx6+ZtEKr/
        tGeoIVsaRIwu+2Pjdd/6OM07XQtlCsQnmvhH3yo/L/tiK/I+7fTpmhPwazjnuWKNGKKIEZRasfhyt
        jzBKF5uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Mgo-005WPV-Kl; Tue, 26 Jan 2021 11:39:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 889403010C8;
        Tue, 26 Jan 2021 12:39:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 776DD2128500F; Tue, 26 Jan 2021 12:39:17 +0100 (CET)
Date:   Tue, 26 Jan 2021 12:39:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stefan Saecherl <stefan.saecherl@fau.de>
Cc:     x86@kernel.org, linux-kernel@i4.cs.fau.de,
        Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kgdb: Allow removal of early BPs
Message-ID: <YA//ZcJAyQPEtybr@hirez.programming.kicks-ass.net>
References: <20201214141314.5717-1-stefan.saecherl@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214141314.5717-1-stefan.saecherl@fau.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 03:13:12PM +0100, Stefan Saecherl wrote:

> One thing to consider when doing this is that code can go away during boot
> (e.g. .init.text). Previously kgdb_arch_remove_breakpoint handled this case
> gracefully by just having copy_to_kernel_nofault fail but if one then calls
> text_poke_kgdb the system dies due to the BUG_ON we moved out of
> __text_poke.  To avoid this __text_poke now returns an error in case of a
> nonpresent code page and the error is handled at call site.

So what if the page is reused and now exists again?

We keep track of the init state, how about you look at that and not poke
at .init.text after it's freed instead?
