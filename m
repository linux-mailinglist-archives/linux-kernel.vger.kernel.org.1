Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7C2BB3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgKTShi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730315AbgKTShg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:37:36 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CDB24654;
        Fri, 20 Nov 2020 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897456;
        bh=2bhoMmVygSUPKT93A0DAHGg2hZg6OEYngPqQhxzi7tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4wIZXPclmEBR9oWZSh3r4QafP0RM3CQ6A2K1P79N5DRNPh2wOMO9lwZ1XgIgrA9s
         w6ajaGuDdbIwP2Bh88++DYv1tnRUtDeMGr0jtV2LrCz/ac3lqgo01hPX97FscNe0EX
         t6uI+wp5ahdWHPITurZSdPOHpHqDg1eTuuHfuSCg=
Date:   Fri, 20 Nov 2020 12:37:42 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 103/141] mtd: rawnand: fsmc: Fix fall-through warnings for
 Clang
Message-ID: <3020f35812cb74a63323bcc36971aa598a5e3730.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 4191831df182..273626d49769 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -916,6 +916,7 @@ static int fsmc_nand_attach_chip(struct nand_chip *nand)
 				 "Using 4-bit SW BCH ECC scheme\n");
 			break;
 		}
+		break;
 
 	case NAND_ECC_ENGINE_TYPE_ON_DIE:
 		break;
-- 
2.27.0

