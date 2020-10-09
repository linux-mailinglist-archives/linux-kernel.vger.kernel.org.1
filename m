Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334FC288D81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389587AbgJIP4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389522AbgJIP4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:56:22 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CDFC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 08:56:22 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t15so9468316otk.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWucc2MoM3+jWn4/lhiGL+OiIehDOSkDt2N+uvSCsOE=;
        b=AYqnZAn+pNk5nqG2FryEi5pClUbiOCGqnpYuOy+JSLtkcTuVTyuD0DVacu+0LsVvDn
         IF8gzhEP+qiSh7vp4p0zmBvfCD8Ez3KSM95Kv6PHOdgY7ieTddunkcsfyI7oMcINu9bY
         kNHV0PjqifYjc2IamL4E0Ebb31XpJ+KwLQsWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWucc2MoM3+jWn4/lhiGL+OiIehDOSkDt2N+uvSCsOE=;
        b=CXR8Kz8Q2bypFTJ/etzFzavf+JYzekwrsAawwfIlqcoFrgMNKdvxTuiHX4lYfYhAW+
         tWR/BLslIOLLL8MGTpQ9dcYjzFKMX1QYsSeUEujRx6dy66LH1VdgCNMa9akGCJTzXG+l
         6+fmjiqU4LbF5GBbDyd582gBIrUepCiX3pH+M7rOvrYyFXjlVjtjsWFjpXpCf96+AdGt
         MW6zTsjY3xde2tbbRNwXJUxZpwiBdCCB0tICB4Zg4yz9i8gF7X7kO/V5ZDaVldU4zfFW
         jl6uLSkke2R8a3p5Qa9ju5X4XQs6jdWZCHlUFnDVSbBqwJnNEJCNjSsXC+2p8ui+1o1C
         SaCQ==
X-Gm-Message-State: AOAM533JAC6d4qAioQpIsGWTvuRrm7WDo3N2bR8/ge3jhwf9pT1vqxZ+
        2ceKo9ZCyistVP/li5trBlx5Kw==
X-Google-Smtp-Source: ABdhPJwVkcMvn2ygOb8HoWLPbM1+S2/K4Hz+4tlGkq6lsxeY1dS2zVmuVGbtqTqk3pS0zz1c3hoVew==
X-Received: by 2002:a9d:8d2:: with SMTP id 76mr8855643otf.270.1602258981857;
        Fri, 09 Oct 2020 08:56:21 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e7sm7347246oia.9.2020.10.09.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:56:21 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] drivers/misc/vmw_vmci: convert num guest devices counter to counter_atomic32
Date:   Fri,  9 Oct 2020 09:56:05 -0600
Message-Id: <c268264fb7444fb32f8b589f9b48a1cd08bd0780.1602209970.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602209970.git.skhan@linuxfoundation.org>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and open
counts that control state changes, and pm states.

atomic_t variable used to count number of vmci guest devices is used
as just as counter and it doesn't control object lifetimes or state
management. vmci_num_guest_devices is used as bool flag to determine
if a guest instance exists. There is a very little chance for this
counter to overflow.

Convert it to use counter_atomic32.

This conversion doesn't change the overflow wrap around behavior.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index cc8eeb361fcd..8f6aca974b5f 100644
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
+	return counter_atomic32_read(&vmci_num_guest_devices) > 0;
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

