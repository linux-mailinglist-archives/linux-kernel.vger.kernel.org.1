Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976942BA0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 04:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgKTC6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKTC6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:58:14 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA02C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 18:58:12 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m9so6070856pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 18:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q42fM4ZSIDgOH+Mf6O95q9fJDIQslntwrCj9m7v0fAM=;
        b=il5a5qT5GhoI0zFTEmAdt7mgc5YhNELB5BUm/X+UnY3o0UulHn4iKnyFczSPmjxf5w
         f9mzQ0P3hRqZ2d/F+tD/aZxtJuWZhq7I0o+gOshc1ytAgqvyxiOiJvgEjkgl3cYMQqYd
         K6OUC+JCKftMOdrOtnhSvN59U02NuUhLkJIzxzbihHcCLF50yfwFsZUXqSViTEc8KW1F
         omeOUC0d724X6twEaZ9cXN6NnH3UAvec3ERcd2K1nKR7ISUobXY2LRD4h/95Jh+vanJK
         qnDFR4Y4L1oM8cyBHFENGmiGQBrIoEhMBjZFOStJWQWyGPCH8v7M+P+7P01aZRjr+ZuB
         jyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q42fM4ZSIDgOH+Mf6O95q9fJDIQslntwrCj9m7v0fAM=;
        b=gm4NEtbRQvHk1zmV4IjU8TQywuDapq4ORYqGV6AzR+LCTtqt2GMa3yRwyFqF7YghTR
         euG6epfmPJUJu+0K20voGRJJyya3Hke92Ee7ah0mosJH7i28cCXHNf+sx87IXfDWrnYz
         WLbSIruqvjivcC/mXBfg8T3ZhSUaKUYkAg/sKPxifBSj//zmb9BOax9aeGrAYbh3HrYI
         VdPA0ZXtW1Ool2eSB1HlvRiSPQu9voSQ0zwtzEYhh50G84kHgnpTfdR6FvtApDSCudsH
         qhPHNjNMjYAwCSQw6ySrnrjS3VQbfRFShL/LmO9Yhk2rTk/JpMg+PbhKKQDeg/0KP0Of
         iQWg==
X-Gm-Message-State: AOAM531rX4Z+Mn+Gh/dqIzz4W6kxJT9YrjuyRiCKHUbOA0wM1+0vG8KA
        8qd4cAbV+B7x7nHwrKWKgbM=
X-Google-Smtp-Source: ABdhPJzlFdgiY8nhDpctzfQWziRzH+2sGa8JchrR0FDb3F6LH1TeRaqva7hULV5KCaWQo/Hs0U9KMw==
X-Received: by 2002:a62:5c87:0:b029:197:5f13:b66c with SMTP id q129-20020a625c870000b02901975f13b66cmr11843999pfb.73.1605841092254;
        Thu, 19 Nov 2020 18:58:12 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
        by smtp.gmail.com with ESMTPSA id i130sm1181212pgc.7.2020.11.19.18.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 18:58:11 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kernel/cpu: add arch override for clear_tasks_mm_cpumask() mm handling
Date:   Fri, 20 Nov 2020 12:57:56 +1000
Message-Id: <20201120025757.325930-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201120025757.325930-1-npiggin@gmail.com>
References: <20201120025757.325930-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc keeps a counter in the mm which counts bits set in mm_cpumask as
well as other things. This means it can't use generic code to clear bits
out of the mask and doesn't adjust the arch specific counter.

Add an arch override allowing powerpc to use clear_tasks_mm_cpumask().

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17..2b8d7a5db383 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -815,6 +815,10 @@ void __init cpuhp_threads_init(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+#ifndef arch_clear_mm_cpumask_cpu
+#define arch_clear_mm_cpumask_cpu(cpu, mm) cpumask_clear_cpu(cpu, mm_cpumask(mm))
+#endif
+
 /**
  * clear_tasks_mm_cpumask - Safely clear tasks' mm_cpumask for a CPU
  * @cpu: a CPU id
@@ -850,7 +854,7 @@ void clear_tasks_mm_cpumask(int cpu)
 		t = find_lock_task_mm(p);
 		if (!t)
 			continue;
-		cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
+		arch_clear_mm_cpumask_cpu(cpu, t->mm);
 		task_unlock(t);
 	}
 	rcu_read_unlock();
-- 
2.23.0

