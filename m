Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9257F279503
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgIYXrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgIYXrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:40 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE142C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:40 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s66so3951211otb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TH11kEvm9iFU4edsTXh7gIDGSk88lSWe2otA52wUs9w=;
        b=UNNLjr39gbouxZCpSiFmcY9V1u0ktwIu7LfYV86klf1keKuS9PkQjb6Vl4/wm2tfsB
         G+xB4lPkRm3p+eIzjRXwpJ1X3XOUWMEm6GNbDW+NGx47YtNIeYp0awbq6fwQjMjThrtL
         y9b5rXVmtqJJiyUIpLg6dFL3iNVsbuKheOEPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TH11kEvm9iFU4edsTXh7gIDGSk88lSWe2otA52wUs9w=;
        b=eNZZeCiZExCt2aOOMXRxqv/zsMKcqVo0XpFPsk0bOGUg2+dSBWGnISyPm0t954mW1D
         cXDM4d1dqgq/ajF0wm55SAIf21XZ/NoWqLVuxRnPjVG0/ogrQuYgQwVJUwhAjjnhXaxc
         cUevxfZhe1zXAhBjIxFUKIO0KJMt13lOJgimMefD9liwzwpq2vDRhCYvxN3nuJTgfpk0
         d2KIytyHpF4EX+mSbfpqSiXs1cf9u85F023m5R8AF72wG4q5AH/oDcj5dDXG0zyJuqvM
         PElNiYCtRIMvLmSk21d4ozkpFbLS4vPLnUaP1eHTF5sx7ee9/9cUtNFES0Pqz7RWce4U
         99tw==
X-Gm-Message-State: AOAM530t0mFQGiy3d821hedlD6Jzw0ICbJvsLjUPbSCgaYIehQQIqJk6
        7WhfU+sl1BJffOzdFB+caBc4/A==
X-Google-Smtp-Source: ABdhPJz/N5qHYeVtWPNLZSMPG+q+JbGjAeoRPiaG78bk13SSNfuduPKklEESh2O7y0hCpBwnUyersA==
X-Received: by 2002:a05:6830:10ca:: with SMTP id z10mr1960036oto.208.1601077660111;
        Fri, 25 Sep 2020 16:47:40 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:39 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, gregkh@linuxfoundation.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] drivers/acpi/apei: convert seqno counter_atomic32
Date:   Fri, 25 Sep 2020 17:47:20 -0600
Message-Id: <c05e3d040fcaa51e275065f6d6f0b0588fdfebcd.1601073127.git.skhan@linuxfoundation.org>
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

seqno is a sequence number counter for logging. This counter gets
incremented. Unsure if there is a chance of this overflowing. It
doesn't look like overflowing causes any problems since it is used
to tag the log messages and nothing more.

Convert it to use counter_atomic32.

This conversion doesn't change the overflow wrap around behavior.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/apei/ghes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81bf71b10d44..92169436be18 100644
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
+	static struct counter_atomic32 seqno = COUNTER_ATOMIC_INIT(0);
 	unsigned int curr_seqno;
 	char pfx_seq[64];
 
@@ -573,7 +574,7 @@ static void __ghes_print_estatus(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
+	curr_seqno = counter_atomic32_inc_return(&seqno);
 	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
 	printk("%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
 	       pfx_seq, generic->header.source_id);
-- 
2.25.1

