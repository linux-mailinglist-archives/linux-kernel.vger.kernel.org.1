Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1E9293582
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404845AbgJTHHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404740AbgJTHHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:07:37 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E643CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:07:36 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 184so806294lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8McS5lbaBCf5JTK6wcTtTbcIkoyUi8hMk2YmNfJw8M=;
        b=e1Y8DGWy8PvUo/hwsGgNr/SxdVXPOv2DnsuZU21mBVE0a25+BM9fRGatglVVPp9dE7
         Lj1eLuXIUt6uQviUNHRz8UMfE7RvzoKm4fQ0fvZxduLALc0et0o6Z+aLVK+Kdg5Xgj9Q
         28dFK/a8fFtDoZwXlcR7MoOwy2Efmluo1+anAYmYnGchJFYr4fdJUQVVzVrFVp+F/gfB
         7UIUFT/uaTidTjc+5wmTzbtkd35BESS4VV6UbgNlcqV4/YHG+1LR39Dtr/GQ8up7Oq7a
         o/0XT1U70IqMREyAVcpkU7ZCRhNWbcYcdAcWvdVSYbFYo/y8aCFSYswwyFbA1P7L4whR
         SpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8McS5lbaBCf5JTK6wcTtTbcIkoyUi8hMk2YmNfJw8M=;
        b=R+Ggqimx87SVNPjcDoz/a+K/a8VvNNhLMD2SzXDyqhipXfBTJeq8A0YTELqPDmD1rn
         ZLTGjT/1r157NMR+lviGhokcgV1xUvsl001531MO+zbxmZcpXeHxd1Wue30ubFpn3QVp
         bGDTU3C/ICzS+wYICLp7RCl6+1XlwCkWBihTnDkT+nad75X10zcyC8VDt3txndw/NC1d
         tR0tNlFDoKzRY7ijf9alsiA6AuQC5lstsTI/eBQJZqymiu14n7X01cC8DSjj1Jw3dECe
         Cz/UdFf+Hw/3P1RCO7pzhkf/dYtRTAbHfe73smi6ijzgd/YivXrL1eJ1NRlI9Qk9J8dl
         oV1g==
X-Gm-Message-State: AOAM533vkkAgUJ4m+p8fzoQzYwTs7rFJS5j/axWAtDW9IRZE6vsEMlDI
        JfExrmNDb2pUJO5SmZZeXxbm1nmAABdAFssYLiFYBw==
X-Google-Smtp-Source: ABdhPJze6CEfoi8/vvii5B8d0+u1FpywdGMBPFXjnDIeIpd5UubkRRY//yghku8Ufl5i5OH4rN/5B3WrTxn8dIcS/Dk=
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr465214lfg.419.1603177655367;
 Tue, 20 Oct 2020 00:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org> <b366c68fe0b365892aa4324be90235d6@kernel.org>
In-Reply-To: <b366c68fe0b365892aa4324be90235d6@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 20 Oct 2020 12:37:24 +0530
Message-ID: <CAFA6WYN18oe9143offQ1V5RwnYZmvy29vPR0SKFtpkdOePezsQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] arm64: Add framework to turn IPI as NMI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Oct 2020 at 17:26, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-14 12:12, Sumit Garg wrote:
> > Introduce framework to turn an IPI as NMI using pseudo NMIs. In case a
> > particular platform doesn't support pseudo NMIs, then request IPI as a
> > regular IRQ.
> >
> > The main motivation for this feature is to have an IPI that can be
> > leveraged to invoke NMI functions on other CPUs. And current
> > prospective
> > users are NMI backtrace and KGDB CPUs round-up whose support is added
> > via future patches.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/include/asm/nmi.h | 16 +++++++++
> >  arch/arm64/kernel/Makefile   |  2 +-
> >  arch/arm64/kernel/ipi_nmi.c  | 77
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 94 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/include/asm/nmi.h
> >  create mode 100644 arch/arm64/kernel/ipi_nmi.c
>
> [...]
>
> > +     irq_set_status_flags(ipi, IRQ_HIDDEN);
>
> Another thing is this. Why are you hiding this from /proc/interrupts?
> The only reason the other IPIs are hidden is that displaying them as
> "normal" interrupts would be a change in userspace ABI.
>
> In your case, this is something new that can perfectly appear as
> a standard interrupt (and I don't see how you'd display the
> statistics otherwise).

Makes sense. I will remove this flag for this IPI so that it can be
displayed as a standard interrupt.

-Sumit

>
>          M.
> --
> Jazz is not dead. It just smells funny...
