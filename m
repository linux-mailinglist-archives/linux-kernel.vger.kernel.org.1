Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8816226BF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgIPIWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgIPIWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:22:51 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF0C06174A;
        Wed, 16 Sep 2020 01:22:50 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id y5so5915532otg.5;
        Wed, 16 Sep 2020 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pf/0VysCKn4ocbuOhB2ODSL1UWcYH0XOwCAhzG/Ewyw=;
        b=m4eken512+wW+EooahqTF+CX9zmTxdBE6W+4Y2uyXc+1VoERScgQNadPSqswhfTgA/
         SPqIgm+DjVimnqRmRL5rLXBcsJkfESGhqxOHj/1w9edamq4LHjXAS4nf3jT3EH//3X2u
         3SUO1oozbJ0MxfXWsov4iiDG5yoaWupQ+vC7otELtJOym29wzZYr028Jqc3sqM2BWvUn
         GgKNJt+Q/OabZSdo5PU41CeCF77W2UwMKwuU+4n4kh8u61+j0lbO4USe4k9Q0PIRjm5r
         pmicUEPFsIySLz6Ap6WTzu91nZaJAj9ShezKbr/LQkcJFMIvrsia21FemKYiuZ5GIwaD
         Et7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pf/0VysCKn4ocbuOhB2ODSL1UWcYH0XOwCAhzG/Ewyw=;
        b=q/ABgQnJrOmXCRKxDsvgNUBnQK3bH4gen1poeGx9pT8L2+wDTxie5a6+cJ6NoBRaB4
         klE1LWAc9UCBccRApR0b1Pty8lpFQIX+M6Sok5Vfon2j8K60uMz2y2pDOMw+eLWRKdY5
         j4NzMvH1/UcGyumZqfdbr3QnpOgcSiE6gtw4CnOBaZmIcWSzo1rXi9WHyBglW7xx2YBt
         iz5Olu0EpQyxkpUmKUwaKwfc9MVVu9fH6C+GSs3t9geM1+Rn5K/Cz2TerievB4JMovlB
         HkvOa7BqcP2QDMMSI96AwCpd3mURDiPMprbwPhhV0KigoAkA1adUjiYyA+EBteF3ysJU
         ze5A==
X-Gm-Message-State: AOAM530qSCnt6hvIfHmfAOAy0KkEvDzLktY8UHczqJgZ4RFN2mGVGU7m
        rMz1SHzmEBamzdnbBAuawECaPVOSsHLd35hz+f4=
X-Google-Smtp-Source: ABdhPJzzOfrsmpEE/0CL89QPWKSUNdntwA8sI90HLhOjxVAfyISZVa0MwUjlv+AM6ICOkslok5OMKVAXNfmfPFHVBwc=
X-Received: by 2002:a05:6830:1f4d:: with SMTP id u13mr14956323oth.184.1600244568835;
 Wed, 16 Sep 2020 01:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200912125148.1271481-1-maz@kernel.org> <20200912125148.1271481-6-maz@kernel.org>
 <20200912232228.GI3715@yoga>
In-Reply-To: <20200912232228.GI3715@yoga>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 16 Sep 2020 10:22:36 +0200
Message-ID: <CAFqH_51qdmN12TePxV6wgouG2L0wtuwjzd-xjoV9vNS6XdiiJg@mail.gmail.com>
Subject: Re: [PATCH 5/6] irqchip/mtk-sysirq: Allow modular build
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Stultz <john.stultz@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Bjorn Andersson <bjorn.andersson@linaro.org> del dia dg.,
13 de set. 2020 a les 1:25:
>
> On Sat 12 Sep 07:51 CDT 2020, Marc Zyngier wrote:
>
> > Switch the driver to a "hybrid probe" model which preserves the
> > built-in behaviour while allowing the driver to be optionnally
> > built as a module for development purposes.
> >
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>

I've tested this on mt8173 and mt8183, and this time, the patches
didn't break booting on these platforms. For MediaTek, right now, only
makes sense the driver to be built-in as other drivers that use it are
not ready for deferring their probe. So,

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks
  Enric

> > ---
> >  drivers/irqchip/irq-mtk-sysirq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> > index 6ff98b87e5c0..ee45d8f71ec3 100644
> > --- a/drivers/irqchip/irq-mtk-sysirq.c
> > +++ b/drivers/irqchip/irq-mtk-sysirq.c
> > @@ -231,4 +231,6 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
> >       kfree(chip_data);
> >       return ret;
> >  }
> > -IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", mtk_sysirq_of_init);
> > +IRQCHIP_HYBRID_DRIVER_BEGIN(mtk_sysirq)
> > +IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
> > +IRQCHIP_HYBRID_DRIVER_END(mtk_sysirq)
> > --
> > 2.28.0
> >
