Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECA9300044
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbhAVK23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbhAVKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:21:49 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0D1C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:21:07 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id g15so3466605pjd.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XoFMW3OnfJNPPFldVSvQQaSFejRFNATBngl33Eh4QXM=;
        b=ZSWzskGWJQHTWK8xCE0MwgJkMnc94cSw/xSZAitSkx1ocOp67NrLdmveru5Jfn5jJr
         AFQn+XTyax+ZDbHMFjPyaCHwhO9euQMT8ZoQ2dnOHNu51obRl8NO+pQ+XGYGMOtp1kVW
         2/UUEQhJ9nrY0FuV0NDAqXBYBxDkWc/0HFLYHatQD6VnqJKIgpBVV02nsIVPY5I6Fjcl
         YqEyeZBDTn4B9uftmeR0SNIwjNXlUgZKkJ+9pHP7/Fa4SyDVHXXRuVpCzhx95mAPmAoA
         zD+qQ/8VdloWls+4lRhfzcxZiX+GuTS4WcV0XAQk+dMGGV3aDupkjx9Qo51hgWkhn0Xr
         ibJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XoFMW3OnfJNPPFldVSvQQaSFejRFNATBngl33Eh4QXM=;
        b=UYgw3hnsORrtKJQ8a+cPGgYwk1PIuxYycZ0Q84QZCdyxf+gdUJHKrV2D8BQTeJG4Vt
         1sz7kyBXdsLAZ4th+P9/1Cs2ca5vWXFKQwC0cQS1dll/zoZ7hlR0yByTN2p2scnnPwR3
         BwMRQ/dEQZfc2d6xjYft1u8JdiVmDTPKLaTI+398w1OX+X36hbc1MlDnehLJsh9usOPo
         5qPXqJHJlb80UmpRXNIGoGCyNOSuCUSk2Qv5oQU2weCN+HcldnuzM0ZvJoEVJcsUPdEb
         xs+yjmPHqYkKNNDP1lCCA0F9i9zd/bvqU+KZig4CHvz7+AtuzI+xTK3CwwxSFBjuQUDa
         qJXw==
X-Gm-Message-State: AOAM532EXcYxI129+VSPIbAWZ9WZEOl/Bo33NxsDWT5gDvKXFYIWQvO2
        2+5APLkL4zk5Zvr2axIcv11UyQ==
X-Google-Smtp-Source: ABdhPJzRoAHA3V2OMWAaOdw8coCyBE2IHrTcMy8kprKt4kCmC5DwgsnYIdx2PH4Lqtn4pdxX8zUBjA==
X-Received: by 2002:a17:902:bc41:b029:de:1ec2:dac1 with SMTP id t1-20020a170902bc41b02900de1ec2dac1mr4244934plz.9.1611310866648;
        Fri, 22 Jan 2021 02:21:06 -0800 (PST)
Received: from localhost.localdomain ([122.173.53.31])
        by smtp.gmail.com with ESMTPSA id ne6sm8487557pjb.44.2021.01.22.02.21.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 02:21:05 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2] kdb: Make memory allocations more robust
Date:   Fri, 22 Jan 2021 15:50:50 +0530
Message-Id: <1611310850-3339-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kdb uses in_interrupt() to determine whether it's library
code has been called from the kgdb trap handler or from a saner calling
context such as driver init. This approach is broken because
in_interrupt() alone isn't able to determine kgdb trap handler entry via
normal task context such as [1].

We can improve this by adding check for in_dbg_master() instead which
explicitly determines if we are running in debugger context.

[1] $ echo g > /proc/sysrq-trigger

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

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

