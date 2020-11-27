Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C2E2C6AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbgK0RxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbgK0RxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:07 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7561DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:07 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w202so5166973pff.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAfb3eu9PEwqw2acxzKnY+PHQEjWwXbjMesTIZeFnXs=;
        b=ShMuYNe7NhTa0j4JWs6zezip9DKv/wVj3FWthKlbvsRE96DCXIFdx4dCxbB60K7vNM
         aUU9k7Go0VsRUAwvUmwtIAVo5EDlXeaBQdxKIyi4NlNDu48/dpqJ9e3L4reVQo80YDi/
         Gl+GrtSaX18zGIpvBhTtx4StM+nhxHS71vc7d7hnI3kdsWbAlRJpnxRWSc5CHNpk5z6e
         XwNHJkJaJpRRTK6ijIjqH5A484Wo8DmiiAQpR3YfsHT73SISNbvYoGMuoPVpToDQz4VJ
         uNMMW4mqSzmofEiw0DRXhQznPr0yItvpdHP2GbSS+OV06JFd7JHt+wdYRT/moGMX2LaE
         NoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAfb3eu9PEwqw2acxzKnY+PHQEjWwXbjMesTIZeFnXs=;
        b=Ck2xAl7ksgLETgNivWNgekjbTqPpbeIJ9N+88XFeGquPIC/+GZWP375hz9Wldhsg4E
         CNbQOLyxjfAQeFYE3npB1qRTo0JgLxlxBy/BVZ12KA/8nY9M33uamKHrMiagb3pFPaZO
         VchUlGhXIZsdkmfmbokZnrLFhF0U0dx4HhglYh4lWP7zgKa8f8tsAVQN/Vc964VKWU7P
         AyzRCXkgKRrQDFeihORs3Gd7UT47wMmwK4ko/EZ+mZXpIo36oeUSrRpFm1pgiSCwQacB
         s8V3JWo3qWofmRLN8RrjPNsltUJBFmYc8obi8tchz00ZU/37q6QGqEfVpMKqDto2iKdj
         5FYA==
X-Gm-Message-State: AOAM532CZOKC4jWfjlAwroA2posl+/j1L75AIMXMyunwQ0V2p9/leyKS
        vCI3BLr8KQwRMevf8PwF19/o0Q==
X-Google-Smtp-Source: ABdhPJxRTKNZcLka4nx9t5gy6bRADeaKB53K/14ja9sOd/6VcaciKw9tgFpAgp+RNykqC8GhduOQzQ==
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr11583917pjb.172.1606499587077;
        Fri, 27 Nov 2020 09:53:07 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:06 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] coresight: tmc-etf: Fix NULL ptr dereference in tmc_enable_etf_sink_perf()
Date:   Fri, 27 Nov 2020 10:52:50 -0700
Message-Id: <20201127175256.1092685-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

There was a report of NULL pointer dereference in ETF enable
path for perf CS mode with PID monitoring. It is almost 100%
reproducible when the process to monitor is something very
active such as chrome and with ETF as the sink and not ETR.
Currently in a bid to find the pid, the owner is dereferenced
via task_pid_nr() call in tmc_enable_etf_sink_perf() and with
owner being NULL, we get a NULL pointer dereference.

Looking at the ETR and other places in the kernel, ETF and the
ETB are the only places trying to dereference the task(owner)
in tmc_enable_etf_sink_perf() which is also called from the
sched_in path as in the call trace. Owner(task) is NULL even
in the case of ETR in tmc_enable_etr_sink_perf(), but since we
cache the PID in alloc_buffer() callback and it is done as part
of etm_setup_aux() when allocating buffer for ETR sink, we never
dereference this NULL pointer and we are safe. So lets do the
same thing with ETF and cache the PID to which the cs_buffer
belongs in tmc_alloc_etf_buffer() as done for ETR. This will
also remove the unnecessary function calls(task_pid_nr()) since
we are caching the PID.

Easily reproducible running below:

 perf record -e cs_etm/@tmc_etf0/ -N -p <pid>

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000548
Mem abort info:
  ESR = 0x96000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
<snip>...
Call trace:
 tmc_enable_etf_sink+0xe4/0x280
 coresight_enable_path+0x168/0x1fc
 etm_event_start+0x8c/0xf8
 etm_event_add+0x38/0x54
 event_sched_in+0x194/0x2ac
 group_sched_in+0x54/0x12c
 flexible_sched_in+0xd8/0x120
 visit_groups_merge+0x100/0x16c
 ctx_flexible_sched_in+0x50/0x74
 ctx_sched_in+0xa4/0xa8
 perf_event_sched_in+0x60/0x6c
 perf_event_context_sched_in+0x98/0xe0
 __perf_event_task_sched_in+0x5c/0xd8
 finish_task_switch+0x184/0x1cc
 schedule_tail+0x20/0xec
 ret_from_fork+0x4/0x18

Cc: stable@vger.kernel.org
Fixes: 880af782c6e8 ("coresight: tmc-etf: Add support for CPU-wide trace scenarios")
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h    | 2 ++
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 65a29293b6cb..f5f654ea2994 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -87,6 +87,7 @@ enum cs_mode {
  * struct cs_buffer - keep track of a recording session' specifics
  * @cur:	index of the current buffer
  * @nr_pages:	max number of pages granted to us
+ * @pid:	PID this cs_buffer belongs to
  * @offset:	offset within the current buffer
  * @data_size:	how much we collected in this run
  * @snapshot:	is this run in snapshot mode
@@ -95,6 +96,7 @@ enum cs_mode {
 struct cs_buffers {
 	unsigned int		cur;
 	unsigned int		nr_pages;
+	pid_t			pid;
 	unsigned long		offset;
 	local_t			data_size;
 	bool			snapshot;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 44402d413ebb..989d965f3d90 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -227,6 +227,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct perf_output_handle *handle = data;
+	struct cs_buffers *buf = etm_perf_sink_config(handle);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	do {
@@ -243,7 +244,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 		}
 
 		/* Get a handle on the pid of the process to monitor */
-		pid = task_pid_nr(handle->event->owner);
+		pid = buf->pid;
 
 		if (drvdata->pid != -1 && drvdata->pid != pid) {
 			ret = -EBUSY;
@@ -399,6 +400,7 @@ static void *tmc_alloc_etf_buffer(struct coresight_device *csdev,
 	if (!buf)
 		return NULL;
 
+	buf->pid = task_pid_nr(event->owner);
 	buf->snapshot = overwrite;
 	buf->nr_pages = nr_pages;
 	buf->data_pages = pages;
-- 
2.25.1

