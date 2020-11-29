Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063C82C7B3F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 21:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgK2U6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 15:58:15 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55908 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgK2U6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 15:58:15 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kjTl8-009Oo3-Cf; Sun, 29 Nov 2020 21:57:26 +0100
Date:   Sun, 29 Nov 2020 21:57:26 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Liu <willy.liu@realtek.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: dts: allwinner: H5: NanoPi Neo Plus2:
 phy-mode rgmii-id
Message-ID: <20201129205726.GQ2234159@lunn.ch>
References: <20201129194512.1475586-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129194512.1475586-1-xypron.glpk@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 08:45:12PM +0100, Heinrich Schuchardt wrote:
> Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx
> delay config") network is broken on the NanoPi Neo Plus2.
> 
> This patch changes the phy-mode to use internal delays both for RX and TX
> as has been done for other boards affected by the same commit.
> 
> Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
