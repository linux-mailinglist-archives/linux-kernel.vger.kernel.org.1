Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957E430254A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbhAYNHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:07:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11873 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbhAYM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:59:20 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DPTqN2Vsjz7ZrG;
        Mon, 25 Jan 2021 20:35:44 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 20:36:47 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <christian.brauner@ubuntu.com>, <akpm@linux-foundation.org>,
        <tglx@linutronix.de>, <areber@redhat.com>,
        <thomascedeno@google.com>, <Nicolas.Viennot@twosigma.com>,
        <walken@google.co>, <viresh.kumar@linaro.org>,
        <liao.pingfang@zte.com.cn>, <mchristi@redhat.com>,
        <viro@zeniv.linux.org.uk>, <linux@rasmusvillemoes.dk>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] kernel/sys.c: Remove unused including <linux/version.h>
Date:   Mon, 25 Jan 2021 20:47:49 +0800
Message-ID: <1611578869-43453-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following versioncheck warning:

kernel/sys.c:42:1: unused including <linux/version.h>

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 kernel/sys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index e6fd8b8..8ecd3c5 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -39,7 +39,6 @@
 #include <linux/mount.h>
 #include <linux/gfp.h>
 #include <linux/syscore_ops.h>
-#include <linux/version.h>
 #include <linux/ctype.h>
 #include <linux/syscall_user_dispatch.h>
 
-- 
2.6.2

