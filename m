Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9995B285367
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgJFUqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgJFUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:46:03 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C2BC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 13:46:02 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z5so132083ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vsaHXKcQ93l92h/rWhaFfF8DrlMfqUO8xaQHLjCgKs=;
        b=O3NplXvpfjLAIfYxJ4RTIFfrJzKphxLrLWGSjuYG9IDcQ3g601f8K/84jJHNcPJvu8
         Q2ESLBIpG5NTW6cZ7T3yeTJCcR1M4hctuhXHroMWxZXmOA29k6uqm850/LUagEW5edtl
         rxs652IGEfs3+pRO9W04aHvZLDtHVwJagaS7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vsaHXKcQ93l92h/rWhaFfF8DrlMfqUO8xaQHLjCgKs=;
        b=fdlg9EKSApFMHnmLgpjLcU3v333weBMoDGZMqL/WU7ZErpwwQ42kWUK8vK83J+wqxB
         8TfLrMIMbXlBttNe6AI955uaxbWf9A2bv3u/Mh8vhgeBKNzyRMiFMbpHRv7z2bKu48TH
         BEYG/Dbfc6IIrpOUtkcDcmiOb5GyGb7Vk1uq6SRaR3xiq3JAggjbvQaSFPKDgzno6b1W
         BKD74Qzug7/j57ZHfcuZVrCycZDhCuDA9k5x9zj9eV1YQWeYNnCXWLG42MNQhm7FYwae
         AcrdDfCY3QzcqNm49srHfJjmkCSCVpzv1Gdwv1DYylLlvY6osnucKc9s+KSDB8deE2JI
         9kwA==
X-Gm-Message-State: AOAM533aQc6Ok/7RponV6eTpEnf+GasKSdPBeh0mvvcOD0/JIfi6rdFr
        e7H5XnhM97TupIfK9No+lKGArQ==
X-Google-Smtp-Source: ABdhPJwCpu7ZLTBlZ04avtyCFRGaPeBaWnt/hkumvEwqIWOhFFFP541kmKJ1R33evovp9FK+P3pLOQ==
X-Received: by 2002:a92:8587:: with SMTP id f129mr28160ilh.226.1602017161959;
        Tue, 06 Oct 2020 13:46:01 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm1665627ili.54.2020.10.06.13.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:46:01 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] drivers/misc/vmw_vmci: convert num guest devices counter to counter_atomic32
Date:   Tue,  6 Oct 2020 14:44:41 -0600
Message-Id: <81f5ca6f9b0a032840d6ec0fb403d4908b9ddec9.1602011710.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602011710.git.skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
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

