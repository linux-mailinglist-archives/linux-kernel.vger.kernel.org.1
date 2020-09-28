Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99B527A984
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgI1I1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgI1I1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:27:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65780C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:27:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id bw23so218262pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82LGwDgQ4uOMZZxIFGmOXiLDSf9v/yoQATb6JKDH2IA=;
        b=eAVhvtJQaiwxzVErGlTfbLcGWM4yu12I4WBkLQGeGwH8woCQm5ybORFQgL/ItoP+Ow
         U1sv/DNsbULlvP/qQKTymtMWkXxemiN39+DtldYZo7Om7Bm01dswm4wyQd1IpPvcPb2z
         HXjjxMrNhO5qSTrc5yySyRvxDnQ+H14+VoCPM5FDOkplsgjFyuaAijT75lXEhgS/Ol4J
         2lVqKJ/LKRtcfXjbZ4oPo/g22YhXxUgY57K4T9syw/GmHFAV5S7xpTHeXDqgwQkpYa9z
         kxYyMSFySBKDDImWBSmSXEvr73Z874rYFIZ6ZSuP56buM0ujqdbW/93zvr1BSlyDRmZf
         vP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82LGwDgQ4uOMZZxIFGmOXiLDSf9v/yoQATb6JKDH2IA=;
        b=c6x3FGCYMf1Y+6Azs4yAJHOJtsEYphUljUTScNq5aG64ruo4cw0NaJ7gdWQPeWyAgR
         9sZVR8MXy/5VssTSq3SshgZ2vXCOV4KCEx6/gg3xjMMXnoyH8sID1SItxNSwmIX6be/3
         FA+OAxZya1TBTT/BRW7dpfav/X5ESi/5kRFdHNGguIXSj719iP0rL/78wVA60trORpvN
         zZmU1VVE7k+Kt+usOPXev/sQVlTFn+2pPe+r9MXKuQkOfRJMeLOdsMAjp6xaQ2Ru6M4/
         wYfhGMdppUIqSEJx9rTR0UhqrO2KDHr2sE4Z9A2mnsxDRc6Bl3MsZWjGmt9HQCl/8z5f
         4IkQ==
X-Gm-Message-State: AOAM5335oRq+NKCYoIyqqAREtvEjMYLw39Z4p5xETzjsp6KH36AukjWc
        00D5cm0mCqU/NmkRyjvj56g=
X-Google-Smtp-Source: ABdhPJzWoqkGOAGW9JKqB5rB1EZ50WJbVpduo3qXuGHWirnOzfDjYtrXYyZlWlZbY2hJXq08VNKDlA==
X-Received: by 2002:a17:90a:104f:: with SMTP id y15mr308789pjd.45.1601281632827;
        Mon, 28 Sep 2020 01:27:12 -0700 (PDT)
Received: from localhost.localdomain (114-137-252-94.emome-ip.hinet.net. [114.137.252.94])
        by smtp.gmail.com with ESMTPSA id a5sm367426pjd.57.2020.09.28.01.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 01:27:11 -0700 (PDT)
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     dietmar.eggemann@arm.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Yun Hsiang <hsiang023167@gmail.com>
Subject: [PATCH 1/1] sched/uclamp: release per-task uclamp control if user set to default value
Date:   Mon, 28 Sep 2020 16:26:43 +0800
Message-Id: <20200928082643.133257-1-hsiang023167@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the user wants to release the util clamp and let cgroup to control it,
we need a method to reset.

So if the user set the task uclamp to the default value (0 for UCLAMP_MIN
and 1024 for UCLAMP_MAX), reset the user_defined flag to release control.

Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
---
 kernel/sched/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..fa63d70d783a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1187,6 +1187,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
 	enum uclamp_id clamp_id;
+	bool user_defined;
 
 	/*
 	 * On scheduling class change, reset to default clamps for tasks
@@ -1210,14 +1211,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
+	user_defined = attr->sched_util_min == 0 ? false : true;
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
-			      attr->sched_util_min, true);
+			      attr->sched_util_min, user_defined);
 	}
 
+	user_defined = attr->sched_util_max == 1024 ? false : true;
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
-			      attr->sched_util_max, true);
+			      attr->sched_util_max, user_defined);
 	}
 }
 
-- 
2.25.1

