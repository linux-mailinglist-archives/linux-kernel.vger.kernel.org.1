Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8C2A769B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 05:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgKEEud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 23:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbgKEEuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 23:50:32 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756AC061A4C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 20:50:32 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 32so289071otm.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 20:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvjwOA4E4EU4uWdZHjmur5yZGUS7qBISeC6b1M+D3zM=;
        b=tiU9APlPLOoAxUJp76XWPjX0w6Bzx0nGeeJFMUVVCicmATSCu0ouGOStpsm7KH2jwB
         K7hHvMnRwOoRvfihBotW5GprFltQEStY9Jfm7q+4st4EWnGOTU73Jx2M75hpCfe5Hr6L
         MF83qfpHNGdRLhGlFU2btE7KJchSHqtEQa3AjnqgjvJB3lQJ/zMbDsXJahAIUwoGiciE
         Ht1H91HmQnTJG7/5Vos+NVVvdPLXNllP3efOkrwybSR/pIyClUEMvO6FANa7IFG0sKWz
         60dlWyzlKq+eLg2Wbu4oJqMqTyOdVtDlFW3Pdc/Dsc5Y6Golc1qyTigYMINObZ1xh4fq
         WFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvjwOA4E4EU4uWdZHjmur5yZGUS7qBISeC6b1M+D3zM=;
        b=MW13y6fGEbde6xDEs9yZRY4tJJ7dhRNMdRL44aU6lu+tjug/wfwBqQRsun+ppwt039
         xgv+oJ9c1MB19nc9YzBmLoZfONgxHtMpjaFkRgr0o7ryJ58ORMD+yEjpnJxwjbJaefVE
         2fPtNj57+Ns/Nz6szI1/T9maq9iuHqcIbfmDWQ1p8NUHRk79q9eLZ3MC71gXnztWb9OM
         pBVukUfYxSGGqHivWVhROVRDXIZ0jElmssYS36mTYBjs7U/ui4f5reDS+PjJjN8//mry
         /Fo6mS8NYU6UgFSbwKtSCK6g4+HuUNEj8k4JcCvBKsqlZb51wInmfspUojA2o9kxUk+p
         mAJA==
X-Gm-Message-State: AOAM532MEsp+Wz58KAcOcq65iuQa1f3bLp8O8G592zDfT4RsJlqbrQ4I
        kHxoJG3EXIAIUGj2lkGkZr1joA==
X-Google-Smtp-Source: ABdhPJy+pHmn9uCABK0hmaSx7N/RXjSjED1Z0kRvX70fzCNGwChVT6aF6Wa70HEsQOk6oZmoejz7gA==
X-Received: by 2002:a9d:60d:: with SMTP id 13mr468308otn.366.1604551831750;
        Wed, 04 Nov 2020 20:50:31 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k13sm100553ooi.41.2020.11.04.20.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 20:50:31 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/4] remoteproc: sysmon: Ensure remote notification ordering
Date:   Wed,  4 Nov 2020 20:50:48 -0800
Message-Id: <20201105045051.1365780-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105045051.1365780-1-bjorn.andersson@linaro.org>
References: <20201105045051.1365780-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reliance on the remoteproc's state for determining when to send
sysmon notifications to a remote processor is racy with regard to
concurrent remoteproc operations.

Further more the advertisement of the state of other remote processor to
a newly started remote processor might not only send the wrong state,
but might result in a stream of state changes that are out of order.

Address this by introducing state tracking within the sysmon instances
themselves and extend the locking to ensure that the notifications are
consistent with this state.

