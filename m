Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF392A4056
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgKCJc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgKCJcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:32:53 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B23C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:32:53 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id x13so13674251pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXPiKnajprsVmoagr8lc4F80WvhfqnnWb0E5r9CyaTA=;
        b=T5pOlxf8VV1zzfEju8qFL0DQ4EgCEIfPJz8yMuOXt9szWzNyKhE3E7pCm9Z+QU9CmQ
         nFrDtg7EldsI+XtcSwwtrCnMy2PqYorfKH7J31UgniG2rjwnNWjcnLc6uVdBJdxsxsoU
         vE/JNiNwI72jpR/PfnREef8qfnb/YPJj/H4Mhz0hrhMa+s7R3UzhhVoATGKGImB+hfZf
         vJB9T46VmRkQyPI5Dvtxp8xkOVwKj96e1WYcF9kvLK2nU6ol8WdoGfdDU8IHvSXXa7s+
         l+vQ+h0j0cZAxTv6mCAnYz5y+8WayoQQIJ+8zbVpb9CODqZgIxt+fV7VxCv+38oV9fKV
         3JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXPiKnajprsVmoagr8lc4F80WvhfqnnWb0E5r9CyaTA=;
        b=X2Ce0Q0axSHm4HsOMrppN9TFkYDBUEzOj3me3eio3eA8jJfj2iDiKrAG/VAfztYjD7
         /dh6tZqtKxvia6cL7UxQ3ToYm9cmbmioLvwYkllrXCJSSaprgSAUBsRQ2d/8XeOVk5bz
         GK1I12b81MIxIyIole+V/Mwl7ywIv0xUHLN3D4IezRMmIqszEmORFDHjtfx3YNG3JgVR
         1Mv0p/iNfpOslHJgAyIUH6MShOa7wKCkH3CGEeFSzdAZxQCp9K9HceHssFuWrMXvYGLz
         ysgKFA/lShxqgCHid790LK7J3AXaCt3AnvqlUJ+wT7TkmyoVFFfXJxkwARXnETY4KQM2
         Tquw==
X-Gm-Message-State: AOAM530eiIuMl8nYOwfe+nqX8pq8ynA+T9QNGgOrem8cnWqPc6HkAjX+
        S9ZWkjTTul4pTZs63z/5536o6iP5yG3VcA==
X-Google-Smtp-Source: ABdhPJxFlhZATRI9DgOKBEyXjdfT2Eg14GrNTRW8hc1WOeEvBSg28bBtiktlPKw2bfrHQ9h0nZhDOA==
X-Received: by 2002:a65:688b:: with SMTP id e11mr6790464pgt.175.1604395972269;
        Tue, 03 Nov 2020 01:32:52 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id 194sm4441193pfz.142.2020.11.03.01.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 01:32:51 -0800 (PST)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     pmladek@suse.com, bala24@linux.ibm.com,
        Santosh Sivaraj <santosh@fossix.org>
Subject: [RESEND PATCH] kernel/watchdog: Fix watchdog_allowed_mask not used warning
Date:   Tue,  3 Nov 2020 15:02:35 +0530
Message-Id: <20201103093235.655665-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define watchdog_allowed_mask only when SOFTLOCKUP_DETECTOR is enabled.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---

Original patch is here:
https://lore.kernel.org/lkml/20190807014417.9418-1-santosh@fossix.org/

A similar patch was also sent by Balamuruhan and reviewed by Petr.
https://lkml.org/lkml/2020/8/20/1030

 kernel/watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5abb5b22ad13..71109065bd8e 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -44,8 +44,6 @@ int __read_mostly soft_watchdog_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
 static int __read_mostly nmi_watchdog_available;
 
-static struct cpumask watchdog_allowed_mask __read_mostly;
-
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
@@ -162,6 +160,8 @@ static void lockup_detector_update_enable(void)
 int __read_mostly sysctl_softlockup_all_cpu_backtrace;
 #endif
 
+static struct cpumask watchdog_allowed_mask __read_mostly;
+
 /* Global variables, exported for sysctl */
 unsigned int __read_mostly softlockup_panic =
 			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
-- 
2.26.2

