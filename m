Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC828B30F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgJLKyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:54:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:32892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387594AbgJLKyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:54:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3118AC2F;
        Mon, 12 Oct 2020 10:54:14 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:54:11 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups updates for v5.10
Message-ID: <20201012105411.GI25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull maybe the easiest branch of all. :-)

Thx.

---
The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.10

for you to fetch changes up to 900ffe39fec908e0aa26a30612e43ebc7140db79:

  x86/entry: Fix typo in comments for syscall_enter_from_user_mode() (2020-09-22 18:24:46 +0200)

----------------------------------------------------------------
* Misc minor cleanups.

----------------------------------------------------------------
Colin Ian King (1):
      x86/resctrl: Fix spelling in user-visible warning messages

Kees Cook (1):
      x86/entry: Fix typo in comments for syscall_enter_from_user_mode()

Uros Bizjak (1):
      x86/entry/64: Do not include inst.h in calling.h

Wang Hai (1):
      x86/mpparse: Remove duplicate io_apic.h include

 arch/x86/entry/calling.h           | 1 -
 arch/x86/kernel/cpu/resctrl/core.c | 4 ++--
 arch/x86/kernel/mpparse.c          | 1 -
 include/linux/entry-common.h       | 2 +-
 kernel/entry/common.c              | 2 +-
 5 files changed, 4 insertions(+), 6 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
