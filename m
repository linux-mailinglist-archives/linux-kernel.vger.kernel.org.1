Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F81BAE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 21:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgD0Tmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 15:42:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46476 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgD0Tmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:42:49 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jT9eR-00008e-D4; Mon, 27 Apr 2020 21:42:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: remove #sound-dai-cells from &i2s1 node of rk3399-pinebook-pro.dts
Date:   Mon, 27 Apr 2020 21:42:46 +0200
Message-Id: <158801655764.50670.4654854118288471887.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200424155600.24254-1-jbx6244@gmail.com>
References: <20200424155600.24254-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 17:55:59 +0200, Johan Jonker wrote:
> The '#sound-dai-cells' property is already defined in rk3399.dtsi
> at the 'i2s1' node, so remove it from the '&i2s1' node in
> 'rk3399-pinebook-pro.dts'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: remove #sound-dai-cells from &i2s1 node of rk3399-pinebook-pro.dts
      commit: e565dd298c6bc9f53f0b07d96b019e000777c1fe
[2/2] arm64: dts: rockchip: remove #sound-dai-cells from &spdif node of rk3399-hugsun-x99.dts
      commit: de70083cbaabb86c282f421b070b041236ba6f4b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
