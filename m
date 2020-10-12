Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A218928BA97
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgJLORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:17:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbgJLORx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:17:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCD9F31B;
        Mon, 12 Oct 2020 07:17:52 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCF3E3F66B;
        Mon, 12 Oct 2020 07:17:51 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        vincent.guittot@linaro.org, Souvik.Chakravarty@arm.com
Subject: [PATCH] firmware: arm_scmi: Add missing Rx size re-initialisation
Date:   Mon, 12 Oct 2020 15:17:46 +0100
Message-Id: <20201012141746.32575-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008143722.21888-2-etienne.carriere@linaro.org>
References: <20201008143722.21888-2-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few commands provide the list of description partially and require
to be called consecutively until all the descriptors are fetched
completely. In such cases, we don't release the buffers and reuse
them for consecutive transmits.

However, currently we don't reset the Rx size which will be set as
per the response for the last transmit. This may result in incorrect
response size being interpretted as the firmware may repond with size
greater than the one set but we read only upto the size set by previous
response.

Let us reset the receive buffer size to max possible in such cases as
we don't know the exact size of the response.

Fixes: b6f20ff8bd94 ("firmware: arm_scmi: add common infrastructure and support for base protocol")
Reported-by: Etienne Carriere <etienne.carriere@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/base.c    | 2 ++
 drivers/firmware/arm_scmi/clock.c   | 2 ++
 drivers/firmware/arm_scmi/common.h  | 8 ++++++++
 drivers/firmware/arm_scmi/perf.c    | 2 ++
 drivers/firmware/arm_scmi/sensors.c | 2 ++
 5 files changed, 16 insertions(+)

Hi Etienne,

I reworked this in a different way and hence dropped your authorship and added
reported by. If you prefer I can attribute you as author. I want to push
2,4,5/5 as fixes and hence the rush.

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 9853bd3c4d45..017e5d8bd869 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -197,6 +197,8 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 			protocols_imp[tot_num_ret + loop] = *(list + loop);
 
 		tot_num_ret += loop_num_ret;
+
+		scmi_reset_rx_to_maxsz(handle, t);
 	} while (loop_num_ret);
 
 	scmi_xfer_put(handle, t);
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index c1cfe3ee3d55..4645677d86f1 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -192,6 +192,8 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 		}
 
 		tot_rate_cnt += num_returned;
+
+		scmi_reset_rx_to_maxsz(handle, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 37fb583f1bf5..a3f1bc44b1de 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -245,6 +245,14 @@ extern const struct scmi_desc scmi_mailbox_desc;
 extern const struct scmi_desc scmi_smc_desc;
 #endif
 
+static inline void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
+					  struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	xfer->rx.len = info->desc->max_msg_size;
+}
+
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ed475b40bd08..82fb3babff72 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -304,6 +304,8 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 		}
 
 		tot_opp_cnt += num_returned;
+
+		scmi_reset_rx_to_maxsz(handle, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 9703cf6356a0..b4232d611033 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -166,6 +166,8 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 		}
 
 		desc_index += num_returned;
+
+		scmi_reset_rx_to_maxsz(handle, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
-- 
2.17.1

