Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D42FFF79
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbhAVJqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbhAVJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:39:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9349C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:38:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c132so3353519pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5XkfPIeaOJLsy0Tv+oZGNxT8cNyK2rUePBRvJsE8fKA=;
        b=hh6PmUhwxLRoyQ/oYOx+tc2FT99ESSRDcHrUQuCUnmt1POfYLRkHJzzroCEVrCArrH
         Ogk0tzqX+rO/FTJA86Lx9TT5HAM+RBM3Th9/Wk4W9cjBhTNNAkkt8oOJdUghNuNSIl7F
         3GWARhehbMK/YFBoecnfuxZIZCwGm9SNDuLNxW2Uy1tP+GuN4xe5/e2xcoN4KH5qaAJQ
         Mgy3eknMBe5cYRzlPkw4/FvlgXWHNuT8Sf1RBkoBQ3KFHchAqLYYnYxVEDGRPC3gJ0xa
         0nTukggDzea0NV8Jpiuatf9HaEzcf4hPgqPBzN5mhr8MXkM9c+53Nk0SfdjjMhgNI5mi
         s0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5XkfPIeaOJLsy0Tv+oZGNxT8cNyK2rUePBRvJsE8fKA=;
        b=M4hi2Z8tfP9uGnsL5ZaAXKaKTy4Ggz5Umafv5/KDu4cN61rzAT76DY8+vAb7XOzfMj
         sSopRcousKx9RiPc65SA1pQWAg8F91/GNxf9szJI+t0KoheoSyfp7adxp++lAlK3aYUG
         xf8ilz3cN/YNQP+uUjBgsgFWF0CoMFU1MLJZsFgyV+93T+XXe8FFjXJEmwGyY+ols/Pr
         t9eCQeMlbdZGAaDtuRQxSMV7vmKcWtEm2o282WZs9mtr3abH8RGBWsbN1xcmEYTu1mAI
         87tQZXTCQk6UT69o7KYDew6BIIfch63HUmeY9Mkk8B9Fn2WmgOrNXJWy40qLvWSSBCOV
         cL7Q==
X-Gm-Message-State: AOAM532xIE79e+AjDuQ+fiAxIR6xDCmWBUkQV1xaB0Zm88+biTXYCgdx
        FFQSd0D48XIs9thQYaxJJ+J0USa1XFAEqw==
X-Google-Smtp-Source: ABdhPJzvUWzsIHNQPvEPrBlano9vEd2rYgUsgOyBcrkbE0eYZBzSqTClmrX9Cd7jS7BLSBuAklpNrw==
X-Received: by 2002:a62:5b07:0:b029:1ae:177d:69e1 with SMTP id p7-20020a625b070000b02901ae177d69e1mr3853738pfb.25.1611308333324;
        Fri, 22 Jan 2021 01:38:53 -0800 (PST)
Received: from localhost.localdomain ([122.173.53.31])
        by smtp.gmail.com with ESMTPSA id y26sm8543616pgk.42.2021.01.22.01.38.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 01:38:52 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] kdb: Make memory allocations more robust
Date:   Fri, 22 Jan 2021 15:08:31 +0530
Message-Id: <1611308311-2530-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kdb uses in_interrupt() to determine whether it's library
code has been called from the kgdb trap handler or from a saner calling
context such as driver init. This approach is broken because
in_interrupt() alone isn't able to determine kgdb trap handler entry via
normal task context such as [1].

We can improve this by adding check for in_dbg_master() which explicitly
determines if we are running in debugger context. Also, use in_atomic()
instead of in_interrupt() as the former is more appropriate to know atomic
context and moreover the later one is deprecated.

[1] $ echo g > /proc/sysrq-trigger

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 7a4a181..7a9ebd9 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -231,7 +231,7 @@ extern struct task_struct *kdb_curr_task(int);
 
 #define kdb_task_has_cpu(p) (task_curr(p))
 
-#define GFP_KDB (in_interrupt() ? GFP_ATOMIC : GFP_KERNEL)
+#define GFP_KDB (in_atomic() || in_dbg_master() ? GFP_ATOMIC : GFP_KERNEL)
 
 extern void *debug_kmalloc(size_t size, gfp_t flags);
 extern void debug_kfree(void *);
-- 
2.7.4

