Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC829AB96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750780AbgJ0MQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:16:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41807 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbgJ0MQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:16:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12so675377pgm.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bY5Jc4p/lAT1HicP9cd/Mn/jdG/DRC+C+OaLB9BQQ3E=;
        b=TeiJuGJCVoHmMoYbKJvqLEBWQJhUZP/CYJYRHyD5aVsom0TC6+gFpkLnWGBNOgt3CW
         obWrCGPdkXut5lB5KCM5g5V1jIXjhRe64OZw4Aiwzp+5MtALI9OQEl8F2oYE4PsoVDaw
         9PMYUjIFDIRpzMnIVERSlVwkaQ2U8bWsdAzQiU5cTEuin0d92iiuxjT1NuQrDT3zINvD
         V8koTpY+qP2HzLmW+Vk4cfFEEiv1i3wDXaYRWbAycuCcZ3yaIWQH8RBWOxelc334ijLQ
         /nZQfDLTMGR19Wna1xlZ351NpJrMNWj6Pa1bCR2oUdSl4x7BglxrcZDIhAAePLwsjjbz
         t0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bY5Jc4p/lAT1HicP9cd/Mn/jdG/DRC+C+OaLB9BQQ3E=;
        b=GBKSPaOxLDbGa7QgZcHTyIBOwgdADC9iaVhcSVCCpZSWTkv5DgnCoWjcA7iqazvtn3
         FOPjgBOIP40xmumzKLHGOu9CyxuWKmRVYdGGLUYAmtJ53bW633o7Ob0jQtC3nUL9EcJb
         Mk/XJCNO9wZxzkjHqhcH5/IHne1gWbU9A6th/p7t6/gYcNn8d87lPRrrgOiCJ4Qw3INe
         hbesWD/XsVxA7r/XQoOVbcz+itL7AJmoHZFP8VUPg2etDUvHZpNnV9uheOMcE045HXU4
         tuHcF3jd16t5zKbegHgi819hEwkLU4tly5Vqde8M2ZdDySEcwWYylYWMMnP1WrzY00NE
         Ba1A==
X-Gm-Message-State: AOAM530/EDFjPm+yw/oopjto5I7U3sXFCiYgZ0kYRDOmkv+zlkqMkHOX
        6mlPQb93Q9Dt7beklS6Jtar5cA==
X-Google-Smtp-Source: ABdhPJxHeSly8oz22VuLpqoaRqUtAAdOV+3tgRhEhtamE/+0BJ2yGwTe5Hqn91b1hhcGKQkK/1UqkQ==
X-Received: by 2002:a05:6a00:13a4:b029:163:f435:28b5 with SMTP id t36-20020a056a0013a4b0290163f43528b5mr1978685pfg.45.1603800963925;
        Tue, 27 Oct 2020 05:16:03 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id t12sm1820747pji.26.2020.10.27.05.16.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 05:16:03 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
Cc:     pizhenwei@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvmet: introduce transport layer keep-alive
Date:   Tue, 27 Oct 2020 20:15:45 +0800
Message-Id: <20201027121546.1776104-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the zero KATO scenario, if initiator crashes without transport
layer disconnection, target side would never reclaim resources.

A target could start transport layer keep-alive to detect dead
connection for the admin queue.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      | 14 +++++++++++---
 drivers/nvme/target/nvmet.h     |  3 ++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index dca34489a1dc..53fbd5c193a1 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -729,7 +729,7 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
 
 	nvmet_stop_keep_alive_timer(req->sq->ctrl);
 	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
-	nvmet_start_keep_alive_timer(req->sq->ctrl);
+	nvmet_start_keep_alive_timer(req->sq->ctrl, req);
 
 	nvmet_set_result(req, req->sq->ctrl->kato);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 957b39a82431..451192f7ad6a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -395,10 +395,18 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 	nvmet_ctrl_fatal_error(ctrl);
 }
 
-void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
+void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
-	if (unlikely(ctrl->kato == 0))
+	if (unlikely(ctrl->kato == 0)) {
+		if (req->ops->keep_alive)
+			pr_info("ctrl %d starts with transport keep-alive %s\n", ctrl->cntlid,
+				req->ops->keep_alive(req) ? "failed" : "succeed");
+		else
+			pr_info("ctrl %d starts without both NVMeOF and transport keep-alive",
+				ctrl->cntlid);
+
 		return;
+	}
 
 	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
@@ -1383,7 +1391,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	ctrl->err_counter = 0;
 	spin_lock_init(&ctrl->error_lock);
 
-	nvmet_start_keep_alive_timer(ctrl);
+	nvmet_start_keep_alive_timer(ctrl, req);
 
 	mutex_lock(&subsys->lock);
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 559a15ccc322..de1785ce9fcd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -305,6 +305,7 @@ struct nvmet_fabrics_ops {
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
+	int (*keep_alive)(struct nvmet_req *req);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
@@ -395,7 +396,7 @@ void nvmet_get_feat_async_event(struct nvmet_req *req);
 u16 nvmet_set_feat_kato(struct nvmet_req *req);
 u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask);
 void nvmet_execute_async_event(struct nvmet_req *req);
-void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl);
+void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
 void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl);
 
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
-- 
2.11.0

