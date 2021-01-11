Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCFC2F17A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbhAKOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388335AbhAKOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:09:03 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5106EC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:08:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n16so10947609wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I58h35GkwvjcxsG9VAqhK3onP53PzupAl4Y9BVQb82w=;
        b=uRx5WHjTnV332VFUpSqk+tFT51LcmLudFmaPDTDvwzixaV8JhRZytSLeKRZbsNqRm7
         T79BkqF7Ia58Lzy8Q7oNsJnmG/ErBKeQJlmYNqVlIyGQmYLfaUUQ6nm8Mkluk/1yepx1
         ULOn8W6E9PWnLH9YDzYD0niHkY8DJ+el5Vq2RZI6bGFm9JznAb9hos9gvCZ1Ht/st/JM
         +WOE+6h1i40A0QmdyUMhY2f9lK6zAgMC0qiqULdRcdrUQwxeCOPzGYBDQ881IGuLhpV0
         OcMFWV5kRI3DU7Uz4kPrDUMFZqEpOIqgTw46O2q7mevTQD+Hoqe8rPN736QXWxeHfdT5
         Atrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I58h35GkwvjcxsG9VAqhK3onP53PzupAl4Y9BVQb82w=;
        b=Is2zM/IeC29ZsaktuRPELplEprM1RMCutY4hbqN8HMCy8YKMO9/o/hICsy6yVKliXg
         IpZx58Fuq/sUDERnro8RZa7MO3UQGaenohL6DscVF7JyJiOWC5B+SM0IvggeqZTL9RJ5
         OHCmTXHKMViuFl4pE0JLbP/1mLcmKokGI6CIRcySCBM8XogVHcuaLXO9ylYIcg2a0Z9B
         O+HBFpcR9WcQfwHhZsa51yfPsEphFODzX44H6P2W9AlZmtuDHQ+fSpDFB5VEDDpvoRt4
         usg2y1n3qLxVr9UrVCJe2Mx4SD1hwCJK2ksv4dIHBOUoc3UPW/btSuQHyMKzKSCwutI2
         KsbQ==
X-Gm-Message-State: AOAM530TfZvqd7I7tuNxcU8u5nkZ7ZwbyC4o/k8UDLuFjJgL6F8W2TSR
        q+ru2rdoPIPF5GvGf2oEBFERh9oWXjPynA==
X-Google-Smtp-Source: ABdhPJwjNOQPTRhauX395hkydHi2zy6dykxEDyPmdbz388dPWlH49jAat4a1988G5Y5eWOjmJLJHEA==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr14998511wmj.115.1610374102076;
        Mon, 11 Jan 2021 06:08:22 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id h16sm21751539wmb.41.2021.01.11.06.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:08:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] clocksource: davinci: move pr_fmt() before the includes
Date:   Mon, 11 Jan 2021 15:08:14 +0100
Message-Id: <20210111140814.3668-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We no longer need to undef pr_fmt if we define our own before including
any headers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/timer-davinci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index bb4eee31ae08..9996c0542520 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -7,6 +7,8 @@
  * (with tiny parts adopted from code by Kevin Hilman <khilman@baylibre.com>)
  */
 
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -17,9 +19,6 @@
 
 #include <clocksource/timer-davinci.h>
 
-#undef pr_fmt
-#define pr_fmt(fmt) "%s: " fmt, __func__
-
 #define DAVINCI_TIMER_REG_TIM12			0x10
 #define DAVINCI_TIMER_REG_TIM34			0x14
 #define DAVINCI_TIMER_REG_PRD12			0x18
-- 
2.29.1

