Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076D41CEA82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 04:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgELCGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 22:06:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4335 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728452AbgELCGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:06:21 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B9529A8BC8D1999137CE;
        Tue, 12 May 2020 10:06:19 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 12 May 2020 10:06:13 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] drivers: soc: ti: knav_qmss_queue: Make knav_gp_range_ops static
Date:   Tue, 12 May 2020 10:12:20 +0800
Message-ID: <1589249540-105611-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/soc/ti/knav_qmss_queue.c:412:23: warning: symbol 'knav_gp_range_ops' was not declared.

The knav_acc_firmwares has only call site within knav_qmss_queue.c
It should be static

Fixes: 41f93af900a2 ("soc: ti: add Keystone Navigator QMSS driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 37f3db6..aa071d9 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -409,7 +409,7 @@ static int knav_gp_close_queue(struct knav_range_info *range,
 	return 0;
 }
 
-struct knav_range_ops knav_gp_range_ops = {
+static struct knav_range_ops knav_gp_range_ops = {
 	.set_notify	= knav_gp_set_notify,
 	.open_queue	= knav_gp_open_queue,
 	.close_queue	= knav_gp_close_queue,
-- 
2.6.2

