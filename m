Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A40C2A2AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgKBMs7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 07:48:59 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50169 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgKBMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:48:58 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 983A5C000C;
        Mon,  2 Nov 2020 12:48:53 +0000 (UTC)
Date:   Mon, 2 Nov 2020 13:48:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris BREZILLON <b.brezillon.dev@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, Dmitriy B <rzk333@gmail.com>,
        Sergey Lapin <slapin@ossfans.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 20/23] mtd: nand: raw: sunxi_nand: Document 'sunxi_nfc's
 'caps' member
Message-ID: <20201102134852.28830ae7@xps13>
In-Reply-To: <20201102115406.1074327-21-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
        <20201102115406.1074327-21-lee.jones@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Lee Jones <lee.jones@linaro.org> wrote on Mon,  2 Nov 2020 11:54:03
+0000:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/raw/sunxi_nand.c:250: warning: Function parameter or member 'caps' not described in 'sunxi_nfc'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Boris BREZILLON <b.brezillon.dev@gmail.com>
> Cc: Qiang Yu <yuq825@gmail.com>
> Cc: Dmitriy B <rzk333@gmail.com>
> Cc: Sergey Lapin <slapin@ossfans.org>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 1 +

Would you mind updating all commit titles with the following logic:

s/nand: raw:/rawnand:/

Otherwise I am fine with all the patches where I did not respond.

Thanks,
Miquèl
