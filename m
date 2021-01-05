Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99C32EB1EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbhAESEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAESEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:04:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C438C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:03:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 91so78887wrj.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ws0vqb3nu8teQwx1qQEsgnpEdt3w8/7o7zh9O8e6AXo=;
        b=EbNAQMf27Cck1oTBODkRfjV6dMLs8dEI6liF5xvEMy0UnI/dF1zkkGT/X0EGT90eDQ
         OKbjzzWKEqJazE19/4dfCurKSM6cJQn0gYeW0bDBCFDn/7WdQuxvChnFbzo8E6Yh+6mO
         X2U1/PJOTCj8EB6J16HyqjGlHcSBSMG26DOplRaeHiNY4QqimEAt7TnWOM2qOIGdGpRG
         TVhpmCjz8fV0UtZAzIlZ1vGa0MjZTgMlJrMooyABqdkQD5w2S1b/GRSFvreHIkq0wSKL
         MvzIJiKF+ahX96bCcqUqOydZGNqX4YKARu+jDG7WEmqC5irBs4ERRadUeZWGCjKzO4s3
         eNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ws0vqb3nu8teQwx1qQEsgnpEdt3w8/7o7zh9O8e6AXo=;
        b=XBLKI36s+wT5oJcAQughbbqSJ1AxXEIoLWEn7KqyofnEZh0azLfMM8OnYg7idqYr9x
         l2847QWEwf6aMvnE8a71i+w/RTJTYEg0NlYNCS/Kdj6l4dNV6te5a5Z4PKtiForeRTqW
         8+ODpOqq4uzC4YpuBxn8Z1oQQiCfjWFUjr0l9w7BbzgH8pwbaSsyyK2Yi0RHLFNfrVNG
         VrXycUie2gTUWdaB2c2Oo+75t017wCb9/0j1X47ssgEM2HDqMXNtLNOhs7haYyp/fKvI
         pYPSKAvYVvH84Szaa41UE4ap40RN7MS3YonCVjUJVU+buyauFAcAGGJPoMGEH29wzglB
         ISoA==
X-Gm-Message-State: AOAM531MsHTAEm5aEeu1nRmlo/sYo7K2KoZFR6FgDuDk61HHj5TqiwiQ
        smkuMRdJRqXYih6F4d4mNrKGZA==
X-Google-Smtp-Source: ABdhPJwOyRgOKRFUNsGt7WGsYJLaPhdCWGnjEn9sleYr/p15BFHvbdPo/S5K4vrhzaNDCLmb8nHxqw==
X-Received: by 2002:adf:80d0:: with SMTP id 74mr775901wrl.110.1609869798055;
        Tue, 05 Jan 2021 10:03:18 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:4957:71a5:7b5c:c94f])
        by smtp.gmail.com with ESMTPSA id s20sm274550wmj.46.2021.01.05.10.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:03:16 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH] arm64: Remove unused variable in arch_show_interrupts
Date:   Tue,  5 Jan 2021 18:03:14 +0000
Message-Id: <20210105180314.64613-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5089bc51f81f ("arm64/smp: Use irq_desc_kstat_cpu() in
arch_show_interrupts()") removed the only user of variable `irq`.
Remove the unused variable.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6bc3a3698c3d..376343d6f13a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -807,7 +807,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	unsigned int cpu, i;
 
 	for (i = 0; i < NR_IPI; i++) {
-		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-- 
2.29.2.729.g45daf8777d-goog

