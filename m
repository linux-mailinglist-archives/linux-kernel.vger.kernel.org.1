Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5757428C7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 05:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbgJMDwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 23:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgJMDwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:52:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDF2C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 20:52:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so16607666pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 20:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rF/GowI+OvAJ42uQFXbwsIX+HPaNK2t5N3RW/GQ/QE0=;
        b=YnGXk/vAcRXCgBwy8MLksps3rFt3p3ilEoqr/MCgzGpqdjS0z5FF2xnKyEAjmriLQ7
         wwhuG32Mmc+3b4MaDcVazkZiweM2/QJKCZRhQwT1g9J8Bnq5qKdauFwCnfGZTn6JXNiH
         MlUjpXwKUWjt3HRw96gNWPidY/8kHyFjfnHNgB/Ju+z/AHZWKRp5eA9UQ0Y4qfIM6aMm
         RMZFpQJCgZyi8zn1sV1FVMAd+NYHLr9xbSyr4ZRJRLOEjhxwx1dTnV67km3/xoLbv/Mf
         d+crmL5AP9Xk3+0PFI/w1ZZdcFgdvUuMgTG8AG4Px3OyDzWrXVuyBjrV9imwzqwwmE8a
         f5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rF/GowI+OvAJ42uQFXbwsIX+HPaNK2t5N3RW/GQ/QE0=;
        b=FV9TAfrQbqxb/+j+6JUknMjqZL9oI/vzVwI1pajiH5CPhFHHwP0p0Jo5UcBuImrBkq
         ewOzYGbL0CIZzSrauqYV32zsM/qABRKDviJPJHbnuA4BpA+jG0dL5DyV+SQMS4zDFUox
         Uf2DJ3+SNtqB/K2Nv9K2NrRCAnDc7B24EfP8fkychaQk7IW5GDN/xQi07J/s8RlibADv
         M9WSXopEyLR/fRBMNsntWkcX80RKbLi4+pY/JOXKNL/1XQF/oJa85aiYPlPQeegbxwxB
         hvt4scq77u3deqoT+/Zd/VWmCk5UxYjdnRk/3o4OY3h8ACFC7GM9CitoRHvGqklGu/3R
         CzsQ==
X-Gm-Message-State: AOAM531uozmeIzp/P6VlGoJHXM0UyIyYKxl4L6PQvKI1npBTrSPXAfQO
        SgjXTyMi47G5OiejUrULERPeY862b8tPB+/9
X-Google-Smtp-Source: ABdhPJwD3ti6zCilmn+dyiNX0Tjm1BhdN3h/LPiYH1j8u1eWaPE9HJ7Kub+GBj9WvRI/SyJOoi9TkQ==
X-Received: by 2002:a17:90a:348e:: with SMTP id p14mr23656062pjb.75.1602561164203;
        Mon, 12 Oct 2020 20:52:44 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id s10sm9343998pji.7.2020.10.12.20.52.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 20:52:43 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH] nvmet: fix uninitialized work for zero kato
Date:   Tue, 13 Oct 2020 11:52:33 +0800
Message-Id: <20201013035233.923889-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hit a warning:
WARNING: CPU: 1 PID: 241 at kernel/workqueue.c:1627 __queue_delayed_work+0x6d/0x90
with trace:
  mod_delayed_work_on+0x59/0x90
  nvmet_update_cc+0xee/0x100 [nvmet]
  nvmet_execute_prop_set+0x72/0x80 [nvmet]
  nvmet_tcp_try_recv_pdu+0x2f7/0x770 [nvmet_tcp]
  nvmet_tcp_io_work+0x63f/0xb2d [nvmet_tcp]
  ...

This could be reproduced easily with a keep alive time 0:
nvme connect -t tcp -n NQN -a ADDR -s PORT --keep-alive-tmo=0

The reason is:
Starting an uninitialized work when initiator connects with zero
kato. Althrough keep-alive timer is disabled during allocating a ctrl
(fix in 0d3b6a8d213a), ka_work still has a chance to run
(called by nvmet_start_ctrl to detect dead host).

Initilize ka_work during allocating ctrl, and set a reasonable kato
before scheduling ka_work.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b7b63330b5ef..3c5b2b065476 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -19,6 +19,8 @@ struct workqueue_struct *buffered_io_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
 
+#define NVMET_DEFAULT_KATO	5
+
 /*
  * This read/write semaphore is used to synchronize access to configuration
  * information on a target system that will result in discovery log page
@@ -385,6 +387,11 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 	if (cmd_seen) {
 		pr_debug("ctrl %d reschedule traffic based keep-alive timer\n",
 			ctrl->cntlid);
+
+		/* run once, trigger from nvmet_start_ctrl to detect dead link */
+		if (!ctrl->kato)
+			return;
+
 		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 		return;
 	}
@@ -403,15 +410,11 @@ static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
 
-	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
-	if (unlikely(ctrl->kato == 0))
-		return;
-
 	pr_debug("ctrl %d stop keep-alive\n", ctrl->cntlid);
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
@@ -1107,6 +1110,8 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 
 static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 {
+	u32 kato = ctrl->kato ? ctrl->kato : NVMET_DEFAULT_KATO;
+
 	lockdep_assert_held(&ctrl->lock);
 
 	if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
@@ -1126,7 +1131,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	 * in case a host died before it enabled the controller.  Hence, simply
 	 * reset the keep alive timer when the controller is enabled.
 	 */
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	mod_delayed_work(system_wq, &ctrl->ka_work, kato * HZ);
 }
 
 static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
@@ -1378,6 +1383,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	/* keep-alive timeout in seconds */
 	ctrl->kato = DIV_ROUND_UP(kato, 1000);
+	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 
 	ctrl->err_counter = 0;
 	spin_lock_init(&ctrl->error_lock);
-- 
2.11.0

