Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE4288D78
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389546AbgJIP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389508AbgJIP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:56:17 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0DC0613DB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 08:56:17 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id o8so9435760otl.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJjgaUZaZ+rzdDuxjp7rbE4oiR+xJP2zpCkQ9BJrqzE=;
        b=QwmxN9RxRycSmgMChWIl0NH0gbcRsP8/Z+tgndphiaJJGvNjywwnqtyxVlWYP54I9r
         Xg5F3NKtm0FVrOT5cn/wn1nU2FqUVm6vmRsXPKm/NeeEqe7mo8GMIHRT+ltEm0wACaN+
         VjY9YrudR9/2aEFnp+OVv2VVkYBPUC/OfBqPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJjgaUZaZ+rzdDuxjp7rbE4oiR+xJP2zpCkQ9BJrqzE=;
        b=oaS2kxBs7rBiBa6JWrlGMxflZMkIaLwWnZmBA4naVduSwfiE7qe/Q7y8ptv4gEMAkJ
         fn5DxIVIT0B7IpLsrmtTptilbRn13q64io54vfBQjXrdMroAfqSzRZyQQbEV0ACP5eDo
         pI2Lm6SOzJVjbZjM7xvnwN87GCpWA7opxoV3E2gA01I8wBiJ16pPXqkSj2RQ4K2Sw/sW
         NBgRv0ccsqvp2m85qB120GT5h6HDyuIh4ZalTqMDky/2c4NGDc+Bk69Nwn+Y8K2RjlK+
         3ANnVs0ncYxENdnTDq7GXrw+avnOVdZ2v1WFoufI9lvTD2t5uovJvS7H796QQyE1bpCk
         cuGg==
X-Gm-Message-State: AOAM530QjBfPBNMX2SivmBAHDIoi8vyZ3q28zfGpg3E/CO9vGjawHzas
        ACBrS00P6Fet5NYRpboQ+WB4nA==
X-Google-Smtp-Source: ABdhPJyn/3sr7V8YTxz6Z14BffXAUtV/l33E+JLfZdnDEuibY2Mv0bJKLgyQkHkbw5G+ZMACKO0jUw==
X-Received: by 2002:a9d:27a1:: with SMTP id c30mr8736898otb.214.1602258976414;
        Fri, 09 Oct 2020 08:56:16 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e7sm7347246oia.9.2020.10.09.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:56:15 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] drivers/acpi: convert seqno counter_atomic32
Date:   Fri,  9 Oct 2020 09:56:00 -0600
Message-Id: <53a101719b89cd0db55885f726a186bc987aba1e.1602209970.git.skhan@linuxfoundation.org>
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
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

seqno is a sequence number counter for logging. This counter gets
incremented. Unsure if there is a chance of this overflowing. It
doesn't look like overflowing causes any problems since it is used
to tag the log messages and nothing more.

Convert it to use counter_atomic32.

This conversion doesn't change the overflow wrap around behavior.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/acpi_extlog.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index f138e12b7b82..d1e733f15cf5 100644
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
+	static struct counter_atomic32 seqno;
 	unsigned int curr_seqno;
 	char pfx_seq[64];
 
@@ -103,7 +104,7 @@ static void __print_extlog_rcd(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
+	curr_seqno = counter_atomic32_inc_return(&seqno);
 	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx, curr_seqno);
 	printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
 	cper_estatus_print(pfx_seq, estatus);
-- 
2.25.1

