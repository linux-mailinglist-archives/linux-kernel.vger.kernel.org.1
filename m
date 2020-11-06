Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CC42A922E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKFJM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:12:59 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:24597 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:12:59 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 6B2B7666D5D;
        Fri,  6 Nov 2020 17:12:55 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Wang Qing <wangqing@vivo.com>, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: fix a typo
Date:   Fri,  6 Nov 2020 17:12:49 +0800
Message-Id: <1604653971-20805-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSU1KQh5LQ0NCTRkZVkpNS09NTkhCTE5DTEtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6Ijo6MT8sThwOHA5MGgsQ
        PiswFDlVSlVKTUtPTU5IQkxNSEpDVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKQ0pJNwY+
X-HM-Tid: 0a759cd488a29373kuws6b2b7666d5d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

withing should be within.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/c6x/platforms/megamod-pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/c6x/platforms/megamod-pic.c b/arch/c6x/platforms/megamod-pic.c
index 56189e5..adac7ac
--- a/arch/c6x/platforms/megamod-pic.c
+++ b/arch/c6x/platforms/megamod-pic.c
@@ -165,7 +165,7 @@ static void __init set_megamod_mux(struct megamod_pic *pic, int src, int output)
  * The MUX map is an array of up to 12 cells; one for each usable core priority
  * interrupt. The value of a given cell is the megamodule interrupt source
  * which is to me MUXed to the output corresponding to the cell position
- * withing the array. The first cell in the array corresponds to priority
+ * within the array. The first cell in the array corresponds to priority
  * 4 and the last (12th) cell corresponds to priority 15. The allowed
  * values are 4 - ((NR_COMBINERS * 32) - 1). Note that the combined interrupt
  * sources (0 - 3) are not allowed to be mapped through this property. They
-- 
2.7.4

