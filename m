Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0552756BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:58:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46292 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIWK6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:58:02 -0400
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kL2TF-0006YK-2A; Wed, 23 Sep 2020 12:57:57 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        art@khadas.com, jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nick@khadas.com
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rk3399-khadas-edge: add missed spiflash node
Date:   Wed, 23 Sep 2020 12:57:56 +0200
Message-ID: <8046326.tZ3HhvINgq@diego>
In-Reply-To: <20200923101225.1513392-2-email2tema@gmail.com>
References: <20200923101225.1513392-1-email2tema@gmail.com> <20200923101225.1513392-2-email2tema@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

please make the subject something like
"arm64: dts: rockchip: add spiflash node to rk3399-khadas-edge"

Am Mittwoch, 23. September 2020, 12:12:24 CEST schrieb Artem Lapkin:
> From: Artem Lapkin <art@khadas.com>
> 
> The Khadas Edge Boards uses winbond - w25q128 spi flash with 104Mhz

Missing "Signed-off-by: ..."

> ---
>  .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> index e36837c04dc..42ebbd6fa46 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> @@ -805,3 +805,17 @@ &vopl {
>  &vopl_mmu {
>  	status = "okay";
>  };
> +
> +
no double empty lines please

> +&spi1 {

please group the &spi1 alphabetically in the file

> +    max-freq = <104000000>;

not part of any binding, spi-max-frequency below should be enough.

> +    status = "okay";
> +
> +    spiflash: flash@0 {
> +    u-boot,dm-pre-reloc;

u-boot specific, please drop

> +    compatible = "winbond,w25q128fw", "jedec,spi-nor";
> +    reg = <0>;
> +    spi-max-frequency = <104000000>;
> +    };
> +};
> +
> 


Heiko


