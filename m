Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6227D573
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgI2SIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgI2SIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:08:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10257C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:08:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so3083012pjd.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RpY12II94GhZux1obQ0BV8Lj0sqJ69KRMrKlaitzPlI=;
        b=stlgmHoQTREWLp0zmktf289kqgC6AMUAk5GE9G/IHZtyXv8FdqnllkYATlpuzSFQTh
         cpoMGi66gxfbYGr8EP1bMU5y5OA17RSR+lzJ/kbTO7uo2wiD05oKc5NtZ/9AF93ULclY
         HiVgh3cYwH8OwrOuIDv0Or3kMuc9NKnz+l5uofAHIL+91eo3LgMhG+CdGBDO0v38nxHV
         K/DQLh2uiSeHekBVIKfYFhJHYJ9yu6bkBKivYjIk8r4i6Ef1uoFf+5kIuYEtoyYuPpbD
         +Ax9LV6D1r8CViqtQqr46cEU2wwxZjFxQo1RnKCWZEx1RSIQHvDogQEtyaHMZVEpIt25
         ihtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RpY12II94GhZux1obQ0BV8Lj0sqJ69KRMrKlaitzPlI=;
        b=kLCq04rOukcg8/VznwqZ24zv3gVfJerxBgpH3G7HHudh8cLm5/yqQcU+k+l6kcIF5/
         O+0b0ZTCtumtjzMEgKOn/66JayM+R8ucKQgrasIY6X/hvZXwPZCKJFp3n04Z0r/5FwVh
         YVFEM8RpCAeFzegdGVPhBSBDjodzGde6OD7T17MhDfwkv59ekHEnpEyThFtO8ijvMwJO
         Y4BqhJCz5nAC0LPqMamcYc82FQTayy1g0hO8VZxJvNdkz4Km8N0v2oZkw97YqwkLvPLW
         ohJ9X2oYRxkBl1zz4WR22WBtN2urvSxnI6cmZBAnSE5KBDUCI8lOoTHgIVbPk+B4QPxW
         yiPw==
X-Gm-Message-State: AOAM533uFz7z8pCRk5IYbq2rMqYSmrIbAVtY9KhIyooof6j75kFnMR/S
        JFMJ8U1/SA2RUlucqnZFTL2+hCWP17890/ruITb+aA==
X-Google-Smtp-Source: ABdhPJzJ/x5xBKqbKvxq2XgXy6Nsp0HjIn+CoyO8Kd30x494FxQS7KkRIzPH3bqG6IqgKOigCMNe3z78HfF/wxyl7DQ=
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr5157521pjr.228.1601402910497;
 Tue, 29 Sep 2020 11:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200916071950.1493-1-gilad@benyossef.com> <20200916071950.1493-2-gilad@benyossef.com>
 <20200923015702.GA3676455@bogus>
In-Reply-To: <20200923015702.GA3676455@bogus>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 29 Sep 2020 21:08:19 +0300
Message-ID: <CAOtvUMekoMjFij_xDnrwRj2PsfgO8tKx4Jk6d7C5vq-Vh+boWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: crypto: update ccree optional params
To:     Rob Herring <robh@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H=D7=9F=D7=AA

On Wed, Sep 23, 2020 at 4:57 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 16, 2020 at 10:19:49AM +0300, Gilad Ben-Yossef wrote:
> > Document ccree driver supporting new optional parameters allowing to
> > customize the DMA transactions cache parameters and ACE bus sharability
> > properties.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> > ---
> >  Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/crypto/arm-cryptocell.tx=
t b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> > index 6130e6eb4af8..1a1603e457a8 100644
> > --- a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> > +++ b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> > @@ -13,6 +13,10 @@ Required properties:
> >  Optional properties:
> >  - clocks: Reference to the crypto engine clock.
> >  - dma-coherent: Present if dma operations are coherent.
> > +- awcache: Set write transactions cache attributes
> > +- arcache: Set read transactions cache attributes
>
> dma-coherent already implies these are 011x, 101x or 111x. In my limited
> experience configuring these (Calxeda SATA and ethernet), writeback,
> write-allocate was pretty much always optimal.

Indeed and these are the default. But not all SoC are born equal and
we got a request to allow setting these.

Maybe instead of numerical values have three possible verbal setting
would be better?


> > +- awdomain: Set write transactions ACE sharability domain (712, 703, 7=
13 only)
> > +- ardomain: Set read transactions ACE sharability domain (712, 703, 71=
3 only)
>
> This probably needs something common. We may need something for Mali,
> too. I don't think different settings for read and write makes much
> sense nor does anything beyond IS or OS.

I agree. Maybe

sharability_domain: either "IS" or "OS"?

>
> These could also just be implied by the compatible string (and requiring
> an SoC specific one).

hm... we could do it but this will require us to know (and publicly
acknowledge) of every SoC making use of this piece of hardware design.
There is currently no other part of the driver that needs this.

Gilad




--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
