Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD42B35CB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 16:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgKOPhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 10:37:33 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:56146 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgKOPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 10:37:33 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1keK5j-007CBo-Gz; Sun, 15 Nov 2020 16:37:23 +0100
Date:   Sun, 15 Nov 2020 16:37:23 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com
Subject: Re: [PATCH RFC v1 1/4] dt-bindings: net: dwmac-meson: use
 picoseconds for the RGMII RX delay
Message-ID: <20201115153723.GA1701029@lunn.ch>
References: <20201114200104.4148283-1-martin.blumenstingl@googlemail.com>
 <20201114200104.4148283-2-martin.blumenstingl@googlemail.com>
 <20201114223250.GI1480543@lunn.ch>
 <CAFBinCAmExHsCpP8hh_K6M6pg8SjoF1WNNj9fwSKR3dhgBGJdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCAmExHsCpP8hh_K6M6pg8SjoF1WNNj9fwSKR3dhgBGJdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 10:22:06AM +0100, Martin Blumenstingl wrote:
> Hi Andrew,
> 
> On Sat, Nov 14, 2020 at 11:32 PM Andrew Lunn <andrew@lunn.ch> wrote:
> [...]
> > > +        amlogic,rgmii-rx-delay-ps:
> > > +          default: 0
> > >            description:
> > >              The internal RGMII RX clock delay (provided by this IP block) in
> > > -            nanoseconds. When phy-mode is set to "rgmii" then the RX delay
> > > +            picoseconds. When phy-mode is set to "rgmii" then the RX delay
> > >              should be explicitly configured. When the phy-mode is set to
> > >              either "rgmii-id" or "rgmii-rxid" the RX clock delay is already
> > >              provided by the PHY. Any configuration is ignored when the
> > >              phy-mode is set to "rmii".
> >
> > Hi Martin
> >
> > I don't think the wording matches what the driver is actually doing:
> >
> >         if (dwmac->rx_delay_ns == 2)
> >                 rx_dly_config = PRG_ETH0_ADJ_ENABLE | PRG_ETH0_ADJ_SETUP;
> >         else
> >                 rx_dly_config = 0;
> >
> >         switch (dwmac->phy_mode) {
> >         case PHY_INTERFACE_MODE_RGMII:
> >                 delay_config = tx_dly_config | rx_dly_config;
> >                 break;
> >         case PHY_INTERFACE_MODE_RGMII_RXID:
> >                 delay_config = tx_dly_config;
> >                 break;
> >         case PHY_INTERFACE_MODE_RGMII_TXID:
> >                 delay_config = rx_dly_config;
> >                 break;
> >         case PHY_INTERFACE_MODE_RGMII_ID:
> >         case PHY_INTERFACE_MODE_RMII:
> >                 delay_config = 0;
> >                 break;
> >
> > So rx_delay is used for both rgmii and rgmii-txid. The binding says
> > nothing about rgmii-txid.
> interesting point here. it's been like this before this patch. still I
> would like to understand what the proper way to fix it is so I can
> also include a fix for it:
> 1. should rgmii-txid not add any RX delay on the MAC side? that would
> mean for my board I will switch to phy-mode rgmii so the MAC applies
> both the RX and TX delays
> 2. update the documentation to clarify that rgmii-txid would also add
> the RX delay on the MAC side

Hi Martin

I would fix the documentation.

> that is a good point and also a bug with one of the previous patches
> I'll include a patch fixing this in v2

Thanks for looking at these.

       Andrew
