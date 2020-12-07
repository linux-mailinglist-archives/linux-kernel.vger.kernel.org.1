Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D62D0EB1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgLGLK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:10:28 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42885 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLGLK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:10:27 -0500
X-Originating-IP: 109.220.208.103
Received: from localhost.localdomain (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B19EC1BF20F;
        Mon,  7 Dec 2020 11:09:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        tudor.ambarus@microchip.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, robh+dt@kernel.org
Cc:     cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        richard@nod.at, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, qi-ming.wu@intel.com
Subject: Re: [PATCH v17 2/2] mtd: rawnand: Add NAND controller support on Intel LGM SoC
Date:   Mon,  7 Dec 2020 12:09:42 +0100
Message-Id: <20201207110942.8080-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To:  <20201110012333.18647-3-vadivel.muruganx.ramuthevar@linux.intel.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 613b6e4e3baa90de4dc16c4d12fa5463e89f966c
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-10 at 01:23:33 UTC, "Ramuthevar, Vadivel MuruganX" wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> This patch adds the new IP of Nand Flash Controller(NFC) support
> on Intel's Lightning Mountain(LGM) SoC.
> 
> DMA is used for burst data transfer operation, also DMA HW supports
> aligned 32bit memory address and aligned data access by default.
> DMA burst of 8 supported. Data register used to support the read/write
> operation from/to device.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
