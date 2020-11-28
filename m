Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF22C72D9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbgK1WI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 17:08:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730911AbgK1WIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:08:53 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8D321527;
        Sat, 28 Nov 2020 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606601293;
        bh=sHqXZ2Li5yhKuFY6HHGckhOLIqjOyBwnWKw9v63z1Tk=;
        h=From:To:Cc:Subject:Date:From;
        b=UASxuEZO+8R556aXkbBYeiur+4HwEcw6uj+mN5puCgoQv/zd3cHKsXi38uRRpzs/o
         ZLFiD2GVeWBNrQGT9CE3nNXDk5qWYFjqbKqvRakqRyiMQ0sRN6JIfvYhMiXzx0caKy
         uPSZHxB2RTHpfIK+/pu+Ev8b1rKLrd+GeFaHc8nE=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: free host huge va_range if not used
Date:   Sun, 29 Nov 2020 00:08:07 +0200
Message-Id: <20201128220807.21638-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

If huge range is not valid, driver uses the host range also for
huge page allocations, but driver never frees its allocation.
This introduces a memory leak every time a user closes its context.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 84227819e4d1..bfe223abf142 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1626,6 +1626,7 @@ static int vm_ctx_init_with_ranges(struct hl_ctx *ctx,
 			goto host_hpage_range_err;
 		}
 	} else {
+		kfree(ctx->host_huge_va_range);
 		ctx->host_huge_va_range = ctx->host_va_range;
 	}
 
-- 
2.17.1

