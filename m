Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D52A8C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbgKFBu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732772AbgKFBu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:50:57 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4F5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:50:56 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i26so2711659pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bj6mkx33Lq/FHGsQAOAgb5U1Gocj2AWp9p/LUe5BWp8=;
        b=dJSDIAQ4jjGcjcwaGzD4ZlAgYa8IwO3UwpSqFuY5q1tqQ8YRaMwCROu6Z1Fi/kSKWZ
         kh5MDjJCfnikopT+pSVxRZ3lKpXCRX2qct8rM7z28kMJQjReAIjgBQTyT3QqiLZhD/XS
         m3jDBk611UGuEwdMjMTbPRB4DrujBFJp1reelkTeOSqLS0l0aFYuFBAZgRhYWjhVO7/x
         GPD9q6yOyriLPW70UHANSIxeF2KNx7HFXcRrNfGBKZZCX7GjjElp3zk4ZRGW9zr6hiLw
         3EzeuWvXWtCB1szarGWa2rtkTqoXroG2SymZzt4DooAVwIGgH05sm5cR2WLt1WGLmdeI
         hZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bj6mkx33Lq/FHGsQAOAgb5U1Gocj2AWp9p/LUe5BWp8=;
        b=Lot0tfO5BJuNBGIUqFwkcz3cgJsBy4kvbclyD6BeE2zJqGA2alzp7NEHlJkub+absk
         bfuWBpeLRk7G3uXx6oR9ahr42JtriFy4fApcsiqEczR9FE8S9wlPRolPjVdHtGmSACKR
         eetnmWNOZFlcwl4i5xOEndt7FK91Re2KxiryvIeiPgY17oqgZ1+Ke7dqxBalX/j11Msr
         CbiVX87VRdXdc+7wD4BP4ERqmbt1rdXLPwWgy5u1H4PwnteXUU7R/AecESiZX3xJ44E3
         qclv3svjLFXmW2IWVAh6b/AoZ9gSB6Jtq+hmv6vcr5FkIuFjJZ+Xn3BkdWN2WQ8BmEid
         /78g==
X-Gm-Message-State: AOAM532DZP7/KRXPJckbJ5zDCV9DOMDiiK9X8sgofAP8jFWi7V42iCP1
        6xZ5SVrDkB9xYuwO5Vm0hNmEGeZ0w/as0g==
X-Google-Smtp-Source: ABdhPJxFllSk+4bISm4qJozdEm6dyBslXlrnbGUbz/i9CXI3UfQKVNdIX6iL6/tDtNeNJMYIYT7Epg==
X-Received: by 2002:a62:5e06:0:b029:164:a9ca:b07e with SMTP id s6-20020a625e060000b0290164a9cab07emr4710392pfb.36.1604627456277;
        Thu, 05 Nov 2020 17:50:56 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id v3sm3357050pju.38.2020.11.05.17.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 17:50:55 -0800 (PST)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Santosh Sivaraj <santosh@fossix.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2] kernel/watchdog: Fix watchdog_allowed_mask not used warning
Date:   Fri,  6 Nov 2020 07:20:25 +0530
Message-Id: <20201106015025.1281561-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define watchdog_allowed_mask only when SOFTLOCKUP_DETECTOR is enabled.

Fixes: 7feeb9cd4f5b ("watchdog/sysctl: Clean up sysctl variable name space")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
v2:
Added Petr's reviewed-by from [1] and add fixes tag as suggested by Christophe.

[1]: https://lkml.org/lkml/2020/8/20/1030

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

