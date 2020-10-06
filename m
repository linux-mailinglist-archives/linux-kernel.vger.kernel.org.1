Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7F28460D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 08:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgJFGai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 02:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgJFGah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 02:30:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C352C0613A8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 23:30:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so8435920pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jEZ/PphhBcpGSudk4zYqpeTRIANvOFR8+5eTx3w3Oj8=;
        b=Aewfvkp8uF0ztDFZgaN+wNHZ+BrMN8FsafukdvDenr6aOGB0e523o+WcBp0c95lwqP
         +KPJHrPDL9qUrMzBjOQKC9ReWS8jiHu/ayJ2mu2F5N6qFnnrUe9OAiReWQM9kUzbjGBe
         iX7nl0CIrnIwIhR8ELaSSk/Hhj2FEyP4Z2Q/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEZ/PphhBcpGSudk4zYqpeTRIANvOFR8+5eTx3w3Oj8=;
        b=ANicfWqnJkY1UwqxCMG6uVJg6VYYdki8JMnq9sPwXMNWeKYsdcQBsAYACAJjqTKiik
         D+yiG0u4u8lB7M+5Esxpem14l6vwkfj8G4vV0uB7VI1M2EqjshQhY2+XZ/VFzzQUmQV1
         kwYurTcwlhLxLvotyumBqXi6nrh4IV5BG8V2nBBaaczL4OXREXicv2Ke5QETw+g2U7tu
         DNxFqGtsosTLt3fCeAMRn2bKK0K7+M388PG3yTVWsOobZ6vzbYEb3SHIc991sJXGFJWy
         ibK1uRuAEaf8bW9HX8Txl74iWnFxdNCgtPbbQcpFNulLUJAPsa9c8CwR0DQ8Evey31lX
         nnqA==
X-Gm-Message-State: AOAM533qFfCWvIr/S75x2EzXGPJE2jFT86DPSKeYcKWigFn4NMYU51Hi
        xeq0AADJDE5gOI75Gcr435abG6RpxatMuRtCF+Scdg==
X-Google-Smtp-Source: ABdhPJzyGjwFiX82SqSnhgwuVLIPB0qX8/w2uOnQTTNNakJGClvpNe5x6G6gWDIyv8uvQNMjCiPMVzXhFa0JwutgfSw=
X-Received: by 2002:a63:1a21:: with SMTP id a33mr2837088pga.305.1601965836782;
 Mon, 05 Oct 2020 23:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200923120817.1667149-0-mholenko@antmicro.com>
 <20200923120817.1667149-2-mholenko@antmicro.com> <CAMuHMdWCTg7g=Zu7Wp1Aee9A6Zr+yFguR-szywvm0ObPfH1cwg@mail.gmail.com>
In-Reply-To: <CAMuHMdWCTg7g=Zu7Wp1Aee9A6Zr+yFguR-szywvm0ObPfH1cwg@mail.gmail.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 6 Oct 2020 08:30:24 +0200
Message-ID: <CAPk366RCSrUE=hwk1E0gh-01aa0YPUU78CL7s3c+dZMDiPZxFw@mail.gmail.com>
Subject: Re: [PATCH v11 2/5] dt-bindings: soc: document LiteX SoC Controller bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Sep 25, 2020 at 2:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Mateusz,
>
> On Wed, Sep 23, 2020 at 12:09 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> >
> > Add documentation for LiteX SoC Controller bindings.
> >
> > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Thanks for your patch!

Thanks for your comments!

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +# Copyright 2020 Antmicro <www.antmicro.com>
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/soc/litex/litex,soc-controller.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: LiteX SoC Controller driver
> > +
> > +description: |
> > +  This is the SoC Controller driver for the LiteX SoC Builder.
> > +  It's purpose is to verify LiteX CSR (Control&Status Register) access
>
> Its
>
> > +  operations and provide function for other drivers to read/write CSRs
>
> functions
>
> > +  and to check if those accessors are ready to use.
>
> be used

I will fix the description as suggested.

> > +
> > +maintainers:
> > +  - Karol Gugala <kgugala@antmicro.com>
> > +  - Mateusz Holenko <mholenko@antmicro.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: litex,soc-controller
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    soc_ctrl0: soc-controller@f0000000 {
> > +        compatible = "litex,soc-controller";
> > +        reg = <0xf0000000 0xC>;
>
> Please be consistent w.r.t. lower/upper case: "0xc".

Sure, I will use lowercase everywhere.

> > +        status = "okay";
> > +    };
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Best regards,
Mateusz


--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
