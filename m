Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685632AE040
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgKJTym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbgKJTyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:36 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A47C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:35 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id p7so15573507ioo.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esDDSNtZdnFGI5HWUHahR5JpDdcEoj2VttF5Zb1WYqw=;
        b=GdU4lZxE6ToHgmw2Kw9CdAWygce76hmaZ8iu0DAA7AR/NZmId9M17NZvuITkTeUEnQ
         JBoGn6VwsHrHqr10PUX/v+uI9RqSKRPhFMiol9zE9zUf3mRDi8lXfAaw/1t8smiVF5Rq
         JRu944yseuS1qwmIJTwzW1pj3x8zEy6idw4CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esDDSNtZdnFGI5HWUHahR5JpDdcEoj2VttF5Zb1WYqw=;
        b=rRy0E5ZQhKF1s+su8omtBbfy7ny1ZS7non9xqkfYaaY8d6JJwKof2ij2RSUGoAL1Vi
         hJWyV97133D8peSo3V9w+AorktFuyXt2RpMF7VGYZMg92JNkfFEeJWFiMmucbp9YkptV
         g7qDwRfP4itNNQYD6HIR9tQlDQ3ux7i50UdvIz81rrUEV9ZnV9+nMMloikb12m7GDdgP
         CxlCR4j4uuGJMRLWZpDptJGAnxqJs/iTN2YcKn74d3ozE9JAlN3oJdP+5pupNRPHzrZI
         9s1UQY3i8bVTCJZmW+4xxiL84+LBiBhg2wrvJf+B4Vcs+CDYA6A2BK+RioKqRq3MVPN+
         XTBg==
X-Gm-Message-State: AOAM532S/EyfIRLEVtc/Lu1CY4CBwIQM5/P4oPZEUVhpkAUw/Ud5fo7i
        aqn80Hxyb1AJCnt1pUQ7duSESg==
X-Google-Smtp-Source: ABdhPJzuYyywnCo/b0N6UqgvVuEYVaStg93IgkbevFUlW/T43CvZLOmhAwVaj+Z9Q56nZFtywEsXPQ==
X-Received: by 2002:a05:6638:d7:: with SMTP id w23mr17329200jao.131.1605038075352;
        Tue, 10 Nov 2020 11:54:35 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:34 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] drivers/acpi: convert seqno seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:29 -0700
Message-Id: <c37986b8b0c9f3ba777dd983329cd727d6e97202.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seqnum_ops api is introduced to be used when a variable is used as
a sequence/stat counter and doesn't guard object lifetimes. This
clearly differentiates atomic_t usages that guard object lifetimes.

seqnum32 variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

seqno is a sequence number counter for logging. This counter gets
incremented. Unsure if there is a chance of this overflowing. It
doesn't look like overflowing causes any problems since it is used
to tag the log messages and nothing more. This conversion doesn't
change the overflow wrap around behavior.

Convert it to use seqnum_ops. This conversion replaces inc_return()
with _inc() followed by _read().

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/acpi_extlog.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 72f1fb77abcd..1e2b36aab9aa 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -12,6 +12,7 @@
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
 #include <linux/ras.h>
+#include <linux/seqnum_ops.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
 
@@ -93,7 +94,7 @@ static struct acpi_hest_generic_status *extlog_elog_entry_check(int cpu, int ban
 static void __print_extlog_rcd(const char *pfx,
 			       struct acpi_hest_generic_status *estatus, int cpu)
 {
-	static atomic_t seqno;
+	static struct seqnum32 seqno;
 	unsigned int curr_seqno;
 	char pfx_seq[64];
 
@@ -103,7 +104,8 @@ static void __print_extlog_rcd(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
+	seqnum32_inc(&seqno);
+	curr_seqno = seqnum32_read(&seqno);
 	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx, curr_seqno);
 	printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
 	cper_estatus_print(pfx_seq, estatus);
-- 
2.27.0

