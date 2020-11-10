Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5FF2AD810
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbgKJNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:53:28 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C504BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:53:26 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m17so6572640qvg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HVbq6NPlJzIOUbEGDX3ZF6qnq7VBRGwp+e76lTdscsU=;
        b=DUJbPjRAjovkdHD6ThomANkCAK7ZZQ2u6Fo8LeXwtDmilCOYXqj54JeRjRCs+KsnrH
         0zFqj2cnA4eWrJbIm53srtIYPZH347mSVSZGW/4xKblX9MLrJoLTRweJ/Yqe9UGGbfv3
         Bh2azZcDM80dtBeeB9F6G5qgldG3UK1R2Hd3IObypqYaGbV4WQAA1+TIxM3TwpnQ44SX
         pPYKj9Zat0WMbYTL2oj/CkMOqD+ddZVos+MJ0Jx2fNE5lcxYiKZu2BEjCj36b261kGwZ
         iSd6cGfSPJpyrXFlWquKJmUcparCI+eXF0A3pxVHxJFluNPTTvtN9dgdUbUnIVYkzold
         8PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HVbq6NPlJzIOUbEGDX3ZF6qnq7VBRGwp+e76lTdscsU=;
        b=OfagNS74M2fLCiTptnJGjxb45XZZNDlbeUaZPghvtyrGFGSh0q7MyVk9a7dvlSxS7F
         GIIBM0tWhyfotiQC+zddpgfHFk7Uqc2APe7T5oKXIiWlsd0+b8AxXaNgWX3D4zCJSePG
         4VWcChn+AoT7Lc7LrsTBd4Fh9lKz1u+H6DQ952F5lfCPnBFWFxfMG0qmsQVA9L6KAtxQ
         KwFt4Jf+8TrzimAMB2jFN2z06upk4KoubW0TETRfQLrIlg+A8UAdTFM+HPWR4MchAlIh
         OmycibmXGdg+KaUcas1K9cPk8+ufeJDbajJ3g1GDI4n8ytClYolLer8cL3ucgxJ3/WDi
         iVoA==
X-Gm-Message-State: AOAM5311fG/dmwuduGzUeJLFMwJfVgYhBrHS8D/PANxhIZuflbV2OmMG
        /HKGunV6/eVvK3hB6kIL4eytu09dAQ==
X-Google-Smtp-Source: ABdhPJxngRBwrANr83qdaq0tL4gdsguRoCVoeHVqd7EocjSsbDLXyXPYCuolOIfM1+G1PNrv/qQdOwtg1w==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a05:6214:174f:: with SMTP id
 dc15mr18927895qvb.26.1605016405908; Tue, 10 Nov 2020 05:53:25 -0800 (PST)
Date:   Tue, 10 Nov 2020 14:53:20 +0100
Message-Id: <20201110135320.3309507-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] kfence: Avoid stalling work queue task without allocations
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To toggle the allocation gates, we set up a delayed work that calls
toggle_allocation_gate(). Here we use wait_event() to await an
allocation and subsequently disable the static branch again. However, if
the kernel has stopped doing allocations entirely, we'd wait
indefinitely, and stall the worker task. This may also result in the
appropriate warnings if CONFIG_DETECT_HUNG_TASK=y.

Therefore, introduce a 1 second timeout and use wait_event_timeout(). If
the timeout is reached, the static branch is disabled and a new delayed
work is scheduled to try setting up an allocation at a later time.

Note that, this scenario is very unlikely during normal workloads once
the kernel has booted and user space tasks are running. It can, however,
happen during early boot after KFENCE has been enabled, when e.g.
running tests that do not result in any allocations.

Link: https://lkml.kernel.org/r/CADYN=9J0DQhizAGB0-jz4HOBBh+05kMBXb4c0cXMS7Qi5NAJiw@mail.gmail.com
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 9358f42a9a9e..933b197b8634 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -592,7 +592,11 @@ static void toggle_allocation_gate(struct work_struct *work)
 	/* Enable static key, and await allocation to happen. */
 	atomic_set(&allocation_gate, 0);
 	static_branch_enable(&kfence_allocation_key);
-	wait_event(allocation_wait, atomic_read(&allocation_gate) != 0);
+	/*
+	 * Await an allocation. Timeout after 1 second, in case the kernel stops
+	 * doing allocations, to avoid stalling this worker task for too long.
+	 */
+	wait_event_timeout(allocation_wait, atomic_read(&allocation_gate) != 0, HZ);
 
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
-- 
2.29.2.222.g5d2a92d10f8-goog

