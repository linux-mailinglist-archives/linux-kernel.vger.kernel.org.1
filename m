Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3E2BB3B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgKTSha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729793AbgKTSh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:37:28 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB2A224181;
        Fri, 20 Nov 2020 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897447;
        bh=5dWhuUO/oHpV2V7fo9QOdb69sHzl2L5kSFQKxqFnL80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYKUxepI2Y9w7Lw0LEgaRaXfpYiNPDk7cSrwfrhgtlX4wbX37LTxU+4yapG4Vvgat
         mxlOkDrnSQPFM21TDicZaqiIHD9PcM3fBCC7TdYlKVrfyI8ySsuaXSpGv1Lq8Uqvg/
         WeuqxqMaZg/rNwgQcRAwfUKbsmm1RPaYih4erYWM=
Date:   Fri, 20 Nov 2020 12:37:33 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 102/141] mtd: onenand: Fix fall-through warnings for Clang
Message-ID: <3579ecfc6f989699a1663ce0a7bcdd84f173c900.1605896060.git.gustavoars@kernel.org>
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
 drivers/mtd/nand/onenand/onenand_samsung.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index 87b28e397d67..b64895573515 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -396,6 +396,7 @@ static int s3c_onenand_command(struct mtd_info *mtd, int cmd, loff_t addr,
 	case ONENAND_CMD_READOOB:
 	case ONENAND_CMD_BUFFERRAM:
 		ONENAND_SET_NEXT_BUFFERRAM(this);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

