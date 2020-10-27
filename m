Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A96529A365
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505139AbgJ0DjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:39:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45718 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441368AbgJ0DjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:39:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id 15so536456pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=LupE/J6VcTBMhjtEQjjbSyPrr1jGLP4woAI8/ZP2Aio=;
        b=0tF30+v9LcH8Hf77Y82B52LfDGR/JCo9+LQaJ2XQEcC5z9oGYZaGdRsMg88Fu2R7js
         l4kXUDyXXOPuLxzF58zzNC4rcw7dYZYzjAUJPlzEH9mXzfjKAg4tG0K8UPxH7Aea5DEB
         GhpCkIlzf51VHFnzbXru16SdLR3L8hOIDC+JCvIj8hxes0e/BS1xeHD3f2rYDX8cba8i
         6kHPAspZ7gxmk7i0a4DoZGb+NBTc22KbU664QWA+K+ZRJ+xgot4TW2vYOhOylXd7JpXy
         iWMUV3Y6GYgIFwtwWADbgvikXhrnKAdodIyjbyZwc3O2zYIsM1wwnkD0/UHTPdR/K46u
         T9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=LupE/J6VcTBMhjtEQjjbSyPrr1jGLP4woAI8/ZP2Aio=;
        b=jTtldHsnlIDHf/KeZzuzEW3LtQ4rtpagWM4nEGQmu0etEUK3vFMB3xsf9s1o4tRbzs
         lG29LQju/GdVREOeyxHaLztp7mZAQTtbVCBz2S8SMrnDJIT/y5XQQo2+1ZhOKzpeVVeu
         2W5c0SqYoBWqMM5CJ8LZ6u+GeS/zf9UKgMl7m5yyP3dGXlkah70DwdDwv+Dd7VGFP7VP
         gs8+s89leJyj9nWuetAJ1qrsd2sB812eP8W2aMz1P6xu3mEE0RVcn4UsYJorwJzDxv4F
         +a+eIVPLKtbPACgpxpjuLuvNVCiFDJYuYTkabQ+aViGX21LP5o+CyzzM2+XCdCcAUHhE
         XYpA==
X-Gm-Message-State: AOAM532/8ZZnuirAtncUf9/g1Cr6s9BLNoErNn3eGaQTqPHC4NtIJfJj
        s5hRh8zO4ggN8zrxw359jdfqcA==
X-Google-Smtp-Source: ABdhPJxL2BTEjdugLbB8On3VBB10WG4v5IQYYWc1EtgUICfi+uK5W/KXh8U7yp8AusiQBMUHsg2Z0Q==
X-Received: by 2002:aa7:9a1b:0:b029:163:edfa:64a2 with SMTP id w27-20020aa79a1b0000b0290163edfa64a2mr418342pfj.70.1603769954732;
        Mon, 26 Oct 2020 20:39:14 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id k10sm187689pji.54.2020.10.26.20.39.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 20:39:14 -0700 (PDT)
Message-ID: <f3ec374cada762149911ff35e92a68a15a7d0327.camel@areca.com.tw>
Subject: [PATCH v2 2/2] scsi: arcmsr: Confirm getting a free ccb is in
 spin_lock circle
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Oct 2020 11:39:13 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

Confirm getting a free ccb is in spin_lock circle.

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 7cfae1d..127fe50 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -3162,10 +3162,12 @@ message_out:
 
 static struct CommandControlBlock *arcmsr_get_freeccb(struct AdapterControlBlock *acb)
 {
-	struct list_head *head = &acb->ccb_free_list;
+	struct list_head *head;
 	struct CommandControlBlock *ccb = NULL;
 	unsigned long flags;
+
 	spin_lock_irqsave(&acb->ccblist_lock, flags);
+	head = &acb->ccb_free_list;
 	if (!list_empty(head)) {
 		ccb = list_entry(head->next, struct CommandControlBlock, list);
 		list_del_init(&ccb->list);

