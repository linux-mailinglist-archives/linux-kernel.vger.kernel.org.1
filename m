Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5932B9CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgKSVQE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Nov 2020 16:16:04 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37575 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgKSVQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:16:04 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 04D19E0009;
        Thu, 19 Nov 2020 21:16:00 +0000 (UTC)
Date:   Thu, 19 Nov 2020 22:15:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YouChing Lin <ycllin@mxic.com.tw>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-mtd@lists.infradead.org,
        gch981213@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: macronix: Add support for MX35LFxGE4AD
Message-ID: <20201119221558.7b484949@xps13>
In-Reply-To: <20201119211133.31590-1-miquel.raynal@bootlin.com>
References: <1604490442-9052-1-git-send-email-ycllin@mxic.com.tw>
        <20201119211133.31590-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 19 Nov 2020
22:11:33 +0100:

> On Wed, 2020-11-04 at 11:47:22 UTC, YouChing Lin wrote:
> > The Macronix MX35LF2GE4AD / MX35LF4GE4AD are 3V, 2G / 4Gbit serial
> > SLC NAND flash device (with on-die ECC).
> > 
> > Validated by read, erase, read back, write, read back and nandtest
> > on Xilinx Zynq PicoZed FPGA board which included Macronix SPI Host
> > (drivers/spi/spi-mxic.c).
> > 
> > Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>  
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Please use "v2" as prefix next time you change something in your patch
instead of "RESEND", it confuses me. I applied the wrong patch, I will
drop this one and take the "RESEND, v1" instead.

Thanks,
Miquèl
