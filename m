Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12269300149
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbhAVLPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbhAVLG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:06:57 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D72C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 03:06:16 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id o20so3482753pfu.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8xmowMygRP96q6ZfQepL38bbSA5RtX+xDKaDnp6OZZo=;
        b=xRAWJg9uWyvrqCaVbaGDdjfC4XRsikv5lqCfNDaWh8BruWcMsnByoGA5IerSTm4iLs
         IfocfLfTFc1n302KZOhl75FOqrKzBRaL3p8dhxhuMc6rzBc3hVp6/sysJJDRo/yQAL0a
         G9ok1GyFpyD3+RmFx6m1O4t+yCM2Foy3AHMkg7eQmFACmTQD3hgi2/PtUJZPV9lXX/O1
         npcolHS9Hz6jth/kq/FBvjUahiuiIMWuM8T6WA9sRlekgcPftdYBDwaGdlz2zI5/GgfL
         fhcnkCXn2jq71kYxLQNDNBBPTUVHzm1CuZUPl71eEoBunw7ejl9M0RfgFScOhTzszAFY
         BPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8xmowMygRP96q6ZfQepL38bbSA5RtX+xDKaDnp6OZZo=;
        b=VeO8rzqnzs+XbUhMlsL3D2muuFFbHiGf+udo/05/wtgmK+JmJpb3wkLMqgWLSesswL
         INNMC8wQiaP/ppJnK6R36J3Xrb44yrx4Hm399YcHZsvhzqgkObDttdjHUdM44RPyCaSe
         Qa9L/I2OuzCM229/CwLxq8EtlKAChMm9c4V6mSGqeddTgdt1gEZfA0l+t8f+Tze9JwD7
         I5noeoydkXBRL4VpLlV1toRD+5L7z+Nh4lIt0L9PdLl+j+PmbytDlhJPaBUwS7USGqQt
         dHTZnSJ4qYcBVqvo+WyCXwolT0ZQPBM/XFoCmruwJso554o20FV1V7Bo7q7nx1DoLG6H
         zT5w==
X-Gm-Message-State: AOAM531ilTZSkeQp/Chs59/oSZe+yu7lt6f5Ni41QKGBmcLVOYSx+yKP
        lfpSB7NO0Wv3Qkp7iE3tqUo2C65dbWm72A==
X-Google-Smtp-Source: ABdhPJw9OXYA0Ves4zH7Zwge3APRupjHpxKEZURTnQT2SSrlD8+pcogSCSV9X4HvSz9Fw7OVlfcWLg==
X-Received: by 2002:a65:4549:: with SMTP id x9mr4253916pgr.6.1611313575903;
        Fri, 22 Jan 2021 03:06:15 -0800 (PST)
Received: from localhost.localdomain ([122.173.53.31])
        by smtp.gmail.com with ESMTPSA id j3sm8854562pjs.50.2021.01.22.03.06.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 03:06:15 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, stable@vger.kernel.org
Subject: [PATCH v3] kdb: Make memory allocations more robust
Date:   Fri, 22 Jan 2021 16:35:56 +0530
Message-Id: <1611313556-4004-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kdb uses in_interrupt() to determine whether its library
code has been called from the kgdb trap handler or from a saner calling
context such as driver init. This approach is broken because
in_interrupt() alone isn't able to determine kgdb trap handler entry from
normal task context. This can happen during normal use of basic features
such as breakpoints and can also be trivially reproduced using:
echo g > /proc/sysrq-trigger

We can improve this by adding check for in_dbg_master() instead which
explicitly determines if we are running in debugger context.

Cc: stable@vger.kernel.org
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
- Refined commit description and Cc: stable@vger.kernel.org.

Changes in v2:
- Get rid of redundant in_atomic() check.

 kernel/debug/kdb/kdb_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 7a4a181..344eb0d 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -231,7 +231,7 @@ extern struct task_struct *kdb_curr_task(int);
 
 #define kdb_task_has_cpu(p) (task_curr(p))
 
-#define GFP_KDB (in_interrupt() ? GFP_ATOMIC : GFP_KERNEL)
+#define GFP_KDB (in_dbg_master() ? GFP_ATOMIC : GFP_KERNEL)
 
 extern void *debug_kmalloc(size_t size, gfp_t flags);
 extern void debug_kfree(void *);
-- 
2.7.4

