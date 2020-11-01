Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766AE2A1DCB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 13:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgKAMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 07:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgKAMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 07:21:10 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72028C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 04:21:10 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id x13so8472989pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 04:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xAMlcu5HyOJWhMCGe7WlqSeGRHe2WFF/uiSbdM0G/7c=;
        b=lTJd9wcKx1PnyEPaLnRQFqN4EofDlHp+TGW46gz0n44oTcyPQP4UcjFsX0OOb4u3Pt
         L+zsZ67ilwFkpLHa9W6q4U9/RmuuUATjVmD6aw4pUmEHLx4OZYbrBmYIk2ChlXmf3+nA
         X/vn8IvCsgzHwcGvrT1XqjOmeajRUTKLbrtxFbRtyRabPAZWbRKKfmDx09QaW/NSnIms
         1uHUEijFURwvIbD2C9LDp7bsTGDY2HxSr07pd4IDgt6aUgUxB+0ngoliGUoC4fCjfLPY
         FS9y2Gz5TydGrPgnfxP5RaEZ32VSzM4RCy3imP4+r/ndQkvSG8W1DkQarG4eDbzahCou
         GM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xAMlcu5HyOJWhMCGe7WlqSeGRHe2WFF/uiSbdM0G/7c=;
        b=GIhQzCexvPY4itdCSyETA9tdAZ4ldaj7Jrlk3B3R497no66+P2rUUt8+PgY5VfFBVH
         BW2PTZvdrnfsLv5JH7NlmMglDA/AxIVhrYHEUJGzL47z6KUUvYiFVvd+jEpKdLg/Qg+W
         S7xLqcC+QCuNeHO5+qiW8I96FoXiJ4AgiF9vqNIeu4fPtIkdEgKqziZvWGszTTISQl2p
         JZTVEplUDj8e51dbKptkcWESWrCH150bHf+4E31XD2L5GwXJg+tDJb6B2f+P+YMK7W84
         DMQMk4qyx3C6suIA4ro9oC+i4XWEi6JHSiWk8E22Dfaq6TXw5uJ00zCmrXYWlQ+abrLL
         HFgQ==
X-Gm-Message-State: AOAM533Kd/macTN4edlmTsdBNvtPldOgPU6EXOKIkmeqcudJJnve5cc8
        xU37BCS6E7wB8Ne4v+rVfbobyE09o5pEWg==
X-Google-Smtp-Source: ABdhPJwfFYCVE8qKovC88wVntJBDNAUKHGRJjca7IsilaP3HluWiMtd1GOp2sp2TvfiU+HfdSX1/rQ==
X-Received: by 2002:a63:e54a:: with SMTP id z10mr8992651pgj.297.1604233269795;
        Sun, 01 Nov 2020 04:21:09 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com (220-142-209-44.dynamic-ip.hinet.net. [220.142.209.44])
        by smtp.googlemail.com with ESMTPSA id w6sm10164827pgr.71.2020.11.01.04.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 04:21:09 -0800 (PST)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] workqueue: Remove redundant assignment
Date:   Sun,  1 Nov 2020 20:21:24 +0800
Message-Id: <20201101122124.1185-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

The member 'node' of worker_pool struct (per_cpu worker_pool) is
assigned in workqueue_init_early() and workqueue_init().
Commit 2186d9f940b6 ("workqueue: move wq_numa_init() to workqueue_init()")
fixes an issue by moving wq_numa_init() to workqueue_init() in order
to get the valid 'cpu to node' mapping. So, remove the redundant
assignment in workqueue_init_early().

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 kernel/workqueue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 437935e7a199..cf8c0df2410e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5937,7 +5937,6 @@ void __init workqueue_init_early(void)
 			pool->cpu = cpu;
 			cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
 			pool->attrs->nice = std_nice[i++];
-			pool->node = cpu_to_node(cpu);
 
 			/* alloc pool ID */
 			mutex_lock(&wq_pool_mutex);
-- 
2.17.1

