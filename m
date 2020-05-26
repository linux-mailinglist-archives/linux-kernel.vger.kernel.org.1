Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A71C8BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 15:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgEGNMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 09:12:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3893 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgEGNMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:12:22 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A3971C6448F711E9D0C2;
        Thu,  7 May 2020 21:12:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 21:12:10 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <akpm@linux-foundation.org>, <keescook@chromium.org>,
        <andriy.shevchenko@linux.intel.com>, <peterz@infradead.org>,
        <gpiccoli@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] kernel.h: remove duplicate headers
Date:   Thu, 7 May 2020 21:16:08 +0800
Message-ID: <20200507131608.63373-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate headers which are included twice.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 include/linux/kernel.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 04a5885cec1b..12fe1afebfd9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -17,7 +17,6 @@
 #include <asm/byteorder.h>
 #include <asm/div64.h>
 #include <uapi/linux/kernel.h>
-#include <asm/div64.h>
 
 #define STACK_MAGIC	0xdeadbeef
 
-- 
2.20.1

