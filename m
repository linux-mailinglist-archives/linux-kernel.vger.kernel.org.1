Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCA527875E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgIYMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYMiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:38:16 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200A721D7A;
        Fri, 25 Sep 2020 12:38:12 +0000 (UTC)
Date:   Fri, 25 Sep 2020 13:38:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 29/39] arm64: mte: Switch GCR_EL1 in kernel entry and
 exit
Message-ID: <20200925123810.GL4846@gaia>
References: <cover.1600987622.git.andreyknvl@google.com>
 <4e503a54297cf46ea1261f43aa325c598d9bd73e.1600987622.git.andreyknvl@google.com>
 <20200925113433.GF4846@gaia>
 <e4624059-1598-17eb-2c64-3e7f26c2a1ba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4624059-1598-17eb-2c64-3e7f26c2a1ba@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50:23PM +0100, Vincenzo Frascino wrote:
> On 9/25/20 12:34 PM, Catalin Marinas wrote:
> > On Fri, Sep 25, 2020 at 12:50:36AM +0200, Andrey Konovalov wrote:
> >> +	/*
> >> +	 * Calculate and set the exclude mask preserving
> >> +	 * the RRND (bit[16]) setting.
> >> +	 */
> >> +	mrs_s	\tmp2, SYS_GCR_EL1
> >> +	bfi	\tmp2, \tmp, #0, #16
> >> +	msr_s	SYS_GCR_EL1, \tmp2
> >> +	isb
> >> +1:
> >> +#endif
> >> +	.endm
> >> +
> >> +	.macro mte_set_kernel_gcr, tsk, tmp, tmp2
> > 
> > What's the point of a 'tsk' argument here?
> 
> It is unused. I kept the interface same in between kernel and user.
> I can either add a comment or remove it. Which one do you prefer?

Please remove it. Having the same interface is more confusing since you
have a single kernel gcr_excl but multiple user gcr_excl.

-- 
Catalin
