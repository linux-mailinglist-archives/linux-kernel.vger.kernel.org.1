Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C9F28D331
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgJMRg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:36:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:59588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbgJMRg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:36:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 089F8AD6B;
        Tue, 13 Oct 2020 17:36:25 +0000 (UTC)
Date:   Tue, 13 Oct 2020 19:36:15 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.10-rc1
Message-ID: <20201013173615.GI32151@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here's the clang build warning fix from yesterday which is finally
ready. I've added a second one from the tip's urgent queue which could
go in now too.

Please pull,
thx.

---

The following changes since commit 8b6591fd0ac8b7e8b2873703bc24b71a6f3d2d3e:

  Merge tag 'x86_platform_for_v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-10-12 10:31:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.10-rc1

for you to fetch changes up to 081dd68c89061077930ec7776d98837cb64b0405:

  x86/platform/uv: Remove unused variable in UV5 NMI handler (2020-10-13 19:21:13 +0200)

----------------------------------------------------------------
- Fix the #DE oops message string format which confused tools parsing
crash information. (Thomas Gleixner)

- Remove an unused variable in the UV5 code which was triggering a build
warning with clang. (Mike Travis)

----------------------------------------------------------------
Mike Travis (1):
      x86/platform/uv: Remove unused variable in UV5 NMI handler

Thomas Gleixner (1):
      x86/traps: Fix #DE Oops message regression

 arch/x86/kernel/traps.c       | 2 +-
 arch/x86/platform/uv/uv_nmi.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
