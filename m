Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7622F4DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbhAMOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:53:35 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:38516 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbhAMOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:53:29 -0500
Received: by mail-lf1-f46.google.com with SMTP id h205so3154786lfd.5;
        Wed, 13 Jan 2021 06:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=l5ZLL3HVbz3X8xP5ZmbGilDYTblL2ih6VXU4JrkBYVE=;
        b=d+AjSmd312bzQtmQpEPZ8bPKBfXgXS5vOUoQBgVPFpwhKm94vTc1CSOYaZ+N56WuI7
         E0+poT2wwKb9xlJ2udxPhOqlOVltQWNFX/n2Rb1GxichxXyOg8tNKQHTesEPNs0t1i5y
         L3ifX/vHsvwrzpGTRa2WewBSdY5YY5I3AI/nIL7mR+V/ZA8Q9fm/qeC2xSWJJL9QHtUL
         pG/ducgm3T5wwOog2eXLrA6e4Nzb/RtuhvJNelxgs84k0O6RFqL7MbykMXwuIcP2amDT
         nGdXnwvdzrpEwCrMjcPtS3p9yfZpW/d3zc8WiMo6VfUOp1qhfLyRw+1XXuVz2o2+VCoO
         2Kiw==
X-Gm-Message-State: AOAM530Ck/gPlWgdvtShRrrUXASJk0z8+2yq4TjamNDISXefCK0rvVBY
        1AzQABDqxb8LYzPYWrN5WVg=
X-Google-Smtp-Source: ABdhPJxVJAozLF+NK9vI49rngSl80ul7RvHhKpviU+vgCXuE0XnVTsokwh+rPxpgWRga6oaBKmbUeA==
X-Received: by 2002:ac2:4437:: with SMTP id w23mr1069721lfl.618.1610549566561;
        Wed, 13 Jan 2021 06:52:46 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id 68sm202199ljj.23.2021.01.13.06.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:52:45 -0800 (PST)
Message-ID: <629dbc81badc9facea538733bfa8ddc0842b1df7.camel@fi.rohmeurope.com>
Subject: Re: [PATCH 04/15] dt_bindings: bd71828: Add clock output mode
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-clk@vger.kernel.org
In-Reply-To: <20210113135201.GA2328369@robh.at.kernel.org>
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
         <a91eb6288331bb80b30534a31049cde508307fc0.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
         <20210113135201.GA2328369@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 13 Jan 2021 16:52:42 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2021-01-13 at 07:52 -0600, Rob Herring wrote:
> On Fri, Jan 08, 2021 at 03:34:16PM +0200, Matti Vaittinen wrote:
> > The BD71828 allows configuring the clk32kout pin mode to CMOS or
> > open-drain. Add device-tree property for specifying the preferred
> > mode.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml         | 7
> > +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-
> > pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-
> > pmic.yaml
> > index 3a6a1a26e2b3..cba085836bc0 100644
> > --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> > @@ -44,6 +44,13 @@ properties:
> >    clock-output-names:
> >      const: bd71828-32k-out
> >  
> > +  rohm,clkout-mode:
> > +    description: clk32kout mode. Can be set to "open-drain" or
> > "cmos".
> > +    $ref: "/schemas/types.yaml#/definitions/string"
> > +    enum:
> > +      - open-drain
> > +      - cmos
> > +
> 
> I think a boolean or tristate ((0/1/not present) if you need 'leave 
> default') would be better.

I was thinking of boolean but I hit the exact problem of leaving the
default. (Booleans are so tempting for a lazy coder like me :] ) Do you
mean uint with allowed values of 0/1 with the tristated? I can sure do
that - but wouldn't open-drain / cmos be more descriptive?

Best Regards
	Matti Vaittinen

