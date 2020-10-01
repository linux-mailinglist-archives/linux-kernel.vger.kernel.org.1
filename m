Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9A927F68B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbgJAANA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:13:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46881 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730577AbgJAANA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:13:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C074A5C00CA;
        Wed, 30 Sep 2020 20:12:58 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 30 Sep 2020 20:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=mmqRcUlvPdUwSQM/x6F+Lvk29MhRVNZ
        Y0OId6LTaioA=; b=oO0WfMhqd7/SXXOpkm4pvo+CUM/mfVa0S/9LQpznEWngn7L
        pp0BMwLnlNeQX6AK1AaeMTvSe6uHdzjHNpNrfbQINBoDediIUxMfyrIEOjXkf9kW
        6Q8g7HSHoGwgHMXYV1mT40L0nOdaRCJJi1P8cQHW80tO8+20x0rFVrpGvg+tnbER
        MLAgDnRO4Dr0rsg4Ysc/DKiekVD0z+zFyxLFPPvgA0B8tqZ9TPX2IJ1gUGQvcn3/
        veGMQcF3n8oPVTZ4FTpQVGQtWSzQu1pR/KT/lcVbHsoLoxIhZfdljJVR7OOduSKV
        vXG887JOfL0Qjl1NaNKMrUfjQePncm9YfjYP/ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mmqRcU
        lvPdUwSQM/x6F+Lvk29MhRVNZY0OId6LTaioA=; b=Hq9VBLO5rOGiQyygLKdC4D
        npI2wsldxkFbJmNyZsGsDducaQYSd7YWUSFbtq/CYo+LKBZvsP/3lImpwAnoN+2t
        120kjqML3EHNEQAMmiR+m+s1ySUcosEztiLq3CdTJzGo1sKur+7i8DXXAA2yCuC9
        kjhllFwMETxWRB1ckvbIfOQSvSCV5j2JwoVyby8tKPakQyfbYMl6z8k8p19f2KKS
        EU/jbcz9vyjj/o79Za9og95bKpD8t2eaDB3lZkWxiU6wdMP0QxGP6uZakgFrKMKk
        6rkuFUg8WaGc+waZROyoIOA6+kRNvgSEESNydOf58BdOBZaXMpRwkr82mrLGWS6g
        ==
X-ME-Sender: <xms:Bx91X7su7hjam-0xm23UCihQ1Gcd_cqki62_nBAphXy9EG5h1LkNRg>
    <xme:Bx91X8cDwCFJueCMpSjErWxi7-55X0gP_8C6fl2qHJdzBSi2nn_beQR0oA0q26gp0
    CN9pE4-2fMMwb6kDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
    veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:Bx91X-y9-ua34XWjr1AP1838iiPZeGiC4yoAokyMCla9rmMsIXb-mQ>
    <xmx:Bx91X6NR2KEiVwWJ6sEWfXUt9PFHP9NfS6-AR793GxKdHLfXcnlUsw>
    <xmx:Bx91X7_4-hq0dL2JfE7tG1mbOBy85BGnA-4pTIcDhQSxVPzPyEN1YA>
    <xmx:Ch91X2mB-zkFx8juQfFmrRsdGF2ESBYnEvSlwDJpZ_JWtz9gRuqZqA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BF278E0181; Wed, 30 Sep 2020 20:12:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-382-ge235179-fm-20200928.002-ge2351794
Mime-Version: 1.0
Message-Id: <b7bcc925-b0da-446f-84a7-1a564a1f4f83@www.fastmail.com>
In-Reply-To: <20200930090603.19891-1-billy_tsai@aspeedtech.com>
References: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
 <20200930090603.19891-1-billy_tsai@aspeedtech.com>
Date:   Thu, 01 Oct 2020 09:42:34 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Billy Tsai" <billy_tsai@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com
Subject: Re: [RESEND PATCH] ARM: dts: aspeed-g6: Fix gpio memory region
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Billy,

On Wed, 30 Sep 2020, at 18:36, Billy Tsai wrote:
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 97ca743363d7..b9ec8b579f73 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -357,7 +357,7 @@
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				compatible = "aspeed,ast2600-gpio";
> -				reg = <0x1e780000 0x800>;
> +				reg = <0x1e780000 0x500>;

We took the 0x800 value from the memory space layout table in the datasheet for 
the 2600. Should that be updated too? Or are you just limiting the region to 
the registers currently described rather than the allocated address space?

Cheers,

Andrew
