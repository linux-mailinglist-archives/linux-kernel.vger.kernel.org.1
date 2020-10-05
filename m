Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD1E2835FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgJENAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:00:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:29619 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJENAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:00:08 -0400
IronPort-SDR: U9XagJdzIXUEKCl1Vi2FX2g5gWZ0UYnNjNhu7iFsdAAof61CB9CVpYinkalA2hNj2dQNsuAJkY
 voDYH8n1iSXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="143447676"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="143447676"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 05:58:48 -0700
IronPort-SDR: bh/EJQOnHgtBD98BHyEiz6I7urUlEPGqOtvyMj/WcZux1w/Mlqq2XWxJKLr2hMnaQdbP/xj3SJ
 SLKJC1Wa9P+w==
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="525559573"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 05:58:46 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kPQ4e-004eXB-Lt; Mon, 05 Oct 2020 15:58:40 +0300
Date:   Mon, 5 Oct 2020 15:58:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: Re: Build regressions/improvements in v5.9-rc8
Message-ID: <20201005125840.GP3956970@smile.fi.intel.com>
References: <20201005093024.16032-1-geert@linux-m68k.org>
 <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:35:33AM +0200, Geert Uytterhoeven wrote:
> On Mon, Oct 5, 2020 at 11:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v5.9-rc8[1] to v5.9-rc7[3], the summaries are:
> >   - build errors: +3/-6

Thanks for the report!

>   + /kisskb/src/drivers/gpio/gpiolib-cdev.c: error: implicit
> declaration of function 'in_ia32_syscall'
> [-Werror=implicit-function-declaration]:  => 430:6
>   + /kisskb/src/drivers/gpio/gpiolib-cdev.c: error: unknown type name
> 'compat_u64':  => 432:4
> 
> x86_64/um-all{mod,yes}config

I guess the quick fix is to disable that code for UML, I don't know how IOCTLs
are working in UML in cases when host - guest - guest app either from:
	1. x86_64 - x86_64 - i386;
	2. x86_64 - i386 - i386.

>   + error: rk3399_gru_sound.c: relocation truncated to fit:
> R_NDS32_WORD_9_PCREL_RELA against `.text':  => (.text+0x6a8)
> 
> nds32-allyesconfig
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/549738f15da0e5a00275977623be199fbbf7df50/ (all 192 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a1b8638ba1320e6684aa98233c15255eb803fac7/ (all 192 configs)

-- 
With Best Regards,
Andy Shevchenko


