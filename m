Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A142B312E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 23:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKNWc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 17:32:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55664 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgKNWc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 17:32:58 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1ke46E-0075um-ET; Sat, 14 Nov 2020 23:32:50 +0100
Date:   Sat, 14 Nov 2020 23:32:50 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@baylibre.com, narmstrong@baylibre.com, jbrunet@baylibre.com
Subject: Re: [PATCH RFC v1 1/4] dt-bindings: net: dwmac-meson: use
 picoseconds for the RGMII RX delay
Message-ID: <20201114223250.GI1480543@lunn.ch>
References: <20201114200104.4148283-1-martin.blumenstingl@googlemail.com>
 <20201114200104.4148283-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114200104.4148283-2-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 09:01:01PM +0100, Martin Blumenstingl wrote:
> Amlogic Meson G12A, G12B and SM1 SoCs have a more advanced RGMII RX
> delay register which allows picoseconds precision. Deprecate the old
> "amlogic,rx-delay-ns" in favour of a new "amlogic,rgmii-rx-delay-ps"
> property.
> 
> For older SoCs the only known supported values were 0ns and 2ns. The new
> SoCs have 200ps precision and support RGMII RX delays between 0ps and
> 3000ps.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/net/amlogic,meson-dwmac.yaml     | 52 ++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> index 6b057b117aa0..bafde1194193 100644
> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> @@ -74,18 +74,68 @@ allOf:
>              Any configuration is ignored when the phy-mode is set to "rmii".
>  
>          amlogic,rx-delay-ns:
> +          deprecated: true
>            enum:
>              - 0
>              - 2
>            default: 0
> +          description:
> +            The internal RGMII RX clock delay in nanoseconds. Deprecated, use
> +            amlogic,rgmii-rx-delay-ps instead.
> +
> +        amlogic,rgmii-rx-delay-ps:
> +          default: 0
>            description:
>              The internal RGMII RX clock delay (provided by this IP block) in
> -            nanoseconds. When phy-mode is set to "rgmii" then the RX delay
> +            picoseconds. When phy-mode is set to "rgmii" then the RX delay
>              should be explicitly configured. When the phy-mode is set to
>              either "rgmii-id" or "rgmii-rxid" the RX clock delay is already
>              provided by the PHY. Any configuration is ignored when the
>              phy-mode is set to "rmii".

Hi Martin

I don't think the wording matches what the driver is actually doing:

        if (dwmac->rx_delay_ns == 2)
                rx_dly_config = PRG_ETH0_ADJ_ENABLE | PRG_ETH0_ADJ_SETUP;
        else
                rx_dly_config = 0;

        switch (dwmac->phy_mode) {
        case PHY_INTERFACE_MODE_RGMII:
                delay_config = tx_dly_config | rx_dly_config;
                break;
        case PHY_INTERFACE_MODE_RGMII_RXID:
                delay_config = tx_dly_config;
                break;
        case PHY_INTERFACE_MODE_RGMII_TXID:
                delay_config = rx_dly_config;
                break;
        case PHY_INTERFACE_MODE_RGMII_ID:
        case PHY_INTERFACE_MODE_RMII:
                delay_config = 0;
                break;

So rx_delay is used for both rgmii and rgmii-txid. The binding says
nothing about rgmii-txid.

And while i'm looking at the code, i wonder about this:

       if (rx_dly_config & PRG_ETH0_ADJ_ENABLE) {
                if (!dwmac->timing_adj_clk) {
                        dev_err(dwmac->dev,
                                "The timing-adjustment clock is mandatory for the RX delay re-timing\n");
                        return -EINVAL;
                }

                /* The timing adjustment logic is driven by a separate clock */
                ret = meson8b_devm_clk_prepare_enable(dwmac,
                                                      dwmac->timing_adj_clk);
                if (ret) {
                        dev_err(dwmac->dev,
                                "Failed to enable the timing-adjustment clock\n");
                        return ret;
                }
        }

It looks like it can be that rx_dly_config & PRG_ETH0_ADJ_ENABLE is
true, so the clock is enabled, but delay_config does not contain
rx_delay_config, so it is pointless turning it on.

	Andrew
