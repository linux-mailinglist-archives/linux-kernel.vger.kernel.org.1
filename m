Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60D2C879B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgK3PTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:19:43 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38883 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgK3PTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:19:42 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 19BB722EDE;
        Mon, 30 Nov 2020 16:18:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606749538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cx9xkbcxLxdJj1hfUMKUShG9h0n8+lIT3oYgBQ9YZUU=;
        b=ZfusJNkUOlpLWnPQ7YtIzZxUad4uQHglmFkgLPPwSbR69PUdqljQwa/IRcDXVKbv9k+AeN
        +L4qmEjHad3wFYthA56LqdFDmLHZJtbW4a38vaUoWrWYPi+dXD0tyZxFBoSsjbwXemf7UG
        N7TxKsN0Pd8wEkXcYGymxKwChxYlC7g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Nov 2020 16:18:58 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] arm64: dts: freescale: sl28: correct MMC order
In-Reply-To: <20201124212126.32218-1-michael@walle.cc>
References: <20201124212126.32218-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <8115204301687a0576d4ddb4f799d0fa@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-24 22:21, schrieb Michael Walle:
> Commit 342ab37ecaf8 ("arm64: dts: freescale: use fixed index mmcN for
> layerscape") hardcoded the order of the MMC devices. This doesn't fit
> the sl28 boards, which come with an onboard eMMC. Thus use the more
> natural order for the eMMC and SD card. Use /dev/mmcblk0 for the eMMC
> and /dev/mmcblk1 for the SD card which is removable by the user.
> 
> Please note, that the images for this board already use root=UUID=,
> therefore the actual device number doesn't matter for booting.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git
> a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> index fbaecf285d05..6da4a28c4d19 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> @@ -18,6 +18,8 @@
> 
>  	aliases {
>  		crypto = &crypto;
> +		mmc0 = &esdhc1;
> +		mmc1 = &esdhc;
>  		serial0 = &duart0;
>  		serial1 = &duart1;
>  		serial2 = &lpuart1;

This will be superfluous because Vladimirs patch was applied:
https://lore.kernel.org/linux-devicetree/20201130143923.GK4072@dragon/

Thanks!
-michael
