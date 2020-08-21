Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1524D3BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHULRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 07:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgHULRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:17:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 123242072D;
        Fri, 21 Aug 2020 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598008625;
        bh=wsJMHwvewGqUDJUzfhs5P78BW+2XX/LSgMLqfV+VlNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1IE6xSeHH5Qh4LS4LHPTCqSPoACbXLs5TwLnZEEz4/ynQT366k5uktdoAx0PGG76
         jxlPILGfjRQeQhbcnHXVrU1mr1HBImxWeVJgBW/H7o4VaUeE1vEEygTAurYAd57uXD
         mJ48mvCjCcRNArwcBxp2xnDg1+q21PntwfyMNWbA=
Date:   Fri, 21 Aug 2020 12:17:01 +0100
From:   Will Deacon <will@kernel.org>
To:     =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Message-ID: <20200821111700.GD20455@willie-the-truck>
References: <HKAPR02MB4291648701A6803290A17299E0610@HKAPR02MB4291.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HKAPR02MB4291648701A6803290A17299E0610@HKAPR02MB4291.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:48:11AM +0000, 彭浩(Richard) wrote:
> On Thu, Jul 09, 2020 at 07:18:01AM +0000,Peng Hao(Richard) wrote:
> > On Thu, 9 Jul 2020 at 09:50, Peng Hao(Richard) <richard.peng@oppo.com> wrote:
> > >> >Apparently, you are hitting a R_AARCH64_JUMP26 or R_AARCH64_CALL26
> > >> >relocation that operates on a b or bl instruction that is more than
> > >> >128 megabytes away from its target.
> > >> >
> > >> My understanding is that a module that calls functions that are not part of the module will use PLT.
> > >> Plt_max_entries =0 May occur if a module does not depend on other module functions.
> > >>
> > >
> > >A PLT slot is allocated for each b or bl instruction that refers to a
> > >symbol that lives in a different section, either of the same module
> > > (e.g., bl in .init calling into .text), of another module, or of the
> > >core kernel.
> > >
> > >I don't see how you end up with plt_max_entries in this case, though.
> > if a module does not depend on other module functions, PLT entries in the module is equal to 0.
> 
> >This brings me back to my earlier question: if there are no PLT entries in
> >the module, then count_plts() will not find any R_AARCH64_JUMP26 or
> >R_AARCH64_CALL26 relocations that require PLTs and will therefore return 0.
> >The absence of these relocations means that module_emit_plt_entry() will not
> >be called by apply_relocate_add(), and so your patch should have no effect.
> 1.The module in question is the calling function from core kernel.( Ib_core.ko triggered the warning multiple times).
> 2. There are multiple threads loading IB_core.ko
> [   73.388931]  ###cpu=33, name=ib_core, core_plts=0, init_plts=0  
> [   73.402102]  #### cpu=33,pid=2297,name=ib_core, module_emit_plt_entry:plt_num_entries=1, plt_max_entries=0 (warning)
> [   73.439391]  ###cpu=24, name=ib_core, core_plts=0, init_plts=0  
> [   73.448617]  ###cpu=4, name=ib_core, core_plts=0, init_plts=0  
> [   73.547535]  ###cpu=221, name=ib_core, core_plts=0, init_plts=0  
> [   75.198075]  #### cpu=24,pid=2336,name=ib_core, module_emit_plt_entry:plt_num_entries=1, plt_max_entries=0 (warning)
> [   75.489496]  #### cpu=4,pid=2344,name=ib_core, module_emit_plt_entry:plt_num_entries=1, plt_max_entries=0(warning)
> 
> I don't understand why count_plts returns 0 when CONFIG_RANDOMIZE_BASE=n for R_AARCH64_JUMP26 and R_AARCH64_CALL26.
> 
> 3. Set CONFIG_ARM64_MODULE_PLTS=y and restart the server several times without triggering this warning.

Can you provide a means for us to reproduce this failure with an upstream
kernel, please? I really can't tell what's going on from the report. If I
can reproduce the problem locally, then I'm happy to take a look.

Thanks,

Will
