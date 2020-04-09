Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDB1A304A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDIHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 03:36:30 -0400
Received: from spam01.hygon.cn ([110.188.70.11]:13396 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbgDIHg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:36:29 -0400
X-Greylist: delayed 1219 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2020 03:35:59 EDT
Received: from spam2.hygon.cn (localhost [127.0.0.2] (may be forged))
        by spam2.hygon.cn with ESMTP id 0397FbS0024891
        for <linux-kernel@vger.kernel.org>; Thu, 9 Apr 2020 15:15:37 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id 0397CWCm024636;
        Thu, 9 Apr 2020 15:12:32 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id 0397Ccjr052279;
        Thu, 9 Apr 2020 15:12:38 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from ubuntu.localdomain (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 9 Apr 2020
 15:12:16 +0800
From:   Jiasen Lin <linjiasen@hygon.cn>
To:     <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <jdmason@kudzu.us>, <dan.carpenter@oracle.com>
CC:     <allenbh@gmail.com>, <dave.jiang@intel.com>,
        <zhangpanyong@hygon.cn>, <linjiasen@hygon.cn>
Subject: [PATCH] NTB: Fix static check warning in perf_clear_test
Date:   Thu, 9 Apr 2020 00:11:24 -0700
Message-ID: <1586416284-3246-1-git-send-email-linjiasen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn 0397CWCm024636
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pthr->dma_chan can't be NULL in this context, so there is
no need to check pthr->dma_chan.

Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
---
 drivers/ntb/test/ntb_perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 972f6d9..f73b126 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1010,8 +1010,8 @@ static void perf_clear_test(struct perf_thread *pthr)
 				   pthr->perf->test_peer->dma_dst_addr,
 				   pthr->perf->test_peer->outbuf_size,
 				   DMA_FROM_DEVICE, 0);
-	if (pthr->dma_chan)
-		dma_release_channel(pthr->dma_chan);
+
+	dma_release_channel(pthr->dma_chan);
 
 no_dma_notify:
 	atomic_dec(&perf->tsync);
-- 
2.7.4

