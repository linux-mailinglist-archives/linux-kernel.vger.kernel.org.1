Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ADB2C6AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbgK0RxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbgK0RxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:08 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F694C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:08 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id s2so3011622plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIDb70TVBZgre0o2Y2c30VS9W3UnJeMILhzgcalu4cA=;
        b=J9FseNlQZNBEdC9FggIZ/qXHGNym9mg9AX+5msPMwH9e7HGUSu9IfSodJSEBqDUSZP
         FoIjq5CePZg7k1LRHI4QyWvq7zaxqSKNl/T8C0Oz33aXmmB0E9kXaNZQpiax6fGDbwvJ
         jRHlTKTaDKmHlSCxWit0UD9nUSIFyn2/CuBfSt8e1ddMEU6IquwutTBSGpV7VgVmciyP
         r/Ij+wodrM7Hby595ZoEsCrh/Ayf5AlaARywGLKRCfP8ZRdiK/g2WEijJ5PyWeuEBv9q
         4MmF0wnyxQ7Gnd5kVpji9O7MFNcLzTQWv1Ug5xsR2BUG0tU4nVxxY1bnFVceeHUxU5pv
         JjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIDb70TVBZgre0o2Y2c30VS9W3UnJeMILhzgcalu4cA=;
        b=S3fEbL5ppUHU4JLpImi80KiLbue60YrGGzxJN+ZFfTnRtii0VaYKSJozaa3PyZ+Fer
         PFSH8hcm7lBuzKQCMrntf0KTHvtsHY8zJOhWKyqqr6ETC0T68GlBm/hBCDkZljlFoQy4
         VlqcdPt8CuzTLqwTIuuQj3wbzVca/eSvKuXRY4ZzVivMwZWuTlgsxjRWBA2dNooseydr
         TqBJvoP+PdM1r6iI4LftxSfwaipGvk4fdzcu7pwiqoUczgOJ7ljbmEyqxGVxncWxfuDz
         hxNIkQewJOCc19dOGCJ+7+MUh4MUDjeHCpjYvfVwqG7fdmNpTxxyIOsI4rJaWCDACOV6
         qfbQ==
X-Gm-Message-State: AOAM533t1gB42XeRtCmL78qvQNB3lfwzDJViJ0ciDm3vljZGwqUL0+Xm
        f8Epn2NtsUCL3hnTZ7eX6MTBHuywMauGqWUG
X-Google-Smtp-Source: ABdhPJzY0T9kaV36mzn+aiwFbi8EdPqbuxEa3JPRgJg3WMBMK8Jp/vPOnd4oswyp7XIZWeNUi7ensA==
X-Received: by 2002:a17:902:b182:b029:da:d0c:abac with SMTP id s2-20020a170902b182b02900da0d0cabacmr7817626plr.40.1606499588035;
        Fri, 27 Nov 2020 09:53:08 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:07 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] coresight: etb10: Fix possible NULL ptr dereference in etb_enable_perf()
Date:   Fri, 27 Nov 2020 10:52:51 -0700
Message-Id: <20201127175256.1092685-11-mathieu.poirier@linaro.org>
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
active such as chrome and with ETF as the sink, not ETR.

But code path shows that ETB has a similar path as ETF, so
there could be possible NULL pointer dereference crash in
ETB as well. Currently in a bid to find the pid, the owner
is dereferenced via task_pid_nr() call in etb_enable_perf()
and with owner being NULL, we can get a NULL pointer
dereference, so have a similar fix as ETF where we cache PID
in alloc_buffer() callback which is called as the part of
etm_setup_aux().

Cc: stable@vger.kernel.org
Fixes: 75d7dbd38824 ("coresight: etb10: Add support for CPU-wide trace scenarios")
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 248cc82c838e..1b320ab581ca 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -176,6 +176,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	unsigned long flags;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct perf_output_handle *handle = data;
+	struct cs_buffers *buf = etm_perf_sink_config(handle);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
@@ -186,7 +187,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	}
 
 	/* Get a handle on the pid of the process to monitor */
-	pid = task_pid_nr(handle->event->owner);
+	pid = buf->pid;
 
 	if (drvdata->pid != -1 && drvdata->pid != pid) {
 		ret = -EBUSY;
@@ -383,6 +384,7 @@ static void *etb_alloc_buffer(struct coresight_device *csdev,
 	if (!buf)
 		return NULL;
 
+	buf->pid = task_pid_nr(event->owner);
 	buf->snapshot = overwrite;
 	buf->nr_pages = nr_pages;
 	buf->data_pages = pages;
-- 
2.25.1

