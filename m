Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE992B9C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgKSVIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:08:14 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51931 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgKSVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:08:14 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 8D2B11BF205;
        Thu, 19 Nov 2020 21:08:11 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 16/23] mtd: rawnand: cafe_nand: Remove superfluous param doc and add another
Date:   Thu, 19 Nov 2020 22:08:10 +0100
Message-Id: <20201119210810.25643-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-17-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: ee5b8bfee9222bab46f0206b7c4c3853a2e42654
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:21:59 UTC, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/raw/cafe_nand.c:372: warning: Function parameter or member 'page' not described in 'cafe_nand_read_page'
>  drivers/mtd/nand/raw/cafe_nand.c:372: warning: Excess function parameter 'mtd' description in 'cafe_nand_read_page'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
