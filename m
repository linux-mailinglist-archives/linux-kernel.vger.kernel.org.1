Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852BE296D70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462849AbgJWLQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:16:38 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34846 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462757AbgJWLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:16:37 -0400
Received: by mail-ej1-f65.google.com with SMTP id p5so1860069ejj.2;
        Fri, 23 Oct 2020 04:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I7tXxZpGoreg85HA0VUxkudPh8npM8uC5nLxLgLNurw=;
        b=cM3Z4sytLTIjLxEXkNvyBil5R8nHzT/o2Yat1OZfrvDefqeNUpfdDlillmtt+lCgR/
         KDxKxbPrKWl5elWiA30ol7GPxUCCxoek/zC/qGugbGIB5G00Xg8ySmCeMjxMJ1R9N1L7
         BoXRjDclAga4WhMmgqCFgjTKYWwfX+yXI6YtU8bJ+IrrvFMy6yJOVAwMhFN7B3uFTPOM
         XlhWSojXPM+nzCVa4ypWaIBUG2e21dXTirZ5D5MvgjSuzQNGzE6VxZD/h4RMXCx7HAP3
         0ODXZ6CuBiMiDSuReGbo+hPxuz96UMrxmnv1e5iI7NYtbgPkzF2LILErWSVMpfWq9JEB
         yJOQ==
X-Gm-Message-State: AOAM5338zadOGz07tyZRCLrstk127x5qDgCjq05GOkistM7gqxQVpo7/
        0aRaC0satQ0jByGWtkcNusI=
X-Google-Smtp-Source: ABdhPJzoA3+2dyw0HIdiALYHcsoNfM039rsAqi/Wc+Hi2TMGcbUlUhwbDTGeU1VWf0IsmpGbG0mD6Q==
X-Received: by 2002:a17:906:a04c:: with SMTP id bg12mr1373658ejb.317.1603451795423;
        Fri, 23 Oct 2020 04:16:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id ao17sm666245ejc.18.2020.10.23.04.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 04:16:34 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:16:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx: Add Beacon i.MX8M Nano development kit
Message-ID: <20201023111632.GB48162@kozik-lap>
References: <20201022165751.771695-1-aford173@gmail.com>
 <20201023094437.GB42872@kozik-lap>
 <CAHCN7xKLgNvMJP9YoP1eQa_f3-GLNj3ZSuvJA9RcF4OJufHhgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7xKLgNvMJP9YoP1eQa_f3-GLNj3ZSuvJA9RcF4OJufHhgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:51:56AM -0500, Adam Ford wrote:
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> > > new file mode 100644
> > > index 000000000000..faa55d888065
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> > > @@ -0,0 +1,19 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > +/*
> > > + * Copyright 2020 Compass Electronics Group, LLC
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "imx8mn.dtsi"
> > > +#include "imx8mn-beacon-som.dtsi"
> > > +#include "imx8mn-beacon-baseboard.dtsi"
> >
> > Why do you need baseboard as DTSI? Is is separate than kit? Judging by
> > contents look like just empty/fake DTS and the baseboard should be the
> > DTS.
> >
> > Another hint: Baseboard also does not have its compatible, so it cannot
> > exist in real life separate from the development kit...
> 
> The baseboard can handle two separate, mutually exclusive video
> outputs. It has a LVDS bridge chip and an HDMI bridge chip, but
> without the DSI and LCDIF support, neither can function.
> Right now, that LVDS chip doesn't have an upstream driver, but I plan
> to introduce it once the LCDIF, and DSI interfaces are available and
> functional.
> 
> Once there is video support, the kit-level DTS file will get support
> for one of the video outputs, and a second DTS file will get created
> to support the other.  Both of these kit-level files would include the
> baseboard and SOM DTSI files since they would be common to both kits.

Sounds good.

> 
> > > +
> > > +/ {
> > > +     model = "Beacon EmbeddedWorks i.MX8M Mini Development Kit";
> > > +     compatible = "beacon,imx8mn-beacon-kit", "fsl,imx8mn";
> >
> > Undocumented compatible.
> 
> I am still trying to learn the YAML rules.  Do I just add it to the
> fsl.yaml?  'beacon' is in the vendor-prefixes, but I looked and the
> 'imx8mm-beacon-kit' which is already in the kernel doesn't have a
> compatible either and they are virtually identical.

Enough will be adding it to the fsl.yaml. There is no strict need for
separate compatible for baseboard, although that's quite common practice
since you want to reuse it.

The beacon,imx8mm-beacon-kit is in fsl.yaml, so you can just duplicate
for imx8mn.

Best regards,
Krzysztof

