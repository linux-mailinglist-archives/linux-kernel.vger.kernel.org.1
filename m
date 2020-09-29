Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5708127C1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgI2KKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgI2KKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:10:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1B1C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:10:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so4663877wrl.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Ji8d51UZNthiwaFwQiiDA22tNDSUGquN8QOwnTBLMs=;
        b=dYn7ozwsu9fg/NjCG2J03XJS8gkymmXk+ZLjMvvFMy5YAsZb7wz4hUSy3iEQiWZQNP
         RPpxTHq0AyQ5etyPB+k11seysp+LrevA+87AsjBF3FqrCGsmj3s64V0FgPDhy1PKgCYT
         PTg/9yqwPbDzNxGWjzyaaqR7bGsGdliYQiuT7d2nKEIF6b6LTlgSDShNDZZZtI9Y10OC
         wrX6We+gzKz3zE5uBusmtL1fvrmkEoYQueI8AqPPHMo81IApcB7Wg2DprCiAJB/jt+eU
         z3f4tbHfi24RzvVJIJQRJ402fGnxI49OIYXPnDOu7IypL3hhhNnQIwQpo3l23Spad2/T
         XxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Ji8d51UZNthiwaFwQiiDA22tNDSUGquN8QOwnTBLMs=;
        b=NBedcj2/puUPDdriVMWlaT3qbeJBmaE84XaJelZ91Jg+TkCh+29oJLF+t782LH6w8m
         Kz+2nkL5MOfM81yS4CUIfIjWQ2RyfLpZINuo8/PViUgmTkZDogVBaIPwZhmYm2EP3Htz
         /r9AbALu2s0WPYwc9FQWuve3fK7nVvkiZU51cAMV1JbpP1KSkIo2v2J5Vp7bgHyUksqa
         btOrZpsqGuZDFS6xFvea0uvld402IzJdN7KOvVoQLcI/J5xyaVB3aTjt9v898GkNojDl
         eRV9s2TloXcvXLXKntmAS9tFqD17jL7rAayAIzMLLXPMI1ClkQHAAiPHu0I2xJ5djrvd
         ULsw==
X-Gm-Message-State: AOAM531GdPwPUEJiFUti3tGTjaW4LPphHte0ACc6HMEB5BmqYcPMf92Z
        Ux7z4lcBhbdIZCZ9hsoJPdbK7g==
X-Google-Smtp-Source: ABdhPJxMbY4zNLxYSqL/hs2GeeOd4gbGIk3Je7AqtBA5FUlPfloGghminqaN+JIdSsNscq6TH9/Wpw==
X-Received: by 2002:adf:f34a:: with SMTP id e10mr3315435wrp.91.1601374215541;
        Tue, 29 Sep 2020 03:10:15 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-68-189.w109-210.abo.wanadoo.fr. [109.210.51.189])
        by smtp.gmail.com with ESMTPSA id x19sm3380680wmj.48.2020.09.29.03.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 03:10:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 01/10] lib: string_helpers: provide kfree_strarray()
Date:   Tue, 29 Sep 2020 12:09:55 +0200
Message-Id: <20200929101004.20288-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200929101004.20288-1-brgl@bgdev.pl>
References: <20200929101004.20288-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's a common pattern of dynamically allocating an array of char
pointers and then also dynamically allocating each string in this
array. Provide a helper for freeing such a string array with one call.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_helpers.h |  2 ++
 lib/string_helpers.c           | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 86f150c2a6b6..fa06dcdc481e 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -94,4 +94,6 @@ char *kstrdup_quotable(const char *src, gfp_t gfp);
 char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
 char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
 
+void kfree_strarray(char **array, size_t n);
+
 #endif
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 963050c0283e..efeee2353613 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -649,3 +649,27 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
 	return pathname;
 }
 EXPORT_SYMBOL_GPL(kstrdup_quotable_file);
+
+/**
+ * kfree_strarray - free a number of dynamically allocated strings contained
+ *                  in an array and the array itself
+ *
+ * @array: Dynamically allocated array of strings to free. If NULL - the
+ *         function does nothing.
+ * @n: Number of strings (starting from the beginning of the array) to free.
+ *
+ * Passing a non-null @array and @n == 0 as well as NULL @array  are valid
+ * use-cases.
+ */
+void kfree_strarray(char **array, size_t n)
+{
+	unsigned int i;
+
+	if (!array)
+		return;
+
+	for (i = 0; i < n; i++)
+		kfree(array[i]);
+	kfree(array);
+}
+EXPORT_SYMBOL_GPL(kfree_strarray);
-- 
2.26.1

