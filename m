Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8394A2F4941
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbhAMLAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:00:33 -0500
Received: from elvis.franken.de ([193.175.24.41]:47814 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhAMLA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:28 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kzdsF-0002Aa-00; Wed, 13 Jan 2021 11:59:35 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id F1ACBC02B1; Wed, 13 Jan 2021 11:59:24 +0100 (CET)
Date:   Wed, 13 Jan 2021 11:59:24 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 3/4] mips/mm/highmem: Use set_pte() for kmap_local()
Message-ID: <20210113105924.GA10822@alpha.franken.de>
References: <20210112170136.078559026@linutronix.de>
 <20210112170411.187513575@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112170411.187513575@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 06:01:39PM +0100, Thomas Gleixner wrote:
> set_pte_at() on MIPS invokes update_cache() which might recurse into
> kmap_local(). Use set_pte() like the original MIPS highmem implementation
> did.
> 
> Fixes: a4c33e83bca1 ("mips/mm/highmem: Switch to generic kmap atomic")
> Reported-by: Paul Cercueil <paul@crapouillou.net>
> Reported-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/mips/include/asm/highmem.h |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
