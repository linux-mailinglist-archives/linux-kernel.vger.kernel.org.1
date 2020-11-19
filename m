Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221E92B9CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgKSVJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:09:00 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:51769 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKSVI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:08:59 -0500
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 83F30240005;
        Thu, 19 Nov 2020 21:08:56 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 13/23] mtd: rawnand: brcmnand: Demote non-conformant kernel-doc headers
Date:   Thu, 19 Nov 2020 22:08:55 +0100
Message-Id: <20201119210855.25964-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-14-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: ace13d23b2880c9e41e0344d62625dbe289191a3
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:21:56 UTC, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'host' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'addr' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'buf' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'len' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'cmd' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'host' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'desc' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'addr' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'buf' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'len' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'dma_cmd' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'begin' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'end' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'next_desc' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1977: warning: Function parameter or member 'host' not described in 'brcmnand_dma_run'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1977: warning: Function parameter or member 'desc' not described in 'brcmnand_dma_run'
> 
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