Fixes: 1f36ab3f6e3b ("remoteproc: sysmon: Inform current rproc about all active rprocs")
Fixes: 1877f54f75ad ("remoteproc: sysmon: Add notifications for events")
Fixes: 1fb82ee806d1 ("remoteproc: qcom: Introduce sysmon")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Reduced the locking to be per sysmon instance
- Dropped unused local "rproc" variable in sysmon_notify()

 drivers/remoteproc/qcom_sysmon.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index 9eb2f6bccea6..38f63c968fa8 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -22,6 +22,9 @@ struct qcom_sysmon {
 	struct rproc_subdev subdev;
 	struct rproc *rproc;
 
+	int state;
+	struct mutex state_lock;
+
 	struct list_head node;
 
 	const char *name;
@@ -448,7 +451,10 @@ static int sysmon_prepare(struct rproc_subdev *subdev)
 		.ssr_event = SSCTL_SSR_EVENT_BEFORE_POWERUP
 	};
 
+	mutex_lock(&sysmon->state_lock);
+	sysmon->state = SSCTL_SSR_EVENT_BEFORE_POWERUP;
 	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
+	mutex_unlock(&sysmon->state_lock);
 
 	return 0;
 }
@@ -472,22 +478,25 @@ static int sysmon_start(struct rproc_subdev *subdev)
 		.ssr_event = SSCTL_SSR_EVENT_AFTER_POWERUP
 	};
 
+	mutex_lock(&sysmon->state_lock);
+	sysmon->state = SSCTL_SSR_EVENT_AFTER_POWERUP;
 	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
+	mutex_unlock(&sysmon->state_lock);
 
-	mutex_lock(&sysmon_lock);
 	list_for_each_entry(target, &sysmon_list, node) {
-		if (target == sysmon ||
-		    target->rproc->state != RPROC_RUNNING)
+		if (target == sysmon)
 			continue;
 
+		mutex_lock(&target->state_lock);
 		event.subsys_name = target->name;
+		event.ssr_event = target->state;
 
 		if (sysmon->ssctl_version == 2)
 			ssctl_send_event(sysmon, &event);
 		else if (sysmon->ept)
 			sysmon_send_event(sysmon, &event);
+		mutex_unlock(&target->state_lock);
 	}
-	mutex_unlock(&sysmon_lock);
 
 	return 0;
 }
@@ -500,7 +509,10 @@ static void sysmon_stop(struct rproc_subdev *subdev, bool crashed)
 		.ssr_event = SSCTL_SSR_EVENT_BEFORE_SHUTDOWN
 	};
 
+	mutex_lock(&sysmon->state_lock);
+	sysmon->state = SSCTL_SSR_EVENT_BEFORE_SHUTDOWN;
 	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
+	mutex_unlock(&sysmon->state_lock);
 
 	/* Don't request graceful shutdown if we've crashed */
 	if (crashed)
@@ -521,7 +533,10 @@ static void sysmon_unprepare(struct rproc_subdev *subdev)
 		.ssr_event = SSCTL_SSR_EVENT_AFTER_SHUTDOWN
 	};
 
+	mutex_lock(&sysmon->state_lock);
+	sysmon->state = SSCTL_SSR_EVENT_AFTER_SHUTDOWN;
 	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
+	mutex_unlock(&sysmon->state_lock);
 }
 
 /**
@@ -534,11 +549,10 @@ static int sysmon_notify(struct notifier_block *nb, unsigned long event,
 			 void *data)
 {
 	struct qcom_sysmon *sysmon = container_of(nb, struct qcom_sysmon, nb);
-	struct rproc *rproc = sysmon->rproc;
 	struct sysmon_event *sysmon_event = data;
 
 	/* Skip non-running rprocs and the originating instance */
-	if (rproc->state != RPROC_RUNNING ||
+	if (sysmon->state != SSCTL_SSR_EVENT_AFTER_POWERUP ||
 	    !strcmp(sysmon_event->subsys_name, sysmon->name)) {
 		dev_dbg(sysmon->dev, "not notifying %s\n", sysmon->name);
 		return NOTIFY_DONE;
@@ -591,6 +605,7 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 	init_completion(&sysmon->ind_comp);
 	init_completion(&sysmon->shutdown_comp);
 	mutex_init(&sysmon->lock);
+	mutex_init(&sysmon->state_lock);
 
 	sysmon->shutdown_irq = of_irq_get_byname(sysmon->dev->of_node,
 						 "shutdown-ack");
-- 
2.28.0

