Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725FA2B9CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKSVKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:10:50 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54369 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgKSVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:10:50 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2B9DFC0007;
        Thu, 19 Nov 2020 21:10:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 06/23] mtd: onenand: onenand_bbt: Fix expected kernel-doc formatting
Date:   Thu, 19 Nov 2020 22:10:46 +0100
Message-Id: <20201119211046.26837-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-7-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 7ea513602cc6ef3fd605ec801654b15e6384e74c
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:21:49 UTC, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/onenand/onenand_bbt.c:33: warning: Function parameter or member 'buf' not described in 'check_short_pattern'
>  drivers/mtd/nand/onenand/onenand_bbt.c:33: warning: Function parameter or member 'len' not described in 'check_short_pattern'
>  drivers/mtd/nand/onenand/onenand_bbt.c:33: warning: Function parameter or member 'paglen' not described in 'check_short_pattern'
>  drivers/mtd/nand/onenand/onenand_bbt.c:33: warning: Function parameter or member 'td' not described in 'check_short_pattern'
>  drivers/mtd/nand/onenand/onenand_bbt.c:57: warning: Function parameter or member 'mtd' not described in 'create_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:57: warning: Function parameter or member 'buf' not described in 'create_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:57: warning: Function parameter or member 'bd' not described in 'create_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:57: warning: Function parameter or member 'chip' not described in 'create_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:132: warning: Function parameter or member 'mtd' not described in 'onenand_memory_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:132: warning: Function parameter or member 'bd' not described in 'onenand_memory_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:145: warning: Function parameter or member 'mtd' not described in 'onenand_isbad_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:145: warning: Function parameter or member 'offs' not described in 'onenand_isbad_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:145: warning: Function parameter or member 'allowbbt' not described in 'onenand_isbad_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:182: warning: Function parameter or member 'mtd' not described in 'onenand_scan_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:182: warning: Function parameter or member 'bd' not described in 'onenand_scan_bbt'
>  drivers/mtd/nand/onenand/onenand_bbt.c:230: warning: Function parameter or member 'mtd' not described in 'onenand_default_bbt'
> 
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
