Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042C22EFD2E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbhAICtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbhAICtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:49:36 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B05C061573;
        Fri,  8 Jan 2021 18:48:55 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id h3so4642483ils.4;
        Fri, 08 Jan 2021 18:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QxjVHH/k2EEheDURmsY7RVs3TpbxjnXeiCn/55GgY8=;
        b=jv3Exx/ZPs37gY4yPcfBCzxcInUqxq76J3hRtGGDgHlB5Gjkcl+9go8ek7xlMjTR24
         btCZGxszuFYXAevC0wWj/wXyyNTz1HiQcZoj6VIXamk62ayhc+A30jsGKGvlba5pdtzS
         d/E4ALC0YWHS0MqHIB0MBeFfORXafXUYt+vGd32LGGZhCTNaGJFwb7Cnvra2R+JA86A4
         tjWqX8YNe2f/E3D7A6oN1flOeLbWdWgi/nf744o/PkVh9yWe2ItHibMjjZTi4Tka41pq
         zF0I+xAlj+Up5NIlq2USP/qxqgwpVP3wmLA6ekNP4EL1zOGQ4ZMCn3vd9EKeVmwzwyVx
         v75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QxjVHH/k2EEheDURmsY7RVs3TpbxjnXeiCn/55GgY8=;
        b=JahkpEjxTT36rvo7KKkBKL5/N2CSt/tBizqXR8JFqZWwiElcEIlHkncpPW37+MsKqy
         sC7ATFweTFPBme4Nri5ecpQRF2Q/bMGqRhk3V3wmfyaKMNUaWOeOdPl7/ZuCAMPlKTbR
         IpT65rgmMuJxB/z11c7Bqc0r8LA/D3jNgv2DMzbcqCSXBG0IAgViLop7rw/FN9YGify+
         +7qiCRSkKA530tn9pu8xWUR1OL8lCcc0/begrJ4Wdi1/TO6mrVngFJdEaldrdRYZZ2QH
         voIP52u1k9z2/bAkCPoaEqSJK1D5/tk1Yp3clCjcExJ0BxukQe9/yKfdU860GXbhri+Y
         XSwA==
X-Gm-Message-State: AOAM531G/7aaQWlP/OWPoFQ92jHYeQnU2DDKV74dzrFRt4OaSxpfZrL0
        RiKL2khXWKvbOzCyWDPiw9wPPrq9Tn0oiZjjhaI=
X-Google-Smtp-Source: ABdhPJxS+9A57zLwR8bsRSnfqQl46R/uDEFOCJ8/ycwNV+IYQdMu9xqsIA8C2sOBHOQlxrCbPQwOWS7582sgHxIs+K8=
X-Received: by 2002:a92:c081:: with SMTP id h1mr6487153ile.46.1610160534190;
 Fri, 08 Jan 2021 18:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20210106173900.388758-1-aford173@gmail.com> <833e228f-6fb5-ae98-a367-9566cf5fcf69@lucaceresoli.net>
In-Reply-To: <833e228f-6fb5-ae98-a367-9566cf5fcf69@lucaceresoli.net>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 8 Jan 2021 20:48:42 -0600
Message-ID: <CAHCN7x+57x4WLbq0+7OCPhJs-1=7SJidVHD2jYjdbqn_F+d3dA@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: clk: versaclock5: Add load capacitance properties
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 4:49 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Adam,
>
> On 06/01/21 18:38, Adam Ford wrote:
> > There are two registers which can set the load capacitance for
> > XTAL1 and XTAL2. These are optional registers when using an
> > external crystal.  Update the bindings to support them.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  .../devicetree/bindings/clock/idt,versaclock5.yaml   | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > index 2ac1131fd922..e5e55ffb266e 100644
> > --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > @@ -59,6 +59,18 @@ properties:
> >      minItems: 1
> >      maxItems: 2
> >
> > +  idt,xtal1-load-femtofarads:
>
> I wonder whether we should have a common, vendor independent property.

That would be nice.

> In mainline we have xtal-load-pf (ti,cdce925.txt bindings) which has no
> vendor prefix. However I don't know how much common it is to need

rtc-pcf85063.c uses  quartz-load-femtofarads, so there is already some
discrepancy.

Since the unit of measure here is femtofarads, using pF in the name seems wrong.
We need to read the data as a u32, so femtofarads works better than
pF, which would require a decimal point.

> different loads for x1 and x2. Any hardware engineer around?

I talked to a hardware engineer where I work, and he said it makes
sense to keep them the same.  I only separated them because there are
two registers, and I assumed there might be a reason to have X1 and X2
be different, but I'm ok with reading one value and writing it to two
different registers.

adam
>
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 9000
> > +    maximum: 25000
> > +    description: Optional loading capacitor for XTAL1
>
> Nit: I think the common wording is "load capacitor", not "loading
> capacitor".
>
> --
> Luca
