Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787C12D6A14
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394119AbgLJVje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:39:34 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:56449 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394078AbgLJVjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:39:33 -0500
Received: from localhost.localdomain (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4C4FC200004;
        Thu, 10 Dec 2020 21:38:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YouChing Lin <ycllin@mxic.com.tw>, miquel.raynal@bootlin.com,
        vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: spinand: macronix: Add support for MX35LFxG24AD
Date:   Thu, 10 Dec 2020 22:38:46 +0100
Message-Id: <20201210213846.9508-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1607570529-22341-3-git-send-email-ycllin@mxic.com.tw>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: ee4e0eafa43cfd9008722fe15e17b8bf62fb6e8d
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-10 at 03:22:09 UTC, YouChing Lin wrote:
> The Macronix MX35LF1G24AD(/2G24AD/4G24AD) are 3V, 1G/2G/4Gbit serial
> SLC NAND flash device (without on-die ECC).
> 
> Validated by read, erase, read back, write, read back on Xilinx Zynq
> PicoZed FPGA board which included Macronix SPI Host(drivers/spi/spi-mxic.c)
> & S/W BCH ecc(drivers/mtd/nand/ecc-sw-bch.c) with bug fixing patch
> (mtd: nand: ecc-bch: Fix the size of calc_buf/code_buf of the BCH).
> 
> Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
