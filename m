Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CB52C6933
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbgK0QNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgK0QNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:13:15 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C743C0613D1;
        Fri, 27 Nov 2020 08:13:15 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x4so1174663pln.8;
        Fri, 27 Nov 2020 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GirRYv7Yp+UW6qivVdz+bDt6vd2WoU0OZWfuEpWcOf8=;
        b=L9r8nbKPGD+VrNpeg9Ia569cWKcPzthfGsiXwc6CDERjxEJbacIkzCDDATwpdu3lM4
         vm7jJnZzIjwUsnyRH8gCW+vbGk2SsKeASSX/xBdl8kA73D9X9QWDIeQ7txNUyfYlv4Rp
         aDCaXq48MNEXZo8bH9F/S/eghpoYAtQtRZAVILyW2K1NI3v3lSzt1kg19VdvPUN4/SRd
         Rl1UwVuIac2Wzeg6SAKw91giz34p4QiKvxTo7xdUVDu4nwQ8AOjPHSsGYf41pCX9XB+C
         I7UeLgFwKSNZrgiYG0keXhjq2UqHcbLI7d2gBFsTopenE0rMjgjbMWtuQb6hFqqf0B/Z
         DLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GirRYv7Yp+UW6qivVdz+bDt6vd2WoU0OZWfuEpWcOf8=;
        b=Tu8LO6YxFkeq0tuITQs0pPVMu9DmjB/is4T42sYW5ksZOLQ9QaSSMoe7Tqsu7m483x
         ArDlnoyA3KEXzGgtZKEpogYjFzMoh3s+ZvbGdtcN/VRjaKzWdcgh7LCU87a44UZi9xVM
         YqvrTL8ONmfP5+xY/eivLuS01/NVouQ1UR4sU4AXigLHOuZl5ao4JMchJdDDGM0UwAyV
         OzIWg01DwwiANYktsxrMUvJ/i9unUpj5tWcQpa2ryiYoTUyaPXugtRM33c8ezBASQtsm
         9vVpL3D4t8Pzt1ARaYX1ktrQ2a0deH6iYbcBgUgPcl9gn+o7wWUKIpnm+PFUbSWKI0FO
         a1Yg==
X-Gm-Message-State: AOAM532R34ifHDL7j/GrdbSu8IZVbAK7EbgpcMl4Af9i88NyrnDQvvYX
        RyQlyJ2uPf33gOcCQ+zxGa0=
X-Google-Smtp-Source: ABdhPJwJ3TjlePotEChx7WHTGAVLvC2oQXEJgQuJnNR6re1vWaiN/cNyXzaL66pXZiGeligXyc5bRw==
X-Received: by 2002:a17:902:fe12:b029:da:5be6:60a8 with SMTP id g18-20020a170902fe12b02900da5be660a8mr474123plj.21.1606493595264;
        Fri, 27 Nov 2020 08:13:15 -0800 (PST)
Received: from localhost.localdomain ([115.192.120.179])
        by smtp.gmail.com with ESMTPSA id v126sm7992715pfb.137.2020.11.27.08.13.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2020 08:13:14 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qianjun.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 2/5] sched, fair: use __schedstat_set() in set_next_entity()
Date:   Sat, 28 Nov 2020 00:12:26 +0800
Message-Id: <20201127161229.19336-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201127161229.19336-1-laoar.shao@gmail.com>
References: <20201127161229.19336-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedstat_enabled() has been already checked, so we can use
__schedstat_set() directly.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8ff1daa3d9bb..7e7c03cede94 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4414,7 +4414,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		schedstat_set(se->statistics.slice_max,
+		__schedstat_set(se->statistics.slice_max,
 			max((u64)schedstat_val(se->statistics.slice_max),
 			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
-- 
2.18.4

