Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598432B9CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKSVK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:10:57 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33979 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgKSVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:10:56 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E76BFC000C;
        Thu, 19 Nov 2020 21:10:53 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Dahl <ada@thorsis.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 05/23] mtd: Fix misspelled function parameter 'section'
Date:   Thu, 19 Nov 2020 22:10:53 +0100
Message-Id: <20201119211053.26927-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-6-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 90169f4947f677ca33d91fa0c208dcd75a46d66a
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:21:48 UTC, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/mtdcore.c:1592: warning: Function parameter or member 'section' not described in 'mtd_ooblayout_find_eccregion'
>  drivers/mtd/mtdcore.c:1592: warning: Excess function parameter 'sectionp' description in 'mtd_ooblayout_find_eccregion'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Alexander Dahl <ada@thorsis.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
