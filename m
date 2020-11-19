Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55A22B9C78
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgKSVFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:05:37 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42487 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgKSVFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:05:37 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 881FF1C0007;
        Thu, 19 Nov 2020 21:05:34 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Baskov Evgeiny <baskov@ispras.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     ldv-project@linuxtesting.org, Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd-ram: correctly free memory on error path in platram_probe()
Date:   Thu, 19 Nov 2020 22:05:33 +0100
Message-Id: <20201119210533.23671-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113160537.899-1-baskov@ispras.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: e0e1153084bc04b055787b0b8ef664024c6e2ced
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-13 at 16:05:37 UTC, Baskov Evgeiny wrote:
> If an error happens in mtd_device_parse_register or mtd_device_register,
> memory allocated for struct platram_info is leaked.
> 
> Make platram_probe() call platram_remove() on all error paths
> after struct platram_info allocation to correctly free resources.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Baskov Evgeiny <baskov@ispras.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
