Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71622BFC8C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 23:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgKVWpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 17:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKVWpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 17:45:44 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3139DC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 14:45:44 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 5so7897458plj.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 14:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdWIGTc92K23SGH+h45CfwAU+BJCGqp0BeoMZ1rGk8A=;
        b=Z6Fm/S3V7eXuJUGZ5sbX1lgvXOrObrDIGsn9unaLCxeWisxliLoyeHJ0euahfscnk0
         mAJJgWKdyi/E5Y3EXpOOOjdcv/P37fWdEnZZ5Wj2tXQv45nZYSfr3hTFfYquNUstxB4x
         3nK86wzpLhihoXMjKw4z1xrUObSwMVHsNaPVz1IBOsOHhURXIOp6VFumVPe2+Y07xHoo
         LgmMtnpXWgY1ZQ8HuWdoXlzVh9S2bWTEPXg8JD2wjQCF8RqIYNa7ckbKmwsNUxKDUrpC
         ruDc7qtDn46KNhtV9CngsZ2+x6ivvvlWLayf00FE7jTjNLWUU9HI2LskKIxHgdDI21Dt
         FhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdWIGTc92K23SGH+h45CfwAU+BJCGqp0BeoMZ1rGk8A=;
        b=qdOvMMLBDkLrby/L+zfeTwCePEAtMw/veBffoMukkWThsNxLM6UHXFE+cNohmAyzer
         30KSPKJ/4WuJcgsN31NvB6g03otelXnSQMXoiFu1YJM9VHvUhSj6nBrrox85nEpyVysX
         n/HBisdm+b1u2JXOoHJc9s8v5DAwLH6VtD0LkyKZZEQrqh2v4C4c2vuchqSsn6rg7B2/
         9yPmrvKseMIFqkxV0O7rpuLQ/JmO80R7ZXMvCeoGA3LKSXu9jI0ZHNJb5A4YDHvPMyYt
         CYmj+iQHU4vnk2oVzd5+mHkTTqx34npzob3mUcNr5d4BvoZCTxSOZbqgVRR/MECcjgKE
         yaBQ==
X-Gm-Message-State: AOAM533MR1nI9r88a70Wswgv9yMVRkMsYiIYLzbUG+GFqZ2LLELh8yj5
        ne+dOqES5MyVjoaCQ0r1+UYuuvGM2c+udU5Q
X-Google-Smtp-Source: ABdhPJyOCdi13QjBP6bghqocwysl62lW1Z+eeElWlOe0SE/C+t2ICxOM0iBgwk3jG3ttrTGj0txu6Q==
X-Received: by 2002:a17:902:468:b029:d5:ad3c:cf52 with SMTP id 95-20020a1709020468b02900d5ad3ccf52mr21892231ple.7.1606085143479;
        Sun, 22 Nov 2020 14:45:43 -0800 (PST)
Received: from localhost.localdomain ([49.207.209.223])
        by smtp.gmail.com with ESMTPSA id v196sm9856162pfc.34.2020.11.22.14.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 14:45:42 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        syzbot+a79e17c39564bedf0930@syzkaller.appspotmail.com
Subject: [PATCH] misc: vmw_vmci: fix kernel info-leak by initializing dbells in vmci_ctx_get_chkpt_doorbells()
Date:   Mon, 23 Nov 2020 04:15:34 +0530
Message-Id: <20201122224534.333471-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel-infoleak was reported by syzbot, which was caused because
dbells was left uninitialized.
Using kzalloc() instead of kmalloc() fixes this issue.

Reported-by: syzbot+a79e17c39564bedf0930@syzkaller.appspotmail.com
Tested-by: syzbot+a79e17c39564bedf0930@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index 16695366ec92..26ff49fdf0f7 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -743,7 +743,7 @@ static int vmci_ctx_get_chkpt_doorbells(struct vmci_ctx *context,
 			return VMCI_ERROR_MORE_DATA;
 		}
 
-		dbells = kmalloc(data_size, GFP_ATOMIC);
+		dbells = kzalloc(data_size, GFP_ATOMIC);
 		if (!dbells)
 			return VMCI_ERROR_NO_MEM;
 
-- 
2.25.1

