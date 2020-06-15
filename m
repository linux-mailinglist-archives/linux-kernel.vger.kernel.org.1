Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD61FA3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 01:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgFOXCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 19:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:02:52 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833EB206B7;
        Mon, 15 Jun 2020 23:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592262171;
        bh=2fY6x6btMBGUWDGltZvwP9IaFu4qoglTHiwDo9vpb/U=;
        h=Date:From:To:Cc:Subject:From;
        b=g5cHDt68M/meaEKU1f97f0CLzvuXsjJiY9mlxth+B3JPAZBgVHwzM60WynMnhxZ9X
         AYuNd6fYNYGF5keGR4oS9VQ2aWlHckv308xgCuU+IKhAjiO2KQP9EzWOW/kD590LMW
         8iVHjeFZ3CiDbYdVhIinFkL1GvlQ2zpVMwpE3xJQ=
Date:   Mon, 15 Jun 2020 18:08:11 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] staging: rts5208: Use array_size() helper in vmalloc()
Message-ID: <20200615230811.GA18818@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and memset()

The vmalloc() function has no 2-factor argument form, so multiplication
factors need to be wrapped in array_size(). Also, while there, use
array_size() in memset().

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/rts5208/ms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index d53dd138a356..9001570a8c94 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -2306,14 +2306,14 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 		if (!segment->l2p_table)
 			goto BUILD_FAIL;
 	}
-	memset((u8 *)(segment->l2p_table), 0xff, table_size * 2);
+	memset((u8 *)(segment->l2p_table), 0xff, array_size(table_size, 2));
 
 	if (!segment->free_table) {
-		segment->free_table = vmalloc(MS_FREE_TABLE_CNT * 2);
+		segment->free_table = vmalloc(array_size(MS_FREE_TABLE_CNT, 2));
 		if (!segment->free_table)
 			goto BUILD_FAIL;
 	}
-	memset((u8 *)(segment->free_table), 0xff, MS_FREE_TABLE_CNT * 2);
+	memset((u8 *)(segment->free_table), 0xff, array_size(MS_FREE_TABLE_CNT, 2));
 
 	start = (u16)seg_no << 9;
 	end = (u16)(seg_no + 1) << 9;
-- 
2.27.0

