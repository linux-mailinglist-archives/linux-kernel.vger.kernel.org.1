Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CCB2DDE91
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 07:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbgLRGZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 01:25:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9228 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgLRGZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 01:25:16 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CxzMg68jMzkrL7;
        Fri, 18 Dec 2020 14:23:43 +0800 (CST)
Received: from localhost (10.174.184.155) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Fri, 18 Dec 2020
 14:24:27 +0800
From:   Jiahui Cen <cenjiahui@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Wei Xu <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <xieyingtai@huawei.com>, Jiahui Cen <cenjiahui@huawei.com>
Subject: [PATCH] lib/logic_pio: Fix overlap check for pio registery
Date:   Fri, 18 Dec 2020 14:23:35 +0800
Message-ID: <20201218062335.5320-1-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the [start, end) is a half-open interval, a range with the end equal
to the start of another range should not be considered as overlapped.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
---
 lib/logic_pio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index f32fe481b492..445d611f1dc1 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -57,7 +57,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 		    new_range->flags == LOGIC_PIO_CPU_MMIO) {
 			/* for MMIO ranges we need to check for overlap */
 			if (start >= range->hw_start + range->size ||
-			    end < range->hw_start) {
+			    end <= range->hw_start) {
 				mmio_end = range->io_start + range->size;
 			} else {
 				ret = -EFAULT;
-- 
2.28.0

