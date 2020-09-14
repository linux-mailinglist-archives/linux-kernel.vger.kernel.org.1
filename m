Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7B268346
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 05:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgINDzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 23:55:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbgINDzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:55:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8BD54B3DD203246DF187;
        Mon, 14 Sep 2020 11:55:22 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 11:55:12 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Li Yang <leoyang.li@nxp.com>
CC:     <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] soc/qman: convert to use be32_add_cpu()
Date:   Mon, 14 Sep 2020 12:17:52 +0800
Message-ID: <20200914041752.3702104-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
drivers/soc/fsl/qbman/qman_test_api.c---
 drivers/soc/fsl/qbman/qman_test_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman_test_api.c b/drivers/soc/fsl/qbman/qman_test_api.c
index 2895d062cf51..7066b2f1467c 100644
--- a/drivers/soc/fsl/qbman/qman_test_api.c
+++ b/drivers/soc/fsl/qbman/qman_test_api.c
@@ -86,7 +86,7 @@ static void fd_inc(struct qm_fd *fd)
 	len--;
 	qm_fd_set_param(fd, fmt, off, len);
 
-	fd->cmd = cpu_to_be32(be32_to_cpu(fd->cmd) + 1);
+	be32_add_cpu(&fd->cmd, 1);
 }
 
 /* The only part of the 'fd' we can't memcmp() is the ppid */
-- 
2.25.1

