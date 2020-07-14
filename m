Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6830421F56F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgGNOvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgGNOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:51:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C37C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:50:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so22195604wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pwz2ffWzBJ40s4OQQcEx95BGb6IW3I0JlI9ImusOaw=;
        b=YaPkEvwkRMrXCrAr3GD3Lq5esr1zvrFowgkVtFLyXE9aeQ+n6qHPlhaUhK4AYO4xUs
         hm5M2HAtd3m5JHJjY2xKUYjnMD1tdtfs5OPz2xXGUBp2zizzY0ZWTKvQ9U0A5cXFSIRJ
         j3yMdMtUprKvhoEl35KqZAv8e37m9RfHJ9JDTy287GDX+MDLsV7UmkJ7LDgRcd0qsysv
         Ia93V3kAPH4VDyioq5fO47gOCGnLqoR2QLu1mPSgJAUAUCITRKMczfB1Ec4oXyA2jWHx
         PQLY4by7vk9xQhpkcw3oZfR/uB2heai2vAqu8clRrz2QEmp5oM3aCK3aViE9BDI4b5mz
         3u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pwz2ffWzBJ40s4OQQcEx95BGb6IW3I0JlI9ImusOaw=;
        b=GxBwKVwoEKGwFb7QvepOmfYrd5khbAih7Xx9JJ9dSxnpvby2V4IWSnwKlYjYZyBa4p
         V8KdZJtjJWnupGnBNkcWLQMSKTDAyTrHQflcBBc+/LJuHlUfhF17CJiXdV2R/Et8YR3T
         oPIbGQv6089k6iKzmbAOJlU6v0si7KNq+2gitVrsBI87HnwjS6CW56R7KLUOa30WTdqp
         j+mFk4AgxtS+ksgDwc9kRSw0cpyOiaGtxsZ8Zd/iobt14+3SEoCE2WhE96DWKl4qmoTQ
         slgbxiIm/ZwaBhlE5MPYPjUjeuEO+g7kpkoLzCxuEOIOmUpE/i2ljTvV096ikygAQu3f
         hLyg==
X-Gm-Message-State: AOAM533j1I8lDUcMAN+m4+Zjjjyc9ayc053lLKrMVTRgOxm7sQfgMywB
        FPo/l5oesG3ypSV5rKNpddi3eA==
X-Google-Smtp-Source: ABdhPJxR1XkWPEdO/OToyZfeyPk6VSF/2G2O+HfpfRXS3rTqGgoQ4md522X2INCeZPPwNAHNuFWGZw==
X-Received: by 2002:a5d:650e:: with SMTP id x14mr6401946wru.187.1594738258660;
        Tue, 14 Jul 2020 07:50:58 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:50:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/13] cpufreq: powernv-cpufreq: Functions only used in call-backs should be static
Date:   Tue, 14 Jul 2020 15:50:42 +0100
Message-Id: <20200714145049.2496163-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/powernv-cpufreq.c:669:6: warning: no previous prototype for ‘gpstate_timer_handler’ [-Wmissing-prototypes]
 drivers/cpufreq/powernv-cpufreq.c:902:6: warning: no previous prototype for ‘powernv_cpufreq_work_fn’ [-Wmissing-prototypes]

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 8646eb197cd96..068cc53abe320 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
  * according quadratic equation. Queues a new timer if it is still not equal
  * to local pstate
  */
-void gpstate_timer_handler(struct timer_list *t)
+static void gpstate_timer_handler(struct timer_list *t)
 {
 	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
 	struct cpufreq_policy *policy = gpstates->policy;
@@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
-void powernv_cpufreq_work_fn(struct work_struct *work)
+static void powernv_cpufreq_work_fn(struct work_struct *work)
 {
 	struct chip *chip = container_of(work, struct chip, throttle);
 	struct cpufreq_policy *policy;
-- 
2.25.1

