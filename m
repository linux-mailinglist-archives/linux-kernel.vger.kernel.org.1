Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F852A65EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgKDOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:09:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730019AbgKDOJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:31 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73B62236F;
        Wed,  4 Nov 2020 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498970;
        bh=xT2IyVREpRvgS9f8hyYduDeoZTy/pP/MnHu6daFUncU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfJlVCF12MLCdwetfifErc2ywLwrCx1TUrWet2ARfxKZGzLJNa+89Sfc/NrOgsBdP
         0fPQoYQB66Ko5Wi8aOEYw26A/XjEZZi3hN8CXui04W843423CD643D5RR5OH9H2GkA
         mcHpse8VsDNcDph2uYA0lW2FRqlJhcsJzjzQw2uA=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: restore vm_pgoff after mmap
Date:   Wed,  4 Nov 2020 16:09:05 +0200
Message-Id: <20201104140908.10178-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to using dma_mmap_coherent() to perform mmap of dma memory, we
had to clear the vm_pgoff field before calling that function.

However, that broke the userspace (profiler tool) as they relied
on searching the /proc/self/maps for these values to correctly
"disassemble" the topology recipe.

To re-enable that functionality, the driver can simply restore the
value of vm_pgoff before returning to userspace but after calling
dma_mmap_coherent().

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 360dc340b2f4..b30249e4d3b7 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -518,6 +518,7 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 	}
 
 	cb->mmap_size = cb->size;
+	vma->vm_pgoff = handle;
 
 	return 0;
 
-- 
2.17.1

