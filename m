Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D083D2B9C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgKSVIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:08:00 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40945 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgKSVH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:07:59 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1BAEB1BF204;
        Thu, 19 Nov 2020 21:07:56 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/23] mtd: rawnand: omap_elm: Finish half populated function header, demote empty ones
Date:   Thu, 19 Nov 2020 22:07:56 +0100
Message-Id: <20201119210756.25480-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-19-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 7e1172c3404f32424a843edc86cef2aee0b8848b
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:22:01 UTC, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/raw/omap_elm.c:102: warning: Function parameter or member 'ecc_steps' not described in 'elm_config'
>  drivers/mtd/nand/raw/omap_elm.c:102: warning: Function parameter or member 'ecc_step_size' not described in 'elm_config'
>  drivers/mtd/nand/raw/omap_elm.c:102: warning: Function parameter or member 'ecc_syndrome_size' not described in 'elm_config'
>  drivers/mtd/nand/raw/omap_elm.c:440: warning: Function parameter or member 'info' not described in 'elm_context_save'
>  drivers/mtd/nand/raw/omap_elm.c:488: warning: Function parameter or member 'info' not described in 'elm_context_restore'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
