Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41BA216B28
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 13:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGGLMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 07:12:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727827AbgGGLMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:12:52 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E970C29AF5D6A67F67A2;
        Tue,  7 Jul 2020 19:12:50 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 19:12:43 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Jason Yan <yanaijie@huawei.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] lib/test_lockup.c: make symbol 'test_works' static
Date:   Tue, 7 Jul 2020 19:22:52 +0800
Message-ID: <20200707112252.9047-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse build warning:

lib/test_lockup.c:403:1: warning:
 symbol '__pcpu_scope_test_works' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/test_lockup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index ff26f36d729f..0f81252837b9 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -400,7 +400,7 @@ static void test_lockup(bool master)
 	test_unlock(master, true);
 }
 
-DEFINE_PER_CPU(struct work_struct, test_works);
+static DEFINE_PER_CPU(struct work_struct, test_works);
 
 static void test_work_fn(struct work_struct *work)
 {

