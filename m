Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E985D1ADBD5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 13:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgDQLFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 07:05:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38376 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgDQLFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:05:34 -0400
Received: from p57b77c7a.dip0.t-ipconnect.de ([87.183.124.122] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jPOoK-0003KN-CI; Fri, 17 Apr 2020 13:05:28 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arm64: dts: rockchip: add core devicetree for rk3318
Date:   Fri, 17 Apr 2020 13:05:27 +0200
Message-ID: <2141402.AJMLQ3pQEO@phil>
In-Reply-To: <20200417105739.3718-1-jbx6244@gmail.com>
References: <20200417105739.3718-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Freitag, 17. April 2020, 12:57:39 CEST schrieb Johan Jonker:
> The rk3318 is basically a rk3328 with improved gpu,
> so add a dtsi based on that.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Please don't add dangling dtsi files.
I'd expect at least a board dts to actually use that and
also the updated gpu node.

From a cursory glance it looks like it gets upgraded from
450-MP2 to 450MP3 or so, so that would at least mean
another set of interrupts.

Heiko

> ---
>  arch/arm64/boot/dts/rockchip/rk3318.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3318.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3318.dtsi b/arch/arm64/boot/dts/rockchip/rk3318.dtsi
> new file mode 100644
> index 000000000..a32f771bc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3318.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3328.dtsi"
> 




