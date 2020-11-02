Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94A82A30B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgKBRAq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 12:00:46 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57173 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgKBRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:00:46 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2B6131BF20A;
        Mon,  2 Nov 2020 17:00:41 +0000 (UTC)
Date:   Mon, 2 Nov 2020 18:00:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Yifeng <yifeng.zhao@rock-chips.com>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
Message-ID: <20201102180039.757d3234@xps13>
In-Reply-To: <803e291f-67e0-f66c-6c9e-041db1b3847c@gmail.com>
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>
        <20201028095326.15562-3-yifeng.zhao@rock-chips.com>
        <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>
        <e02e13a0-769d-6b73-c87e-5b7d75fd4254@rock-chips.com>
        <0b417fc2-3503-9bf6-914d-0f8b38df1914@gmail.com>
        <20201102140725.66e7dcb1@xps13>
        <5ad70fa0-05a9-e1e7-32cc-32933ff25ae9@gmail.com>
        <803e291f-67e0-f66c-6c9e-041db1b3847c@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Johan Jonker <jbx6244@gmail.com> wrote on Mon, 2 Nov 2020 17:31:18
+0100:

> On 11/2/20 2:11 PM, Johan Jonker wrote:
> > Hi,
> > 
> > On 11/2/20 2:07 PM, Miquel Raynal wrote:
> >> Hi Johan, Yifeng
> >>
> >> Johan Jonker <jbx6244@gmail.com> wrote on Mon, 2 Nov 2020 13:57:56
> >> +0100:
> >>
> >>> Hi Yifeng,
> >>>
> >>> Don't poke with "ecc->bytes" ones it is set in rk_nfc_ecc_init(). It
> >>> will not be noted by the MTD frame work or userspace. I think there's
> >>> currently no way to let the user know that a different ECC must be used.
> >>> Neither can the user set ECC on the fly.
> >>>
> >>> Example R/W flow:
> >>>
> >>>         nand_select_target()
> >>> 	chip->ecc.write_page_raw()
> >>> 	chip->ecc.write_page()
> >>>
> >>> [..]
> >>>
> >>> 	chip->ecc.read_page_raw()
> >>> 	chip->ecc.read_page()
> >>>         nand_deselect_target()
> >>>
> >>> A write/read with:
> >>>
> >>> rk_nfc_read_page_hwecc()
> >>> rk_nfc_write_page_hwecc()
> >>>
> >>> or
> >>>
> >>> rk_nfc_read_page_raw()
> >>> rk_nfc_write_page_raw()
> >>>
> >>> must end up with the same result. If we can't archive that, then we
> >>> shouldn't offer RAW mode to the user for now. If Miquel agrees you
> >>> should just get the driver ready now without these 2 functions and round
> >>> things up.
> >>
> >> What about just not supporting the BootROM area if it was marked
> >> "reserved" by the BRom in the DT?
> > 
> > Should we just fill the buffers with '0xff' for boot blocks?
> 
> (part 2) ;)
> My fault....
> Better use:
> 
>     if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
>         (page < (pages_per_blk * rknand->boot_blks))) {
> 
> 	return -EIO;
> 
>     }

Yup, I was about to tell you that I would prefer returning a nice
error, this is fine I guess.

Anyway, I think reading bad block markers is done in raw mode, so if
raw accessors refuse to return valid values for boot blocks, you won't
be able to access it neither with raw nor corrected hooks.

Perhaps refusing the access to the regular page access is ok, but maybe
we should be able to at least read these pages in raw mode
(and move the BBM to its right location). What do you think?

Thanks,
Miquèl

> 
> 
> > 
> >>
> >> Raw accessors is really a nice and basic feature that I would like to
> >> have in every new driver.
> >>
> >> Thanks,
> >> Miquèl
> >>
> > 
> 
