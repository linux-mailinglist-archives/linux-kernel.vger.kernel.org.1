Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1428C023
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgJLS7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgJLS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:59:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECD4C0613D0;
        Mon, 12 Oct 2020 11:59:19 -0700 (PDT)
Received: from zn.tnic (p200300ec2f06920038fd325cadbd10b1.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:38fd:325c:adbd:10b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAE691EC0315;
        Mon, 12 Oct 2020 20:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602529156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=z38xt7QuaaNmuknyixMSJVUbIhDopUruZ+mwFLEsK5Y=;
        b=RPfXh09oY+Jl5wqACEKFIeADB51jj53jw5Ohrmoc2Xa/L8ykDb4tR4wmyXyV5dRbXxJE9C
        iWpN8OBmfzcSrueHd64TjwqbkCCY7X+8ogVxv6LvrDnz0doVAJZ5CbPwATpeGGTcz9y/1i
        QgmKgjN1DQY+Mp1askLWjw01TjC9LQE=
Date:   Mon, 12 Oct 2020 20:59:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [GIT PULL] x86/asm updates for v5.10
Message-ID: <20201012185913.GL22829@zn.tnic>
References: <20201012110557.GK25311@zn.tnic>
 <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
 <CAFULd4Z1_UKN6haGbNJMi0_tGddPZcawRDfoYnLdn-Qe6UR3-Q@mail.gmail.com>
 <CAHk-=whbEhjSHR7D=8Q_xARd=UKHGcz750LoT1BeRdgTR+6uSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whbEhjSHR7D=8Q_xARd=UKHGcz750LoT1BeRdgTR+6uSw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-toolchains@vger.kernel.org for clang folks...

On Mon, Oct 12, 2020 at 11:56:45AM -0700, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 11:41 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > GCC does not distinguish between %ah and %al and it is not possible to pass "%ah" to the assembly. To access the high part of the %ax register, %h modifier has to be used in the assembly template.
> 
> Do you know whether that's true for clang too, for example?
> 
> Also note that even if the _asm_ might get "%al", maybe the compiler
> decided to use "%ah" for something else?
> 
> I have memories of gcc using the high registers at some point, but it
> might have been some special case code - and it might also be very
> historical.
> 
> [ Goes off and checks ]
> 
> In fact, I can still find gcc generating high register code, although
> it's quite possible that yes, it's only peephole bit extract
> instruction kind of use..
> 
> I also find that clang generates code that uses the high byte
> registers, although again, that's not from any knowledge of clang
> internals, and just by looking at my kernel image disassembly.
> 
> So yes, it _may_ all be just peepholes, but it's not obvious that this
> is all safe.
> 
>                    Linus

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
