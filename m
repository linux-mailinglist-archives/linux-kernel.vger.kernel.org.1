Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40510218DA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGHQ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 12:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgGHQ4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:56:47 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F8CC2063A;
        Wed,  8 Jul 2020 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594227407;
        bh=bv+/EUpbItqmxCleKRlnE+H9M5d/Q8k1+r6VTLbku0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXOPSHwZsA9daM42GKBetVdlugzJ7LqpoFzUbiB61LLRoZ9DiySusUNJfX2e4UkSW
         35pff0TGK+zA2DPGFo4XbicEWldNKGEWFBDnEjZcue0fKruw/gJ+PNiYVgH18sCE8E
         4Y+AvDSKnnKJBADagdCIm52nEIVdFq6QbSSVXosc=
Date:   Wed, 8 Jul 2020 19:56:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     sparclinux@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] sparc32: srmmu: improve type safety of
 __nocache_fix()
Message-ID: <20200708165642.GF128651@kernel.org>
References: <20200627081653.25311-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627081653.25311-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping.

On Sat, Jun 27, 2020 at 11:16:51AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> As discussed at [1] the __nocache_fix() macro in sparc's SRMMU can be made
> type safe and so the compiler will yell anout misuse of pXd pointers for
> which the __nocache_fix() is primarily used.
> 
> The first patch is an fix of such misuse that I've discovered after adding
> type cast to __nocache_fix(), but to avoid breaking bisection I've made it
> the first commit.
> 
> v2: rebased on v5.8-rc2+
> 
> --
> Sincerely yours,
> Mike.
> 
> [1] https://lkml.kernel.org/r/CAHk-=wisORTa7QVPnFqNw9pFs62UiwgsD4C4d=MtYy1o4JPyGQ@mail.gmail.com
> 
> Mike Rapoport (2):
>   sparc32: use PUD rather than PGD to get PMD in srmmu_inherit_prom_mappings()
>   sparc32: srmmu: improve type safety of __nocache_fix()
> 
>  arch/sparc/include/asm/pgtsrmmu.h |  2 +-
>  arch/sparc/mm/srmmu.c             | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> base-commit: 1590a2e1c681b0991bd42c992cabfd380e0338f2
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
