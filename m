Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4252789D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIYNoj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Sep 2020 09:44:39 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:45695 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgIYNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:44:39 -0400
X-Originating-IP: 90.65.92.90
Received: from localhost (lfbn-lyo-1-1913-90.w90-65.abo.wanadoo.fr [90.65.92.90])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7F84E1BF216;
        Fri, 25 Sep 2020 13:44:36 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Heider <a.heider@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Update link to V7 schematic
In-Reply-To: <20200925084306.16309-1-pali@kernel.org>
References: <20200925084306.16309-1-pali@kernel.org>
Date:   Fri, 25 Sep 2020 15:44:36 +0200
Message-ID: <87wo0iezsr.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pali,

could you add a commit log besides the topic ?

Also note that I've just sent the pull requests for 5.10 and I was
already a little late for that, so I fear this patch will be for 5.11.

Unless the former url was broken it this case it could be considered as
a fixe and could be applied for 5.9. If you think it, you should also
add a "Fixes:" tag.

Thank,

Gregory

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index 61d49d6a2a2a..6062a7df7342 100644
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
