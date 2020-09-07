Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6625F3D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 09:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgIGHWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 03:22:19 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37867 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgIGHWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:22:15 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 68CE42000A;
        Mon,  7 Sep 2020 07:22:11 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YouChing Lin <ycllin@mxic.com.tw>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: spinand: macronix: Add support for MX31UF1GE4BC
Date:   Mon,  7 Sep 2020 09:22:10 +0200
Message-Id: <20200907072210.3566-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1595404978-31079-3-git-send-email-ycllin@mxic.com.tw>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 2a3472738184cd6857d506b94a4f97eb7339ddc9
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-22 at 08:02:58 UTC, YouChing Lin wrote:
> The Macronix MX31UF1GE4BC is a 1.8V, 1Gbit (128MB) serial
> NAND flash device.
> 
> Validated by read, erase, read back, write and read back
> on Xilinx Zynq PicoZed FPGA board which included
> Macronix SPI Host (driver/spi/spi-mxic.c).
> 
> Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
