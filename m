Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A801EC541
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 00:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgFBWr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 18:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgFBWr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 18:47:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39DCC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 15:47:57 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g5so164492pfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 15:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1KXljua1G5hAoel7DwUEO0U9O2u7J2/xCv2Bo1SECA=;
        b=iWF16kqpdpIGtjp4xjBjKqaVpGDpxlLCroVAwhliDtYhWFf8MY/3vyqEG5n6Il9+Fo
         DerUOVLmdU+EKOQVPAeoRrJ1q1Pl0K+eS/qIqC/KUhRbmQXRl9nk4Ug9huZC/rpqTPr2
         9ZCZ+7Go9nue5fKbjPKA8SLvQO9EfzUOER4NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1KXljua1G5hAoel7DwUEO0U9O2u7J2/xCv2Bo1SECA=;
        b=iaJ3M+hH89cPM12Age/eDiMIQ7FO9IAC78RRh2+uhYPq6nY164Yxo2wDO50tsZd5N7
         23PYdCkTWDU3HCe5cF3C6v1uQPqbJ9lBpU3KhsQbMaaUznnKSaF5TzdHcXHEk4g3hQDp
         tl08RvF+QiVQVHmeST0K7x0f320NvwOGfkQoRDnQdyjCTn0ocMFQNUDJndhjVqcJqqNx
         UAyxLuZKfDmf3L/UUiQmqKtMy3rnsICT8U5iEZdaXncHLJ9Ftn2YXhzF/KcjTrGEaFU+
         gzbQqQWXOYJImaZlO/F9Cagr0tF9r5iEeeMr7GPdKliks2xXRFI3HNDyjl40D6G3Sb+O
         UeVA==
X-Gm-Message-State: AOAM531yg07vOcfD0AXjrmoB60FuZn/nYIfGyhL1r7tHQKCE4TAqO0nJ
        BACi+Q0yej2oiQqIOaUc6nRFU6/EfFrGug==
X-Google-Smtp-Source: ABdhPJyunawwPk6QVYIip344J3GUrogqxyNoIrIxPW+q87l4LTgEH9YrcHGEx+smIuSrHsQ69HWQ6g==
X-Received: by 2002:a17:90a:ce05:: with SMTP id f5mr1707468pju.32.1591138077291;
        Tue, 02 Jun 2020 15:47:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j10sm88789pjf.9.2020.06.02.15.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 15:47:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     sumit.garg@linaro.org, Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2] kgdb: Avoid suspicious RCU usage warning
Date:   Tue,  2 Jun 2020 15:47:39 -0700
Message-Id: <20200602154729.v2.1.I70e0d4fd46d5ed2aaf0c98a355e8e1b7a5bb7e4e@changeid>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
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

Changes in v2:
- Cuddle up to the local interrupt locking code.

 kernel/debug/debug_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index ef94e906f05a..c9748f454fb7 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -575,6 +575,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 		arch_kgdb_ops.disable_hw_break(regs);
 
 acquirelock:
+	rcu_read_lock();
 	/*
 	 * Interrupts will be restored by the 'trap return' code, except when
 	 * single stepping.
@@ -634,6 +635,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 			atomic_dec(&slaves_in_kgdb);
 			dbg_touch_watchdogs();
 			local_irq_restore(flags);
+			rcu_read_unlock();
 			return 0;
 		}
 		cpu_relax();
@@ -652,6 +654,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 		raw_spin_unlock(&dbg_master_lock);
 		dbg_touch_watchdogs();
 		local_irq_restore(flags);
+		rcu_read_unlock();
 
 		goto acquirelock;
 	}
@@ -775,6 +778,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	raw_spin_unlock(&dbg_master_lock);
 	dbg_touch_watchdogs();
 	local_irq_restore(flags);
+	rcu_read_unlock();
 
 	return kgdb_info[cpu].ret_state;
 }
-- 
2.27.0.rc2.251.g90737beb825-goog

