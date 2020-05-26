Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC01C9ECA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 00:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEGWyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 18:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgEGWyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:54:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49FFC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 15:54:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so3316005pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 15:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X1eOoZGo2RhELWP8ZXLrEQsjy79crnPXYewegVbC2bc=;
        b=WAPAb6AJ5skxQqiGjsj4YLprJto6hJMDsC1OXq2025SYCXQw680iFz8cZQDTQ1DckJ
         EmxNFgDSkka2NqoQTFhhqT/tuSIZd2brTu/CJYiVc8+eMuFmzWsQT+pvUbKme/7dYNq5
         oV1FD3X4i27cGhlx9grXyhUdkRWJpiSoqqf6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X1eOoZGo2RhELWP8ZXLrEQsjy79crnPXYewegVbC2bc=;
        b=BMcvs8Wb6kVEyfZ3A9cz77LSIg8lKNyraK1R6tI2Bng4W01Q93AhI1vLwgWhwnqcZo
         8MZZEtHfjXG/euOagjBmsRYRh/SKTGhxun/JV+MG4gJNMCVaQey+f3KpxHS4UzoMXkj+
         qsDSfxWvAjL6AROEhykpDRqyiXfr5Nk1m15olmRISRgihnBu/9K5cF7UOmK6IvkrmH+x
         sFHk0O7FaGUSUKQmkKDnQHiR7GJ1zg9x3zkpgeMWxI9/ZxCof4lXms5ydsb1rdtjJmwp
         60K/0bH2ZFP8NhksiO6A8Km/bAHL3lTvlAr4Pp8dqWfNywHU2Ar+A9r5uDi75u5RHpLH
         J0mg==
X-Gm-Message-State: AGi0PuYxud6twgHjRxUy+d/VP0vnQ4bj/yurY2r4pDLjrsaIhlDeg617
        avxIzOJ0iOgLMcFZaNLd1lJvew==
X-Google-Smtp-Source: APiQypJKFKpsytswpG/Q3vS6VvEccA4XHAZJIeSSZXlao5nBRjVP6Zd0WcIrMxJfYOyASvW1D28v3w==
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr2525688pjr.182.1588892059212;
        Thu, 07 May 2020 15:54:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id k6sm763768pju.44.2020.05.07.15.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 15:54:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     sumit.garg@linaro.org, Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kgdb: Avoid suspicious RCU usage warning
Date:   Thu,  7 May 2020 15:53:58 -0700
Message-Id: <20200507153444.1.I70e0d4fd46d5ed2aaf0c98a355e8e1b7a5bb7e4e@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At times when I'm using kgdb I see a splat on my console about
suspicious RCU usage.  I managed to come up with a case that could
reproduce this that looked like this:

  WARNING: suspicious RCU usage
  5.7.0-rc4+ #609 Not tainted
  -----------------------------
  kernel/pid.c:395 find_task_by_pid_ns() needs rcu_read_lock() protection!

  other info that might help us debug this:

    rcu_scheduler_active = 2, debug_locks = 1
  3 locks held by swapper/0/1:
   #0: ffffff81b6b8e988 (&dev->mutex){....}-{3:3}, at: __device_attach+0x40/0x13c
   #1: ffffffd01109e9e8 (dbg_master_lock){....}-{2:2}, at: kgdb_cpu_enter+0x20c/0x7ac
   #2: ffffffd01109ea90 (dbg_slave_lock){....}-{2:2}, at: kgdb_cpu_enter+0x3ec/0x7ac

  stack backtrace:
  CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc4+ #609
  Hardware name: Google Cheza (rev3+) (DT)
  Call trace:
   dump_backtrace+0x0/0x1b8
   show_stack+0x1c/0x24
   dump_stack+0xd4/0x134
   lockdep_rcu_suspicious+0xf0/0x100
   find_task_by_pid_ns+0x5c/0x80
   getthread+0x8c/0xb0
   gdb_serial_stub+0x9d4/0xd04
   kgdb_cpu_enter+0x284/0x7ac
   kgdb_handle_exception+0x174/0x20c
   kgdb_brk_fn+0x24/0x30
   call_break_hook+0x6c/0x7c
   brk_handler+0x20/0x5c
   do_debug_exception+0x1c8/0x22c
   el1_sync_handler+0x3c/0xe4
   el1_sync+0x7c/0x100
   rpmh_rsc_probe+0x38/0x420
   platform_drv_probe+0x94/0xb4
   really_probe+0x134/0x300
   driver_probe_device+0x68/0x100
   __device_attach_driver+0x90/0xa8
   bus_for_each_drv+0x84/0xcc
   __device_attach+0xb4/0x13c
   device_initial_probe+0x18/0x20
   bus_probe_device+0x38/0x98
   device_add+0x38c/0x420

If I understand properly we should just be able to blanket kgdb under
one big RCU read lock and the problem should go away.  We'll add it to
the beast-of-a-function known as kgdb_cpu_enter().

With this I no longer get any splats and things seem to work fine.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/debug_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 2b7c9b67931d..5155cf06731b 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -564,6 +564,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	int online_cpus = num_online_cpus();
 	u64 time_left;
 
+	rcu_read_lock();
+
 	kgdb_info[ks->cpu].enter_kgdb++;
 	kgdb_info[ks->cpu].exception_state |= exception_state;
 
@@ -635,6 +637,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 			atomic_dec(&slaves_in_kgdb);
 			dbg_touch_watchdogs();
 			local_irq_restore(flags);
+			rcu_read_unlock();
 			return 0;
 		}
 		cpu_relax();
@@ -773,6 +776,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	dbg_touch_watchdogs();
 	local_irq_restore(flags);
 
+	rcu_read_unlock();
+
 	return kgdb_info[cpu].ret_state;
 }
 
-- 
2.26.2.645.ge9eca65c58-goog

