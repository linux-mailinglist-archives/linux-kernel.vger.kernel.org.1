Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B881C275A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgIWOkv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Sep 2020 10:40:51 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:39214 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgIWOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:40:39 -0400
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 91C9E3B27C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 14:38:52 +0000 (UTC)
X-Originating-IP: 90.65.92.90
Received: from localhost (lfbn-lyo-1-1913-90.w90-65.abo.wanadoo.fr [90.65.92.90])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C70EB20010;
        Wed, 23 Sep 2020 14:38:30 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Luka Kovacic <luka.kovacic@sartura.hr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com,
        Luka Kovacic <luka.kovacic@sartura.hr>
Subject: Re: [PATCH 0/4] Add support for a series of MikroTik CRS3xx switches
In-Reply-To: <20200724103840.18994-1-luka.kovacic@sartura.hr>
References: <20200724103840.18994-1-luka.kovacic@sartura.hr>
Date:   Wed, 23 Sep 2020 16:38:30 +0200
Message-ID: <87eemsimmx.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luka,

> These patches add support for a series of MikroTik CRS3xx switches
> based on the Marvell Prestera 98DX3236 switch chip.
>
> Namely, support is added for:
>  -  MikroTik CRS305-1G-4S+ (including the Bit variant)
>  -  MikroTik CRS326-24G-2S+ (including the Bit variant)
>  -  MikroTik CRS328-4C-20S-4S+ (including the Bit variant)
>
> The Bit board variant is added for each of the boards.
> These boards were modified to use a bigger Macronix flash.
>
> Currently only basic board support is added, but the support will
> be extended in a new patchset.
>
> Luka Kovacic (4):
>   arm: mvebu: dts: Add CRS326-24G-2S board
>   arm: mvebu: dts: Add CRS305-1G-4S board
>   arm: mvebu: dts: Add CRS328-4C-20S-4S board

These 3 patches have been applied on mvebu/dt

>   MAINTAINERS: Add an entry for MikroTik CRS3xx 98DX3236 boards

and this one on mvebu/arm

Thanks,

Gregory
>
>  MAINTAINERS                                   |  11 ++
>  arch/arm/boot/dts/Makefile                    |   6 +
>  .../boot/dts/armada-xp-crs305-1g-4s-bit.dts   |  43 ++++++++
>  arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts  |  17 +++
>  arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi | 104 ++++++++++++++++++
>  .../boot/dts/armada-xp-crs326-24g-2s-bit.dts  |  43 ++++++++
>  arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts |  17 +++
>  .../arm/boot/dts/armada-xp-crs326-24g-2s.dtsi | 104 ++++++++++++++++++
>  .../dts/armada-xp-crs328-4c-20s-4s-bit.dts    |  43 ++++++++
>  .../boot/dts/armada-xp-crs328-4c-20s-4s.dts   |  17 +++
>  .../boot/dts/armada-xp-crs328-4c-20s-4s.dtsi  | 104 ++++++++++++++++++
>  11 files changed, 509 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
>  create mode 100644 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts
>  create mode 100644 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi
>  create mode 100644 arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
>  create mode 100644 arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts
>  create mode 100644 arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi
>  create mode 100644 arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts
>  create mode 100644 arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dts
>  create mode 100644 arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtsi
>
> -- 
> 2.26.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
