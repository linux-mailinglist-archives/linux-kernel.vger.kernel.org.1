Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B01A9637
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635875AbgDOIWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 04:22:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2635867AbgDOIWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:22:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8FB6EBE898881FBAF5;
        Wed, 15 Apr 2020 16:22:35 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 16:22:25 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <sstabellini@kernel.org>, <linux@armlinux.org.uk>,
        <xen-devel@lists.xenproject.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] arm/xen: make _xen_start_info static
Date:   Wed, 15 Apr 2020 16:48:53 +0800
Message-ID: <20200415084853.5808-1-yanaijie@huawei.com>
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

Fix the following sparse warning:

arch/arm64/xen/../../arm/xen/enlighten.c:39:19: warning: symbol
'_xen_start_info' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/arm/xen/enlighten.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index dd6804a64f1a..fd4e1ce1daf9 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -36,7 +36,7 @@
 
 #include <linux/mm.h>
 
-struct start_info _xen_start_info;
+static struct start_info _xen_start_info;
 struct start_info *xen_start_info = &_xen_start_info;
 EXPORT_SYMBOL(xen_start_info);
 
-- 
2.21.1

