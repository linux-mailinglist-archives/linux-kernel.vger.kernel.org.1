Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308F927D008
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgI2N4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgI2N4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:56:20 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A63121531;
        Tue, 29 Sep 2020 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601387780;
        bh=uRJnlxyDIqK1z0xXEQyA0WTBRacwx7hXWOOlHUk7db8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=owyxPAUUGklTGXbl9zzQmLxVPE6CKVkrTZntI27qfpCMh/Cr8YtrB82pi8hfW1y7/
         7LYjgghWALjXNhMPKoos3YBmO2VJTCDC1KNZgoi/RgrkKoeWpx1rUAagjFYsdYVKY9
         a2MkVT/H3ebKkcNFbYLidoIqOiS0iUmpEsqJM+rQ=
Received: by mail-oi1-f169.google.com with SMTP id v20so5556693oiv.3;
        Tue, 29 Sep 2020 06:56:20 -0700 (PDT)
X-Gm-Message-State: AOAM530ebxF3wwsn6Zm08N46KZzzTQyKF+QWe8RVBvb9O0pdl7j4g3TW
        52iuzBXsGB3itgoVg4triAdFYUvA//+aXiCJ8w==
X-Google-Smtp-Source: ABdhPJyZwlJWIDEVgF/lxBVWBxEh8NZUj9WkweYpi7M6hWCdX840Y3vhe88h8a44y5ld4Bh1pVSLqF/8s8tezFZzpYw=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr2734685oie.152.1601387779028;
 Tue, 29 Sep 2020 06:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200928063950.64722-1-chunfeng.yun@mediatek.com>
 <20200928181247.GA3008733@bogus> <1601359599.29336.49.camel@mhfsdcap03>
In-Reply-To: <1601359599.29336.49.camel@mhfsdcap03>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Sep 2020 08:56:07 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+UxJAGv4+om1BFAJbq1VETnY4UvpqgGs3mSP8e1kkFmQ@mail.gmail.com>
Message-ID: <CAL_Jsq+UxJAGv4+om1BFAJbq1VETnY4UvpqgGs3mSP8e1kkFmQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: add properties for hard wired devices
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 1:09 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Mon, 2020-09-28 at 13:12 -0500, Rob Herring wrote:
> > On Mon, Sep 28, 2020 at 02:39:50PM +0800, Chunfeng Yun wrote:
> > > Add some optional properties which are needed for hard wired devices
> > >
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >  Documentation/devicetree/bindings/usb/usb-hcd.yaml | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > > index 7263b7f2b510..1194a82887e7 100644
> > > --- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > > @@ -22,6 +22,17 @@ properties:
> > >      description:
> > >        Name specifier for the USB PHY
> > >
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 0
> > > +
> > > +patternProperties:
> > > +  "^hub|device@[0-9a-f]+$":
> >
> > Could be any class of device, so '@[0-9a-f]+$'
> You mean we will use different standard node name for each usb class?
> e.g.
> Use 'ethernet@*' for a usb ethernet adapter, and use 'camera@*' for a
> usb camera sensor?

Yes.

> > > +    type: object
> > > +    description: The hard wired USB devices. See usb/usb-device.txt
> >
> > Ideally, we'd convert usb-device.txt to schema and reference it here.
> Ok, I'll try to do it.
>
> BTW: Does the compatible support pattern? Is there any example I can
> refer to?

Yes, use 'pattern' keyword.

Rob
