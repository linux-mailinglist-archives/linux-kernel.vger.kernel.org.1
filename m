Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A968A283C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgJEQMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgJEQMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:12:44 -0400
Received: from hump.ibmuc.com (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4DCB206DD;
        Mon,  5 Oct 2020 16:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601914364;
        bh=46wSMdq5RlcK/6mnsJmGrm+9ho+IPIx2GRlGSTCDeDg=;
        h=From:To:Cc:Subject:Date:From;
        b=zyYBXnlxC9t8tqBoyOvseoObLClTnx7Gj2TNCbspp0cMoQ32Ps96tX9z4DzEyWWNV
         EfPtkz4JL3y0YTSG1mVorsOI9YYeoG2Myrhfay+firgE3GMIXIe4nbUgx2WA3bri+g
         zpEosBFAs2a1DIQbWavq6JH38Vms1izEftV38how=
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] ARC: SMP: fix typo and use "come up" instead of "comeup"
Date:   Mon,  5 Oct 2020 19:12:37 +0300
Message-Id: <20201005161237.196566-1-rppt@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

When a secondary CPU fails to come up, there is a missing space in the
log:

	Timeout: CPU1 FAILED to comeup !!!

Fix it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index eca35e02ce06..52906d314537 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -226,7 +226,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	}
 
 	if (!cpu_online(cpu)) {
-		pr_info("Timeout: CPU%u FAILED to comeup !!!\n", cpu);
+		pr_info("Timeout: CPU%u FAILED to come up !!!\n", cpu);
 		return -1;
 	}
 
-- 
2.25.4

