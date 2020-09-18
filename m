Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF0526F123
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgIRCtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:49:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730306AbgIRCsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:48:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B67D5D27B7108AEF2E08;
        Fri, 18 Sep 2020 10:48:50 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 10:48:43 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] w1: ds28e17: use module_w1_family to simplify the code
Date:   Fri, 18 Sep 2020 11:11:15 +0800
Message-ID: <20200918031115.3982776-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_w1_family() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/w1/slaves/w1_ds28e17.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
index 046ddda83df9..d165aa9d803f 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -751,19 +751,4 @@ static struct w1_family w1_family_19 = {
 	.fid = W1_FAMILY_DS28E17,
 	.fops = &w1_f19_fops,
 };
-
-
-/* Module init and remove functions. */
-static int __init w1_f19_init(void)
-{
-	return w1_register_family(&w1_family_19);
-}
-
-static void __exit w1_f19_fini(void)
-{
-	w1_unregister_family(&w1_family_19);
-}
-
-module_init(w1_f19_init);
-module_exit(w1_f19_fini);
-
+module_w1_family(w1_family_19);
-- 
2.25.1

