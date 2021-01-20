Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC62FD7C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbhATSFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390152AbhATSCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:02:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E547FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:01:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m187so3610175wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5yZ5BO3u6lFnZ9F8UDgKbhKjLGtUQNrjUBzAHGBNeJ0=;
        b=VSxvdICIp48jXqyEITKyru2UcJ9m9c+PJwLnlRlyDflVj1bev2cSqhhoHJWZN/J08F
         PujNT6SeDWCVeWpOph5AePRWcP5Vjv8zMngbkSFGTS35TSU0MVx5/mUipPJ1RouLQNeG
         L50hugDZsMA/Befv5tTE2waM3SmRpqQJoWxAM95TfGGtj/pLQ9NIdCKHkkmIzA+1H7Oh
         TrsydV6uZhIsa5+PGQxDB4yRgT+zx6a5XTINaC50UqwBGIP9N7y5m3L5xssf2TRhxl6H
         bXA1svKxh0o5+Y7Dqhu7A2h4Mw3tX/BoCsI/MnsNEjdfhJt0olw9BOf4WKxfqm6TflJL
         ZcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yZ5BO3u6lFnZ9F8UDgKbhKjLGtUQNrjUBzAHGBNeJ0=;
        b=YGgv/iOheUPr8tUJkCgzI9TGyB4/ckZDryoL4yNyQj9xCB2LY2YbkeCEXFaQRVx44a
         c2gyNmtbAaI/SnwqTAY7G/uN9fb+HxKp+N2KSsVSkFZFMU5FqpNroAC6jYC5I02zMI+Z
         5uZX4xWzMFL8BNvrVJz4XC3ls6W6E5rKJkydkluRQQmR4cWxl3SbbN+xEoPuiApIx1aH
         BGurPgwNXIg5qVxER7Y4slg63wKH8PcoCJmzmOo1bjH75XCyvShQKK+APP2jlmJG9Y/O
         2X7dPJxFbljWUDlwJZAsn12wPNgnuma89GK/6chWTIzf3h3m6AP3DpQ5kJOFuUhNpS7V
         6o8g==
X-Gm-Message-State: AOAM532YtTLkfP0Zx+cUUC/tx1vYUWzVqaM9uFXHVYWZr3LuUuGESu0w
        d++ifOaYEiotjzLq14bQZgoB1w==
X-Google-Smtp-Source: ABdhPJz5Y0JvcnhmCsjZZ+kKBCgVdEfttMWHMp7t3aOwOPusy1CsvGlJAMfLnaCstLDe4cxl7J7uDg==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr5364888wmc.43.1611165701757;
        Wed, 20 Jan 2021 10:01:41 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g194sm5267422wme.39.2021.01.20.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:01:41 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 2/2] soundwire: qcom: add support for static port mapping
Date:   Wed, 20 Jan 2021 18:01:10 +0000
Message-Id: <20210120180110.8357-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210120180110.8357-1-srinivas.kandagatla@linaro.org>
References: <20210120180110.8357-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some of Qualcomm SoundWire controller instances ports are statically
mapped based on the functionalities. So add support for such mapping.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6d22df01f354..0641b591037e 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -474,7 +474,10 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
 			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
-				pcfg = &ctrl->pconfig[i];
+				if (p_rt->is_static_map)
+					pcfg = &ctrl->pconfig[p_rt->mapped_port_num - 1];
+				else
+					pcfg = &ctrl->pconfig[i];
 				p_rt->transport_params.port_num = p_rt->num;
 				p_rt->transport_params.sample_interval =
 					pcfg->si + 1;
@@ -551,7 +554,11 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
 			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
 				/* Port numbers start from 1 - 14*/
-				pn = find_first_zero_bit(port_mask, maxport);
+				if (p_rt->is_static_map)
+					pn = p_rt->mapped_port_num;
+				else
+					pn = find_first_zero_bit(port_mask, maxport);
+
 				if (pn > (maxport - 1)) {
 					dev_err(ctrl->dev, "All ports busy\n");
 					ret = -EBUSY;
-- 
2.21.0

