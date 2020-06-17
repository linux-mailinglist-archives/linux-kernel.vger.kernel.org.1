Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1371FD737
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgFQV23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 17:28:29 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:50143 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQV22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:28:28 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0C41D240005;
        Wed, 17 Jun 2020 21:28:19 +0000 (UTC)
Date:   Wed, 17 Jun 2020 23:28:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH 2/3] ARM: dts: at91: sam9x60ek: classd: pull-down the L1
 and L3 lines
Message-ID: <20200617212819.GE3675@piout.net>
References: <20200615095525.43414-1-codrin.ciubotariu@microchip.com>
 <20200615095525.43414-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615095525.43414-2-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2020 12:55:24+0300, Codrin Ciubotariu wrote:
> The L1 and L3 lines drive NMOS transistors that are OFF with a low level.
> On the SAM9X60 EK board, if the pins corresponding to L1 and L3
> have pull-ups enabled, there is an extra 2 x 30uA power consumption.
> Use pull-downs for these 2 lines to remove the unnecessary power
> consumption.
> 
> Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sam9x60ek.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
