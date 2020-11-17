Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C412B595B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 06:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgKQFhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 00:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgKQFhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 00:37:20 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06FC0613CF;
        Mon, 16 Nov 2020 21:37:18 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id cq7so21143247edb.4;
        Mon, 16 Nov 2020 21:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=973CLQ4hKIcVvVlggyyxVG1OJphs1HYbDwdKvdbnPvA=;
        b=l258iBmDO9qjwSlmMlbf0nPSfvCDYRRzX1PT3RDD8Bs6vWSgpLfDEJFTpTulQwxV1S
         GWQ1RvyUp7mw3FtO1/2dHV4+Ha57XNHsXvH51YVTzLEXz2ZwOO3lSS0EOU5DS64tSV1R
         /gwrfByfh6heBElvGCJh+daNUUJkprRfeMFa2CSyXUZICh+lP/BcyPmnnurEI2Q6oSjk
         gwMAwSPFFL9g0vuAmTRMYfVNqInFnfKm1bQU+kpqswOarcxHSHZ0ghOjPWCaJvFahxc5
         i2cx/I5aA+eZJE3wJ/xuCDZoZcX6uUxVHA+RWbeEezulG7yq72yNAPvoENswlt1MNyUW
         nBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=973CLQ4hKIcVvVlggyyxVG1OJphs1HYbDwdKvdbnPvA=;
        b=R2YkUx0zOwV9qcmXVTN+u4mJVpA+sXC1yArQbKgrQ9zvOGjidNz5AZQgHQlLQnAWd7
         GM8Ugu4OuTXL16MVXdEbf4/xkHXbCKLytVRLziWzGp77f89OBhnZ+YdXsjDe2s8dyfwk
         gPdKSUwntFZjTgN+MM4d+Rl7UYuMWHDTWHV6rHgJOp4aFlAdK5fOwmXcM6ehCq75gYWF
         DEGHXPGMo9ouWvQwpyJy1uOZNtQkb9AQxJCh4UFSdgFaqg4l27+1zbKX5rCE1D1vI4ZK
         Ja930AIA1fkcn99HjdTiaWSp7tXfqZkG5SJbo3rNStssmVAmksm6JaU4bzBlowDMukjv
         s4Og==
X-Gm-Message-State: AOAM5335MiF+/79hNmlFw1MUmC5mkX6ilPKJhjBemzwhc3aTiy9fZODZ
        l+dnWbAp7kwcki12stOKZHQ=
X-Google-Smtp-Source: ABdhPJwSVFZNL3rz4YIZhQ8jy1dy04EVa+HFRuoOKr3l2g/WTIJLw/BujBGgABoq84njxrMnkKg+hA==
X-Received: by 2002:aa7:d3c3:: with SMTP id o3mr19793635edr.319.1605591437341;
        Mon, 16 Nov 2020 21:37:17 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d78:5700:47c:2ce2:8782:8bbe])
        by smtp.gmail.com with ESMTPSA id f24sm11565635edx.90.2020.11.16.21.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 21:37:16 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ring-buffer: remove obsolete rb_event_is_commit()
Date:   Tue, 17 Nov 2020 06:37:03 +0100
Message-Id: <20201117053703.11275-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a389d86f7fd0 ("ring-buffer: Have nested events still record running
time stamp") removed the only uses of rb_event_is_commit() in
rb_update_event() and rb_update_write_stamp().

Hence, since then, make CC=clang W=1 warns:

  kernel/trace/ring_buffer.c:2763:1:
    warning: unused function 'rb_event_is_commit' [-Wunused-function]

Remove this obsolete function.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201116

Steven, please pick this minor non-urgent clean-up patch.

 kernel/trace/ring_buffer.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ab68f28b8f4b..799d790ab365 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2629,9 +2629,6 @@ rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
 	return skip_time_extend(event);
 }
 
-static inline bool rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
-				     struct ring_buffer_event *event);
-
 #ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 static inline bool sched_clock_stable(void)
 {
@@ -2759,20 +2756,6 @@ static unsigned rb_calculate_event_length(unsigned length)
 	return length;
 }
 
-static __always_inline bool
-rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
-		   struct ring_buffer_event *event)
-{
-	unsigned long addr = (unsigned long)event;
-	unsigned long index;
-
-	index = rb_event_index(event);
-	addr &= PAGE_MASK;
-
-	return cpu_buffer->commit_page->page == (void *)addr &&
-		rb_commit_index(cpu_buffer) == index;
-}
-
 static u64 rb_time_delta(struct ring_buffer_event *event)
 {
 	switch (event->type_len) {
-- 
2.17.1

