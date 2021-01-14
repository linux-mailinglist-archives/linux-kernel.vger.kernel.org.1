Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A362F6523
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbhANPsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:48:46 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48951 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbhANPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:45 -0500
X-Originating-IP: 86.201.233.230
Received: from localhost.localdomain (lfbn-tou-1-151-230.w86-201.abo.wanadoo.fr [86.201.233.230])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 40F61E0018;
        Thu, 14 Jan 2021 15:47:59 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: intel: check the mtd name only after setting the variable
Date:   Thu, 14 Jan 2021 16:47:58 +0100
Message-Id: <20210114154758.32030-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106140943.98072-1-martin.blumenstingl@googlemail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 18f62614308be69a2752afb5f6bbad60096ad774
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-06 at 14:09:43 UTC, Martin Blumenstingl wrote:
> Move the check for mtd->name after the mtd variable has actually been
> initialized.
> 
> While here, also drop the NULL assignment to the mtd variable as it's
> overwritten later on anyways and the NULL value is never read.
> 
> Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
