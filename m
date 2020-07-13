Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7995221D65E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 14:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgGMMzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 08:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMMzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:55:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bgjmm0RTwkjol3u3Vm3ArdMHTSLlmvv1aOs6GxS+xr4=; b=jz8sMEjNED4cY6W4gU0jsBwP88
        glS/1dqvwaIuZB19kJd+HQ4CioMubFAhYLuJ8rNVR/EfgCHtQtWWUyfIIDZ0/vxfi17jWpTMLCPES
        OQfPJTN07rV3lBuI9P3V1IhTZw/MLJ62WF95PDPGhk5ytvpoAZgTyu4wEUPU6j5/jywpy3nVPI+q6
        GtCe+HexwdKZDggYx4JXjwfeUgCwl1J+0qbxPd7McuwGShoNcqv5zDgE/zHJvloOkZWEWlUrItzbz
        vb9+z2XAIxc1Z5R3OlyRbcKOJ1Ohr4e4cPxxcHtKS8atoMi6bjLXxEiQ0zk5hGvnSWGaYN2Rt+3DL
        8z14O8gQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juxzm-00087v-VW; Mon, 13 Jul 2020 12:55:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AAF9303A02;
        Mon, 13 Jul 2020 14:55:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFCD120D27C74; Mon, 13 Jul 2020 14:55:43 +0200 (CEST)
Date:   Mon, 13 Jul 2020 14:55:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com
Subject: Re: [PATCH v3 7/7] sched/topology: Use prebuilt SD flag degeneration
 mask
Message-ID: <20200713125543.GJ10769@hirez.programming.kicks-ass.net>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
 <20200701190656.10126-8-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701190656.10126-8-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 08:06:55PM +0100, Valentin Schneider wrote:
> Leverage SD_DEGENERATE_GROUPS_MASK in sd_degenerate() and
> sd_degenerate_parent().
> 
> Note that this changes sd_degenerate() somewhat: I'm using the negation of
> SD_DEGENERATE_GROUPS_MASK as the mask of flags not requiring groups, which
> is equivalent to:
> 
> SD_WAKE_AFFINE | SD_SERIALIZE | SD_NUMA
> 
> whereas the current mask for that is simply
> 
> SD_WAKE_AFFINE
> 
> I played with a few toy NUMA topologies on QEMU and couldn't cause a
> different degeneration than what mainline does currently. If that is deemed
> too risky, we can go back to using SD_WAKE_AFFINE explicitly.

Arguably SD_SERIALIZE needs groups, note how we're only having that
effective for machines with at least 2 nodes. It's a bit shit how we end
up there, but IIRC that's what it ends up as.

SD_NUMA is descriptive, and not marking a group as degenerates because
it has SD_NUMA seems a bit silly. But then, it would be the top domain
and would survive anyway?
