Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7437B1C98E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgEGSKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728305AbgEGSKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:10:33 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650D1C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:10:33 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id v18so7681677qtq.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9OhNNPOR5bOJXqrXgYTR/z4ZLcIw94c7qBlgw12zehM=;
        b=ge96F09XdFsFsB5dYM9NSm1hEwRKTOm6LHBDxv4p756JWp8TiB91WkCmvrH5GpJ7ID
         R1VU3A76KGfuijtfRH6+xrVKU0ddCaeLZF07G8RQYkl68nCxyTdIXIQfY4W8gRGhbCod
         azIuW5jjVQqpdZInIkwMQBSRaUjl5Tu+cNcP1+KoCyvyGrxIzqKulY0Gn7TkwjziZ94Z
         BtRbwdywx5zzFJCVKWdH20zAP5GXCNqJLhSfhYgDYP5/Mm28PlWHVX30Ju4SOsih1iTY
         7kpSk4677XwaHJJbNtMj+FUeOaemVnGoLjxIK5A4BsQxJR1aZ0j9uqW/oOpFjoP7CYkq
         VN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9OhNNPOR5bOJXqrXgYTR/z4ZLcIw94c7qBlgw12zehM=;
        b=Qq0N97IGRHG+M5nM4He30s0BuDThwGnX/ejOSVUyt+ETbNpVocgoFdSmx/O52hah4A
         qqlTpe0GjJ6ZjsIn+L31jy3Zc9SdA92rxf2LMwFQ7DT9t9CwiM+lIZ07EVZMZeAhbHSj
         5N57XQjiDnvG0/iQ8PmgLW33wGeyQLfac4vh5UXBW28uSMwuDegtCDhsuMOlPi0y2+is
         xF9H/xMuugrcTXjYixKZINBzHCxTSiBoK4TWR1iS1tcv9x0CbJ4XlFks5X9ox0TQaToG
         /D3aC7zGaDr8JMp/BziFA/sCTzzOdWDmjko4urkSbv5y4T6cFGKhaQjAhCltgiQax35M
         ECCA==
X-Gm-Message-State: AGi0PuYZcX6TLj7w53iYoBGUfp0/YqY6q2ep3W07wsspNL3QYXNC0y1/
        SJeajanOpc1mjisHAvSJBGQkbvFaFOjn3hoxJw7hGC5rRYiCFX8r7nOT8JndMCjYG8U6/YBk0vf
        7Xyd/M9qHRQ9EZUDMKA8Rm7BS2/usuKiI/jviD5iXpxlK6O81lBK8ecxYHKfwN22LLRJ7Po8q
X-Google-Smtp-Source: APiQypIiwLV5BbE0n5CUQvk0QJA7FNWdGbxWcAUCqDJsE+LSuluk52+DrvUSh3DwGlH7tJ6FU4zi3lidRXSp
X-Received: by 2002:a0c:f50a:: with SMTP id j10mr13910437qvm.172.1588875032506;
 Thu, 07 May 2020 11:10:32 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:06 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-9-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 08/14] sched/core: Export runqueues per-cpu array
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be needed by schedutil once modularized, export it.

Signed-off-by: Quentin Perret <qperret@google.com>
---
This is only needed for cpu_rq() -> cpu_bw_dl() in schedutil, so there is
probably an alternative if exporting this isn't desirable.
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dbaf3f63df22..537eb45b4274 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+EXPORT_SYMBOL_GPL(runqueues);
 
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
 /*
-- 
2.26.2.526.g744177e7f7-goog

