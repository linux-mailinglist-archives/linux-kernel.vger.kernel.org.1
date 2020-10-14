Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3028E19B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgJNNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:48:05 -0400
Received: from m12-13.163.com ([220.181.12.13]:34135 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgJNNsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=E8eoo
        Zv9mg4vjc6B//7fzf+17eEcWSkIXNw/wvIpW9U=; b=QGe5RjPkXslJd2Gi42G8v
        0ARw+/b9u11cf5pRQ67s4t1/73NHo++ziPTY8fW5bqO9YbsawfprbX/PXM0Ua0hG
        3xI5Iv5/UotafEhQn/1TOINVdlEZ8U+hD9HdH5fL+qaj1LD0VygzS1tnbDSpbPmY
        BIwSGWQBihCf/8JuZ7oiLw=
Received: from localhost (unknown [101.228.30.83])
        by smtp9 (Coremail) with SMTP id DcCowAAHRZG1_YZfSUoGLQ--.31205S2;
        Wed, 14 Oct 2020 21:31:33 +0800 (CST)
Date:   Wed, 14 Oct 2020 21:31:33 +0800
From:   Hui Su <sh_def@163.com>
To:     bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] taskstats: use family->version instead of
 TASKSTATS_GENL_VERSION
Message-ID: <20201014133133.GA8908@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DcCowAAHRZG1_YZfSUoGLQ--.31205S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrJFWDuF1fWFWkGryruryfWFg_yoWxGFg_Xw
        12qr18WF15tr92qr48ZFsYvF18t3yFqF47Ar1kGF4xAF18GryaqayDXr1DGr1kWrnxCrsx
        uwsxGrykKr17GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU86OJ5UUUUU==
X-Originating-IP: [101.228.30.83]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMRW9X1UMV7xVXAAAs9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use family->version instead of the hrad code(TASKSTATS_GENL_VERSION).

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/taskstats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index e2ac0e37c4ae..8364663ca07d 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -713,7 +713,7 @@ static int __init taskstats_init(void)
 		return rc;
 
 	family_registered = 1;
-	pr_info("registered taskstats version %d\n", TASKSTATS_GENL_VERSION);
+	pr_info("registered taskstats version %d\n", family->version);
 	return 0;
 }
 
-- 
2.25.1


