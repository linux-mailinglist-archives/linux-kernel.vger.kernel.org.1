Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DFC27B06C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgI1PAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:00:25 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57069 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgI1PAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:00:24 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 5F7DEFF81A;
        Mon, 28 Sep 2020 15:00:21 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santiago Esteban <santiago.esteban@microchip.com>
Subject: Re: [PATCH 1/3] mtd: rawnand: Fix wrongful fallthrough NAND_ECC_SOFT
Date:   Mon, 28 Sep 2020 17:00:19 +0200
Message-Id: <20200928150019.9404-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200917075213.532161-2-tudor.ambarus@microchip.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 86adb4473ce9bf59d2b069264f69322bd8bb5a5f
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-17 at 07:52:11 UTC, Tudor Ambarus wrote:
> In case of valid HW ECC, where the fallback to SW ECC is not needed,
> the mentioned commit breaks the "switch (ecc->placement)" statement,
> but then wrongly falls through the "case NAND_ECC_SOFT" of the
> parent "switch (ecc->mode)". This causes an -EINVAL in
> nand_set_ecc_soft_ops(), because for the valid HW ECC cases
> ecc->mode is set to NAND_ECC_HW, but the nand_set_ecc_soft_ops()
> expects a NAND_ECC_SOFT mode, thus -EINVAL.
> 
> Move the fallback to SW ECC after the setting of the ECC on host ops.
> With this, when a valid HW ECC is available, we break the
> "switch (ecc->mode)" statement, and when a fallback to SW ECC is
> needed, we fallthrough "case NAND_ECC_SOFT".
> 
> Fixes: d3f8ec8e979b ("mtd: rawnand: Separate the ECC engine type and the ECC byte placement")
> Reported-by: Santiago Esteban <santiago.esteban@microchip.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
