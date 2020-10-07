Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD89286134
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgJGO1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:27:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:35778 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgJGO1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:27:30 -0400
IronPort-SDR: CSuqXJZrd28meun3itWFfpLMgpe6A1a5apI6hoL+Zjwo9rwPK1wScujMuyrZpG3bTKPXqX0tgh
 JezlTk2TvyaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="164190760"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="164190760"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 07:27:30 -0700
IronPort-SDR: JYMz5YWnZlRBAa2MOypnKV7oImTiFq3d+7V1Fs7dMRch+uN8n6NJmebEX71lW1BnWrOrivB7GE
 7a9ZOb/ml1+A==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="297509225"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 07:27:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kQAQf-0013l3-Gj; Wed, 07 Oct 2020 17:28:29 +0300
Date:   Wed, 7 Oct 2020 17:28:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Paul Bolle <pebolle@tiscali.nl>,
        Richard Weinberger <richard.weinberger@gmail.com>,
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
Message-ID: <20201007142829.GB4077@smile.fi.intel.com>
References: <20201005093024.16032-1-geert@linux-m68k.org>
 <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
 <20201005125840.GP3956970@smile.fi.intel.com>
 <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
 <CAFLxGvyvgSvcizZFZxezFKhZCP79yyMuM7izFbcUtzRTpiOb6A@mail.gmail.com>
 <5f5c303d30eaa32c21131502cc6f28db9d655329.camel@tiscali.nl>
 <20201007130241.GA4077@smile.fi.intel.com>
 <20201007134842.GA1869@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007134842.GA1869@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:48:42PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 07, 2020 at 04:02:41PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 07, 2020 at 02:45:30PM +0200, Paul Bolle wrote:
> > > Richard Weinberger schreef op wo 07-10-2020 om 14:08 [+0200]:
> > > > UML has no ia32 emulation and therefore no in_ia32_syscall().
> > > > Maybe you can check for CONFIG_IA32_EMULATION too?
> > > 
> > > The pending fix is:
> > >     #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> > > 
> > > Since this check guards in_ia32_syscall() just checking CONFIG_IA32_EMULATION
> > > should do too.
> > > 
> > > (Way outside my limited expertise, but anyway: is does look odd to see a call
> > > to in_ia32_syscall() in drivers/. All other calls are in arch/x86/. Isn't this
> > > a bit too x86 specific for an arch independent driver?)
> > 
> > According to Arnd who suggested that fix the problem is basically appears on
> > x86. He also mentioned the new approach that Christoph Hellwig is working on.
> > But we decided to go the ifdeffery for better backporting.
> 
> linux-next has compat_need_64bit_alignment_fixup(), which is the
> proper thing to use.  But for now you'll need the ifdef mess.

Thanks for pointing out to this!

So, we need to utilize the new stuff from:
cc7886d25bca ("compat: lift compat_s64 and compat_u64 to <asm-generic/compat.h>")
527c412519eb ("compat: add a compat_need_64bit_alignment_fixup() helper")


-- 
With Best Regards,
Andy Shevchenko


