Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21562C917A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbgK3Ws7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbgK3Wsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:48:55 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9423BC0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:48:15 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p20so27510pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mFKhjbWpDLNsHACLGmSHDXeR1f1UUpzNDZei7Sfx4p4=;
        b=MvulgOGVVW08Vt/wL+I1C6I9oeDyrppJFT8uqQTNSjTwSd/sD6sBnUAWZxhuLLZE3y
         S4usiy+muEMGYxatq1U9Y7mfsJAU0ROb6yBoE/ltWahRxvIYhsdTSl0iW0IgWUjwY8jJ
         FoRhoC//fH/m6MGBlPGhrgB1RYZKIY+uOtYw1tgM5UrTMLP+hFBMhGfCH15rJRifI6a8
         Q6fOxn9KP3TPygBiIyXm8u6qe+EjzsTCs2yMsw8e7/6N8plZIViv8JC95w0NgoI2XOVt
         jSDzBlWehVZ1mVm+BuLXcwzv1cw6ptJHYb+/L6NJ6eq1qrtyxaQpovPNIyH0hzOBcxya
         hB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mFKhjbWpDLNsHACLGmSHDXeR1f1UUpzNDZei7Sfx4p4=;
        b=mRyFWmVZIOZoGa8Aefs85o+l2bP09xOCcBu7LojP7siZ/v1os8wOSe3U+YNdZYbgOW
         mimoyemEzE+R3jqDw56Lgda8g1Ia0H9l1bnMYhGdM1Nx+xkg+Dqii+0E+ibUOZV1VKQZ
         MHfEfV7YpQKLaYVaM6YRVN6wx1FhfhGQAIRKSr3++onBazOekQpO42RU2niGhZNRgfEo
         /6ntGigKOXTwo33igk1Vhi32KhKFmtN4NlFWtxmtilb9J9xyrmy4vnX9ea3xSvkCE13a
         ak1ehK/Jw+a9Gp96+aUSYTYONh2ehcMz5thO2TZiSJPtKNS+FdmbrNk/FQeoJjwQvLM9
         2bqQ==
X-Gm-Message-State: AOAM533Oj6FpA39hKof9vuWncBJc07J5+IPmF6Tv07rQVh+ugmVmop6O
        iofPExHgKd6aGTVIRNptz98Q0UbHIQUV+vrLMAI=
X-Google-Smtp-Source: ABdhPJzzdnkUYT3hv3toB3W84HZCkOGX5OS+zb5UKJf6oZl0xdsy/y+HunnvnQfX6IJdR+jOsHsYOHUF+Z/dpPIAPD0=
Sender: "willmcvicker via sendgmr" <willmcvicker@willmcvicker.c.googlers.com>
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a17:902:724c:b029:d9:e964:c4a4 with
 SMTP id c12-20020a170902724cb02900d9e964c4a4mr20861397pll.82.1606776495078;
 Mon, 30 Nov 2020 14:48:15 -0800 (PST)
Date:   Mon, 30 Nov 2020 22:47:53 +0000
In-Reply-To: <20201130224753.1569357-1-willmcvicker@google.com>
Message-Id: <20201130224753.1569357-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20201130224753.1569357-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 1/1] gpiolib: Don't free if pin ranges are not defined
From:   Will McVicker <willmcvicker@google.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Edmond Chung <edmondchung@google.com>,
        Andrew Chant <achant@google.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edmond Chung <edmondchung@google.com>

A similar check was added in gpiochip_generic_request, but not in free.
This has caused an imbalance count of request vs. free calls to the
pinctrl driver. This patch is targeted to fix that issue.

Fixes: 2ab73c6d8323 ("gpio: Support GPIO controllers without pin-ranges")
Signed-off-by: Edmond Chung <edmondchung@google.com>
Signed-off-by: Andrew Chant <achant@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/gpio/gpiolib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 089ddcaa9bc6..6e3c4d7a7d14 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1806,6 +1806,11 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_request);
  */
 void gpiochip_generic_free(struct gpio_chip *gc, unsigned offset)
 {
+#ifdef CONFIG_PINCTRL
+	if (list_empty(&gc->gpiodev->pin_ranges))
+		return;
+#endif
+
 	pinctrl_gpio_free(gc->gpiodev->base + offset);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_free);
-- 
2.29.2.454.gaff20da3a2-goog

