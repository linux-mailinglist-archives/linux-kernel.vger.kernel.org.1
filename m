Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DFD2B9CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgKSVIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:08:43 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:42085 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgKSVIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:08:42 -0500
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 500C3200007;
        Thu, 19 Nov 2020 21:08:39 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Dan Brown <dan_brown@ieee.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 15/23] mtd: rawnand: diskonchip: Marking unused variables as __always_unused
Date:   Thu, 19 Nov 2020 22:08:37 +0100
Message-Id: <20201119210837.25727-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-16-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: e4a81ebcc2557e9c1d7500d601983175981d34e1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:21:58 UTC, Lee Jones wrote:
> 'dummy' is never checked (as per the nomenclature) and the use of
> 'emtpymatch' is currently #if 0'ed out.  We could also #if 0 the
> declaration, but #ifery is pretty ugly, so I like to keep it to a
> minimum.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/raw/diskonchip.c: In function ‘DoC_Delay’:
>  drivers/mtd/nand/raw/diskonchip.c:219:16: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
>  drivers/mtd/nand/raw/diskonchip.c: In function ‘doc200x_calculate_ecc’:
>  drivers/mtd/nand/raw/diskonchip.c:706:6: warning: variable ‘emptymatch’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Dan Brown <dan_brown@ieee.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
