Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F742A1E5D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgKANnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgKANnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:43:31 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F4FC0617A6;
        Sun,  1 Nov 2020 05:43:31 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E6E7622EDE;
        Sun,  1 Nov 2020 14:43:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604238207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWUASnyqf1M1i4/7F/3wqjODT1qRJeDlkrPp7DBta9Q=;
        b=Lh9iJSkI+ExWT+nX+gQwLOFy2yT5LE2yXZzdgEebEtystiqoCR3mg+EEU6UuehVP7vBWsp
        ihFWw8ED2RUUARfpumlgBnQkigkQKlgyiu43bHr9rboVuFEMt4iMDGJSJM5stijgZoPnRc
        mmou1Vhq6Qjx6GyOVIRxUfF9OjQEVi8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 01 Nov 2020 14:43:26 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Ioana Ciornei <ciorneiioana@gmail.com>
Subject: Re: [PATCH net] arm64: dts: fsl-ls1028a-kontron-sl28: specify in-band
 mode for ENETC
In-Reply-To: <20201101131905.8316-1-michael@walle.cc>
References: <20201101131905.8316-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <4ce87119133d080332eb2fb3432318d0@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Ioana; the reference commit has a typo in her email address]

Am 2020-11-01 14:19, schrieb Michael Walle:
> Since commit 71b77a7a27a3 ("enetc: Migrate to PHYLINK and PCS_LYNX") 
> the
> network port of the Kontron sl28 board is broken. After the migration 
> to
> phylink the device tree has to specify the in-band-mode property. Add
> it.
> 
> Fixes: 71b77a7a27a3 ("enetc: Migrate to PHYLINK and PCS_LYNX")
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> index f46eb47cfa4d..8161dd237971 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> @@ -75,6 +75,7 @@
>  &enetc_port0 {
>  	phy-handle = <&phy0>;
>  	phy-connection-type = "sgmii";
> +	managed = "in-band-status";
>  	status = "okay";
> 
>  	mdio {

-- 
-michael
