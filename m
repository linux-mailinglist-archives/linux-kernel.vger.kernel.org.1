Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8502BA9BA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgKTMAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKTMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:00:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38584C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1IRDo4hBUd8j6ToyEOlhDczl8zQL0MZ1VcE/2Tj86V8=; b=lWgrloRSTuiGC5nk/4mHtAapdq
        VwjRJ9pV/B0T1qMIc8kscWWKsHYukR+oAG35rA52pWTnBDx5lko8Mg2mrSuBc9HXXKzFegH7oJGtp
        cwml6uFpFrBaQnbMehbVUamRufyImy2h3sQ01dQNaCyElJ40tKE7oY7DlyW91yiQQ3HL8MtyQUvbq
        My0bogQ20GyepoV5LrRr5SCuJg65biu6wXWYQzw+W+2vh2FY8g8nwuPKoIFrqvMl6beiZDTPBQfCH
        /pI3NOmklXlVteKMmE3U6Bp4Myx1Ojzlpwrt8x2Its6o0bCkEETXsUOqeydQ25qMtkGezRaNWRG5r
        37I6qZZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg54r-0004IG-6x; Fri, 20 Nov 2020 11:59:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61B3B307062;
        Fri, 20 Nov 2020 12:59:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41741200DF1A6; Fri, 20 Nov 2020 12:59:43 +0100 (CET)
Date:   Fri, 20 Nov 2020 12:59:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, luto@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use
 popf
Message-ID: <20201120115943.GD3021@hirez.programming.kicks-ass.net>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-6-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120114630.13552-6-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:46:23PM +0100, Juergen Gross wrote:
> +static __always_inline void arch_local_irq_restore(unsigned long flags)
> +{
> +	if (!arch_irqs_disabled_flags(flags))
> +		arch_local_irq_enable();
> +}

If someone were to write horrible code like:

	local_irq_disable();
	local_irq_save(flags);
	local_irq_enable();
	local_irq_restore(flags);

we'd be up some creek without a paddle... now I don't _think_ we have
genius code like that, but I'd feel saver if we can haz an assertion in
there somewhere...

Maybe something like:

#ifdef CONFIG_DEBUG_ENTRY // for lack of something saner
	WARN_ON_ONCE((arch_local_save_flags() ^ flags) & X86_EFLAGS_IF);
#endif

At the end?
