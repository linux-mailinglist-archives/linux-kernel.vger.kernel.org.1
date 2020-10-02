Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B78280D73
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgJBG1G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Oct 2020 02:27:06 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56701 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBG1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:27:06 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id C3A481C000B;
        Fri,  2 Oct 2020 06:27:01 +0000 (UTC)
Date:   Fri, 2 Oct 2020 08:27:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
Message-ID: <20201002082700.7ed74f27@xps13>
In-Reply-To: <20200929090807.21511-3-yifeng.zhao@rock-chips.com>
References: <20200929090807.21511-1-yifeng.zhao@rock-chips.com>
        <20200929090807.21511-3-yifeng.zhao@rock-chips.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

Yifeng Zhao <yifeng.zhao@rock-chips.com> wrote on Tue, 29 Sep 2020
17:08:05 +0800:

> This driver supports Rockchip NFC (NAND Flash Controller) found on RK3308,
> RK2928, RKPX30, RV1108 and other SOCs. The driver has been tested using
> 8-bit NAND interface on the ARM based RK3308 platform.
> 
> Support Rockchip SoCs and NFC versions:
> - PX30 and RK3326(NFCv900).
> 	ECC: 16/40/60/70 bits/1KB.
> 	CLOCK: ahb and nfc.
> - RK3308 and RV1108(NFCv800).
> 	ECC: 16 bits/1KB.
> 	CLOCK: ahb and nfc.
> - RK3036 and RK3128(NFCv622).
> 	ECC: 16/24/40/60 bits/1KB.
> 	CLOCK: ahb and nfc.
> - RK3066, RK3188 and RK2928(NFCv600).
> 	ECC: 16/24/40/60 bits/1KB.
> 	CLOCK: ahb.
> 
> Supported features:
> - Read full page data by DMA.
> - Support HW ECC(one step is 1KB).
> - Support 2 - 32K page size.
> - Support 8 CS(depend on SoCs)
> 
> Limitations:
> - No support for the ecc step size is 512.
> - Untested on some SoCs.
> - No support for subpages.
> - No support for the builtin randomizer.
> - The original bad block mask is not supported. It is recommended to use
>   the BBT(bad block table).
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v9:
> - The nfc->buffer will realloc while the page size of the second mtd
>   is large than the first one
> - Fix coding style.
> - Remove struct rk_nfc_clk.
> - Prepend some function with rk_nfc_.
> - Replace function readl_poll_timeout_atomic with readl_relaxed_poll_timeout.
> - Remove function rk_nfc_read_byte and rk_nfc_write_byte.
> - Don't select the die if 'check_only == true' in function rk_nfc_exec_op.
> - Modify function rk_nfc_write_page and rk_nfc_write_page_raw.

You should probably rebase your patches on a more recent kernel, there
are several inconsistencies with the current core (see the kernel test
robot reports). Please consider having a look at the history to follow
the naming. If you need help, please ask!

Cheers,
Miquèl
