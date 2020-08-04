Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91C23BF00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 19:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgHDRne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 13:43:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56693 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgHDRne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:43:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k30y4-0004z3-QE; Tue, 04 Aug 2020 17:43:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Robert Richter <rric@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, oprofile-list@lists.sf.net,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/oprofile: fix spelling mistake "contex" -> "context"
Date:   Tue,  4 Aug 2020 18:43:16 +0100
Message-Id: <20200804174316.402425-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/oprofile/cell/spu_task_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/oprofile/cell/spu_task_sync.c b/arch/powerpc/oprofile/cell/spu_task_sync.c
index df59d0bb121f..489f993100d5 100644
--- a/arch/powerpc/oprofile/cell/spu_task_sync.c
+++ b/arch/powerpc/oprofile/cell/spu_task_sync.c
@@ -572,7 +572,7 @@ void spu_sync_buffer(int spu_num, unsigned int *samples,
 		 * samples are recorded.
 		 * No big deal -- so we just drop a few samples.
 		 */
-		pr_debug("SPU_PROF: No cached SPU contex "
+		pr_debug("SPU_PROF: No cached SPU context "
 			  "for SPU #%d. Dropping samples.\n", spu_num);
 		goto out;
 	}
-- 
2.27.0

