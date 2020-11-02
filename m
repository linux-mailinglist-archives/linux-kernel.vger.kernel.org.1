Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C8B2A2B37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgKBNHb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 08:07:31 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50019 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgKBNHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:07:31 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D7E9CFF803;
        Mon,  2 Nov 2020 13:07:26 +0000 (UTC)
Date:   Mon, 2 Nov 2020 14:07:25 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Yifeng <yifeng.zhao@rock-chips.com>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
Message-ID: <20201102140725.66e7dcb1@xps13>
In-Reply-To: <0b417fc2-3503-9bf6-914d-0f8b38df1914@gmail.com>
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>
        <20201028095326.15562-3-yifeng.zhao@rock-chips.com>
        <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>
        <e02e13a0-769d-6b73-c87e-5b7d75fd4254@rock-chips.com>
        <0b417fc2-3503-9bf6-914d-0f8b38df1914@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan, Yifeng

Johan Jonker <jbx6244@gmail.com> wrote on Mon, 2 Nov 2020 13:57:56
+0100:

> Hi Yifeng,
> 
> Don't poke with "ecc->bytes" ones it is set in rk_nfc_ecc_init(). It
> will not be noted by the MTD frame work or userspace. I think there's
> currently no way to let the user know that a different ECC must be used.
> Neither can the user set ECC on the fly.
> 
> Example R/W flow:
> 
>         nand_select_target()
> 	chip->ecc.write_page_raw()
> 	chip->ecc.write_page()
> 
> [..]
> 
> 	chip->ecc.read_page_raw()
> 	chip->ecc.read_page()
>         nand_deselect_target()
> 
> A write/read with:
> 
> rk_nfc_read_page_hwecc()
> rk_nfc_write_page_hwecc()
> 
> or
> 
> rk_nfc_read_page_raw()
> rk_nfc_write_page_raw()
> 
> must end up with the same result. If we can't archive that, then we
> shouldn't offer RAW mode to the user for now. If Miquel agrees you
> should just get the driver ready now without these 2 functions and round
> things up.

What about just not supporting the BootROM area if it was marked
"reserved" by the BRom in the DT?

Raw accessors is really a nice and basic feature that I would like to
have in every new driver.

Thanks,
Miquèl
