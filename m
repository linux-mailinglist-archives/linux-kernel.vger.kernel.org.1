Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B0A29AB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899659AbgJ0MQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899633AbgJ0MQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:16:10 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889B324677;
        Tue, 27 Oct 2020 12:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603800969;
        bh=rHy7m3RuiJVB+20ux7B22H/jeahOgDzJQVxUUqsPONE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nnslobMGiXfBKFGnGsYxOuqPAeWLHs9VXT5qE++xWWTVdGmCplAti2v3iFFzFaPmh
         Aw2AlXxRpu2V1H8IMkogfIpWAvF+1iZ4KdGcyGqB3Mdx5Q8hdz0p0oleDQMcwMkW7I
         Tm3oL/qRKuH7Eee2jicv4D49KxzNLOagtRWKlDNQ=
Received: by mail-oo1-f52.google.com with SMTP id n2so268401ooo.8;
        Tue, 27 Oct 2020 05:16:09 -0700 (PDT)
X-Gm-Message-State: AOAM5302FloAnbSnrVnjFibVSewxkGq+XY0OOAffVn2uXawmEJJuSnL9
        MyYhwfcr0sycV4BZwbdjNuT8yqffpH/Hpu/i9g==
X-Google-Smtp-Source: ABdhPJwWNPIQlF6Bp7SJfw0BWlotFu1Nk1SaBiaHNR8Jk/NmGn35wJqO0jl1Ihg5ANtyL/n3D9IZ22eRLIBU/rPXk3E=
X-Received: by 2002:a4a:d453:: with SMTP id p19mr1528328oos.50.1603800968782;
 Tue, 27 Oct 2020 05:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201021102855.18026-1-a.fatoum@pengutronix.de>
 <20201026143656.GA118160@bogus> <23e423ba-25f2-c3ed-ea65-2c2d86ae9522@pengutronix.de>
In-Reply-To: <23e423ba-25f2-c3ed-ea65-2c2d86ae9522@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Oct 2020 07:15:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL8sjw1o6PzCSRM9FtRx7XLDQg2bWXxo4Yw5t6fnroudw@mail.gmail.com>
Message-ID: <CAL_JsqL8sjw1o6PzCSRM9FtRx7XLDQg2bWXxo4Yw5t6fnroudw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: stm32: add simple-mfd compatible
 for tamp node
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Christophe Roullier <christophe.roullier@st.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 4:30 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Rob,
>
> On 10/26/20 3:36 PM, Rob Herring wrote:
> > On Wed, Oct 21, 2020 at 12:28:55PM +0200, Ahmad Fatoum wrote:
> >> The stm32mp1 TAMP (Tamper and backup registers) does tamper detection
> >> and features 32 backup registers that, being in the RTC domain, may
> >> survive even with Vdd switched off.
> >>
> >> This makes it suitable for use to communicate a reboot mode from OS
> >> to bootloader via the syscon-reboot-mode binding. Add a "simple-mfd"
> >> to support probing such a child node. The actual reboot mode
> >> node could then be defined in a board.dts or fixed up by the bootloader.
> >
> > 'simple-mfd' implies there is no dependency on the parent node for the
> > child (such as the regmap perhaps). Is that the case here?
>
> No, there's a dependency and the Linux driver does syscon_node_to_regmap
> on the device tree node's parent but that's how the syscon-reboot-mode binding
> is documented:
>
>   The SYSCON mapped register is retrieved from the
>   parental dt-node plus the offset. So the SYSCON reboot-mode node
>   should be represented as a sub-node of a "syscon", "simple-mfd" node.
>
> How would you prefer this being done instead?

Well, probably the syscon driver could just probe any children, but
I'm not sure if that would break anyone. So I guess fine as-is.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
