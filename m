Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0413C28763B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgJHOiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgJHOiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:38:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59933C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:38:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f21so6707739wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D+9J/HNIjhjYiMOlJN5FLKO8xUVilMJPpBLCBZbGWLw=;
        b=UMIv7thr4BJdqGPaaDxbj0L5JfqV94gw26TUdeeoEdsuDXaBmIO255ZX0YboaE+xHJ
         FvokadyGOOTDiVLwu78QN++GEmauP0HHBRN9x2hP3k0PWX4p8XklfbICE4jWIMvhpOKU
         /KSZAaWlMfz3y3Pcf0Qs451JurQqIFbds4etRxXChNl1oL4WuIu/I0UTciUZ8temcOA/
         Sn02bcEnkqBjV9MRvpUS23OgjbkDq0y+dIpRYR50X77jNk25NNXhyAaejXu8bVMaJFQv
         obUQr47YMd+zKjHLcnd+fnR/ifsxymAHbeOy74d6PTLQK38nLR4//al4qtN3QOphZNKO
         lYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D+9J/HNIjhjYiMOlJN5FLKO8xUVilMJPpBLCBZbGWLw=;
        b=ILEAtYZOBXdKxJ6JAdxMDf2e5mBDsQXWdvEPxcA4AAV5JQC2gtaysZ9dPKD2JqEY/Y
         yh3GrTX+cfqnlODDkCZ4lL5VKCV/Y47/0hvy1RJZxdn8c6S3/A9x6okM6WELTZ96Uz4Y
         8kMGQEi2L/8reDxcuUNjrjOvQN5VGKIc0OqynBMvei87RrTJBVa/DUyL+Y/p4sTCUjDV
         osXWiKRVtacaONWONcHXAhdGHwbcDsnuNiZV9e2EPKrTAGEYK7XxWRi00DRnXMdBAV+c
         7oGXmWfBdZCYeyCkzduivbBNBEO8zHZvbllb6J1pNHZm998s/Ht59TEyy4V8rwwCR6Zp
         dNHA==
X-Gm-Message-State: AOAM533XBzC2pm98Wjq6DlUg65iFpzq/+W5Uf1JmyF1x7RD6zjuSXl1i
        za1VKtAUnyZgSDUafQ5Irdf+OTyPpDvsQXvfb48=
X-Google-Smtp-Source: ABdhPJzKkZD13r1AHLAaKgwoB0i221mwt28cGazWbJRZz/jY0hD+8bq6hEB2H4HDDpiro84/lG9EFA==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr8985143wmh.156.1602167921940;
        Thu, 08 Oct 2020 07:38:41 -0700 (PDT)
Received: from lmecxl0524.lme.st.com ([2a04:cec0:11c8:908d:6533:9100:d943:8b22])
        by smtp.gmail.com with ESMTPSA id y14sm6926942wma.48.2020.10.08.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:38:41 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH 2/5] firmware: arm_scmi: fix transfer missing re-initialization
Date:   Thu,  8 Oct 2020 16:37:19 +0200
Message-Id: <20201008143722.21888-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008143722.21888-1-etienne.carriere@linaro.org>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement helper function scmi_do_xfer_again() to process consecutive
transfers that are initialized only once with scmi_xfer_get_init()
and hence get the pool completion and responses message length not
reloaded regarding last completed transfer.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/arm_scmi/base.c    |  2 +-
 drivers/firmware/arm_scmi/clock.c   |  2 +-
 drivers/firmware/arm_scmi/common.h  |  2 ++
 drivers/firmware/arm_scmi/driver.c  | 10 ++++++++++
 drivers/firmware/arm_scmi/perf.c    |  2 +-
 drivers/firmware/arm_scmi/sensors.c |  2 +-
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 9853bd3c4d45..508f214baa1b 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -183,7 +183,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 		/* Set the number of protocols to be skipped/already read */
 		*num_skip = cpu_to_le32(tot_num_ret);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = scmi_do_xfer_again(handle, t);
 		if (ret)
 			break;
 
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index c1cfe3ee3d55..9bb54c1a8d55 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -161,7 +161,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 		/* Set the number of rates to be skipped/already read */
 		clk_desc->rate_index = cpu_to_le32(tot_rate_cnt);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = scmi_do_xfer_again(handle, t);
 		if (ret)
 			goto err;
 
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 37fb583f1bf5..6d4eea7b0f3e 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -143,6 +143,8 @@ struct scmi_xfer {
 
 void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
 int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer);
+int scmi_do_xfer_again(const struct scmi_handle *handle,
+		       struct scmi_xfer *xfer);
 int scmi_do_xfer_with_response(const struct scmi_handle *h,
 			       struct scmi_xfer *xfer);
 int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c5dea87edf8f..887cb8249db0 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -402,6 +402,16 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	return ret;
 }
 
+int scmi_do_xfer_again(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	xfer->rx.len = info->desc->max_msg_size;
+	xfer->hdr.poll_completion = false;
+
+	return scmi_do_xfer(handle, xfer);
+}
+
 #define SCMI_MAX_RESPONSE_TIMEOUT	(2 * MSEC_PER_SEC)
 
 /**
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ed475b40bd08..66d3d8459936 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -281,7 +281,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 		/* Set the number of OPPs to be skipped/already read */
 		dom_info->level_index = cpu_to_le32(tot_opp_cnt);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = scmi_do_xfer_again(handle, t);
 		if (ret)
 			break;
 
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 9703cf6356a0..97addcf828a3 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -134,7 +134,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 		/* Set the number of sensors to be skipped/already read */
 		put_unaligned_le32(desc_index, t->tx.buf);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = scmi_do_xfer_again(handle, t);
 		if (ret)
 			break;
 
-- 
2.17.1

