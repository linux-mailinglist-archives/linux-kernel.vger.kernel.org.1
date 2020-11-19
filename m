Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F29D2B9CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgKSVOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:14:42 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:41685 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgKSVOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:14:42 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 89735240009;
        Thu, 19 Nov 2020 21:14:38 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YouChing Lin <ycllin@mxic.com.tw>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND, PATCH v1] mtd: spinand: macronix: Add support for MX35LFxGE4AD
Date:   Thu, 19 Nov 2020 22:14:38 +0100
Message-Id: <20201119211438.7571-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1604561020-13499-1-git-send-email-ycllin@mxic.com.tw>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 0326b52e7bf18904a4fee54689851ccd81b57d27
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-05 at 07:23:40 UTC, YouChing Lin wrote:
> The Macronix MX35LF2GE4AD / MX35LF4GE4AD are 3V, 2G / 4Gbit serial
> SLC NAND flash device (with on-die ECC).
> 
> Validated by read, erase, read back, write, read back and nandtest
> on Xilinx Zynq PicoZed FPGA board which included Macronix SPI Host
> (drivers/spi/spi-mxic.c).
> 
> Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
