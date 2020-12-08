Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101BC2D2805
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgLHJoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgLHJoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:44:23 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF85C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 01:43:37 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id q137so16291814iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOfSXZUZHFJ0/IMjArCSIU3fFYQ+AgSZyhk4SA6mvo8=;
        b=TURij3foAEti0mrje6JLTCEE3aN72QYT63E09q6MeQ1zqxm3dsKZao3Ot6C0mRnuKR
         f8Xg8CNH/AdX05HE1SF3OUZIYkbn8GRFyAYgaKrJziOyJRGu+my5MKdzw3ueT3yAdS84
         a9QKCvlrroKrK0tdC35re585Rgl3XVqUfas8ayW5qO76FjHfUzx0eVTI0D9Ha6AOE+Lr
         C5xypVLohQ9OyKRzRMZTUIZzn8EJABqz3I+P1CPDN4TQrAtTI1UU1qAEDDBf70CFaDrf
         1mJnX/RCZl44lixvN1KlX5vuGELgix8pCppYtXR0Y8wdLhwm2hRQcOlSAh7aQ8s8t5eQ
         F5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOfSXZUZHFJ0/IMjArCSIU3fFYQ+AgSZyhk4SA6mvo8=;
        b=r5LZ8aN94Hgibi6seVvq6vofDoA8lXfKfaRLNQUC/qYJquq0EeD1WBgg4/eL14hd9A
         HXaS6PhHtuIyfAJ+iPBVi95YS5uX/UtfqpaD2n3nCS9e14uMN5GOmxkKmblKUKuDaEjj
         tJqi00fXwr9W9l1eDAEJPK122NaDeqKWyJZbLMLxxBx6j7rq/usCIJ+DCGHnXwbQXfAk
         rcoBKqzvRVDMAI+ABaLyzm8E28BwCJNh/ZFX13NWklq12yylCGyQgCYO41c28adrcDUu
         Fju3G6NYCNA/xFrQOs3/OkdmzgXuydlAEppRkP6uh9787uKwC4MiHRJPXP9cnLGF6NRR
         A6rg==
X-Gm-Message-State: AOAM533ygjUUYLW+N18WBRonv1t4aiyCnB0+gSIlXVIWG11kAJAFS8TX
        5hwwoioEwOV524ymCvNTaOjwfBORokb8CgYZPA==
X-Google-Smtp-Source: ABdhPJybwfILFe99lXBifqW5iw2cLCWEzWjRS0cwJ+NP2ueNhNCk6av7UDI29nA9alC0A/gvVVvSsPzjZnimDM/y9ZE=
X-Received: by 2002:a5e:c609:: with SMTP id f9mr23831527iok.41.1607420616820;
 Tue, 08 Dec 2020 01:43:36 -0800 (PST)
MIME-Version: 1.0
References: <1607419304-26140-1-git-send-email-kernelfans@gmail.com> <0f230af42ff4c6e4cf763b9145fb9487@kernel.org>
In-Reply-To: <0f230af42ff4c6e4cf763b9145fb9487@kernel.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 8 Dec 2020 17:43:25 +0800
Message-ID: <CAFgQCTuVortG9FgAA+Ximo1zcAfTLK5vpZMWap=ZZA8Tp=yQsg@mail.gmail.com>
Subject: Re: [PATCH] arm64/irq: report bug if NR_IPI greater than max SGI
 during compile time
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 5:31 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-12-08 09:21, Pingfan Liu wrote:
> > Although there is a runtime WARN_ON() when NR_IPR > max SGI, it had
> > better
> > do the check during built time, and associate these related code
> > together.
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/arm64/kernel/smp.c                | 2 ++
> >  drivers/irqchip/irq-gic-v3.c           | 2 +-
> >  drivers/irqchip/irq-gic.c              | 2 +-
> >  include/linux/irqchip/arm-gic-common.h | 2 ++
> >  4 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 18e9727..9fc383c 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/kernel_stat.h>
> >  #include <linux/kexec.h>
> >  #include <linux/kvm_host.h>
> > +#include <linux/irqchip/arm-gic-common.h>
> >
> >  #include <asm/alternative.h>
> >  #include <asm/atomic.h>
> > @@ -76,6 +77,7 @@ enum ipi_msg_type {
> >       IPI_WAKEUP,
> >       NR_IPI
> >  };
> > +static_assert(NR_IPI <= MAX_SGI_NUM);
>
> I am trying *very hard* to remove dependencies between the architecture
> code and random drivers, so this kind of check really is
> counter-productive.
>
> Driver code should not have to know the number of IPIs, because there is
> no requirement that all IPIs should map 1:1 to SGIs. Conflating the two

Just curious about this. Is there an IPI which is not implemented by
SGI? Or mapping several IPIs to a single SGI, and scatter out due to a
global variable value?

Thanks,
Pingfan

> is already wrong, and I really don't want to add more of that.
>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
