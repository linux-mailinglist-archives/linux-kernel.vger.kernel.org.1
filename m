Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34050272F20
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgIUQyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgIUQyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:54:00 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1FD2076E;
        Mon, 21 Sep 2020 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600707240;
        bh=xGa9Eqdt0M/VMouAv7Tm2DGzar84+s9Y/iw3yGW/kZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPgNTegbrbzi1BlwfdWwpOU01z0aBiRgjQMMcB8WFQLwFmV9CJZIWHYl31y37BgYY
         pvtxgEhlb63pDzVcGGaH0uSKB7qDkBN9Ua3vpabYBXhsGtj+rpxSkB/GUzE6+wFjko
         CfVHRzl9beFqyot++9YGkqmSGpmrc/5iPFiz7JoA=
Received: by pali.im (Postfix)
        id 095E47BF; Mon, 21 Sep 2020 18:53:57 +0200 (CEST)
Date:   Mon, 21 Sep 2020 18:53:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andre Heider <a.heider@gmail.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Get rid of duplicate
 serial aliases
Message-ID: <20200921165357.yvajlsb6cjojbqqc@pali>
References: <20200921164830.499548-1-a.heider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921164830.499548-1-a.heider@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 September 2020 18:48:30 Andre Heider wrote:
> The included armada-372x.dtsi already defines these two aliases.

Where? I do not see it in that file:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/marvell/armada-372x.dtsi

> 
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
> 
> This goes on top of Pali's patch:
> "arm64: dts: marvell: espressobin: Add ethernet switch aliases"
> 
> The resulting .dtb files are the same.
> 
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index 0775c16e0ec8..3169a820558f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -17,8 +17,6 @@ aliases {
>  		ethernet1 = &switch0port1;
>  		ethernet2 = &switch0port2;
>  		ethernet3 = &switch0port3;
> -		serial0 = &uart0;
> -		serial1 = &uart1;
>  	};
>  
>  	chosen {
> -- 
> 2.28.0
> 
