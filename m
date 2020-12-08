Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41F12D2857
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgLHKBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLHKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:01:04 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD1C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 02:00:24 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id i9so16392576ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 02:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eenPMKZFIvKxHs8p+z8DXTbTMPPBle9331ck5pciU80=;
        b=bBDlyv2qSZUEWjQuOSkhL2I7jBbgzltH8brFYzzNclfrlVParEemmX0evih924F3/q
         cmb6B3J03cRJKK95KI4JrEqz+7GqBLyv/oXyJEp3wsLOqC9u7sMiOPyFaWXPXoyecj4r
         txWkKNL49fd8PM5JDnXfBZM9BOlC0TxkYyCFjDzjOH7Z8so6BAzpfDXUgHjs2crf9W4g
         2/jN94Sf7/xRx5dWhCdBaed5L0rPFQl4CWau2UGjnJR36h/hCgNBsmuEw1wIFpbsUk1y
         Jph+1OUa/6caOYI/rg1hvDwhZZ5NjO27TO2sTiO/Ujs2q9bilJWT6S7Lt2dqxKoUGPM3
         36jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eenPMKZFIvKxHs8p+z8DXTbTMPPBle9331ck5pciU80=;
        b=pLBq7iA4lqcji1v/4WxLKDypOmbmlpcODmYLBE1vTo4dM1oQPCOsyp3wMAIUl6/Tlx
         a/QOca0u8wHD5PY4W6hgm4UMj9OX9DHVX+raVGD820SDvJdXS/ypr7xdSA0gRQ30Iv/L
         NsJtoUx8BdKu4e2sRPA3lwb9f3xGXX57oVl0aj5GJwNmODIcwwMd7QntwHw5P7LZdOeq
         ltnG/pGiTVjNA9x1hQxBM+PjQi9clXFeRtXdaZfHDWfnhjaCXoPX7fDj+OwZ/S+AnnXq
         fbVLpvjzmxzJ/oOn+uNTiraH7LmzA1GRfCoT5qxydUpOrcO9CKmUtosv/fEgcuM+jxPw
         7L6w==
X-Gm-Message-State: AOAM531HkIySToPNwO0b38q7vcOHC5qjH6LhpnB0b9qUDIOKRw6Oyh22
        xMUcrxuXXKNI2DPp2lstlRqi8Ac2CZ+tGNWhzw==
X-Google-Smtp-Source: ABdhPJz8l5jcgM4AiD08klQNZ2GrQJEFPsaBT50M2qgzqwaKJhcYQPMMtCyvKsHEWbfYfLbxyCM6uwWG1yox/giGJsQ=
X-Received: by 2002:a02:488:: with SMTP id 130mr18446065jab.39.1607421624025;
 Tue, 08 Dec 2020 02:00:24 -0800 (PST)
MIME-Version: 1.0
References: <1607419304-26140-1-git-send-email-kernelfans@gmail.com>
 <0f230af42ff4c6e4cf763b9145fb9487@kernel.org> <CAFgQCTuVortG9FgAA+Ximo1zcAfTLK5vpZMWap=ZZA8Tp=yQsg@mail.gmail.com>
 <867be4df47247f8c56687cf2046ee7bb@kernel.org>
In-Reply-To: <867be4df47247f8c56687cf2046ee7bb@kernel.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 8 Dec 2020 18:00:12 +0800
Message-ID: <CAFgQCTtWhZoTyCP1ByrAhHrkWX=V49pQjPYeLVvv=bhT63Ekmw@mail.gmail.com>
Subject: Re: [PATCH] arm64/irq: report bug if NR_IPI greater than max SGI
 during compile time
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 5:51 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-12-08 09:43, Pingfan Liu wrote:
> > On Tue, Dec 8, 2020 at 5:31 PM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-12-08 09:21, Pingfan Liu wrote:
> >> > Although there is a runtime WARN_ON() when NR_IPR > max SGI, it had
> >> > better
> >> > do the check during built time, and associate these related code
> >> > together.
> >> >
> >> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> > Cc: Will Deacon <will@kernel.org>
> >> > Cc: Thomas Gleixner <tglx@linutronix.de>
> >> > Cc: Jason Cooper <jason@lakedaemon.net>
> >> > Cc: Marc Zyngier <maz@kernel.org>
> >> > Cc: Mark Rutland <mark.rutland@arm.com>
> >> > To: linux-arm-kernel@lists.infradead.org
> >> > Cc: linux-kernel@vger.kernel.org
> >> > ---
> >> >  arch/arm64/kernel/smp.c                | 2 ++
> >> >  drivers/irqchip/irq-gic-v3.c           | 2 +-
> >> >  drivers/irqchip/irq-gic.c              | 2 +-
> >> >  include/linux/irqchip/arm-gic-common.h | 2 ++
> >> >  4 files changed, 6 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> >> > index 18e9727..9fc383c 100644
> >> > --- a/arch/arm64/kernel/smp.c
> >> > +++ b/arch/arm64/kernel/smp.c
> >> > @@ -33,6 +33,7 @@
> >> >  #include <linux/kernel_stat.h>
> >> >  #include <linux/kexec.h>
> >> >  #include <linux/kvm_host.h>
> >> > +#include <linux/irqchip/arm-gic-common.h>
> >> >
> >> >  #include <asm/alternative.h>
> >> >  #include <asm/atomic.h>
> >> > @@ -76,6 +77,7 @@ enum ipi_msg_type {
> >> >       IPI_WAKEUP,
> >> >       NR_IPI
> >> >  };
> >> > +static_assert(NR_IPI <= MAX_SGI_NUM);
> >>
> >> I am trying *very hard* to remove dependencies between the
> >> architecture
> >> code and random drivers, so this kind of check really is
> >> counter-productive.
> >>
> >> Driver code should not have to know the number of IPIs, because there
> >> is
> >> no requirement that all IPIs should map 1:1 to SGIs. Conflating the
> >> two
> >
> > Just curious about this. Is there an IPI which is not implemented by
> > SGI? Or mapping several IPIs to a single SGI, and scatter out due to a
> > global variable value?
>
> We currently have a single NS SGI left, and I'd like to move some of the
> non-critical IPIs over to dispatching mechanism (the two "CPU stop" IPIs
> definitely are candidate for merging). That's not implemented yet, but
> I don't see a need to add checks that would otherwise violate this
> IPI/SGI distinction.

Got it. Thanks for your detailed explanation.

Regards,
Pingfan
