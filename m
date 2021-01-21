Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06112FEAF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbhAUNB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:01:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730328AbhAUNBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:01:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69B2023A00
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611234036;
        bh=zOUmjTvjQhlXVBR+uCOUkYxo/5YaQKWmpamWU0MAFHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TD+WhK5gaLBMydUeK77ZWEe4YC1mV1T0Q6BJ4Ekr4xMdW0SI9sgxUfsVVOzaIL2H+
         i0+jpSftYycNbUsafcMZTdOGsF1Q8G2WXOOOj8mPb6KpNwfhhiDVOc6PxEH9aTfPB1
         y9wFUpphZEwt92K1c0TU3aqYM+V/0o42dUT8gLaYTtCF+RfHLpQs3/Md+kkDXq09Mj
         K1quJts27Dt3MSpoylnKHlH5BDQqUy64Kg+wR8YGtlqVlwpSOJYgpqRCrbZCyJB0Qc
         LFMbaiUIWBYbxRwTrLxhs/QjG12L9M2Ep9SmF7pP1s2eKvk0KNTethN80piU2HzARf
         HGPrBZ2NzFxGQ==
Received: by mail-ot1-f42.google.com with SMTP id k8so1477570otr.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:00:36 -0800 (PST)
X-Gm-Message-State: AOAM5324+ZVtgLJs0P0BND9wH0/U7o4npU3H68pv6tdspTJCmKQrziOY
        Iu8HGvlyl2Q0Nl0ACZEpgq+CSUU4l/JkZuOJe+I=
X-Google-Smtp-Source: ABdhPJzOCtzUf7ZFeL2yzxXslX5TLFUOOJcfbfAGG6M0QVElMOWoobgu655hMG0xg8qBkSm5mRl+iUjHXkYvXMfiqDs=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr10341889otq.305.1611234035653;
 Thu, 21 Jan 2021 05:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com> <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
In-Reply-To: <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Jan 2021 14:00:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3g888Rn=FRaYB80d5ehHA8b9GUZfa0J+D1nXPKkzcpig@mail.gmail.com>
Message-ID: <CAK8P3a3g888Rn=FRaYB80d5ehHA8b9GUZfa0J+D1nXPKkzcpig@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 1:50 PM Mohamed Mediouni
<mohamed.mediouni@caramail.com> wrote:
> > On 21 Jan 2021, at 13:44, Arnd Bergmann <arnd@kernel.org> wrote:
> >> @@ -186,8 +325,11 @@ static int __init apple_aic_init(struct device_no=
de *node,
> >>       if (WARN(!aic.base, "unable to map aic registers\n"))
> >>               return -EINVAL;
> >>
> >> +       aic.fast_ipi =3D of_property_read_bool(node, "fast-ipi");
> >
> > Where is this property documented, and what decides which one to use?
> It=E2=80=99s getting documented in the next patch set.
>
> This property is there to enable support for older iPhone processors
> later on, some of which do not have fast IPI support.
>
> On Apple M1, fast-ipi is always on.

Ok, makes sense. Does fast-ipi mean you cannot use the other mode at
all, or is it just faster as implied by the name? If so, how much faster?

       Arnd
