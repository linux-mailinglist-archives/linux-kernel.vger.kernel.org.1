Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8A269F08
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIOHDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:03:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgIOHCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:02:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C283098D5B32229C345C;
        Tue, 15 Sep 2020 15:02:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 15:02:08 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] bootconfig: init: make xbc_namebuf static
Date:   Tue, 15 Sep 2020 15:03:24 +0800
Message-ID: <20200915070324.2239473-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates the following sparse warning:

init/main.c:306:6: warning: symbol 'xbc_namebuf' was not declared.
Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 92773a5daf8d..5ac07eb4a300 100644
--- a/init/main.c
+++ b/init/main.c
@@ -303,7 +303,7 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 #ifdef CONFIG_BOOT_CONFIG
 
-char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 
-- 
2.25.4

