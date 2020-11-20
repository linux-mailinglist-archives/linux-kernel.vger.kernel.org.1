Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123592BA0AD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 04:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgKTC6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTC6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:58:06 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF12C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 18:58:06 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i13so6051621pgm.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 18:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEquB2e4ILjHkuvoO1HDaYbpd0GtS6EX4u7NzQ82bGM=;
        b=qwaRz9PzkgumlOLi6+U/YB2GvWe8NTcbyeFyYcl1tx+ZCOb8wx26LgiYUsITReXuI5
         AKdC25sqEkLSn+pn+ghWdehXOkTQzQKLKN8rU+9phrz8+lyLEw5IcqeXrlXq8Un1W9mk
         x6rut2m2uUY2JeDfr+//mz/yfN0VEFWhr3I4oJ+F2rgfdRMMuI4+6rOWQBWk9D4O/P1G
         JYha8RQW+gTPv0mpu8zkUYkfHXAr28zd+HqvrKGKECEH2hvZnprIt6Ydih80X8M0+JvE
         nWRg4rUMzDMKqVBPHm4bl5kQDyHa8KAblvxxlj2T44hiCkSiZnezGB6VV0xdTSxIoZQA
         yRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEquB2e4ILjHkuvoO1HDaYbpd0GtS6EX4u7NzQ82bGM=;
        b=ik/G7LVH+djXLI27D80LjpjoMKjvavqdZLb3Gxuh2Lj8Y/0o0nfK/yxSNL0Ik1n6Q5
         sQEhakfpctfvgOP13Fed+pE4d1NMM+ohD9nq3+DN7hKa13cSf+0058sPkhbnCZIRXrAF
         ZqU1dviXs2pcpKA3KBeIQEtSO+vPpv3s+1uNtOTWH5v/RlEpfFB34FHyJubPwY9Jgpn0
         6nNpWx0OYe4xM5vdUVySLMXvLfLue6c3m2M8YVMdOVc3KqmkEC3PTmtPjjUiRgelgBJz
         Qb4l8N+E6tcWv55jFQ+QyDNwwU1nKoGa8e4ROwo3b0DNJeBSjHCS2rgBPBBtdbIuthBR
         xVXA==
X-Gm-Message-State: AOAM531080IiQAfoM8IUI43QaUoZfcxnmrTkPI69BiktNRODTJcEyHjZ
        ul3yqa53ioqyVNiyzlSSERk=
X-Google-Smtp-Source: ABdhPJzV6Iqey8/uSJdBfUMohg+eIQvpY6Ifki/IcYVuYzXRJbV3GpliRlXIFEnM/YSdiNCpW4kZSw==
X-Received: by 2002:a63:4956:: with SMTP id y22mr15351360pgk.266.1605841085625;
        Thu, 19 Nov 2020 18:58:05 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
        by smtp.gmail.com with ESMTPSA id i130sm1181212pgc.7.2020.11.19.18.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 18:58:05 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] powerpc/64s: fix for CPU hotplug vs mm_cpumask bug
Date:   Fri, 20 Nov 2020 12:57:55 +1000
Message-Id: <20201120025757.325930-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a race in powerpc mm_cpumask code, I hope the core kernel
patch looks okay and we could take it through the powerpc tree with
an ack from someone (Peter or Thomas, perhaps?)

Thanks,
Nick

Nicholas Piggin (2):
  kernel/cpu: add arch override for clear_tasks_mm_cpumask() mm handling
  powerpc/64s: Trim offlined CPUs from mm_cpumasks

 arch/powerpc/include/asm/book3s/64/mmu.h     | 12 ++++++++++++
 arch/powerpc/mm/book3s64/mmu_context.c       | 20 ++++++++++++++++++++
 arch/powerpc/platforms/powermac/smp.c        |  2 ++
 arch/powerpc/platforms/powernv/smp.c         |  3 +++
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  3 +++
 kernel/cpu.c                                 |  6 +++++-
 6 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.23.0

