Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015732A1199
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgJ3XZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJ3XZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:25:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE4C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:25:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b3so6646937pfo.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yjeVmLTkqXf7MYuqaimKsn2xYixi+z/wiQhveY1XA3k=;
        b=n4BaFFoQfUBTngee/lv/kx6xG0deSPWxRXzBrw7dk/vp1ugf8rw4Qbn4geQHQ0k4xr
         K6BQkOBWfS59FIygXhrLdgLPd8trbw+shFZag8g7wOBzVJOVSJ2qriL5RNEY5pEyMghs
         C+2DJhYvuCw1StCS9iN8X2KaaTQJROqCrip84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yjeVmLTkqXf7MYuqaimKsn2xYixi+z/wiQhveY1XA3k=;
        b=rYfQ8B8yqUds0FyCDt+CAgzH5jJ4TYISp0XAyGKj9bBJ23bhjQ18xsYL5JxrKu/Rwl
         /TaKFCuXnrxPF0djEeq/Nqdy+NNgg5D0iujeOGW2YdFvwRT8Q0Mu7pecqAd2Oo9CMil5
         MVtcxBIc3sfUhhbXuKFe32+cuCuOmY55eRn99bA6/trV2fFRQGWN2b/E4yEdISV7OgLR
         5JHG0Gbu3WMuTgr6DjQN+iIYfXU5bHZF3kBbH7FbeFco6vV+AP14N5QdKyw0pU3mIxXa
         ZlX5e8cIosHD3AeoSNZbJXW+y8s1ULwXesxpsLJokwVw4H/6C4Dij83JoSxb+U+NIMRl
         KgDg==
X-Gm-Message-State: AOAM531/P16k1WLidWnkizfNidtBbbaRMjFY4O6E80l2ICHSoShYfhha
        cOl7tYGLtWkmJWafN7Q+tpcQlA==
X-Google-Smtp-Source: ABdhPJwlWPAZ/R/eEPth4rGkW4O3U7aSkpILyeC/FCsvN9oBuHawsqshEw9Vbrj9yrtxRsgr3DkfWQ==
X-Received: by 2002:aa7:96b9:0:b029:155:6332:e1c7 with SMTP id g25-20020aa796b90000b02901556332e1c7mr11680612pfk.35.1604100325414;
        Fri, 30 Oct 2020 16:25:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id y10sm5764000pjr.2.2020.10.30.16.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 16:25:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH] platform/chrome: Don't treat RTC events as wakeup sources
Date:   Fri, 30 Oct 2020 16:25:23 -0700
Message-Id: <20201030232523.2654478-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC sends an RTC host event when the RTC fires, but we don't need to
treat that as a wakeup event here. The RTC class already properly
handles activating and deactivating a wakeup source in rtc_update_irq()
by calling pm_stay_awake() at the start of processing and pm_relax()
once all expired RTC timers have been processed. This reduces one wakeup
increment but not much else. I noticed this while debugging RTC wakeups
and how they always incremented the wakeup count by two instead of one
because this is duplicated.

Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: <linux-rtc@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I wonder if it makes more sense to look for certain events and treat
them as wakeup sources? It may be that most of the time an EC event
can be pm_relax()ed too and only need to be held active until the
processing is over? I haven't looked beyond this situation.

 drivers/platform/chrome/cros_ec_proto.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 0ecee8b8773d..7c92a6e22d75 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -742,12 +742,16 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 		 * Sensor events need to be parsed by the sensor sub-device.
 		 * Defer them, and don't report the wakeup here.
 		 */
-		if (event_type == EC_MKBP_EVENT_SENSOR_FIFO)
-			*wake_event = false;
-		/* Masked host-events should not count as wake events. */
-		else if (host_event &&
-			 !(host_event & ec_dev->host_event_wake_mask))
+		if (event_type == EC_MKBP_EVENT_SENSOR_FIFO) {
 			*wake_event = false;
+		} else if (host_event) {
+			/* rtc_update_irq() already handles wakeup events. */
+			if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_RTC))
+				*wake_event = false;
+			/* Masked host-events should not count as wake events. */
+			if (!(host_event & ec_dev->host_event_wake_mask))
+				*wake_event = false;
+		}
 	}
 
 	return ret;
-- 
Sent by a computer, using git, on the internet

