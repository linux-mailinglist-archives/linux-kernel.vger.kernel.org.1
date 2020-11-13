Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2C92B22DD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKMRqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKMRqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:46:32 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE442C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:29 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id y17so9217292ilg.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40/cDlcEfTdEejZ/aCiOotkpvr8vR4pXOw6eVWgRoOQ=;
        b=d0H1yPCGdSvJSDF/9DqeQNJCbuDUdks4ZOROuAD9yuKoXHs+YNvDITq/tDKdvD96fK
         p0mlsS2HsPp+HiTx5SuZ8V1V7/HT4OsA6cB9GIIRxpj43P+Ke+QvhVTGCc1J0lVmnXbO
         /PFrDS6mlY3KITbKNLe797ItK2vdpM9ivE3Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40/cDlcEfTdEejZ/aCiOotkpvr8vR4pXOw6eVWgRoOQ=;
        b=n8KLbdBMhgU/lcTlM4ydyx16DKmZsBisjBOFp32Lrn5fKtEAyS0gZpHVPZXmXcrT8f
         5Ub5e2GvTRRJCtGvTO4dpZkRaC0iOv5g4LyhDU+UaNFaU8jzeACh6Yzwvr8v24W0EsoO
         iC1nC09gq3u16Fi5SsGc44cFY/0RG6psne+nBteIUssknXEGoP5dhAo4EsnIDyuK3xmG
         aJuhiZGA7bat+1o6cgRyczmT15RTVSnKkZ4nvmnM51mC0SDnW7vAZlynN74k1je+3gFO
         nljv0TD88l45zJqcNsQqQwfGtBUVZGLlmnSgqWouhZ8I7GaF+ZB1FEzARiZEPLcYC5oI
         VzCA==
X-Gm-Message-State: AOAM532fLQ0p6xa9YYrfU6OPnDhFRaEzRpgs1UdYE4nT/ryGRChVNv2L
        5yGZ7EUjIJF2+BtNSmbi9deWHw==
X-Google-Smtp-Source: ABdhPJztcmfqYzDzMmyF0PYWt0eujkKZtL5AK7mJIw/D96Bi/odpIwaym7pt8HiSN5EI8BU1S/I0vg==
X-Received: by 2002:a92:600e:: with SMTP id u14mr659595ilb.221.1605289586244;
        Fri, 13 Nov 2020 09:46:26 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:25 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] drivers/acpi: convert seqno seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:05 -0700
Message-Id: <b0bed077dd48518f10195844b5bb0ac4374df868.1605287778.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605287778.git.skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

Convert seqno atomic counter to use seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/acpi_extlog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 72f1fb77abcd..5872ff698644 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -12,6 +12,7 @@
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
 #include <linux/ras.h>
+#include <linux/seqnum_ops.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
 
@@ -93,8 +94,7 @@ static struct acpi_hest_generic_status *extlog_elog_entry_check(int cpu, int ban
 static void __print_extlog_rcd(const char *pfx,
 			       struct acpi_hest_generic_status *estatus, int cpu)
 {
-	static atomic_t seqno;
-	unsigned int curr_seqno;
+	static struct seqnum32 seqno;
 	char pfx_seq[64];
 
 	if (!pfx) {
@@ -103,8 +103,8 @@ static void __print_extlog_rcd(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
-	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx, curr_seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx,
+		 seqnum32_inc_return(&seqno));
 	printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
 	cper_estatus_print(pfx_seq, estatus);
 }
-- 
2.27.0

