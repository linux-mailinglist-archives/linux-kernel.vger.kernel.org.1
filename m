Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15A0297DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 19:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762741AbgJXRvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 13:51:25 -0400
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:54476 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762733AbgJXRvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 13:51:25 -0400
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id A87E720E29;
        Sat, 24 Oct 2020 17:51:23 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id B746D20100;
        Sat, 24 Oct 2020 17:51:20 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 8EBE93F1C5;
        Sat, 24 Oct 2020 17:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 6F47D2A359;
        Sat, 24 Oct 2020 13:51:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1603561878;
        bh=aVQacDor6pG41Pl/v7YjPYCOYPsZrwjxjqQcNYBRudg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TZu5EjBXqzPxTkuUurhixihe0BkicgUFN/zJ/JW1dDl9tIT5wN5EPiJvHaHAJqYts
         cgQ0vbKAig3Vq6n9zKmmln9fiWeC/z1qdjXRjIMgwHUcZknFYHS41SAPZdGONjZ4zP
         z462fmi2Vb5asyxJVF/640rQWIykd4Stvl7tOra0=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fExfxNYMQzqg; Sat, 24 Oct 2020 13:51:17 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 24 Oct 2020 13:51:17 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 342EF400C0;
        Sat, 24 Oct 2020 17:51:16 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="CgWyXQ5R";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.66])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id B7730400C0;
        Sat, 24 Oct 2020 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1603561872; bh=aVQacDor6pG41Pl/v7YjPYCOYPsZrwjxjqQcNYBRudg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CgWyXQ5RL9TEMGozS/ZRaqnKwgrC/IpGdtgZbNxJoo2V32toh8/cb5TO02gXGIWpc
         IFPgDh5jXilAcEpAPsPjwSFCq2hvTbGADKZxU/PfKJir+6SOlMlk/zSjLydIYb9DsO
         5GHyqMQPMmqrBcWZ7YOQ7pnHvhvPp8hOE8xyK02w=
Message-ID: <79894e1266db69e463ee74a52551101298cae03e.camel@aosc.io>
Subject: Re: [linux-sunxi] [PATCH 02/10] ARM: dts: sun6i: a31-hummingbird:
 Enable RGMII RX/TX delay on Ethernet PHY
From:   Icenowy Zheng <icenowy@aosc.io>
To:     wens@kernel.org, Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 25 Oct 2020 01:51:06 +0800
In-Reply-To: <20201024162515.30032-2-wens@kernel.org>
References: <20201024162515.30032-1-wens@kernel.org>
         <20201024162515.30032-2-wens@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 342EF400C0
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.66:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-10-25星期日的 00:25 +0800，Chen-Yu Tsai写道：
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Ethernet PHY on the A31 Hummingbird has the RX and TX delays
> enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.
> 
> Fix the phy-mode description to correct reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").

Personally I think they should revert this commit, and consider other
solution.

This commit breaks everything.

(Although the patch on individual DT patches are technically correct)

> 
> Fixes: c220aec2bb79 ("ARM: dts: sun6i: Add Merrii A31 Hummingbird
> support")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> index 049e6ab3cf56..73de34ae37fd 100644
> --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> @@ -154,7 +154,7 @@ &gmac {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&gmac_rgmii_pins>;
>  	phy-handle = <&phy1>;
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>  	status = "okay";
>  };
>  
> -- 
> 2.28.0
> 
