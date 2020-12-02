Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8E2CB73F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgLBIcm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Dec 2020 03:32:42 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55745 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgLBIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:32:42 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 58DEF240002;
        Wed,  2 Dec 2020 08:31:58 +0000 (UTC)
Date:   Wed, 2 Dec 2020 09:31:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "richard@nod.at" <richard@nod.at>, Vignesh R <vigneshr@ti.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: orion-nand: uncorrectable ECC error on v5.10-rc6
Message-ID: <20201202093157.4fa6998f@xps13>
In-Reply-To: <79a69fe8-551b-6cfb-0505-37178ee5a0ec@alliedtelesis.co.nz>
References: <d88ccac1-801c-f30a-097a-331d49956a9c@alliedtelesis.co.nz>
        <20201202085948.038efb3e@xps13>
        <79a69fe8-551b-6cfb-0505-37178ee5a0ec@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote on Wed, 2 Dec
2020 08:23:13 +0000:

> Hi Miquel,
> 
> On 2/12/20 8:59 pm, Miquel Raynal wrote:
> > Hi Chris,
> >
> > Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote on Wed, 2 Dec
> > 2020 07:47:32 +0000:
> >  
> >> Hi,
> >>
> >> I've just booted v5.10-rc6 on a kirkwood based board (which uses the
> >> orion-nand driver) and I get the following errors reported. I haven't
> >> started bisecting yet but v5.7.19 mounts the nand flash without any issue.
> >>
> >> ubi0: attaching mtd0
> >> __nand_correct_data: uncorrectable ECC error
> >> ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 64 bytes
> >> from PEB 0:0, read only 64 bytes, retry
> >> __nand_correct_data: uncorrectable ECC error
> >> ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 64 bytes
> >> from PEB 0:0, read only 64 bytes, retry
> >> __nand_correct_data: uncorrectable ECC error
> >> ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 64 bytes
> >> from PEB 0:0, read only 64 bytes, retry
> >> __nand_correct_data: uncorrectable ECC error
> >> ubi0 error: ubi_io_read: error -74 (ECC error) while reading 64 bytes
> >> from PEB 0:0, read 64 bytes
> >> CPU: 0 PID: 101 Comm: ubiattach Not tainted 5.10.0-rc6+ #1
> >> Hardware name: Marvell Kirkwood (Flattened Device Tree)
> >> [<8010ca64>] (unwind_backtrace) from [<80109bd0>] (show_stack+0x10/0x14)
> >> [<80109bd0>] (show_stack) from [<8045f10c>] (ubi_io_read+0x184/0x304)
> >> [<8045f10c>] (ubi_io_read) from [<8045f4ac>] (ubi_io_read_ec_hdr+0x44/0x240)
> >> [<8045f4ac>] (ubi_io_read_ec_hdr) from [<80464db0>]
> >> (ubi_attach+0x178/0x15fc)
> >> [<80464db0>] (ubi_attach) from [<80458d8c>] (ubi_attach_mtd_dev+0x538/0xb48)
> >> [<80458d8c>] (ubi_attach_mtd_dev) from [<8045a114>]
> >> (ctrl_cdev_ioctl+0x170/0x1e0)
> >> [<8045a114>] (ctrl_cdev_ioctl) from [<80203094>] (sys_ioctl+0x1f8/0x990)
> >> [<80203094>] (sys_ioctl) from [<80100060>] (ret_fast_syscall+0x0/0x50)
> >> Exception stack(0x87633fa8 to 0x87633ff0)
> >> 3fa0:                   00000003 7e9b0c30 00000003 40186f40 7e9b0c30
> >> 00000000
> >> 3fc0: 00000003 7e9b0c30 000148f8 00000036 00014770 00013f90 76f3dfa4
> >> 00000000
> >> 3fe0: 76e936f0 7e9b0c1c 00011f68 76e936fc  
> > I recently contributed a pile of fixes to ensure DT parsing was not
> > broken and this applies to Orion. Can you please check
> >
> > mtd: rawnand: orion: Move the ECC initialization to ->attach_chip()  
> That looks to be it. In Linus's tree commit 76dc2bfc2e1b ("Merge tag 
> 'mtd/fixes-for-5.10-rc6' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux") seems to be 
> the difference between working and not working.
> > And tell me if you see something wrong there? I assumed this driver was
> > not supporting on host ECC engines and only soft Hamming was used, is
> > this assumption wrong?  
> 
> Our dts has
> 
>          nand-ecc-mode = "soft";
>          nand-ecc-algo = "bch";
>          nand-on-flash-bbt;
> 

I assumed Hamming was the only possible algorithm, this is the error.

I have several drivers in this case then.

We need to default to Hamming but let the user decide then. Can you try
something like the below change please?


Thanks,
Miquèl


---8<---

Author: Miquel Raynal <miquel.raynal@bootlin.com>
Date:   Wed Dec 2 09:31:14 2020 +0100

    mtd: rawnand: orion: Fix soft ECC algo selection
    
    Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index e3bb65fd3ab2..66211c9311d2 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -86,7 +86,9 @@ static void orion_nand_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 static int orion_nand_attach_chip(struct nand_chip *chip)
 {
        chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
-       chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
+
+       if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
+               chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
 
        return 0;
 }

