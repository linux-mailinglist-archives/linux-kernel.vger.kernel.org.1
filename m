Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789B02B9DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 23:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgKSWkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 17:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgKSWku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 17:40:50 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C46EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 14:40:50 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id w10so6873827ilq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 14:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OOSsF7KnxFiHnRY0GY2iUK6XWu8gB3i6mV+T4+SlcUs=;
        b=R95lTJA4IP1J1OO+QCE2nzBGjLaWqo+e9QFoqUa3A7O7xI3pKQ4r0uG4HT4Jz67IUm
         whiNfCSA+tDFO3KaafhnjbDo2y6/qPsh7rhnFGHRTv8Lq8dQ8VuTLi7ld4o0kc/6gFql
         cxzbEoCamnJ6ymEaOUox37s6nEcaowVc5XJmlmbXm/Xjv5MDpLy5q/NRoxRP1M8cEOFg
         ORv161ukmdMhWu8OMMAgnUp799EYwsrg4rCWaMZzTtgt3ZrhKLurZg5TEtdOftIrAlGi
         XOv1qy/ClMZXVjO2fdH7ywR3Umxx3n+JILYv4Gx0wmjFBQm0NjloTdfFRLmkDcDP4pWV
         +oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OOSsF7KnxFiHnRY0GY2iUK6XWu8gB3i6mV+T4+SlcUs=;
        b=UmNQri2NtywJPA4mFBxYEmhBy0R/ZYRIA9Y1fokNoWCIaHnBfTlkgRQWvVkTzzn8B3
         Uduq8hogDTQDFzMcdJ2J8ntCJqcZ5nRZNRqSmVpYZaPuBAJFTIhDd5RPggPdJ622VueO
         MqAUnujXcaAZrMT4LbTNjvxiTafG9PN21KMmbzLhI/wqUbIcTAZxS3wvE9+VlpwWjAom
         ri3ePu4qH3SrgqDLFOSpdIUsYdblUd4+xO6lGuv9mig6zfRo9JVR6hF8DYnoS8WjNfGg
         r52i80DLQ9H/v+fyHDRniOV6DE6vBuODtOD1zptGlC6KA5rlXBNZ4GOhmpm1BBe0iPGv
         V4qw==
X-Gm-Message-State: AOAM532kpyvEGbjJ97sPuM6WWqn/AoIZ+AR/2UuCDzaJkZykg/RkTjPf
        36qtPIS0WRkv+Cr7vnYZHUtYEx+l3klSzg==
X-Google-Smtp-Source: ABdhPJza97JlcTNihMoQGiobgh1N6Iww+mRwBtUxxzJD3ZmxFQlJhkmVeLvYXNTgwB3M+a/Cm8ma2A==
X-Received: by 2002:a05:6e02:92f:: with SMTP id o15mr23878207ilt.169.1605825649701;
        Thu, 19 Nov 2020 14:40:49 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id b4sm587797ile.13.2020.11.19.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 14:40:49 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: ipa: use config data for clocking
Date:   Thu, 19 Nov 2020 16:40:41 -0600
Message-Id: <20201119224041.16066-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201119224041.16066-1-elder@linaro.org>
References: <20201119224041.16066-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop assuming a fixed IPA core clock rate and interconnect
bandwidths.  Use the configuration data defined for these
things instead.  Get rid of the previously-used constants.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index ef343669280ef..9dcf16f399b7a 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -30,18 +30,6 @@
  * An IPA clock reference must be held for any access to IPA hardware.
  */
 
-#define	IPA_CORE_CLOCK_RATE		(75UL * 1000 * 1000)	/* Hz */
-
-/* Interconnect path bandwidths (each times 1000 bytes per second) */
-#define IPA_MEMORY_AVG			(80 * 1000)	/* 80 MBps */
-#define IPA_MEMORY_PEAK			(600 * 1000)
-
-#define IPA_IMEM_AVG			(80 * 1000)
-#define IPA_IMEM_PEAK			(350 * 1000)
-
-#define IPA_CONFIG_AVG			(40 * 1000)
-#define IPA_CONFIG_PEAK			(40 * 1000)
-
 /**
  * struct ipa_clock - IPA clocking information
  * @count:		Clocking reference count
@@ -116,18 +104,25 @@ static void ipa_interconnect_exit(struct ipa_clock *clock)
 /* Currently we only use one bandwidth level, so just "enable" interconnects */
 static int ipa_interconnect_enable(struct ipa *ipa)
 {
+	const struct ipa_interconnect_data *data;
 	struct ipa_clock *clock = ipa->clock;
 	int ret;
 
-	ret = icc_set_bw(clock->memory_path, IPA_MEMORY_AVG, IPA_MEMORY_PEAK);
+	data = &clock->interconnect_data[IPA_INTERCONNECT_MEMORY];
+	ret = icc_set_bw(clock->memory_path, data->average_rate,
+			 data->peak_rate);
 	if (ret)
 		return ret;
 
-	ret = icc_set_bw(clock->imem_path, IPA_IMEM_AVG, IPA_IMEM_PEAK);
+	data = &clock->interconnect_data[IPA_INTERCONNECT_IMEM];
+	ret = icc_set_bw(clock->memory_path, data->average_rate,
+			 data->peak_rate);
 	if (ret)
 		goto err_memory_path_disable;
 
-	ret = icc_set_bw(clock->config_path, IPA_CONFIG_AVG, IPA_CONFIG_PEAK);
+	data = &clock->interconnect_data[IPA_INTERCONNECT_CONFIG];
+	ret = icc_set_bw(clock->memory_path, data->average_rate,
+			 data->peak_rate);
 	if (ret)
 		goto err_imem_path_disable;
 
@@ -144,6 +139,7 @@ static int ipa_interconnect_enable(struct ipa *ipa)
 /* To disable an interconnect, we just its bandwidth to 0 */
 static int ipa_interconnect_disable(struct ipa *ipa)
 {
+	const struct ipa_interconnect_data *data;
 	struct ipa_clock *clock = ipa->clock;
 	int ret;
 
@@ -162,9 +158,13 @@ static int ipa_interconnect_disable(struct ipa *ipa)
 	return 0;
 
 err_imem_path_reenable:
-	(void)icc_set_bw(clock->imem_path, IPA_IMEM_AVG, IPA_IMEM_PEAK);
+	data = &clock->interconnect_data[IPA_INTERCONNECT_IMEM];
+	(void)icc_set_bw(clock->imem_path, data->average_rate,
+			 data->peak_rate);
 err_memory_path_reenable:
-	(void)icc_set_bw(clock->memory_path, IPA_MEMORY_AVG, IPA_MEMORY_PEAK);
+	data = &clock->interconnect_data[IPA_INTERCONNECT_MEMORY];
+	(void)icc_set_bw(clock->memory_path, data->average_rate,
+			 data->peak_rate);
 
 	return ret;
 }
@@ -273,10 +273,10 @@ ipa_clock_init(struct device *dev, const struct ipa_clock_data *data)
 		return ERR_CAST(clk);
 	}
 
-	ret = clk_set_rate(clk, IPA_CORE_CLOCK_RATE);
+	ret = clk_set_rate(clk, data->core_clock_rate);
 	if (ret) {
-		dev_err(dev, "error %d setting core clock rate to %lu\n",
-			ret, IPA_CORE_CLOCK_RATE);
+		dev_err(dev, "error %d setting core clock rate to %u\n",
+			ret, data->core_clock_rate);
 		goto err_clk_put;
 	}
 
-- 
2.20.1

