Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0EB2CD33F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbgLCKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:15:59 -0500
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:59060 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388379AbgLCKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:15:59 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0B3ADk7f007196; Thu, 3 Dec 2020 19:13:46 +0900
X-Iguazu-Qid: 2wHHLA7xMtRANeMyfq
X-Iguazu-QSIG: v=2; s=0; t=1606990426; q=2wHHLA7xMtRANeMyfq; m=uvqzJE9rpSVBHj/c4gT2V3Kl3jjXhFwKCnNLeSOWyyU=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1111) id 0B3ADjHu032395;
        Thu, 3 Dec 2020 19:13:45 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 0B3ADjBn028759;
        Thu, 3 Dec 2020 19:13:45 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 0B3ADjiX023246;
        Thu, 3 Dec 2020 19:13:45 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-arm-kernel@lists.infradead.org, yuji2.ishikawa@toshiba.co.jp,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: visconti: Add watchdog support for TMPV7708 SoC
References: <20201202132143.2408012-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Date:   Thu, 03 Dec 2020 19:13:43 +0900
In-Reply-To: <20201202132143.2408012-1-nobuhiro1.iwamatsu@toshiba.co.jp>
        (Nobuhiro Iwamatsu's message of "Wed, 2 Dec 2020 22:21:43 +0900")
X-TSB-HOP: ON
Message-ID: <87a6uv42p4.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp> writes:

> Add watchdog node in TMPV7708's dtsi, and tmpv7708-rm-mbrc boards's
> dts.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts |  5 +++++
>  arch/arm64/boot/dts/toshiba/tmpv7708.dtsi        | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts b/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
> index ed0bf7f13f54..37da418393e0 100644
> --- a/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
> +++ b/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
> @@ -41,3 +41,8 @@ &uart1 {
>  	clocks = <&uart_clk>;
>  	clock-names = "apb_pclk";
>  };
> +
> +&wdt {
> +	status = "okay";
> +	clocks = <&wdt_clk>;
> +};
> diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> index 242f25f4e12a..c360e68bef1d 100644
> --- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> +++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> @@ -134,6 +134,12 @@ uart_clk: uart-clk {
>  		#clock-cells = <0>;
>  	};
>  
> +	wdt_clk: wdt-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <150000000>;
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -384,6 +390,12 @@ spi6: spi@28146000 {
>  			#size-cells = <0>;
>  			status = "disabled";
>  		};
> +
> +		wdt: wdt@28330000 {
> +			compatible = "toshiba,visconti-wdt";
> +			reg = <0 0x28330000 0 0x1000>;
> +			status = "disabled";
> +		};
>  	};
>  };

FWIW,

Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Thanks,
Punit
