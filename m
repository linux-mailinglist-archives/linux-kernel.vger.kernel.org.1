Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF132DA40C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgLNXSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:18:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34475 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392636AbgLNXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:18:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id a109so17535096otc.1;
        Mon, 14 Dec 2020 15:18:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PJYZpqISwTWCGFh/9VLQ/JLUDluHBOnC2KCClfM7zXU=;
        b=OmRMAMlrHC0iJOS3ynsY//uc4o0EgAXYplu7Tfp9E2iRqRS6Fye9Zsk4nnBdtTGyNE
         mAQPI5GJerDzPh26M6TFnSTdKtajLL02IzR30XUgneWPJd9lJ4zEVC/ruie/tch/wDWU
         qNMyEno2/B8T7MjOp4Yd++JTBg3KFaXtcbUk5qlJh2pn1re3+GBWHkXAIeRyzqE50JJf
         RrL9CDT3drB1k3tnrOwOGFWaT4rCq2et9Y4TSEGdr6lw/9CyPfAl8o9jEZqC3AnzVXRQ
         8iYH6HYO4jrIaoSFLdsbOiy8WRIgqe42ZuknpnN/Qb8rpcSbOkwIXpUWGkZ6+kHjU1jz
         iqXA==
X-Gm-Message-State: AOAM531m4GkUBWw1k4goQE6T/LAE+kK+WN1BsfRFToqoU97UU5S0p1yk
        MlOocWW1O19WVJrjEV2Aag==
X-Google-Smtp-Source: ABdhPJwEiFtlSuIvxXmWUCQ/IGRxlFX1etWmF/iAnIsRGh3YRDVzq6jGSi1aA/SKqhzG4sRjORnR8w==
X-Received: by 2002:a9d:32b6:: with SMTP id u51mr20523362otb.119.1607987865772;
        Mon, 14 Dec 2020 15:17:45 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n63sm4620242oih.39.2020.12.14.15.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:17:44 -0800 (PST)
Received: (nullmailer pid 2564822 invoked by uid 1000);
        Mon, 14 Dec 2020 23:17:43 -0000
Date:   Mon, 14 Dec 2020 17:17:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20201214231743.GA2560842@robh.at.kernel.org>
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
 <1607704424-16223-2-git-send-email-u0084500@gmail.com>
 <20201214095916.4g47zlueng4wa3hv@holly.lan>
 <CADiBU38wZ+yrfjbggJyY7BHc5-tdV-KWVgWBmZn-q3EY99=PPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU38wZ+yrfjbggJyY7BHc5-tdV-KWVgWBmZn-q3EY99=PPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:40:55PM +0800, ChiYuan Huang wrote:
> Hi,
> 
> Daniel Thompson <daniel.thompson@linaro.org> 於 2020年12月14日 週一 下午5:59寫道：
> >
> > Hi CY
> >
> > On Sat, Dec 12, 2020 at 12:33:43AM +0800, cy_huang wrote:
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Adds DT binding document for Richtek RT4831 backlight.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >
> > This patch got keyword filtered and brought to my attention
> > but the rest of the series did not.
> >
> > If it was a backlight patch series you need to send it To: the
> > all the backlight maintainers.
> >
> Yes, I'm waiting for mfd reviewing.
> Due to mfd patch, I need to add backlight dt-binding patch prior to
> backlight source code.
> Or autobuild robot will said mfd dt-binding build fail from Rob.
> That's why I send the backlight dt-binding prior to the source code.
> 
> I still have backlight/regulator source code patch after mfd reviewing.
> Do you want me to send all the patches without waiting for mfd reviewing?

What happened to the regulator part of the binding? I said you could 
merge it into the mfd schema, not drop it. Bindings should be complete 
so we get a full picture of a device.

Rob
