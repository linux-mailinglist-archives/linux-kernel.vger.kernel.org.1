Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612AE29212C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 04:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbgJSCgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 22:36:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728791AbgJSCgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 22:36:45 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3B394413605DF552B001;
        Mon, 19 Oct 2020 10:36:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 10:36:38 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <tytso@mit.edu>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] random: Fix missing-prototypes in random.c
Date:   Mon, 19 Oct 2020 10:37:23 +0800
Message-ID: <1603075043-2502-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings.
drivers/char/random.c:2297:6: warning: no previous prototype for
‘add_hwgenerator_randomness’ [-Wmissing-prototypes]

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/char/random.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d20ba1b..1bf06d6 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -321,6 +321,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/genhd.h>
+#include <linux/hw_random.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
 #include <linux/nodemask.h>
-- 
2.7.4

