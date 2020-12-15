Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE272DA8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 08:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgLOHxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 02:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgLOHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 02:53:52 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EE1C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 23:53:12 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c133so3955472wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 23:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=foy6ZLeBeEx74vDjfYB0oMy91t0/O4Z6V1trwOXNuTc=;
        b=WbqD6VbDgOEvTKUmuccmA6XZFaIcHkma0n4y+kz3ztDHSRjkHJ38azkM8vkiVRz34Y
         gb3Qra4uFQw8QOeOsJ5Vc+GbmgZ4p2uLJE+iBp0nv9d9V+sWIq3LEp4RFW8JtG2vNLr/
         rLw1+c8Y8z5+phhrlixg2CxlYcd8bFIhnWPkhmxqcHtqBJJYN6U2adl/A2ApTatREWKe
         CRfuOHitaoMLmNGsOJDxZG5W7mO+KgLLpplB8J1n4lmVKETwFx8z9TCEc05NKkyUyNkK
         tEWxtbS1Ru+nwgTnqGaR4zbSuVzXCnQga4Q3uvs/iq9n0xwWlyhTjhVTcVc7GPJ7BT3z
         4bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=foy6ZLeBeEx74vDjfYB0oMy91t0/O4Z6V1trwOXNuTc=;
        b=EKkmBTZum2asRN+GguqEhrD3StiSC4kjrgNA74VJs0NalAKriBUZaR0xKijmIljA4U
         90KUZMuWR9KvGP++VKxoHBL39PO5YGV5hm7P9Gpbudcdles6icOR3GPYJ1EId9JwDsPb
         Qsve491qVGOXt5jFw2R7yPIW5rJTvebl3Wb9ajUwDAIL5pu6KbV6QB3GW0xt1YG/wEda
         3p1bipIiPQeaJy4pZnd6VnWteC+O+fPw8gTwsMbdY28K3r4orsm0b85lZ/djkaSEmoBY
         RxTXdfqZvuIilJPNOoppR4Jqv+SHF6bQkYAgocYge3yUJlVKM0+24ziClkbkhNLWOLPn
         08Iw==
X-Gm-Message-State: AOAM5304O5gjLF+QKv/Q42itIw9qwCMGSTUFvc64KeoKGF92n0MoIGTL
        JLcefYONPGPgusiN/sf7w4d1nwIokvEgucRM
X-Google-Smtp-Source: ABdhPJwBt3cjKcFE7agtObjKVJDNkyO24lD9AHSAoqOLZnucdqAlcrW4uvDffYO+gqX3t7neEtNe+A==
X-Received: by 2002:a1c:8f:: with SMTP id 137mr32189390wma.4.1608018790940;
        Mon, 14 Dec 2020 23:53:10 -0800 (PST)
Received: from dell ([91.110.221.168])
        by smtp.gmail.com with ESMTPSA id i7sm23414157wrv.12.2020.12.14.23.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 23:53:10 -0800 (PST)
Date:   Tue, 15 Dec 2020 07:53:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     ChiYuan Huang <u0084500@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20201215075308.GI5029@dell>
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
 <1607704424-16223-2-git-send-email-u0084500@gmail.com>
 <20201214095916.4g47zlueng4wa3hv@holly.lan>
 <CADiBU38wZ+yrfjbggJyY7BHc5-tdV-KWVgWBmZn-q3EY99=PPg@mail.gmail.com>
 <20201214151409.qdqh2i5hr4g3eboe@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201214151409.qdqh2i5hr4g3eboe@holly.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020, Daniel Thompson wrote:

> On Mon, Dec 14, 2020 at 10:40:55PM +0800, ChiYuan Huang wrote:
> > Hi,
> > 
> > Daniel Thompson <daniel.thompson@linaro.org> 於 2020年12月14日 週一 下午5:59寫道：
> > >
> > > Hi CY
> > >
> > > On Sat, Dec 12, 2020 at 12:33:43AM +0800, cy_huang wrote:
> > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > >
> > > > Adds DT binding document for Richtek RT4831 backlight.
> > > >
> > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > This patch got keyword filtered and brought to my attention
> > > but the rest of the series did not.
> > >
> > > If it was a backlight patch series you need to send it To: the
> > > all the backlight maintainers.
> > >
> > Yes, I'm waiting for mfd reviewing.
> > Due to mfd patch, I need to add backlight dt-binding patch prior to
> > backlight source code.
> > Or autobuild robot will said mfd dt-binding build fail from Rob.
> > That's why I send the backlight dt-binding prior to the source code.
> > 
> > I still have backlight/regulator source code patch after mfd reviewing.
> > Do you want me to send all the patches without waiting for mfd reviewing?
> 
> To some extent it's up to you.
> 
> I think I would have shared all the pieces at once (although not it Lee,
> as mfd maintainer, had suggested otherwise).

You should not need to concern yourself with patch ordering outside
of the realms of the set i.e. [PATCH 1/x], [PATCH 2/x], etc.

If you just send the whole patch set and you do not specify otherwise,
it will be applied, in order, as a set.

Sending subsystem patches without the correct maintainers as recipients
is bad form.  Many of us have filters on, so this tactic will seldom
work in any case.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
