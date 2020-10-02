Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225D8280DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgJBHP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:15:26 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38911 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBHP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:15:26 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EFA5B1BF217;
        Fri,  2 Oct 2020 07:15:20 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        open list <linux-kernel@vger.kernel.org>,
        =?utf-8?q?=C3=81lvaro_Fern=C3=A1n?= =?utf-8?q?dez_Rojas?= 
        <noltari@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH] mtd: parsers: bcm63xx: Do not make it modular
Date:   Fri,  2 Oct 2020 09:15:19 +0200
Message-Id: <20201002071519.26282-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200929172726.30469-1-f.fainelli@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b597cc75f7fe76708bc6ab3f0e09bbff6f09ae4a
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-29 at 17:27:21 UTC, Florian Fainelli wrote:
> With commit 91e81150d388 ("mtd: parsers: bcm63xx: simplify CFE
> detection"), we generate a reference to fw_arg3 which is the fourth
> firmware/command line argument on MIPS platforms. That symbol is not
> exported and would cause a linking failure.
> 
> The parser is typically necessary to boot a BCM63xx-based system anyway
> so having it be part of the kernel image makes sense, therefore make it
> 'bool' instead of 'tristate'.
> 
> Fixes: 91e81150d388 ("mtd: parsers: bcm63xx: simplify CFE detection")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
