Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC4B276CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgIXJGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbgIXJGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:06:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47B6C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so2706348wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IAxU6/9sgHpm6P+CDKU9EvOjV2OLEJ2czMQZlt8AogQ=;
        b=Pfo3pIGjVFfeA9tBaTJbHb6tpjMkFey1Tz979QrJ1PXR6vB3hz3wE4gzvtQCRbxVRw
         SfbO/D0UNCFddppguFi3PUvYxmJP2b5S9ONdFdTNHjKmb8+ly/MLTnvjdicHRcx6qho6
         kKsRbqviyD6HRJ9vichjMaXoL99EZUOyT+ozgNoKIz7QWQAAhKsRWgYjJxIybOZfFVzy
         vnsyNC8Y7IlkxVS7zVkTQaU3mkmhL4cKLtwD5JbyvATVzpRSLgA0Yt1z9JgJKoQk9xdy
         edBBfHnMJGQs3LF5VY+oRPDru6dbVdcBvioG+/2LfDRjhz5kdxbCkWaINd+QC8FIkkU6
         r5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IAxU6/9sgHpm6P+CDKU9EvOjV2OLEJ2czMQZlt8AogQ=;
        b=L6P4+oGwfYyeHIU38mkYFlm531P05i9ImZwBSpV4UJAx4G051MJjUt7Z/Y2H8Ncxk2
         X1xxuLESc1e7V8ziLdFDhipQ6avDIUSptIFiV891HwldBQ86/dZrz+fsGpJEngcgAb9d
         uDOnjJ5525laAJKioq+cTx1tYQCyN8hDj1OQgJhPJ06DY2CDhm+1Xgr0US/OKX0l2XiE
         tu1zqt8gfoJGrrIG1F85yKugTcORhRPwRhrfUv8onx6e6/fyBKSJFeIFrJwpxjXoPskK
         ZMMp0W7tnN1KpePr731BU7PqGPP5wcTuQE2eIXwqtCtJ+we/PeQnG1A4JgWIVOysvSPB
         fYWQ==
X-Gm-Message-State: AOAM533boGNE9YZYtBwb83AbqzG6eP8uxPoLtz782iMWYCqCO9e9N11a
        bEzs7GtJdGjFOz4FAMCfPFmndw==
X-Google-Smtp-Source: ABdhPJz800kTxCmjebc35tM8fHyGBlc54WffweoDzLpSzc/l/vAKwD/QLeTMiO1cbZRV1LrohdEYRA==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr3593346wmh.152.1600938369436;
        Thu, 24 Sep 2020 02:06:09 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.gmail.com with ESMTPSA id h2sm2861461wrp.69.2020.09.24.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:06:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 09/10] clocksource/drivers/sp804: Add support for Hisilicon sp804 timer
Date:   Thu, 24 Sep 2020 11:05:33 +0200
Message-Id: <20200924090534.2004630-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924090534.2004630-1-daniel.lezcano@linaro.org>
References: <1f4f3f8f-2472-44af-0536-6bc76741d276@linaro.org>
 <20200924090534.2004630-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

The ARM SP804 supports a maximum of 32-bit counter, but Hisilicon extends
it to 64-bit. That means, the registers: TimerXload, TimerXValue and
TimerXBGLoad are 64bits, all other registers are the same as those in the
SP804. The driver code can be completely reused except that the register
offset is different.

Use compatible = "hisilicon,sp804" mark as Hisilicon sp804 timer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-8-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 5f4f979a8ef2..f0783d19522f 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -20,6 +20,18 @@
 
 #include "timer-sp.h"
 
+/* Hisilicon 64-bit timer(a variant of ARM SP804) */
+#define HISI_TIMER_1_BASE	0x00
+#define HISI_TIMER_2_BASE	0x40
+#define HISI_TIMER_LOAD		0x00
+#define HISI_TIMER_VALUE	0x08
+#define HISI_TIMER_CTRL		0x10
+#define HISI_TIMER_INTCLR	0x14
+#define HISI_TIMER_RIS		0x18
+#define HISI_TIMER_MIS		0x1c
+#define HISI_TIMER_BGLOAD	0x20
+
+
 struct sp804_timer __initdata arm_sp804_timer = {
 	.load		= TIMER_LOAD,
 	.value		= TIMER_VALUE,
@@ -29,6 +41,15 @@ struct sp804_timer __initdata arm_sp804_timer = {
 	.width		= 32,
 };
 
+struct sp804_timer __initdata hisi_sp804_timer = {
+	.load		= HISI_TIMER_LOAD,
+	.value		= HISI_TIMER_VALUE,
+	.ctrl		= HISI_TIMER_CTRL,
+	.intclr		= HISI_TIMER_INTCLR,
+	.timer_base	= {HISI_TIMER_1_BASE, HISI_TIMER_2_BASE},
+	.width		= 64,
+};
+
 static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
@@ -315,6 +336,12 @@ static int __init arm_sp804_of_init(struct device_node *np)
 }
 TIMER_OF_DECLARE(sp804, "arm,sp804", arm_sp804_of_init);
 
+static int __init hisi_sp804_of_init(struct device_node *np)
+{
+	return sp804_of_init(np, &hisi_sp804_timer);
+}
+TIMER_OF_DECLARE(hisi_sp804, "hisilicon,sp804", hisi_sp804_of_init);
+
 static int __init integrator_cp_of_init(struct device_node *np)
 {
 	static int init_count = 0;
-- 
2.25.1

