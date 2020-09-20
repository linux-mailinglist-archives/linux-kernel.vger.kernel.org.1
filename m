Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272B42717C4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 22:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgITUE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 16:04:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:56474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgITUEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 16:04:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7F3EBAD32;
        Sun, 20 Sep 2020 20:05:30 +0000 (UTC)
Date:   Sun, 20 Sep 2020 22:04:53 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] core/urgent for v5.9-rc6
Message-ID: <20200920200453.GG13044@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single syscall tracing fix.

Thx.

---
The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v5.9_rc6

for you to fetch changes up to b6ec413461034d49f9e586845825adb35ba308f6:

  core/entry: Report syscall correctly for trace and audit (2020-09-14 22:49:51 +0200)

----------------------------------------------------------------
Fix the seccomp syscall rewriting so that trace and audit see the
rewritten syscall number, from Kees Cook.

----------------------------------------------------------------
Kees Cook (1):
      core/entry: Report syscall correctly for trace and audit

 kernel/entry/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 18683598edbc..6fdb6105e6d6 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -60,13 +60,15 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 			return ret;
 	}
 
+	/* Either of the above might have changed the syscall number */
+	syscall = syscall_get_nr(current, regs);
+
 	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall);
 
 	syscall_enter_audit(regs, syscall);
 
-	/* The above might have changed the syscall number */
-	return ret ? : syscall_get_nr(current, regs);
+	return ret ? : syscall;
 }
 
 static __always_inline long

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
