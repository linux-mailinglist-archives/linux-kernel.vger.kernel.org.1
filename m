Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E508279513
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgIYXs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgIYXru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:50 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F1C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:50 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id v20so4574166oiv.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vsaHXKcQ93l92h/rWhaFfF8DrlMfqUO8xaQHLjCgKs=;
        b=WQDYbegUQfHwdHd0Jf6ou0AmpAysdXCxSkB8wstJqokC4OmjXhs5dPyJLBFMW4fTEo
         faP+6rG81B9jQJS/yYiZzTasFyj0e6E1ZOrSyBApSvjtphITP2MHLAFIo3XD3GXJZP0P
         VNZN16vtrknWuNTOoBKvUfhwXr7dOoLKwjAdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vsaHXKcQ93l92h/rWhaFfF8DrlMfqUO8xaQHLjCgKs=;
        b=qMTEz+72HJa4GEvPgQ/qzc8CVt9wdnFaZq75ATglhZLz1zq3JPgBLKfyXY3N+OjVIY
         vxVm1XonlPn2GgUHhN/30HuUWeO6O+Q/W4cA7s8dNTsivgKn7mo16PN6u/6n2y1m/kkL
         Jbwf1/l5BN6GtzgFvvy8Qlsgzg+xXwwtve8zowSnuPX+yuwPGejkx2hj5cYBckTKEnE7
         iLdlLo2LnUx6hPE5KvZP/zh8c+PeLwrD/coyhUeqxlsLNrlFHv4T3R6CpwjukrVXVxGc
         6KGyrAvJ+2pwvnCY/6cmcHF5xL59g+pe9/9E+FY7S05Kz7rNpZeH4Ys7u05/TrKmJKjA
         L5+g==
X-Gm-Message-State: AOAM530gmiRHp9M4D/rC7Fr714yPJicACaFa8c3MkADtbO3YgNBIhQxz
        X9Q467avqRT23YeoP5TZ7K5fYw==
X-Google-Smtp-Source: ABdhPJwgcRupwJVqbbw0xR0CPkdPYYrJG1jask8osvpdhH0txLuFkGrsL1dzRqv1UpNd+xogVP1lzA==
X-Received: by 2002:a05:6808:9bc:: with SMTP id e28mr8759oig.71.1601077670048;
        Fri, 25 Sep 2020 16:47:50 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:49 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] drivers/misc/vmw_vmci: convert num guest devices counter to counter_atomic32
Date:   Fri, 25 Sep 2020 17:47:24 -0600
Message-Id: <df6cafabdf2fe3a0e954be24ad5015c4d95605a4.1601073127.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variable used to count number of vmci guest devices is used
as just as counter and it doesn't control object lifetimes or state
management. Overflow doesn't appear to be problem for this use.

Convert it to use counter_atomic32.

This conversion doesn't change the overflow wrap around behavior.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index cc8eeb361fcd..86ae27b05fc2 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/vmalloc.h>
+#include <linux/counters.h>
 
 #include "vmci_datagram.h"
 #include "vmci_doorbell.h"
@@ -68,11 +69,11 @@ struct pci_dev *vmci_pdev;
 static struct vmci_guest_device *vmci_dev_g;
 static DEFINE_SPINLOCK(vmci_dev_spinlock);
 
-static atomic_t vmci_num_guest_devices = ATOMIC_INIT(0);
+static struct counter_atomic32 vmci_num_guest_devices = COUNTER_ATOMIC_INIT(0);
 
 bool vmci_guest_code_active(void)
 {
-	return atomic_read(&vmci_num_guest_devices) != 0;
+	return counter_atomic32_read(&vmci_num_guest_devices) != 0;
 }
 
 u32 vmci_get_vm_context_id(void)
@@ -624,7 +625,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 
 	dev_dbg(&pdev->dev, "Registered device\n");
 
-	atomic_inc(&vmci_num_guest_devices);
+	counter_atomic32_inc(&vmci_num_guest_devices);
 
 	/* Enable specific interrupt bits. */
 	cmd = VMCI_IMR_DATAGRAM;
@@ -684,7 +685,7 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
 
 	dev_dbg(&pdev->dev, "Removing device\n");
 
-	atomic_dec(&vmci_num_guest_devices);
+	counter_atomic32_dec(&vmci_num_guest_devices);
 
 	vmci_qp_guest_endpoints_exit();
 
-- 
2.25.1

