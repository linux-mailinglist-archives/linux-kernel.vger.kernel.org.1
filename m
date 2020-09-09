Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED28B262D68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 12:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgIIKtV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Sep 2020 06:49:21 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46941 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgIIKtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:49:07 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id CB5661BF213;
        Wed,  9 Sep 2020 10:48:57 +0000 (UTC)
Date:   Wed, 9 Sep 2020 12:48:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: spinand: micron: add support for MT29F2G01AAAED
Message-ID: <20200909124856.09afd61b@xps13>
In-Reply-To: <20200909104442.22171-1-nthirumalesha7@gmail.com>
References: <20200909104442.22171-1-nthirumalesha7@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thirumalesha,

Thirumalesha Narasimhappa <nthirumalesha7@gmail.com> wrote on Wed,  9
Sep 2020 18:44:42 +0800:

> The MT29F2G01AAAED is a single die, 2Gb Micron SPI NAND Flash with 4-bit
> ECC
> 
> Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
> ---

Changelog, please?

>  drivers/mtd/nand/spi/micron.c | 141 ++++++++++++++++++++++++----------
>  1 file changed, 101 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 5d370cfcdaaa..fa8c20f37611 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -28,7 +28,7 @@

Thanks,
Miquèl
