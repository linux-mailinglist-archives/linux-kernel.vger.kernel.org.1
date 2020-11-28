Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3512C714E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391584AbgK1V4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:56:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52857 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387745AbgK1U5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:57:33 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kiwK8-0007lg-OT
        for linux-kernel@vger.kernel.org; Sat, 28 Nov 2020 09:15:20 +0000
Received: by mail-wr1-f71.google.com with SMTP id u8so2696551wrq.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 01:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=L1ZVOdz/CkW3cEUwY2qKMVfD+NLZGHncisYT77s+qT8=;
        b=oVYRQuWltJcTTmumydnIY27G1Jv5lZtBHd+byVayls/ztLJo2MYbz/gRB94lPMskyh
         wVkvGnmYoENThOlwtUWh+rdqeV2xFevaAFFfLzYKHBvHtPF+UTC+BPXHKEYxSG8oLAda
         mn9kmh9nIrK8bIPHkthPEyviXufy0Ljnt20uGU/Hn/Rjalslygqnr8/cj5dLapUxC0xY
         jZ7/MB2OoIiReI7ELCXY9NqtomFHPPECqjbI/xLhx7v27KSVmZWIaZNqfqTo95HzBDta
         kL1aqgOdflH1wHzbeXvhE584xz22/UIxKZ01+9xD77gzp/OkTWRwc8sDMSmQxBXOSpNS
         8Jbw==
X-Gm-Message-State: AOAM530/rAslLfHFhJRKSbCv8reMVzVMr8Rl8D/coY/xj2DGWHxCETgU
        JnidtR+b6lvs81A8lSskFjFUdqS3Fx4w40XbKtMg64VfRSIk7Bs7tQ40tZ2XqrW/Sgj1AiVlWaJ
        648opJIM6zgwz3pj20UUMWdM6Cbe+QnUXl6h9GWa1nw==
X-Received: by 2002:adf:a451:: with SMTP id e17mr15976269wra.99.1606554920349;
        Sat, 28 Nov 2020 01:15:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnKnNbHi8CC875wCyQhrcSim8L++P0BQn8wvxEhd6w3P0570zKFSnlyCCs+yqoJ1SS3sWyYQ==
X-Received: by 2002:adf:a451:: with SMTP id e17mr15976260wra.99.1606554920140;
        Sat, 28 Nov 2020 01:15:20 -0800 (PST)
Received: from localhost (host-79-35-122-236.retail.telecomitalia.it. [79.35.122.236])
        by smtp.gmail.com with ESMTPSA id d16sm20573195wrw.17.2020.11.28.01.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 01:15:19 -0800 (PST)
Date:   Sat, 28 Nov 2020 10:15:17 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: set the right timestamp in the slow path of
 __rb_reserve_next()
Message-ID: <X8IVJcp1gRE+FJCJ@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the slow path of __rb_reserve_next() a nested event(s) can happen
between evaluating the timestamp delta of the current event and updating
write_stamp via local_cmpxchg(); in this case the delta is not valid
anymore and it should be set to 0 (same timestamp as the interrupting
event), since the event that we are currently processing is not the last
event in the buffer.

Link: https://lwn.net/Articles/831207
Fixes: a389d86f7fd0 ("ring-buffer: Have nested events still record running time stamp")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 kernel/trace/ring_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dc83b3fa9fe7..5e30e0cdb6ce 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3287,11 +3287,11 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		ts = rb_time_stamp(cpu_buffer->buffer);
 		barrier();
  /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
-		    info->after < ts) {
+		    info->after < ts &&
+		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
+				    info->after, info->ts)) {
 			/* Nothing came after this event between C and E */
 			info->delta = ts - info->after;
-			(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
-					      info->after, info->ts);
 			info->ts = ts;
 		} else {
 			/*
-- 
2.29.2

