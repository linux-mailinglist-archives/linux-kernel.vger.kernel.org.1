Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2CD274EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgIWBoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgIWBo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:44:28 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3DCC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:28 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g96so17484091otb.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGQYLVxFon+BMRQmo5jd0t2Y8IqeCwVAew8G9KfybSI=;
        b=FJKquwpUzE+cYhUFoa3GEcos73wq+OoYSC+PzkhQqx0xruLmQVlUOg8HUr4U7LRfXW
         3KEpGTIOxfeWDhCkpi2vUq/HAOPq2v5DXCybhFmIphIPjgDngNJ4f67xLDUvJpdZC/VB
         ubMA2OlG2s4OBL3z15zFUiC7D0M5QKaJPm8P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGQYLVxFon+BMRQmo5jd0t2Y8IqeCwVAew8G9KfybSI=;
        b=DtFdJ6J5azhg3OZ1xUeDhHZEF1RERi3zdRSF34qdJJXO1dccOOQU3ETxEDmoMmo6c0
         LAh314oheXPk6JqpPOiYtccPtrzO221Lp1qjMtWz1jh35PqLiXkqilCf7z0Ghxm+3gPq
         s8NFzx0n7+/ZE6Jz6dJcjuxA4C/HvN1RahZkAd5eGq84N5uo6DwUnfd+u1k09BT3RU7Q
         vkiWJhmHUae5Dg4FDvKWMy+QaRFqeWAHumbSB61MsngdFbZzXpbaeDZ2rOtUTcRACQbP
         20zBl8EnLtlrM/qDkGw8YJsQ5JWJJFNs3Y8ji6szUZ7KPSe7Bh4GjJ55doLgaD4cf6ZK
         iLoA==
X-Gm-Message-State: AOAM533DqjYvkBLEdv5y1uIVk1K5En/SG0XWm4kjwytP/+AQyyfF6j9g
        YvwJYH69aUHc4gidZoTLu9k04XYKIq59Ww==
X-Google-Smtp-Source: ABdhPJxp82Izfr09pk4P1bnzl3JMRLNZcG8y7BkJGfo8GZNdCKqngqYtQdLKnQYBMZQYegeO7E46AQ==
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr4611443otq.271.1600825467650;
        Tue, 22 Sep 2020 18:44:27 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y23sm8801820ooj.34.2020.09.22.18.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:44:27 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/11] drivers/misc/vmw_vmci: convert num guest devices counter to counter_atomic
Date:   Tue, 22 Sep 2020 19:43:39 -0600
Message-Id: <e53dcdeb280bd90e074f214f8f292e89dedb36df.1600816121.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600816121.git.skhan@linuxfoundation.org>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variable used to count number of vmci guest devices is used
as just as counter and it doesn't control object lifetimes or state
management. Overflow doesn't appear to be problem for this use.

Convert it to use counter_atomic.

This conversion doesn't change the oveflow wrap around behavior.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index cc8eeb361fcd..2c21448af730 100644
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
+static struct counter_atomic vmci_num_guest_devices = COUNTER_ATOMIC_INIT(0);
 
 bool vmci_guest_code_active(void)
 {
-	return atomic_read(&vmci_num_guest_devices) != 0;
+	return counter_atomic_read(&vmci_num_guest_devices) != 0;
 }
 
 u32 vmci_get_vm_context_id(void)
@@ -624,7 +625,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 
 	dev_dbg(&pdev->dev, "Registered device\n");
 
-	atomic_inc(&vmci_num_guest_devices);
+	counter_atomic_inc(&vmci_num_guest_devices);
 
 	/* Enable specific interrupt bits. */
 	cmd = VMCI_IMR_DATAGRAM;
@@ -684,7 +685,7 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
 
 	dev_dbg(&pdev->dev, "Removing device\n");
 
-	atomic_dec(&vmci_num_guest_devices);
+	counter_atomic_dec(&vmci_num_guest_devices);
 
 	vmci_qp_guest_endpoints_exit();
 
-- 
2.25.1

