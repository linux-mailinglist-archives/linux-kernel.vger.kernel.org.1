Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579011E01F7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 21:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbgEXTR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 15:17:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49909 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbgEXTR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:17:27 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 30A2320004;
        Sun, 24 May 2020 19:17:26 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Remove Xiaolei Li and mark MTK NFC as orphaned
Date:   Sun, 24 May 2020 21:17:25 +0200
Message-Id: <20200524191725.30606-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510211809.15610-2-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 2d1b77281f36aa8adce00260918058a4440c889c
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-10 at 21:18:09 UTC, Miquel Raynal wrote:
> Xiaolei's address is bouncing, remove him from MAINTAINERS and mark
> the driver he was maintaining, Mediatek's, as orphaned.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next.

Miquel
