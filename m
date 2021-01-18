Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0AB2F9D97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389293AbhARKuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:50:55 -0500
Received: from foss.arm.com ([217.140.110.172]:60282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389638AbhARKZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:25:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 888901FB;
        Mon, 18 Jan 2021 02:24:54 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.39.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 019A63F66E;
        Mon, 18 Jan 2021 02:24:51 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:24:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v3 1/4] kasan, arm64: Add KASAN light mode
Message-ID: <20210118102426.GA29688@C02TD0UTHF1T.local>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-2-vincenzo.frascino@arm.com>
 <20210115150811.GA44111@C02TD0UTHF1T.local>
 <ba23ab9b-8f49-bdb7-87d8-3eb99ddf54b6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba23ab9b-8f49-bdb7-87d8-3eb99ddf54b6@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 01:47:08PM +0000, Vincenzo Frascino wrote:
> On 1/15/21 3:08 PM, Mark Rutland wrote:
> > On Fri, Jan 15, 2021 at 12:00:40PM +0000, Vincenzo Frascino wrote:
> >>  #ifdef CONFIG_KASAN_HW_TAGS
> >> -#define arch_enable_tagging()			mte_enable_kernel()
> >> +#define arch_enable_tagging(mode)		mte_enable_kernel(mode)
> > 
> > Rather than passing a mode in, I think it'd be better to have:
> > 
> > * arch_enable_tagging_prod()
> > * arch_enable_tagging_light()
> > 
> > ... that we can map in the arch code to separate:
> > 
> > * mte_enable_kernel_sync()
> > * mte_enable_kernel_async()
> > 
> > ... as by construction that avoids calls with an unhandled mode, and we
> > wouldn't need the mode enum kasan_hw_tags_mode...
> > 
> >> +static inline int hw_init_mode(enum kasan_arg_mode mode)
> >> +{
> >> +	switch (mode) {
> >> +	case KASAN_ARG_MODE_LIGHT:
> >> +		return KASAN_HW_TAGS_ASYNC;
> >> +	default:
> >> +		return KASAN_HW_TAGS_SYNC;
> >> +	}
> >> +}
> > 
> > ... and we can just have a wrapper like this to call either of the two functions directly, i.e.
> > 
> > static inline void hw_enable_tagging_mode(enum kasan_arg_mode mode)
> > {
> > 	if (mode == KASAN_ARG_MODE_LIGHT)
> > 		arch_enable_tagging_mode_light();
> > 	else
> > 		arch_enable_tagging_mode_prod();
> > }
> >
> 
> Fine by me, this would remove the need of adding a new enumeration as well and
> reflect on the arch code. I would keep "arch_enable_tagging_mode_sync" and
> "arch_enable_tagging_mode_async" though to give a clear indication in the KASAN
> code of the mode we are setting. I will adapt my code accordingly for v4.

Thanks, that sounds great!

I completely agree on keeping the '_sync' and '_aync' suffixes in the
the core code.

Mark.
