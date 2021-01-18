Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB752FAB80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394326AbhARU3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:29:50 -0500
Received: from foss.arm.com ([217.140.110.172]:60674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389071AbhARKmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:42:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3DDD1FB;
        Mon, 18 Jan 2021 02:41:20 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.39.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D6733F66E;
        Mon, 18 Jan 2021 02:41:18 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:41:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v3 4/4] arm64: mte: Optimize mte_assign_mem_tag_range()
Message-ID: <20210118104116.GB29688@C02TD0UTHF1T.local>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-5-vincenzo.frascino@arm.com>
 <20210115154520.GD44111@C02TD0UTHF1T.local>
 <4b1a5cdf-e1bf-3a7e-593f-0089cedbbc03@arm.com>
 <0c1b9a6b-0326-a24f-6418-23a0723adecf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c1b9a6b-0326-a24f-6418-23a0723adecf@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 12:27:08PM +0000, Vincenzo Frascino wrote:
> Hi Mark,
> 
> On 1/16/21 2:22 PM, Vincenzo Frascino wrote:
> >> Is there any chance that this can be used for the last bytes of the
> >> virtual address space? This might need to change to `_addr == _end` if
> >> that is possible, otherwise it'll terminate early in that case.
> >>
> > Theoretically it is a possibility. I will change the condition and add a note
> > for that.
> > 
> 
> I was thinking to the end of the virtual address space scenario and I forgot
> that if I use a condition like `_addr == _end` the tagging operation overflows
> to the first granule of the next allocation. This disrupts tagging accesses for
> that memory area hence I think that `_addr < _end` is the way to go.

I think it implies `_addr != _end` is necessary. Otherwise, if `addr` is
PAGE_SIZE from the end of memory, and `size` is PAGE_SIZE, `_end` will
be 0, so using `_addr < _end` will mean the loop will terminate after a
single MTE tag granule rather than the whole page.

Generally, for some addr/increment/size combination (where all are
suitably aligned), you need a pattern like:

| do {
|       thing(addr);
|       addr += increment;
| } while (addr != end);

... or:

| for (addr = start; addr != end; addr += increment) {
|       thing(addr);
| }

... to correctly handle working at the very end of the VA space.

We do similar for page tables, e.g. when we use pmd_addr_end().

Thanks,
Mark.
