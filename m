Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B128606C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgJGNs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:48:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2EC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F3Yt1qlrP6C4WwJZp8BRAsz5lDHKiVcAM3PNOj+kOsk=; b=PYbcNNLh598xwUaO2EuiHjHT/W
        PO3aQ7gWxMQCapxc1V+SUq+vtaDOK547kFD8o1cb1y5w5x90cI1NTfPf9yYOrfJ3bPkhhydO1rRGg
        75cvn3i5bICjfZkMMlbME6ngXRi8CyyYs6kI4dLV383ut7hhBC5PnCoZSKmLMLmLskg2Zdcyxn7b6
        7DZGME45SM63HzfQyn1tDfUZIuF5JIEZH4hFCPqH+aFn2LsOZcc26KpVZ4sbxEA32Hmk6kFFVMj3r
        5JfxU1apUywfLOJwZZAt9w5tpH3ieFPLMr4ULuoBGcpzk/5gTt5W6a35S6/JdEumYz7TrKN0IMlaF
        G9Ow4QRA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ9oA-0000z4-4B; Wed, 07 Oct 2020 13:48:42 +0000
Date:   Wed, 7 Oct 2020 14:48:42 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <20201007134842.GA1869@infradead.org>
References: <20201005093024.16032-1-geert@linux-m68k.org>
 <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
 <20201005125840.GP3956970@smile.fi.intel.com>
 <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
 <CAFLxGvyvgSvcizZFZxezFKhZCP79yyMuM7izFbcUtzRTpiOb6A@mail.gmail.com>
 <5f5c303d30eaa32c21131502cc6f28db9d655329.camel@tiscali.nl>
 <20201007130241.GA4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007130241.GA4077@smile.fi.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 04:02:41PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 07, 2020 at 02:45:30PM +0200, Paul Bolle wrote:
> > Richard Weinberger schreef op wo 07-10-2020 om 14:08 [+0200]:
> > > UML has no ia32 emulation and therefore no in_ia32_syscall().
> > > Maybe you can check for CONFIG_IA32_EMULATION too?
> > 
> > The pending fix is:
> >     #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> > 
> > Since this check guards in_ia32_syscall() just checking CONFIG_IA32_EMULATION
> > should do too.
> > 
> > (Way outside my limited expertise, but anyway: is does look odd to see a call
> > to in_ia32_syscall() in drivers/. All other calls are in arch/x86/. Isn't this
> > a bit too x86 specific for an arch independent driver?)
> 
> According to Arnd who suggested that fix the problem is basically appears on
> x86. He also mentioned the new approach that Christoph Hellwig is working on.
> But we decided to go the ifdeffery for better backporting.

linux-next has compat_need_64bit_alignment_fixup(), which is the
proper thing to use.  But for now you'll need the ifdef mess.
