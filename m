Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9692FD7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391623AbhATSEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389565AbhATSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:02:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B9C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:01:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y187so3631308wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQoVeBFspR4mt3piNvLaPW/lHzLoxodJhfaRGQgUT1o=;
        b=n1TBEkVVeRe65EecswdyymfUn7w4pRZ39sPs3d6I+/YsPGlFlkRSPmtoPTLcm/pCL8
         7R62yN0J13Y6ttRM5kWB7NlUsyJ22RODR8K+Cfaqg1PrpGMCBbhDZxgS6aL6Giqjy+Jd
         jEm1XNoT9GsFI5fax/PaWYYmj1hWmwYKJutleqn36DvIBsUiaGCHswZs7aIKL6uE/Bx5
         FLQ/3YKBhdM+0H876HH29jAQUmYlbA7Z8JXw17csFA39INZAEN9BLftUMA42iEc9ufDV
         9ps7E8K69ade4CPGYEimPznqY0ZjGXVZROQxlHOj78+PD08f7uEL+Bo3Z5+eC+CWKri4
         P5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQoVeBFspR4mt3piNvLaPW/lHzLoxodJhfaRGQgUT1o=;
        b=P8CliuqtfOFXlAFasaH6wYGGdFV/RtRII1XZmmdXRIwCrdo71VqC/ynVfcGbkMLA07
         ysRkV4B/OGZiR79D+Nmr4JU0Clb552y2xofNxxJ8x2wrgE737SOyMqpEBPOYRhI3o41a
         NaWEt9/UaSEOG7o74jCCwSAiT1EbR/PD2VAljHoHQ42h4ClZ7t1vbjeofWoUXT1ZXjx0
         27aTCbjPm3iP6HMRGqDzcweHF+8Jl7pRvuDaStyf0osJGl8ElAu42N7IzvFKOYO3u6VD
         VL1OBLSHAUNklazVV5J4auiLHMJS5Bn8LMzxGuaaVETDUmUq1mXhHBxvZD0PX0nQgdKY
         qHaw==
X-Gm-Message-State: AOAM532hUBClH5Pp5P6IOHbbDoAcZWUnek7Z+ATgM0ZzDu14YKqFwhTR
        WfsGsKBmq4tmChiU75fyzGI9Gg==
X-Google-Smtp-Source: ABdhPJy+vZ5Ndk2chQmEIUc7iK9pg24cCvNdSKut3bwHquW7xDOJ8GeEpBtiILkL2aWLPoPKAjyxiw==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr5414365wmk.183.1611165700508;
        Wed, 20 Jan 2021 10:01:40 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g194sm5267422wme.39.2021.01.20.10.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:01:39 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 1/2] soundwire: add support for static port mapping
Date:   Wed, 20 Jan 2021 18:01:09 +0000
Message-Id: <20210120180110.8357-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210120180110.8357-1-srinivas.kandagatla@linaro.org>
References: <20210120180110.8357-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the soundwire controllers can have static functions assigned
to each port, like some ports can only do PCM or PDM. This is the situation
with some of the Qualcomm Controllers.

In such cases its not correct to assign/map any free port on master
during streaming.

So, this patch provides a way to pass mapped port number along
with the port config, so that master can assign correct ports based
on the provided static mapping.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/bus.h       | 4 ++++
 drivers/soundwire/stream.c    | 4 ++++
 include/linux/soundwire/sdw.h | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 2e049d39c6e5..e812557c3293 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -85,6 +85,8 @@ int sdw_find_col_index(int col);
  * @num: Port number. For audio streams, valid port number ranges from
  * [1,14]
  * @ch_mask: Channel mask
+ * @mapped_port_num: Port number to map on Master or Slave in Static Configuration
+ * @is_static_map: true for static port mapping
  * @transport_params: Transport parameters
  * @port_params: Port parameters
  * @port_node: List node for Master or Slave port_list
@@ -95,6 +97,8 @@ int sdw_find_col_index(int col);
 struct sdw_port_runtime {
 	int num;
 	int ch_mask;
+	unsigned int mapped_port_num;
+	bool is_static_map;
 	struct sdw_transport_params transport_params;
 	struct sdw_port_params port_params;
 	struct list_head port_node;
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 1099b5d1262b..eab3bc0c95ed 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1202,6 +1202,10 @@ static struct sdw_port_runtime
 
 	p_rt->ch_mask = port_config[port_index].ch_mask;
 	p_rt->num = port_config[port_index].num;
+	p_rt->is_static_map = port_config[port_index].is_static_map;
+
+	if (p_rt->is_static_map)
+	       p_rt->mapped_port_num = port_config[port_index].mapped_port_num;
 
 	return p_rt;
 }
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index f0b01b728640..a523f062993d 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -894,10 +894,14 @@ void sdw_bus_master_delete(struct sdw_bus *bus);
  *
  * @num: Port number
  * @ch_mask: channels mask for port
+ * @mapped_port_num: Port number to map on Master or Slave in Static Configuration
+ * @is_static_map: true for static port mapping
  */
 struct sdw_port_config {
 	unsigned int num;
 	unsigned int ch_mask;
+	unsigned int mapped_port_num;
+	bool is_static_map;
 };
 
 /**
-- 
2.21.0

