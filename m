Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B026650C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgIKQvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:51:23 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59261 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIKQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:50:21 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3AF331C0006;
        Fri, 11 Sep 2020 16:50:11 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     artem.bityutskiy@linux.intel.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: mtdoops: Don't write panic data twice
Date:   Fri, 11 Sep 2020 18:50:10 +0200
Message-Id: <20200911165010.27563-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903034217.23079-1-mark.tomlinson@alliedtelesis.co.nz>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: c1cf1d57d1492235309111ea6a900940213a9166
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-03 at 03:42:17 UTC, Mark Tomlinson wrote:
> If calling mtdoops_write, don't also schedule work to be done later.
> 
> Although this appears to not be causing an issue, possibly because the
> scheduled work will never get done, it is confusing.
> 
> Fixes: 016c1291ce70 ("mtd: mtdoops: do not use mtd->panic_write directly")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
