Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A8E3002AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbhAVMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:16:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbhAVMOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:14:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5A7323437;
        Fri, 22 Jan 2021 12:13:37 +0000 (UTC)
Date:   Fri, 22 Jan 2021 12:13:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        "glider@google.com" <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/1] mm: Optimizing hugepage zeroing in arm64
Message-ID: <20210122121334.GC8567@gaia>
References: <20210121165153.17828-1-prathu.baronia@oneplus.com>
 <20210121174616.GA22740@willie-the-truck>
 <de782758-a7bc-d5a5-832e-c09ce8fe7c00@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de782758-a7bc-d5a5-832e-c09ce8fe7c00@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:59:37PM +0000, Robin Murphy wrote:
> On 2021-01-21 17:46, Will Deacon wrote:
> > On Thu, Jan 21, 2021 at 10:21:50PM +0530, Prathu Baronia wrote:
> > > This patch removes the unnecessary kmap calls in the hugepage zeroing path and
> > > improves the timing by 62%.
> > > 
> > > I had proposed a similar change in Apr-May'20 timeframe in memory.c where I
> > > proposed to clear out a hugepage by directly calling a memset over the whole
> > > hugepage but got the opposition that the change was not architecturally neutral.
> > > 
> > > Upon revisiting this now I see significant improvement by removing around 2k
> > > barrier calls from the zeroing path. So hereby I propose an arm64 specific
> > > definition of clear_user_highpage().
> > 
> > Given that barrier() is purely a thing for the compiler, wouldn't the same
> > change yield a benefit on any other architecture without HIGHMEM? In which
> > case, I think this sort of change belongs in the core code if it's actually
> > worthwhile.
> 
> I would have thought it's more the constant manipulation of the preempt and
> pagefault counts, rather than the compiler barriers between them, that has
> the impact. Either way, if arm64 doesn't need to be atomic WRT preemption
> when clearing parts of hugepages then I also can't imagine that anyone else
> (at least for !HIGHMEM) would either.

I thought the kmap_local stuff was supposed to fix this unnecessary
preemption disabling on 64-bit architectures:

https://lwn.net/Articles/836144/

I guess it's not there yet.

-- 
Catalin
