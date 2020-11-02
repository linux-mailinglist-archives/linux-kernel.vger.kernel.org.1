Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE22A254D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgKBHdh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 02:33:37 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:58773 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgKBHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:33:37 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1D7DE20000A;
        Mon,  2 Nov 2020 07:32:59 +0000 (UTC)
Date:   Mon, 2 Nov 2020 08:32:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?6LW15Luq5bOw?= <yifeng.zhao@rock-chips.com>
Cc:     "Johan Jonker" <jbx6244@gmail.com>, richard <richard@nod.at>,
        vigneshr <vigneshr@ti.com>, robh+dt <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        =?UTF-8?B?SGVpa29TdMO8Ym5lcg==?= <heiko@sntech.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
Message-ID: <20201102083258.3a748c44@xps13>
In-Reply-To: <20201102114503679684135@rock-chips.com>
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>
        <20201028095326.15562-3-yifeng.zhao@rock-chips.com>
        <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>
        <0dabd80e-b281-be65-b8e2-da00f46964fb@gmail.com>
        <20201102114503679684135@rock-chips.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

赵仪峰 <yifeng.zhao@rock-chips.com> wrote on Mon, 2 Nov 2020 11:46:04
+0800:

> Hi Johan,
> 
> void nand_deselect_target(struct nand_chip *chip)
> {
> 	if (chip->legacy.select_chip)
> 		chip->legacy.select_chip(chip, -1);
> 
> 	chip->cur_cs = -1;
> }
> 
> I need add the code below and it work. 
> 
>    chip->legacy.select_chip = rk_nfc_select_chip;
> 
> But I found almost all nandc drivers do not add this code. Is there any other way to implement it？

Indeed, we don't accept new code we legacy bindings.

I don't understand what extra consumption you are trying to avoid,
because if it is the NAND device itself that is able to save power when
it gets unselected, it's really none of you controller's business.

Perhaps it's the time to focus on the controller support and tune the
code base later in a bid to reduce consumption.

Thanks,
Miquèl
