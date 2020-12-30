Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A102E7665
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 07:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgL3GGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 01:06:17 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:32920 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3GGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=738qe5GBt/3QK5Vaa/
        x6gYSkhhOHlmlZM0sXzd9Pv0U=; b=CExGQbA/a5Y3u5Z8zyXVUJLVcKmxAgjkNm
        IE2Il0ff8d/NBXcSMJ6VamCiEgvfsqVpxFOI9eLWTOwavxZDW9UDql+lo/KapvLO
        cY92JHtZCX8Zuj+tCVH9AWIuoRQQo1nhQpn41WaW+xHDZ0i0VoDE2tYguEIMJOYK
        zeUduMlqI=
Received: from pek-pliu1-d1.wrs.com (unknown [60.247.85.82])
        by smtp2 (Coremail) with SMTP id GtxpCgD3h29pGOxf8oeWHA--.716S3;
        Wed, 30 Dec 2020 14:04:32 +0800 (CST)
From:   Liu Peibao <liupeibao@163.com>
To:     mhiramat@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] init/main.c: fix strings split across lines
Date:   Wed, 30 Dec 2020 14:04:23 +0800
Message-Id: <20201230060424.29097-2-liupeibao@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201230060424.29097-1-liupeibao@163.com>
References: <20201230060424.29097-1-liupeibao@163.com>
X-CM-TRANSID: GtxpCgD3h29pGOxf8oeWHA--.716S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1UGFWUZFyrGw4fur4kJFb_yoW3Wwc_Cw
        n5XFs5XwsIkFyagr4SyF4vvFyvva109rs2yw1xG3yjy342yr4qgF4DG3sxA3W8Wr4I9Fsx
        C3Z5C395ZrsFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0ZiSPUUUUU==
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: xolx1vpled0qqrwthudrp/1tbiXxALbF150D1SewAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning found by checkpatch.pl.

Signed-off-by: Liu Peibao <liupeibao@163.com>
---
 init/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 6feee7f11eaf..1e492de770c8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1470,8 +1470,7 @@ static int __ref kernel_init(void *unused)
 	    !try_to_run_init_process("/bin/sh"))
 		return 0;
 
-	panic("No working init found.  Try passing init= option to kernel. "
-	      "See Linux Documentation/admin-guide/init.rst for guidance.");
+	panic("No working init found. Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.");
 }
 
 /* Open /dev/console, for stdin/stdout/stderr, this should never fail */
-- 
2.17.1

