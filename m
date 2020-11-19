Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6E2B9C97
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKSVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:07:24 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59181 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgKSVHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:07:23 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 38C10C0006;
        Thu, 19 Nov 2020 21:07:17 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 23/23] mtd: devices: powernv_flash: Add function names to headers and fix 'dev'
Date:   Thu, 19 Nov 2020 22:07:16 +0100
Message-Id: <20201119210716.25046-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-24-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 30e98cd953d769136c6d859e0b7c4fc780296503
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:22:06 UTC, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/devices/powernv_flash.c:129: warning: Cannot understand  * @mtd: the device
>  drivers/mtd/devices/powernv_flash.c:145: warning: Cannot understand  * @mtd: the device
>  drivers/mtd/devices/powernv_flash.c:161: warning: Cannot understand  * @mtd: the device
>  drivers/mtd/devices/powernv_flash.c:184: warning: Function parameter or member 'dev' not described in 'powernv_flash_set_driver_info'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linux-mtd@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
