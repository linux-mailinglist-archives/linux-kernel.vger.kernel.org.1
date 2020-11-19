Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA82B9CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgKSVLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:11:47 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47339 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgKSVLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:11:45 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8E693FF803;
        Thu, 19 Nov 2020 21:11:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yu Kuai <yukuai3@huawei.com>, paul@crapouillou.net,
        harveyhuntnexus@gmail.com, miquel.raynal@bootlin.com,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] mtd: rawnand: ingenic: remove redundant get_device() in ingenic_ecc_get()
Date:   Thu, 19 Nov 2020 22:11:42 +0100
Message-Id: <20201119211142.31720-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201031105439.2304211-1-yukuai3@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 9f14bf29d6ba0d18dc5175bbf22a07ec3dc67f23
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-31 at 10:54:39 UTC, Yu Kuai wrote:
> of_find_device_by_node() already takes a reference to the device, and
> ingenic_ecc_release() will drop the reference. So, the get_device() in
> ingenic_ecc_get() is redundand.
> 
> Fixes: 15de8c6efd0e("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Acked-by: Paul Cercueil <paul@crapouillou.net>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
