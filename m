Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB22E285FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgJGNBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:01:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:58172 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgJGNBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:01:43 -0400
IronPort-SDR: ykzXiWQZkktRn7tS09wRlemDnS4bhRuogj290Zy0Js1SPZ5dpwyM7Qeq/041+d9hK0Om8tysua
 HLGPjF+zz/tA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="151860409"
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="151860409"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 06:01:41 -0700
IronPort-SDR: Bt/ncahIGGI1x+byZ3tWuAUkQFB8AfPPmWAoZqQtYaFLENPzoLzBz4QoWT6dyvYMar3RUZmAs7
 7m9t3QG31DHw==
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="328045288"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 06:01:38 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kQ95d-0010Nw-8C; Wed, 07 Oct 2020 16:02:41 +0300
Date:   Wed, 7 Oct 2020 16:02:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: Re: Build regressions/improvements in v5.9-rc8
Message-ID: <20201007130241.GA4077@smile.fi.intel.com>
References: <20201005093024.16032-1-geert@linux-m68k.org>
 <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
 <20201005125840.GP3956970@smile.fi.intel.com>
 <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
 <CAFLxGvyvgSvcizZFZxezFKhZCP79yyMuM7izFbcUtzRTpiOb6A@mail.gmail.com>
 <5f5c303d30eaa32c21131502cc6f28db9d655329.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f5c303d30eaa32c21131502cc6f28db9d655329.camel@tiscali.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:45:30PM +0200, Paul Bolle wrote:
> Richard Weinberger schreef op wo 07-10-2020 om 14:08 [+0200]:
> > UML has no ia32 emulation and therefore no in_ia32_syscall().
> > Maybe you can check for CONFIG_IA32_EMULATION too?
> 
> The pending fix is:
>     #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> 
> Since this check guards in_ia32_syscall() just checking CONFIG_IA32_EMULATION
> should do too.
> 
> (Way outside my limited expertise, but anyway: is does look odd to see a call
> to in_ia32_syscall() in drivers/. All other calls are in arch/x86/. Isn't this
> a bit too x86 specific for an arch independent driver?)

According to Arnd who suggested that fix the problem is basically appears on
x86. He also mentioned the new approach that Christoph Hellwig is working on.
But we decided to go the ifdeffery for better backporting.

-- 
With Best Regards,
Andy Shevchenko


