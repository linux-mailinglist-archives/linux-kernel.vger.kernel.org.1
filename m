Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE0B1C8790
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 13:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgEGLH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 07:07:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbgEGLH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:07:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A3436C3DCBDDF1752CA0;
        Thu,  7 May 2020 19:07:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 19:07:16 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <axboe@kernel.dk>, <b.zolnierkie@samsung.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ata: return true in ata_is_host_link()
Date:   Thu, 7 May 2020 19:06:37 +0800
Message-ID: <20200507110637.37341-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

include/linux/libata.h:1446:8-9: WARNING: return of 0/1 in function
'ata_is_host_link' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 include/linux/libata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8bf5e59a7859..e05a8ed2e31e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1443,7 +1443,7 @@ static inline bool sata_pmp_attached(struct ata_port *ap)
 
 static inline bool ata_is_host_link(const struct ata_link *link)
 {
-	return 1;
+	return true;
 }
 #endif /* CONFIG_SATA_PMP */
 
-- 
2.21.1

