Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DA4274E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgIWBoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgIWBoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:44:15 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B35C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:15 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id h8so4637314ooc.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/GIqnI7mlfppesIjaMfD7yM0AQenEQrRNzXZtVEMHU=;
        b=UcNgW6XBEDSarqd3OMOuWWAXag8YXPD5mpisf+lG7KdwMTbm7KIm7h0Y8yQNT3xfLE
         mY7M0M/5LeLsv+mhDbiJKbR+/CBnPdQo4DBugvD3iHsZ67cF8LvM3+J0FXLWhvS6GQHL
         /GJ29vzx29d7g5nXhNsbqx4Gm3qvv9tzHfOHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/GIqnI7mlfppesIjaMfD7yM0AQenEQrRNzXZtVEMHU=;
        b=bMmYIwGV77yugkRprg60QgJp/LaAMGEr6waSMpTlMewrBibBnWIM5VrmO7zv62Ke6Z
         OpOv3WIznHQCNMThkgf2KlEBm2CI6g/JKUyc+YhIaJrpflYJhlAxR0DgHh2jmcWrF452
         ErC2/CCyfUzq6aweVfz2bQ4ikq9vGAyaTaWcADzagwQLiUKR16Jav5otjndO+g39vdaN
         p7ALrOqqcFr2J019z1jhzYS1FqJRzE3VbjOcyEW8YRawPtpCtcLxGVMtNpK1JsVX5xS2
         RDPW7N1qR3RxDCLY65jC7CLBWq2rx3r4lchwNKWPrKkxxdZlE39B1+BQ0AZr5rM8V8LL
         R+HQ==
X-Gm-Message-State: AOAM530aluFAJkDlbKA/qqi+ldEm/eRuKTfIg+tOlR2/+HDX43X6hkXo
        kiN1SZ9Fa4zZeCRb7AGRmqB4sg==
X-Google-Smtp-Source: ABdhPJxXjC6rWyUS8C2Llv6/HnYjFdtqZ/HADqQskU8n8p5EogKuKvglP6cnix+L7pOqnme/N6+mhQ==
X-Received: by 2002:a4a:c486:: with SMTP id f6mr4924828ooq.21.1600825454819;
        Tue, 22 Sep 2020 18:44:14 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y23sm8801820ooj.34.2020.09.22.18.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:44:14 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/11] drivers/acpi: convert seqno counter_atomic
Date:   Tue, 22 Sep 2020 19:43:34 -0600
Message-Id: <9e2c6cccabc96fe1e5304e2fa2dfdad28ca5ac9c.1600816121.git.skhan@linuxfoundation.org>
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

seqno is a sequence number counter for logging. This counter gets
incremented. Unsure if there is a chance of this overflowing. It
doesn't look like overflowing causes any problems since it is used
to tag the log messages and nothing more.

Convert it to use counter_atomic.

This conversion doesn't change the oveflow wrap around behavior.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/acpi_extlog.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index f138e12b7b82..23b696b7eb14 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -12,6 +12,7 @@
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
 #include <linux/ras.h>
+#include <linux/counters.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
 
@@ -93,7 +94,7 @@ static struct acpi_hest_generic_status *extlog_elog_entry_check(int cpu, int ban
 static void __print_extlog_rcd(const char *pfx,
 			       struct acpi_hest_generic_status *estatus, int cpu)
 {
-	static atomic_t seqno;
+	static struct counter_atomic seqno;
 	unsigned int curr_seqno;
 	char pfx_seq[64];
 
@@ -103,7 +104,7 @@ static void __print_extlog_rcd(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
+	curr_seqno = counter_atomic_inc_return(&seqno);
 	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx, curr_seqno);
 	printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
 	cper_estatus_print(pfx_seq, estatus);
-- 
2.25.1

