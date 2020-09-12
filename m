Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17747267B73
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 18:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgILQgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 12:36:52 -0400
Received: from m12-12.163.com ([220.181.12.12]:43435 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgILQgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 12:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4jlbh
        tobdmkHpDIpt+ysqXYQvcQ30XBahWvBcTK9RnA=; b=hHLLwMgE9FJYSn9zaGvB5
        Asy2fKUIrzvlwE3JUGKBy3QNUHX2QVWNR7nrgecIi3Ue7m0kfJ2mdaPAXYGFxDZx
        8BWnECWbfCixmMIdQ8wnCEwF2mZxu4B+vZM1dSU1lSzASr3pDDwrD5nLR9pWd1QY
        JyJKKiJVPtRywkvOgGOi3Y=
Received: from localhost.localdomain (unknown [125.82.15.167])
        by smtp8 (Coremail) with SMTP id DMCowADHTAcd1VxfGqjmMw--.62689S4;
        Sat, 12 Sep 2020 22:03:11 +0800 (CST)
From:   Hu Haowen <xianfengting221@163.com>
To:     dot@dotat.at
Cc:     linux-kernel@vger.kernel.org, Hu Haowen <xianfengting221@163.com>
Subject: [PATCH] unifdef: Replace space indentions with tabs
Date:   Sat, 12 Sep 2020 22:02:55 +0800
Message-Id: <20200912140255.33477-1-xianfengting221@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowADHTAcd1VxfGqjmMw--.62689S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF15ZFWkAF1fJrW3tF1UKFg_yoW3ZFb_Z3
        yfK3ykZ3WDtF47tryfJFs2yryUKr4q9393Ww1FqF1093WqkF4vg3Z7Gr1DZa43WFy7Cr4a
        9rWIqF1j9r4IgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb489tUUUUU==
X-Originating-IP: [125.82.15.167]
X-CM-SenderInfo: h0ld0wxhqj3xtqjsjii6rwjhhfrp/xtbBDxydAFPAN0DSRQAAs9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Linux kernel coding style, space indentions are not
allowed in source files, so removed them and added tab ones.

Signed-off-by: Hu Haowen <xianfengting221@163.com>
---
 scripts/unifdef.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/unifdef.c b/scripts/unifdef.c
index db00e3e30a59..6fd1e9499268 100644
--- a/scripts/unifdef.c
+++ b/scripts/unifdef.c
@@ -57,9 +57,9 @@
 #include <unistd.h>
 
 const char copyright[] =
-    "@(#) $Version: unifdef-2.5 $\n"
-    "@(#) $Author: Tony Finch (dot@dotat.at) $\n"
-    "@(#) $URL: http://dotat.at/prog/unifdef $\n"
+	"@(#) $Version: unifdef-2.5 $\n"
+	"@(#) $Author: Tony Finch (dot@dotat.at) $\n"
+	"@(#) $URL: http://dotat.at/prog/unifdef $\n"
 ;
 
 /* types of input lines: */
-- 
2.25.1


