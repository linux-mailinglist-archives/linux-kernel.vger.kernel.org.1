Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AAA2D0D91
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgLGJ5S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Dec 2020 04:57:18 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:36425 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLGJ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:57:18 -0500
Received: from xps13 (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B4E16200005;
        Mon,  7 Dec 2020 09:56:33 +0000 (UTC)
Date:   Mon, 7 Dec 2020 10:56:32 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
Message-ID: <20201207105632.6ea2c7ce@xps13>
In-Reply-To: <259fe1ce-6bcb-3a26-493d-87bbd2eaff5e@gmail.com>
References: <20201130100031.22083-1-yifeng.zhao@rock-chips.com>
        <20201130100031.22083-3-yifeng.zhao@rock-chips.com>
        <0abf1dbd-13bb-cd92-907c-849f05ea887c@gmail.com>
        <259fe1ce-6bcb-3a26-493d-87bbd2eaff5e@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Johan Jonker <jbx6244@gmail.com> wrote on Sun, 6 Dec 2020 15:10:57
+0100:

> Hi Yifeng,
> 
> Meanwhile, could you post a RFC version for Uboot based on this version
> plus comments, so people can test the whole process from programming,
> booting and kernel?
> 
> On 11/30/20 1:49 PM, Johan Jonker wrote:
> > Hi,
> > 
> > Looks good to me.
> > Do the maintainers or someone else have any major issues?
> > Could Miquel indicate if a version 16 must be send for that 'ret'
> > variable alone or is it OK now?
> > 
> > 
> > On 11/30/20 11:00 AM, Yifeng Zhao wrote:  
> >> This driver supports Rockchip NFC (NAND Flash Controller) found on RK3308,
> >> RK2928, RKPX30, RV1108 and other SOCs. The driver has been tested using
> >> 8-bit NAND interface on the ARM based RK3308 platform.  
> 
> [..]
> 
> >> +/**
> >> + * struct rk_ecc_cnt_status: represent a ecc status data.  
> 
> represent the ECC status data.

The driver looks good to me now, can you please send a v16 with the
last comments from Johan (thanks for reviewing so carefully btw!).

Thanks,
Miquèl
