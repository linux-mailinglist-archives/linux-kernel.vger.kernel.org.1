Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD22D9B37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439001AbgLNPg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:36:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:53896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438868AbgLNPgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:36:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CEA0AC10;
        Mon, 14 Dec 2020 15:35:20 +0000 (UTC)
Date:   Mon, 14 Dec 2020 16:35:20 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v5.11
Message-ID: <20201214153520.GJ26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the resource control updates accumulated for v5.11. This
branch conflicts with yours due to previous urgent fixes going in
earlier and the merge conflict resolution should look like this:

---
diff --cc arch/x86/kernel/cpu/resctrl/monitor.c
index a98519a3a2e6,622073ffa715..000000000000
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@@ -279,7 -343,8 +343,7 @@@ static void mbm_bw_count(u32 rmid, stru
  		return;
  
  	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
- 	cur_bw = (chunks * r->mon_scale) >> 20;
 -	m->chunks += chunks;
+ 	cur_bw = (get_corrected_mbm_count(rmid, chunks) * r->mon_scale) >> 20;
  
  	if (m->delta_comp)
  		m->delta_bw = abs(cur_bw - m->prev_bw);
---

Please pull,
thx.

---

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.11

for you to fetch changes up to 19eb86a72df50adcf554f234469bb5b7209b7640:

  x86/resctrl: Clean up unused function parameter in rmdir path (2020-12-01 18:06:35 +0100)

----------------------------------------------------------------
- Add logic to correct MBM total and local values fixing errata SKX99 and BDF102
(Fenghua Yu)

- Cleanups.

----------------------------------------------------------------
Borislav Petkov (1):
      Merge tag 'v5.10-rc6' into x86/cache

Fenghua Yu (2):
      Documentation/x86: Rename resctrl_ui.rst and add two errata to the file
      x86/resctrl: Correct MBM total and local values

Rikard Falkeborn (1):
      x86/resctrl: Constify kernfs_ops

Xiaochen Shen (1):
      x86/resctrl: Clean up unused function parameter in rmdir path

 Documentation/x86/index.rst                       |  2 +-
 Documentation/x86/{resctrl_ui.rst => resctrl.rst} | 93 +++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/core.c                |  4 +
 arch/x86/kernel/cpu/resctrl/internal.h            |  3 +-
 arch/x86/kernel/cpu/resctrl/monitor.c             | 82 +++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c            | 21 +++--
 6 files changed, 189 insertions(+), 16 deletions(-)
 rename Documentation/x86/{resctrl_ui.rst => resctrl.rst} (90%)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
