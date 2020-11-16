Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C832B43F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgKPMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKPMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:47:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EDm5HUdSzALa6nGwkOC6uvCfTVdzMOyT7mvCy3/aIBc=; b=fOMoDJBVJayTqypEa67eMhI3iE
        3hldbFstRkLBMKcHlUN+mM4I4w1Dr7/YLL1h6GOGbvAITH3cQslNSeXLvGhEKdgnikxE3fZVh2y62
        mTRPNV56Kx0HtAEx1BG+AkWVa+I5o3EYA+jDLreBq5xo7x7dMQnfVLQOm3+aXXQsUBLKz2qIVF7Zf
        h8oH2aapzHWXx7ovG624ExoxEbdUNyFw0EzyxGD6DpjoDpa4LXyJY5rMjI2Rqy9f/acAp2I1RIKfh
        RbiuwzdHBynOTO0xUEHIqnBu41CFImu84ukBkLT/jmcLfVf1Kg5cuxNBbxs6JYIIvy+tvjYq1vyp7
        IRYssnzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keduN-0002kB-P0; Mon, 16 Nov 2020 12:46:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BA2D301959;
        Mon, 16 Nov 2020 13:46:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84B9D2025CA2A; Mon, 16 Nov 2020 13:46:57 +0100 (CET)
Date:   Mon, 16 Nov 2020 13:46:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116124657.GA3121392@hirez.programming.kicks-ass.net>
References: <20201116091054.GL3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116091054.GL3371@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 09:10:54AM +0000, Mel Gorman wrote:
> Similarly, it's not clear why the arm64 implementation
> does not call smp_acquire__after_ctrl_dep in the smp_load_acquire
> implementation. Even when it was introduced, the arm64 implementation
> differed significantly from the arm implementation in terms of what
> barriers it used for non-obvious reasons.

This is because ARM64's smp_cond_load_acquire() implementation uses
smp_load_aquire() directly, as opposed to the generic version that uses
READ_ONCE().

This is because ARM64 has a load-acquire instruction, which is highly
optimized, and generally considered cheaper than the smp_rmb() from
smp_acquire__after_ctrl_dep().

Or so I've been led to believe.
