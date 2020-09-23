Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1419E274E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgIWBoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgIWBoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:44:18 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA389C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:17 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id r10so4648830oor.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnnwuV3VOuOviE4hRqFlhMMrScbmUrUnYBZ31A2sAus=;
        b=eYGeGfYDB/kbB74Gl3lcqblTdcwd9nYXo1DKO5nlgr1WgrjmSIBoSsOH9+D/3Brz5+
         yLvtLhIN/k9frj/8KlinZQvgL/rnacgAcRI9kFaurTd53lgw6ZBZQl7NA2Rn6MFg5uPN
         2vakWUmbZVLkGkL9sBoPJj1CbB964tDpHb33I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnnwuV3VOuOviE4hRqFlhMMrScbmUrUnYBZ31A2sAus=;
        b=KKxvOXf9142JevUiNfqctiXlYMLobebuU2y8bVeE4EQIfYFXuTAo1YvB6eL2I4shRz
         9SNOqRuDNcM0/+X8KCviGowtRF26FDoqxKoOKAWuwgcfgv/Ury5xmNQADfqZYRywPrQl
         D4ZyiIet59Fx8xTMjseyKCUM7g9YRIrC+erjEb5zvMUTMPgNPkFY0/A0klWH1nZyHT4U
         hcN6s6KD86ixfxReKQ8NTvv1UADru9k+mZ7QPW0/U/odBq2glSdqXFdayrYvK5sljatB
         rLP5aziqUVqpTIJE4KjaL3JECAlve27vTXKVsIfNvRCQQrfAJKuBQRCyOS9FJVAhDCrQ
         I1rQ==
X-Gm-Message-State: AOAM531wEQLVhyLM+jB6paZ7xAAlNSVibSzy2f0hJsGkFLt3KvBMAVXn
        Gf4OGfZV6LabD6l1dOvBcD6hwQ==
X-Google-Smtp-Source: ABdhPJydib0U/+LmDedHvIvhYCgbiu/pl1CAuMUwmfuLEUesHBoF4jaaIPzso0AXi+j4lb9Nog+5uw==
X-Received: by 2002:a4a:e544:: with SMTP id s4mr4955851oot.74.1600825456517;
        Tue, 22 Sep 2020 18:44:16 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y23sm8801820ooj.34.2020.09.22.18.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:44:16 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, gregkh@linuxfoundation.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/11] drivers/acpi/apei: convert seqno counter_atomic
Date:   Tue, 22 Sep 2020 19:43:35 -0600
Message-Id: <11a005f6cc48c6411c0554ed5f40add8928669d2.1600816121.git.skhan@linuxfoundation.org>
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
 drivers/acpi/apei/ghes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81bf71b10d44..88a660f9c22c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -41,6 +41,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/counters.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -562,7 +563,7 @@ static void __ghes_print_estatus(const char *pfx,
 				 const struct acpi_hest_generic *generic,
 				 const struct acpi_hest_generic_status *estatus)
 {
-	static atomic_t seqno;
+	static struct counter_atomic seqno = COUNTER_ATOMIC_INIT(0);
 	unsigned int curr_seqno;
 	char pfx_seq[64];
 
@@ -573,7 +574,7 @@ static void __ghes_print_estatus(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
+	curr_seqno = counter_atomic_inc_return(&seqno);
 	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
 	printk("%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
 	       pfx_seq, generic->header.source_id);
-- 
2.25.1

