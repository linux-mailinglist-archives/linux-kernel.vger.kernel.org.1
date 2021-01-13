Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA24A2F4A04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbhAMLYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:24:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbhAMLYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:24:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77B8A2336F;
        Wed, 13 Jan 2021 11:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610537012;
        bh=0NYgjzOjhml2lGW631C9LPIJcfCrwDvm/lToJKYk97w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQggGfq4UfTT6N0VnGCvSlr57fPvQX3aWyYIUSBLbuQN1ynmtCxF8707RmjryVg4i
         VftYT/t7B9TaAPWH8D47dD5t4RVcFCCoBQY7yGCsB1C8IMtv8pjz/b+t3Jr3u2kg36
         EEOh8rAZSBgPENFUATLWdpQNGLYiU8RuSLQBtrz6aAs+m3ETRHRPdK0clYH3kCkCSt
         bIOs5hpRjqeAVGR3mVD2kTbZg9r17upjwjHr8wUiO16gE6fI/RDRzhEiip/MfjDoqo
         m9qLMdCswtMDkRIKn6vFmyboWMo4+rfp9eHtVYoIkmtCn0j2YFn4br28KDhhaLfFqF
         dM1VnzAOYdXhg==
Date:   Wed, 13 Jan 2021 13:23:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/setup: don't remove E820_TYPE_RAM for pfn 0
Message-ID: <20210113112322.GG1106298@kernel.org>
References: <20210111194017.22696-1-rppt@kernel.org>
 <20210111194017.22696-2-rppt@kernel.org>
 <20210113085644.GA24816@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113085644.GA24816@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:56:49AM +0100, Oscar Salvador wrote:
> On Mon, Jan 11, 2021 at 09:40:16PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The first 4Kb of memory is a BIOS owned area and to avoid its allocation
> > for the kernel it was not listed in e820 tables as memory. As the result,
> > pfn 0 was never recognised by the generic memory management and it is not a
> > part of neither node 0 nor ZONE_DMA.
> 
> So, since it never was added to memblock.memory structs, it was not
> initialized by init_unavailable_mem, right?

Actually it was initialized by init_unavailable_mem() and got zone=0 and
node=0, but the DMA zone started from pfn 1, so pfn 0 was never a part of
ZONE_DMA.
 
> -- 
> Oscar Salvador
> SUSE L3

-- 
Sincerely yours,
Mike.
