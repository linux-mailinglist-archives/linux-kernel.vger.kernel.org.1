Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7126BF42
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgIPI1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:26:48 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACB3C06174A;
        Wed, 16 Sep 2020 01:26:46 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w16so7228783oia.2;
        Wed, 16 Sep 2020 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91zh4RimXAEVlpOKUCGDUKoc77/FjASLS3nmPi0RCO8=;
        b=nU3utdsbpOTVLmMNRYLNojwbz8TGY9gJu612u6xFKIBalDKxuxbanLJBgpWSpsoJCi
         n7NarMlAsCwK60CM/1AquzvTJdvcRujw92/K/5EDNcqKThCFqpdXJVgsvjtXE0n6ktZm
         x7I7fHXflkGmWq7uteyBDKOFsU2rVfWn4AiWDyVru8ttXtbg5iTDHYmdOlO3ruLHNL0O
         SyeIrb/tAQ4glQONRp+/UXw0RZBC/PiA0EJ+y9egkpy5I/yrf1KldWYw3+BrJaUi6yLD
         tmbZO0fO9LcGB0q8Klsc+NgDyQ4QfgvtoW5ln44I+H59X3LjRjdQrrC81MwRdiC/N2XV
         q4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91zh4RimXAEVlpOKUCGDUKoc77/FjASLS3nmPi0RCO8=;
        b=SKctX7n3O15Wt2aWFcj60lXvhKB2UW7UAor/oAlo8GagCqpvrbrYJ1SzZjcdNPuOBe
         jOKtvFitak29z5/8CzeB90WPLT4crzzD9ymFkwVlFUGpfz+pC9nEi2qO/K7BhoVhAcZo
         QFhzRaXJ08w0QVEcl29ZJ2z4YEW0md+HjBZzj7nU4e1o8pKs/mkxyfJnOJhNNbjL8+4/
         gl9MH2vLD9LX5s8Nswb7HLCF7/dpPBRJN6eYsvktKEgt4Q2lvctYW70WEB/7ZDz5G6C1
         Pkp09FQct16Ou+TvMXt59lIQD2ryL6wx8d2eEsiILenJT2rjlkmP6qKLrLKI/NuudWKo
         HMOw==
X-Gm-Message-State: AOAM533EUL/3r76w1QhIGuNu+0Gr0ZZJg/nqIbXt/huOh2kY8Pqx32ZC
        V065kW10Z3VUkdUThh4XBDAp/3HEB/DCPJdTg6U=
X-Google-Smtp-Source: ABdhPJy14BRcrFOpKMyzRkdWnrZd8nyOOg8ZdKxIHwRAq6PaHTh0y40U6xBixjCCazylMyxh8o50zDrJ3j+WVgKydBU=
X-Received: by 2002:aca:b48b:: with SMTP id d133mr2447100oif.47.1600244806223;
 Wed, 16 Sep 2020 01:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200912125148.1271481-1-maz@kernel.org> <20200912125148.1271481-5-maz@kernel.org>
 <20200912232203.GH3715@yoga>
In-Reply-To: <20200912232203.GH3715@yoga>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 16 Sep 2020 10:26:34 +0200
Message-ID: <CAFqH_53iWr+KeteGzL3uJnpgWqFezDn=tzD70oUuvSQ+P3A_DQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] irqchip/mtk-cirq: Allow modular build
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
13 de set. 2020 a les 1:26:
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
> >  drivers/irqchip/irq-mtk-cirq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
> > index 69ba8ce3c178..43e880b63ed2 100644
> > --- a/drivers/irqchip/irq-mtk-cirq.c
> > +++ b/drivers/irqchip/irq-mtk-cirq.c
> > @@ -295,4 +295,6 @@ static int __init mtk_cirq_of_init(struct device_node *node,
> >       return ret;
> >  }
> >
> > -IRQCHIP_DECLARE(mtk_cirq, "mediatek,mtk-cirq", mtk_cirq_of_init);
> > +IRQCHIP_HYBRID_DRIVER_BEGIN(mtk_cirq)
> > +IRQCHIP_MATCH("mediatek,mtk-cirq", mtk_cirq_of_init)
> > +IRQCHIP_HYBRID_DRIVER_END(mtk_cirq)
> > --
> > 2.28.0
> >
