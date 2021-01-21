Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03792FEE25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbhAUPLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:11:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732512AbhAUPKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:10:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E03D23A03
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611241803;
        bh=qROoKO9/UG/vj8s16qRWCH+L6gbGotQ08pHtd3lxyFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fnQhHq4p6mcxAz1OE9RUDifi0g7Wt5ZHPcUe7lEDcGsLK7fXSZ2Achjn/AzPjccVm
         9qWi1jYWK2EHhAG/XQKuA3ooXepS+C857hARaQNZLFPZ3vGSdNZsdfoAuvZFyst4zx
         AxLaYa2BubT+/4leXsJ2urb4gTWB6qbFD2Xl7cXY3NZzfBFHW3XtOcfaqXBsNrqZLP
         zr5i66DUR+IRekXpTxdoYR8E+UR5V9xzUu9ybvyujBR5SKJ0UK6DME8oEpHpfSwaqu
         voktq7tpluimX/C2/8IqzRER9FfmnRDZVDnlHVpK28s046BeGWrI6l02uiZ7f/eHhy
         Tm8Lv/6CtstFg==
Received: by mail-ot1-f42.google.com with SMTP id a109so1900199otc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:10:03 -0800 (PST)
X-Gm-Message-State: AOAM532+3wz6g4Yta6gArhJXSxJp03r/51w4VATdFh9dyKMyKEbPCrCq
        K1i3rUH3JagQWBLZU9qOylMwFqt9av3IcPZwj8U=
X-Google-Smtp-Source: ABdhPJydmo1/Incg43hNe8rPCNBBMq4XGxNUcoWHecwxSjJ/6yIdAncHrtnnhoIKPiFOdkEPGOlTR8WqXPgqjINyFHU=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr10773743otq.305.1611241802465;
 Thu, 21 Jan 2021 07:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com> <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com> <71e94b48857cbdd21c5d6bdadf148621@kernel.org>
 <2861E21B-32B9-479E-A5F6-528D021183E6@caramail.com> <7131f110736b8a17c824f39abeeaf711@kernel.org>
In-Reply-To: <7131f110736b8a17c824f39abeeaf711@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Jan 2021 16:09:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0EhemsG45RQSUQ8ON2REAbJuxcpHhMmWn+-GQCgP2t7w@mail.gmail.com>
Message-ID: <CAK8P3a0EhemsG45RQSUQ8ON2REAbJuxcpHhMmWn+-GQCgP2t7w@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 3:10 PM Marc Zyngier <maz@kernel.org> wrote:
> On 2021-01-21 13:34, Mohamed Mediouni wrote:
> >> On 21 Jan 2021, at 14:22, Marc Zyngier <maz@kernel.org> wrote:
> > Because UART access adapters for the new M1 Macs aren=E2=80=99t plentif=
ul
> > at all, I actually use this for development, with iPhones which have
> > much more easy to buy Lightning-to-UART adapters.
> >
> > (That=E2=80=99s why the old implementation is there too)
> >
> > Might be worth splitting the new one to a new commit though...
>
> This series is supposed to cover M1 only, and adding extra support
> as part of it is only likely to make the code harder to review.
>
> I'd rather you focus on a single IPI interface (fast or slow,
> I don't really care). Extra features can come in later.

Agreed. The slow interface is probably easier to start with,
because it avoids hooking into the FIQ, so the FIQ can be
completely decoupled from AIC and just used for the timer.

Maybe there is even a way to use more than one hardware IPI in
the AIC?

       Arnd
