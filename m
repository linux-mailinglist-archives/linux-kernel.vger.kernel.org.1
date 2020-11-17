Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C62B5A65
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgKQHjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKQHjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:39:35 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F64C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 23:39:35 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id 2so18045602ybc.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 23:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=81ys4Af4st2C7XlSsqfW1vjLoryjipiQwkJBYd8Bo1U=;
        b=qPO31PsA3+HYL9IisFSxJrvBZLmIsrkN8o/iV2M3AOUHsepg70/TfKn0eS8qY+TxQi
         ej+Bp4N1qNv+itrMiWmkurTzf8Z0yHtm60c/6Vr6+n8pkDmnynE1F5wCZNqPC1u5dnby
         dKG+hNM5L+uPwAPk+svJaiZT8hQfCH3fqzth6l8+Kr3X4UDCunB9uYtZHUpr/SptrDYH
         ecGWIM01/Up1MhaMoemLFK8FDHIyOFPv2NtqnYz7d3He52aPPKVirz4pdHU4P6OU5nMO
         crL6KY6HYqCEJCYEIYrpuW7c+38mKemrZK3MBpVK8ai3eVskkm6PpFEtf5dlDlTVOoyL
         +UZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=81ys4Af4st2C7XlSsqfW1vjLoryjipiQwkJBYd8Bo1U=;
        b=IOiMbqp9sRj9MmRcNbYE108HlDTPuoISccRkbszKpfadCPw7KYAGwAh9fUYceOBodU
         hNU/MEVtJJP26PyZfYt0b1plWkVQa65mD4Ij7ashx4VQ6MiNys5osOfIdmYpS83izGYP
         vrwdESwJ4kX/1ZAZjj9tptkueM76K+1QVNXSsr+GCAcX7vzlpO2IW1ex+d57fKpqCGAY
         XLO93RlCDQA/ZZADhVaFfuJOUEwxTVB2CuRrJdj9GU0f3w9mpov/lzFU5/5RCXoeiPiY
         eDNFWQ74iGr92abz0zeGyO+9qweoQ+JeLRLY4CgZ6rSKu/daG2M9yUtdO36fyIepFri1
         zBTg==
X-Gm-Message-State: AOAM533oDQuMtyLR5HrmpC6RBEMvJyaKetIIeJ/f2aCfajZ6r6tTLOZa
        +Hlssgwudkgyn92v+q1LmfU2HgMHu3e0a/RXUX72hA==
X-Google-Smtp-Source: ABdhPJzDnZMr2YRtv9cPXx5CTKyXfN/NpaliyWDLrR2posEVPhRIdfPrLI3ancUlJyJxW4OfYDMnCrpcotjbsg0YoZ0=
X-Received: by 2002:a25:e7cd:: with SMTP id e196mr23631737ybh.375.1605598772788;
 Mon, 16 Nov 2020 23:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20200916071950.1493-1-gilad@benyossef.com> <20200916071950.1493-2-gilad@benyossef.com>
 <20200923015702.GA3676455@bogus> <CAOtvUMekoMjFij_xDnrwRj2PsfgO8tKx4Jk6d7C5vq-Vh+boWw@mail.gmail.com>
 <CAOtvUMfAKnodo+7EYx2M4yAvxu_VmxwXNRmgOW=KFWi3Wy7msQ@mail.gmail.com> <CAL_JsqJditVYJ=4K9i11BjoV2ejABnuMbRyLtm8+e93ApUTu9w@mail.gmail.com>
In-Reply-To: <CAL_JsqJditVYJ=4K9i11BjoV2ejABnuMbRyLtm8+e93ApUTu9w@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 17 Nov 2020 09:39:21 +0200
Message-ID: <CAOtvUMdN2NOJ+7g=XnjOyW7W=77OM=d-d69YDk-a-QmO8Wze5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: crypto: update ccree optional params
To:     Rob Herring <robh@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 8:54 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 22, 2020 at 1:18 AM Gilad Ben-Yossef <gilad@benyossef.com> wr=
ote:
> >
> >
> > Hi again,
> >
> > Any opinion on the suggested below?
>
> Sorry, lost in the pile...

No problem at all. I know how it is...


> >
> >
> > On Tue, Sep 29, 2020 at 9:08 PM Gilad Ben-Yossef <gilad@benyossef.com> =
wrote:
> >>
> >>
> >> On Wed, Sep 23, 2020 at 4:57 AM Rob Herring <robh@kernel.org> wrote:
> >> >
> >> > On Wed, Sep 16, 2020 at 10:19:49AM +0300, Gilad Ben-Yossef wrote:
> >> > > Document ccree driver supporting new optional parameters allowing =
to
> >> > > customize the DMA transactions cache parameters and ACE bus sharab=
ility
> >> > > properties.
> >> > >
> >> > > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> >> > > ---
> >> > >  Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 4 +=
+++
> >> > >  1 file changed, 4 insertions(+)
> >> > >
> >> > > diff --git a/Documentation/devicetree/bindings/crypto/arm-cryptoce=
ll.txt b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> >> > > index 6130e6eb4af8..1a1603e457a8 100644
> >> > > --- a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> >> > > +++ b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> >> > > @@ -13,6 +13,10 @@ Required properties:
> >> > >  Optional properties:
> >> > >  - clocks: Reference to the crypto engine clock.
> >> > >  - dma-coherent: Present if dma operations are coherent.
> >> > > +- awcache: Set write transactions cache attributes
> >> > > +- arcache: Set read transactions cache attributes
> >> >

<snip>

> >> > These could also just be implied by the compatible string (and requi=
ring
> >> > an SoC specific one).
> >>
> >> hm... we could do it but this will require us to know (and publicly
> >> acknowledge) of every SoC making use of this piece of hardware design.
>
> That's already a requirement in general. Sometimes we can avoid it,
> but that's cases of getting lucky.
>
> >> There is currently no other part of the driver that needs this.
>
> If your DT is part of firmware, then waiting until adding some driver
> feature or quirk based on a new DT property is too late. Whereas with
> a SoC specific compatible, you can handle any new feature or quirk
> without a DT change (e.g. just a stable kernel update). Some platforms
> may not care about that model, but in general that's the policy we
> follow. Not doing that, we end up with the DWC3 binding.
>
> A fallback compatible is how we avoid updating drivers for every
> single SoC unless needed.

OK, I now better understand what you meant and that does make some
sense and I will defer to your better judgment  about the proper way
to do this.

Having said that, there is still something that bugs me about this,
even just at the level of better understanding why we do things:

Way back when, before DT, we had SoC specific code that identified the
SoC somehow and set things up in a SoC specific way.
Then we introduced DT as a way to say - "hey look, this is how my
busses looks like, these are the devices I have, deal with it" and I
always assumed that this was meant as a way to release us from having
SoC specific setup code.

It seems now potentially every SoC vendor needs to modify not just the
device tree source (which makes sense of course) but also the driver
supporting their platform.
It now looks like we've come a full circle to me :-)

Thanks!
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
