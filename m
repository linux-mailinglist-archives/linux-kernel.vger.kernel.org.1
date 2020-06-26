Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A723820B034
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgFZLIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 07:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgFZLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:08:15 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26518C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ePLLvn3g4STvMdY6WpJ5BftJMQVL6KUjzTUZoL0oc+M=; b=RUL1JawBO+l23qmfT02FPmoWAp
        tMzPzy2tHXhTaqOnBNg5PoGPK8XREfCJmYdDYFvM07zI8LwTH1D/O2z2q02Orb3dMyVbUDhAZeiQf
        l+6uG231lJ4rrYmo7LXFbc3/YiNwTnO/r2pXEmVkJKuu73pGDiyoFYBVI6qH1LKBFPIWU4y5HJado
        iAQWXtINr/7dHNys57uXxDXGeCqjgRMtNAHQ8qA05+a5dTbBkqpbwncx48E0nvWffbIjiacHr1Vhs
        6DXBiG49zvHSYa5TSxffiERcgqTiNp6BzI8bpU0dAcJhHQvw8yIvOFSGDSg4rnJmoCCf9TyUl1sme
        tRaKkZ9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jomCi-0005mc-8q; Fri, 26 Jun 2020 11:07:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D7513007CD;
        Fri, 26 Jun 2020 13:07:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69B8029C4228B; Fri, 26 Jun 2020 13:07:31 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:07:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/mm: Pre-allocate p4d/pud pages for vmalloc area
Message-ID: <20200626110731.GC4817@hirez.programming.kicks-ass.net>
References: <20200626093450.27741-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626093450.27741-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:34:50AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Pre-allocate the page-table pages for the vmalloc area at the level
> which needs synchronization on x86. This is P4D for 5-level and PUD
> for 4-level paging.
> 
> Doing this at boot makes sure all page-tables in the system have these
> pages already and do not need to be synchronized at runtime. The
> runtime synchronizatin takes the pgd_lock and iterates over all
> page-tables in the system, so it can take quite long and is better
> avoided.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---

Can't we now remove arch_sync_kernel_mappings() from this same file?
