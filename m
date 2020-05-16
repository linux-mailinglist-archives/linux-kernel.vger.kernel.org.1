Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED71D5FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgEPJaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 05:30:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbgEPJaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 05:30:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 585C89868A0B93C86D5A;
        Sat, 16 May 2020 17:29:59 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 16 May 2020 17:29:57 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Doug Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     <kgdb-bugreport@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] kdb: Make the internal env 'KDBFLAGS' undefinable
Date:   Sat, 16 May 2020 17:26:06 +0800
Message-ID: <20200516092606.41576-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'KDBFLAGS' is an internal variable of kdb, it is combined by 'KDBDEBUG'
and state flags. But the user can define an environment variable named
'KDBFLAGS' too, so let's make it undefinable to avoid confusion.

Signed-off-by: Wei Li <liwei391@huawei.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v1 -> v2:
 - Fix lack of braces.

 kernel/debug/kdb/kdb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 4fc43fb17127..75b798340300 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -423,6 +423,8 @@ int kdb_set(int argc, const char **argv)
 			| (debugflags << KDB_DEBUG_FLAG_SHIFT);
 
 		return 0;
+	} else if (strcmp(argv[1], "KDBFLAGS") == 0) {
+		return KDB_NOPERM;
 	}
 
 	/*
-- 
2.17.1

