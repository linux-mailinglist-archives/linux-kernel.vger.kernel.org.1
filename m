Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED726D3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIQGlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgIQGlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:41:12 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3870B21974;
        Thu, 17 Sep 2020 06:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600324871;
        bh=gTdZKSX6NgS308trS+0JD2GfHaXkhosgKfxozY4cd/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b1Tl65StLVPpR2Yl3IZ1RY6XfXzE4ybHiRueZCD/PjFAmE76n9BxSME04p87xrnz5
         ZFOSyyjfQCNGGzSj1c8YwUnd+9xcBoyXLuY0gh1pB4EiNsVtwlR0gBZ8mcFoE7eyNj
         w1LgRGpPDO6/nr09+uJkOsiYG2A01bfFirqnNpbU=
Received: by mail-ej1-f46.google.com with SMTP id z22so1625825ejl.7;
        Wed, 16 Sep 2020 23:41:11 -0700 (PDT)
X-Gm-Message-State: AOAM531pK62v6+u6Tg4rjoNiLUv2MVQ2P/VqbEj4BIDWY5pg4OfClLBl
        CtRyOQO3M9pJM1ngjbrDViza/CIcUnW7j4xV964=
X-Google-Smtp-Source: ABdhPJwT9pc66JXvXrI1tZ2stBeP+SeOm2JL4s7jgRmwKi39beZJM27SYqdw3mYmThUvsSUuM1YzS0U/hvcyOvNsbaY=
X-Received: by 2002:a17:906:4046:: with SMTP id y6mr30579927ejj.148.1600324869747;
 Wed, 16 Sep 2020 23:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200908150241.5771-1-krzk@kernel.org> <20200913023152.GH25109@dragon>
In-Reply-To: <20200913023152.GH25109@dragon>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 17 Sep 2020 08:40:57 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeQ8ZV5H4KY3dTacggyNbWxZRJoyMYNwevmTVjZ+bmHfA@mail.gmail.com>
Message-ID: <CAJKOXPeQ8ZV5H4KY3dTacggyNbWxZRJoyMYNwevmTVjZ+bmHfA@mail.gmail.com>
Subject: Re: [PATCH 1/8] ARM: dts: imx6qdl: Correct interrupt flags in examples
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Alifer Moraes <alifer.wsdm@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Sep 2020 at 04:32, Shawn Guo <shawnguo@kernel.org> wrote:
>
> Add Tim who is the board owner.
>
> On Tue, Sep 08, 2020 at 05:02:34PM +0200, Krzysztof Kozlowski wrote:
> > GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> > These are simple defines so they could be used in DTS but they will not
> > have the same meaning:
> > 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> > 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> >
> > Correct the interrupt flags, assuming the author of the code wanted some
> > logical behavior behind the name "ACTIVE_xxx", this is:
> >   ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> The subject prefix could be a bit more specific, like 'ARM: dts:
> imx6qdl-gw5xxx'.  Also, I do not quite understand meaning of 'in
> examples' in subject.

That's my copy-paste error. I'll resend with a proper subject.

Best regards,
Krzysztof
