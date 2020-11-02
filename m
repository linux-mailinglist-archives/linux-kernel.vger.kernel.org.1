Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF802A25FC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgKBIU1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 03:20:27 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:42807 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgKBIU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:20:27 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 50205200015;
        Mon,  2 Nov 2020 08:20:22 +0000 (UTC)
Date:   Mon, 2 Nov 2020 09:20:21 +0100
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
Message-ID: <20201102092021.14159c03@xps13>
In-Reply-To: <20201102161300764203144@rock-chips.com>
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>
        <20201028095326.15562-3-yifeng.zhao@rock-chips.com>
        <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>
        <0dabd80e-b281-be65-b8e2-da00f46964fb@gmail.com>
        <20201102114503679684135@rock-chips.com>
        <20201102083258.3a748c44@xps13>
        <20201102161300764203144@rock-chips.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

赵仪峰 <yifeng.zhao@rock-chips.com> wrote on Mon, 2 Nov 2020 16:14:01
+0800:

> Hi Miquel,
> 
> The nand_base.c will call nand_deselect_target after NAND read/program... ops done, and set variable chip->cur_cs = -1,
> but the nand controller do nothing and the cs of the NAND device is still selected, 
> so the NAND device  will not enter auto power save mode.

Yes, I need to think about it again.

What I am saying is that this has *nothing* to do with the controller
driver your are trying to merge. Please focus on the bare features.
Once these will be merged, it will be easier to propose changes on top
of it to bring more fine grained features.

It's v13 already, please focus on the controller's basic features,
implement them correctly and in a second time we'll think about the
power consumption, what do you think?

Thanks,
Miquèl
