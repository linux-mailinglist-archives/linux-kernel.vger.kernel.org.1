Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D111B6B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 04:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgDXCvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 22:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgDXCvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:51:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4785EC09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:51:24 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h1so9061442qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BUrnT0o7BM/uOR7eliOfXC3dlOVulqz3+aexHgIkDZ0=;
        b=b7OEgDr1qEYYjNBahzDjLju7zXhjWczgnSN0CkK3XZJHzJ4xmdWTSPeC/hZ18R977T
         Lbc5bqfikfEI8XwjRveQtX8DzdAnw7Upi0+tEVTjuEOLYe/o9O49nQJ+erWcUNeceK/m
         gxmNaW2J9IgSvVfJ/FnKXCuSljinUbBenwRb7SQcaIns9dg/ZlPnlUI7WaB6TZ0UkFDz
         NRmQGHC5D5sKl7ulirwaU2b4vE/EIeq4gFq+4OaXMKmp9Nu+L9nD8sEAb/DWqOi07Ci/
         L50iAtf+Sou66n4pMLHpZjiCblnYxdkjgxxStMv4ztmiH+u1MSjQj48hCFa/pdAMEAcv
         wEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BUrnT0o7BM/uOR7eliOfXC3dlOVulqz3+aexHgIkDZ0=;
        b=fgR2dua+2Etga+ZqUAnz6BuJYif6ldILc+q9fMWl8sM5NqDqVdCsgjNZS3/9ToY+bk
         Nf3Bl+mOMOQy6R9UoZkGRln8jtaer5r97qzz+Be02VJ7arXvXxa6uWniwMSWaMJkqBgE
         VcD85IYzTtT459XvJRAHuQCYeYZ1H+tZh2PJWwvfMQKP2ig1MxB/We6NbGgXB20amRmo
         wynAcd6gEe0yfodzD7qv4IrZcVuUwSqGEUa40swBpf31U3+jj1EEVZCiOYX+hzCqExtW
         7NddmfatPimcjTceix39HT5ZOnfnY30wHlvEa/lYFmSUHgNygxpBElZ0Y+6eubVP68uZ
         qqWA==
X-Gm-Message-State: AGi0PuYnUIt4mPITPfoLY44Vx9mdM5yJNhmXRDwB5YVnOCu/cSu0aWHZ
        S+1fMkSMwhZXJBhhuw3bIl2M5CSzLe8=
X-Google-Smtp-Source: APiQypKNnHZP1jNtsYonEes5/9lC+WDD3mblgjAsDkvG8pqmBWTvK8V/is4JpaNRANkdM0xD8ogSQnhutl0=
X-Received: by 2002:a37:a351:: with SMTP id m78mr2375272qke.63.1587696683068;
 Thu, 23 Apr 2020 19:51:23 -0700 (PDT)
Date:   Thu, 23 Apr 2020 19:50:57 -0700
Message-Id: <20200424025057.118641-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH] eventpoll: fix missing wakeup for ovflist in ep_poll_callback
From:   Khazhismel Kumykov <khazhy@google.com>
To:     viro@zeniv.linux.org.uk, rpenyaev@suse.de,
        akpm@linux-foundation.org, r@hev.cc
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event that we add to ovflist, before 339ddb53d373 we would be
woken up by ep_scan_ready_list, and did no wakeup in ep_poll_callback.
With that wakeup removed, if we add to ovflist here, we may never wake
up. Rather than adding back the ep_scan_ready_list wakeup - which was
resulting un uncessary wakeups, trigger a wake-up in ep_poll_callback.

We noticed that one of our workloads was missing wakeups starting with
339ddb53d373 and upon manual inspection, this wakeup seemed missing to
me. With this patch added, we no longer see missing wakeups. I haven't
yet tried to make a small reproducer, but the existing kselftests in
filesystem/epoll passed for me with this patch.

Fixes: 339ddb53d373 ("fs/epoll: remove unnecessary wakeups of nested epoll")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/eventpoll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8c596641a72b..40cc89559cf6 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1240,7 +1240,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		if (epi->next == EP_UNACTIVE_PTR &&
 		    chain_epi_lockless(epi))
 			ep_pm_stay_awake_rcu(epi);
-		goto out_unlock;
+		goto out_wakeup_unlock;
 	}
 
 	/* If this file is already in the ready list we exit soon */
@@ -1249,6 +1249,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		ep_pm_stay_awake_rcu(epi);
 	}
 
+out_wakeup_unlock:
 	/*
 	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
 	 * wait list.
-- 
2.26.2.303.gf8c07b1a785-goog

