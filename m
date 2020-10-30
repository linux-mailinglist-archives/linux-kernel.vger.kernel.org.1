Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E698F29F976
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgJ3AHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJ3AHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:07:32 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FC1E20724;
        Fri, 30 Oct 2020 00:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604016451;
        bh=TaCeuEJNrZ3yJWXL4ZM1HXnhnb4CcJpQosOHlGaws0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JRsuVi9r9Mofv3qHSzZGzYUTDoO9dI2/1WjyagMloZGFBWCtAkGlIMKvxCXIQj6Sl
         mc/MBhDgodMfg8ZX6dYZXDSz+4/JGKzkCy7eXAwWhhv+7bY0WV7tnsQiKQt0mtZCJm
         y5tgduT+INmxIpTqxRcut2tMtjyFpE7rGo0lrlWM=
Date:   Fri, 30 Oct 2020 08:07:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] arm64: dts: ls1088ardb: add QSGMII PHY nodes
Message-ID: <20201030000725.GT28755@dragon>
References: <20200925132503.30206-1-ioana.ciornei@nxp.com>
 <20200925132503.30206-3-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925132503.30206-3-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 04:24:56PM +0300, Ioana Ciornei wrote:
> Annotate the external MDIO1 node and describe the 8 QSGMII PHYs found on
> the LS1088ARDB board and add phy-handles for DPMACs 3-10 to its
> associated PHY.  Also, add the internal PCS MDIO nodes for the internal
> MDIO buses found on the LS1088A SoC along with their internal PCS PHY
> and link the corresponding DPMAC to the PCS through the pcs-handle.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  .../boot/dts/freescale/fsl-ls1088a-rdb.dts    | 100 ++++++++++++++++++
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  50 +++++++++
>  2 files changed, 150 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> index 5633e59febc3..d7886b084f7f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> @@ -17,6 +17,98 @@ / {
>  	compatible = "fsl,ls1088a-rdb", "fsl,ls1088a";
>  };
>  
> +&dpmac3 {
> +	phy-handle = <&mdio1_phy5>;
> +	phy-connection-type = "qsgmii";
> +	managed = "in-band-status";
> +	pcs-handle = <&pcs3_0>;
> +};
> +
> +&dpmac4 {
> +	phy-handle = <&mdio1_phy6>;
> +	phy-connection-type = "qsgmii";
> +	managed = "in-band-status";
> +	pcs-handle = <&pcs3_1>;
> +};
> +
> +&dpmac5 {
> +	phy-handle = <&mdio1_phy7>;
> +	phy-connection-type = "qsgmii";
> +	managed = "in-band-status";
> +	pcs-handle = <&pcs3_2>;
> +};
> +
> +&dpmac6 {
> +	phy-handle = <&mdio1_phy8>;
> +	phy-connection-type = "qsgmii";
> +	managed = "in-band-status";
> +	pcs-handle = <&pcs3_3>;
> +};
> +
> +&dpmac7 {
> +	phy-handle = <&mdio1_phy1>;
> +	phy-connection-type = "qsgmii";
> +	managed = "in-band-status";
> +	pcs-handle = <&pcs7_0>;
> +};
> +
> +&dpmac8 {
> +	phy-handle = <&mdio1_phy2>;
> +	phy-connection-type = "qsgmii";
> +	managed = "in-band-status";
> +	pcs-handle = <&pcs7_1>;
> +};
> +
> +&dpmac9 {
> +	phy-handle = <&mdio1_phy3>;
> +	phy-connection-type = "qsgmii";
> +	managed = "in-band-status";
> +	pcs-handle = <&pcs7_2>;
> +};
> +
> +&dpmac10 {
> +	phy-handle = <&mdio1_phy4>;
> +	phy-connection-type = "qsgmii";
> +	managed = "in-band-status";
> +	pcs-handle = <&pcs7_3>;
> +};
> +
> +&emdio1 {
> +	status = "okay";
> +
> +	mdio1_phy1: emdio1_phy@1 {

If this is an Ethernet PHY device, please use generic node name like
'ethernet-phy'.  Also the unit-address in node name should match 'reg'
property.

> +		reg = <0x1c>;
> +	};
> +
> +	mdio1_phy2: emdio1_phy@2 {
> +		reg = <0x1d>;
> +	};
> +
> +	mdio1_phy3: emdio1_phy@3 {
> +		reg = <0x1e>;
> +	};
> +
> +	mdio1_phy4: emdio1_phy@4 {
> +		reg = <0x1f>;
> +	};
> +
> +	mdio1_phy5: emdio1_phy@5 {
> +		reg = <0x0c>;
> +	};
> +
> +	mdio1_phy6: emdio1_phy@6 {
> +		reg = <0x0d>;
> +	};
> +
> +	mdio1_phy7: emdio1_phy@7 {
> +		reg = <0x0e>;
> +	};
> +
> +	mdio1_phy8: emdio1_phy@8 {
> +		reg = <0x0f>;
> +	};
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> @@ -87,6 +179,14 @@ &esdhc {
>  	status = "okay";
>  };
>  
> +&pcs_mdio3 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio7 {
> +	status = "okay";
> +};
> +
>  &qspi {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 22544e3b7737..ad8679e58f9a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -672,6 +672,56 @@ emdio2: mdio@0x8B97000 {
>  			status = "disabled";
>  		};
>  
> +		pcs_mdio3: mdio@8c0f000 {
> +			compatible = "fsl,fman-memac-mdio";
> +			reg = <0x0 0x8c0f000 0x0 0x1000>;
> +			little-endian;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			pcs3_0: pcs-phy@0 {

ethernet-phy@0?

Shawn

> +				reg = <0>;
> +			};
> +
> +			pcs3_1: pcs-phy@1 {
> +				reg = <1>;
> +			};
> +
> +			pcs3_2: pcs-phy@2 {
> +				reg = <2>;
> +			};
> +
> +			pcs3_3: pcs-phy@3 {
> +				reg = <3>;
> +			};
> +		};
> +
> +		pcs_mdio7: mdio@8c1f000 {
> +			compatible = "fsl,fman-memac-mdio";
> +			reg = <0x0 0x8c1f000 0x0 0x1000>;
> +			little-endian;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			pcs7_0: pcs-phy@0 {
> +				reg = <0>;
> +			};
> +
> +			pcs7_1: pcs-phy@1 {
> +				reg = <1>;
> +			};
> +
> +			pcs7_2: pcs-phy@2 {
> +				reg = <2>;
> +			};
> +
> +			pcs7_3: pcs-phy@3 {
> +				reg = <3>;
> +			};
> +		};
> +
>  		cluster1_core0_watchdog: wdt@c000000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc000000 0x0 0x1000>;
> -- 
> 2.25.1
> 
