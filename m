Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143A71CA78F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 11:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEHJwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 05:52:24 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:59216
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgEHJwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:52:23 -0400
X-IronPort-AV: E=Sophos;i="5.73,367,1583190000"; 
   d="scan'208";a="348097894"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 08 May 2020 11:52:21 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nic Volanschi <eugene.volanschi@inria.fr>
Subject: [PATCH] powerpc/spufs: adjust list element pointer type
Date:   Fri,  8 May 2020 11:12:56 +0200
Message-Id: <1588929176-28527-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other uses of &gang->aff_list_head, eg in spufs_assert_affinity, indicate
that the list elements have type spu_context, not spu as used here.  Change
the type of tmp accordingly.

This has no impact on the execution, because tmp is not used in the body of
the loop.

Fixes: c5fc8d2a92461 ("[CELL] cell: add placement computation for scheduling of affinity contexts")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/powerpc/platforms/cell/spufs/sched.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index f18d5067cd0f..487fcb47f10d 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -344,8 +344,7 @@ static struct spu *aff_ref_location(struct spu_context *ctx, int mem_aff,
 static void aff_set_ref_point_location(struct spu_gang *gang)
 {
 	int mem_aff, gs, lowest_offset;
-	struct spu_context *ctx;
-	struct spu *tmp;
+	struct spu_context *tmp, *ctx;
 
 	mem_aff = gang->aff_ref_ctx->flags & SPU_CREATE_AFFINITY_MEM;
 	lowest_offset = 0;

