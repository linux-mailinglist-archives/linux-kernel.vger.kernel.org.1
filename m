Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2A2C826F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgK3Kmz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Nov 2020 05:42:55 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:55335 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgK3Kmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:42:54 -0500
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EFF11200002;
        Mon, 30 Nov 2020 10:42:11 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Heider <a.heider@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: marvell: espressobin: Update link to V7
 schematic
In-Reply-To: <20201005133513.8649-1-pali@kernel.org>
References: <20200925084306.16309-1-pali@kernel.org>
 <20201005133513.8649-1-pali@kernel.org>
Date:   Mon, 30 Nov 2020 11:42:11 +0100
Message-ID: <87eekbjfcs.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pali,

> Up-to-date version of V7 schematic is on new URL linked from official
> tech-spec webpage http://espressobin.net/tech-spec/
>
> Signed-off-by: Pali Rohár <pali@kernel.org>


Applied on mvebu/dt64

Thanks,

Gregory

>
> ---
> Changes in V2:
> * Added commit description
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index e225dce64b9e..4775a7eda481 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -8,7 +8,7 @@
>   *
>   */
>  /*
> - * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
> + * Schematic available at http://espressobin.net/wp-content/uploads/2020/05/ESPRESSObin_V7-0_Schematic.pdf
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> index 44dbe9a21cc7..c47a93978386 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -8,7 +8,7 @@
>   *
>   */
>  /*
> - * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
> + * Schematic available at http://espressobin.net/wp-content/uploads/2020/05/ESPRESSObin_V7-0_Schematic.pdf
>   */
>  
>  /dts-v1/;
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
