Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE41927F6CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbgJAAgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:36:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42777 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730403AbgJAAgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:36:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 272555C0140;
        Wed, 30 Sep 2020 20:36:42 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 30 Sep 2020 20:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=06pnMJ4ySgrR3zE2veXLevcnyQj0lWc
        d++eStXNSg1c=; b=Aog4yJOxWHUIdns67r9LYv+XkJAwb8pOR5Onlp08+awFaVQ
        qew0hYLCc6vzzaQ2xXldxtzOEib9UU3GlebbtT5s3RWmdfW+3VwtxKb5tN78A17U
        sCa1scmhP7epAZBhBslpHDUTqcdBfCTWYlFo/a94pN5E7hlFxNlWslqFAeqIce3z
        fPvBGf3Y8xPHEWBd80R8vLgRy9Bneb3UydjHdhH4kTQM8S357sgoiFRpsei5nQzY
        4bTrZukk1cFIcXdoGF41Ly9CZ61XhD5YD84NsHyTXgmJb8qqBQxX8kmjnnKOptQy
        8zTmM/5f3QvGySRCU0qudk/ucffcQXNTxI25FLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=06pnMJ
        4ySgrR3zE2veXLevcnyQj0lWcd++eStXNSg1c=; b=W18IL9tIpICdtp1ksfSx7G
        g//5j74iOFQ1KT0VH87Qm5MWF7jKkycw19OPnIiEniZrjkxPdWiJ3TfPXxHjPrTd
        sMBBhyhHLS1IxTr/GjdpojnzfbDJ4DPShKZRkLLf6WKglSuoD5PkFw+Mkm1Bv81L
        KklfxlyW4YCDKHbPf/hM1p2fLpDxZBKDrGlDuBUPlR0JzCFRy4OidviRVMwkJWjK
        IM4VWIRtG5k2z/M0iuj5IBz3dkJJXdmGFBO8K+Xf9d0zsA/xHlizht9WqZKj25qf
        VwfcNYODqSVBfRRPepbcRRhLb5BP9x/UxI2hdFxd2RZDMftS52nJZFWq1AqaDYhA
        ==
X-ME-Sender: <xms:mCR1X-_E6qEcX4YynjhFOS6dRl2zwSYIot-RarN41PcZLZBBa2h-EA>
    <xme:mCR1X-uvLvSse5KO3u0wIB6RCOI4Wk8dq_8P2MNFIh3VS8uqIl0LJDY-SLBJQ5h9J
    vNxUYMOpJe9NWnEmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
    veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:mCR1X0Bh8tdoFB07gLuf1a6kETGgeneoqjQd-MEiOUTX8WQLEQB_qg>
    <xmx:mCR1X2dUdiFgP6Ewcrsh7Xm6opGU6lcQ3-T0OcYfbjl_xKmOIVriIw>
    <xmx:mCR1XzM-buy3w0I7LvnEp8OHZeo51JnVCN0Gi9EheEyqzmrPCwcuvg>
    <xmx:miR1X-1IWYTN3IiERWOIzaNQZe2QRh4t6k83qs-DIRztZgWt7ptwQQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6D6B9E0181; Wed, 30 Sep 2020 20:36:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-382-ge235179-fm-20200928.002-ge2351794
Mime-Version: 1.0
Message-Id: <6bc40a50-8c21-4642-ad9e-e92f756aac25@www.fastmail.com>
In-Reply-To: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
References: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
Date:   Thu, 01 Oct 2020 10:06:20 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Billy Tsai" <billy_tsai@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com
Subject: Re: [PATCH] ARM: dts: aspeed-g6: Add sgpiom/sgpios node
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Billy,

On Wed, 30 Sep 2020, at 14:41, Billy Tsai wrote:
> This commit add two sgpiom and two sgpios node into aspeed-g6.dtsi
> and change the register range of gpio0 to fix the hardware design.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 51 +++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 97ca743363d7..00237daec2a1 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -357,7 +357,7 @@
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				compatible = "aspeed,ast2600-gpio";
> -				reg = <0x1e780000 0x800>;
> +				reg = <0x1e780000 0x500>;
>  				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>  				gpio-ranges = <&pinctrl 0 0 208>;
>  				ngpios = <208>;
> @@ -365,6 +365,55 @@
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  			};
> +			sgpiom0: sgpiom@1e780500 {
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				compatible = "aspeed,ast2600-sgpiom";
> +				reg = <0x1e780500 0x100>;
> +				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +				ngpios = <128>;
> +				clocks = <&syscon ASPEED_CLK_APB2>;
> +				interrupt-controller;
> +				bus-frequency = <12000000>;
> +
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_sgpm1_default>;
> +				status = "disabled";
> +			};
> +
> +			sgpiom1: sgpiom@1e780600 {
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				compatible = "aspeed,ast2600-sgpiom";
> +				reg = <0x1e780600 0x100>;
> +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> +				ngpios = <80>;
> +				clocks = <&syscon ASPEED_CLK_APB2>;
> +				interrupt-controller;
> +				bus-frequency = <12000000>;
> +
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_sgpm2_default>;

Have you tried building this on top of upstream? Because neither sgpm2 nor 
sgps2 are supported by the pinctrl driver. If you have patches that implement 
both mux configurations, can you post them too?

Andrew
