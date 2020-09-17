Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE72126DF00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgIQPDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbgIQO7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:59:19 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61ED1206E6;
        Thu, 17 Sep 2020 14:59:13 +0000 (UTC)
Date:   Thu, 17 Sep 2020 15:59:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
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
Subject: Re: [PATCH v2 24/37] arm64: mte: Add in-kernel tag fault handler
Message-ID: <20200917145910.GD10662@gaia>
References: <cover.1600204505.git.andreyknvl@google.com>
 <7866d9e6f11f12f1bad42c895bf4947addba71c2.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7866d9e6f11f12f1bad42c895bf4947addba71c2.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:16:06PM +0200, Andrey Konovalov wrote:
>  static int do_tag_check_fault(unsigned long addr, unsigned int esr,
>  			      struct pt_regs *regs)
>  {
> -	do_bad_area(addr, esr, regs);
> +	/* The tag check fault (TCF) is per TTBR */
> +	if (is_ttbr0_addr(addr))
> +		do_bad_area(addr, esr, regs);
> +	else
> +		do_tag_recovery(addr, esr, regs);
> +
>  	return 0;
>  }

I had forgotten the details here. The TCF mode is per EL, so TCF0
affects EL0, TCF affects EL1 irrespective of which TTBR is used. Now, we
know the kernel accesses TTBR0 usually with LDTR/STTR instructions if
UAO is available (soon to get rid of), so these would act as EL0
accesses using TCF0. However, we have the futex.h code which uses
exclusives and they'd be executed as EL1, so you can potentially get a
tag check fault for such uaccess even if the user disabled it in TCF0.

The solution here I think is for uaccess_enable() to set PSTATE.TCO,
restore it in uaccess_disable().

We get away with not toggling PSTATE.TCO in the user MTE patches since
the TCF is always 0 for the kernel.

The do_tag_check_fault() above is still correct, apart from the comment
which needs a better explanation on why we do a is_ttbr0_addr() check.

-- 
Catalin
