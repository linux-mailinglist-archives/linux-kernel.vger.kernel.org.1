Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBDA2CDF0A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbgLCTeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387713AbgLCTeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:11 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F3C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:25 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id f190so5097650wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8k+SU9egNWxq4b0wBJGRhEZTEm6bOGxn0mNslGERbk=;
        b=i4AOc4t6lXCTMJwRv0xGWKqbKrD96tGvsGpGth8MWFRF14OaUEBo0cjW+MIYoq0mHZ
         DiVXxKNb0aADfl4/eRtMqBfGZ6EqInh8InV+/ApVWPPdAjy947PMsuAfb9qEFVECeoKY
         vPIXlXIDiFB9MwkYt5C05MfPQ45K9p3tc36Lgn6p8ykZwWjLzCXqqpOvoX4ONAq/pLa+
         2uC7EIi8qm2ywodgTJ5PZMyiVH0mrNQ7eN/g9/0jxFkIELzyHWD/qJGktL6HmnkPAVVj
         6vkwXGSnhQkJN6gDHDeQ/p3v7PZtiVp0LFeY9dighBga6t+q9zmnQMei9Gs9KDi1h3Ws
         sncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8k+SU9egNWxq4b0wBJGRhEZTEm6bOGxn0mNslGERbk=;
        b=Hrjko3jzb391QgABzZeN5bufG2JIrxUU6O3w/27x49ZzLGJ7nnDPlB4H6UgJIxS4V9
         5maMiVY7ytGLWTzMWSUSlKAwG/sAp0TcB35H3YkO4u0p1eGlvsyb35B2b/A/W4UTxmN3
         TR3wt5nApF2aWWB1awD2bc5KavrP53B79U7hmd3cjcApbwLBIPrMpEB5vfM5kHDjbGan
         plXXetOmbihm2Cbtqglx77HW7MJzt+LkFmongD26HrWzOgAn6iaOOXFleAnFNgjE5QNm
         pHP5TRgJKckrERRUYAOw1dF4rfz13kjTkeJy/klGDYKrys3JnH5sEnKJYI5DkEkE6qCr
         NOPQ==
X-Gm-Message-State: AOAM531gLLDbMKLXQwZoTJn1Qc/JRxK97XM5tswF/KivkkLgt3tN664I
        gmVXOtElLwg4h1B+zLHGX3nRbzDEv0XzHw==
X-Google-Smtp-Source: ABdhPJxGDK64CtDFHHvNDLi5rWAqBDRoe8ZT0K83GtkRNMREb/uEjTb0UfrayhCXDvhNBIGkar5kUw==
X-Received: by 2002:a1c:e342:: with SMTP id a63mr425175wmh.64.1607024004134;
        Thu, 03 Dec 2020 11:33:24 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:23 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] clocksource/drivers/sp804: Make some symbol static
Date:   Thu,  3 Dec 2020 20:32:50 +0100
Message-Id: <20201203193301.2405835-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203193301.2405835-1-daniel.lezcano@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
 <20201203193301.2405835-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

drivers/clocksource/timer-sp804.c:38:31: warning: symbol 'arm_sp804_timer' was not declared. Should it be static?
drivers/clocksource/timer-sp804.c:47:31: warning: symbol 'hisi_sp804_timer' was not declared. Should it be static?
drivers/clocksource/timer-sp804.c:120:12: warning: symbol 'sp804_clocksource_and_sched_clock_init' was not declared. Should it be static?
drivers/clocksource/timer-sp804.c:219:12: warning: symbol 'sp804_clockevents_init' was not declared. Should it be static?

And move __initdata after the variables.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201029123317.90286-2-wangkefeng.wang@huawei.com
---
 drivers/clocksource/timer-sp804.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index db5330cc49bc..22a68cb83cf3 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -34,8 +34,7 @@
 #define HISI_TIMER_BGLOAD	0x20
 #define HISI_TIMER_BGLOAD_H	0x24
 
-
-struct sp804_timer __initdata arm_sp804_timer = {
+static struct sp804_timer arm_sp804_timer __initdata = {
 	.load		= TIMER_LOAD,
 	.value		= TIMER_VALUE,
 	.ctrl		= TIMER_CTRL,
@@ -44,7 +43,7 @@ struct sp804_timer __initdata arm_sp804_timer = {
 	.width		= 32,
 };
 
-struct sp804_timer __initdata hisi_sp804_timer = {
+static struct sp804_timer hisi_sp804_timer __initdata = {
 	.load		= HISI_TIMER_LOAD,
 	.load_h		= HISI_TIMER_LOAD_H,
 	.value		= HISI_TIMER_VALUE,
-- 
2.25.1

