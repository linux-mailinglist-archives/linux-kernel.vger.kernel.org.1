Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652A41B5B12
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgDWMIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 08:08:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgDWMIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:08:04 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 153698BCD0DA6E427896
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:08:02 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 20:07:53 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mailbox: PCC: Make pcc_mbox_driver static
Date:   Thu, 23 Apr 2020 20:14:10 +0800
Message-ID: <1587644050-32420-1-git-send-email-zou_wei@huawei.com>
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

drivers/mailbox/pcc.c:571:24: warning: symbol 'pcc_mbox_driver'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 34844b7..8c7fac3 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -568,7 +568,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	return ret;
 }
 
-struct platform_driver pcc_mbox_driver = {
+static struct platform_driver pcc_mbox_driver = {
 	.probe = pcc_mbox_probe,
 	.driver = {
 		.name = "PCCT",
-- 
2.6.2

