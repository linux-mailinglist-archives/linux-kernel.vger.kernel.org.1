Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A357127B069
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgI1PAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:00:04 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42745 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1PAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:00:02 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 5DDD91C0004;
        Mon, 28 Sep 2020 14:59:59 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-mtd@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mtd: rawnand: ams-delta: Fix non-OF build warning
Date:   Mon, 28 Sep 2020 16:59:57 +0200
Message-Id: <20200928145957.9218-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200919080403.17520-1-jmkrzyszt@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 57a57f268ec97432fb99df8d8e8957e86b34a9d6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-09-19 at 08:04:03 UTC, Janusz Krzysztofik wrote:
> Commit 7c2f66a960fc ("mtd: rawnand: ams-delta: Add module device
> tables") introduced an OF module device table but wrapped a reference
> to it with of_match_ptr() which resolves to NULL in non-OF configs.
> That resulted in a clang compiler warning on unused variable in non-OF
> builds.  Fix it.
> 
> drivers/mtd/nand/raw/ams-delta.c:373:34: warning: unused variable 'gpio_nand_of_id_table' [-Wunused-const-variable]
>    static const struct of_device_id gpio_nand_of_id_table[] = {
>                                     ^
>    1 warning generated.
> 
> Fixes: 7c2f66a960fc ("mtd: rawnand: ams-delta: Add module device tables")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
