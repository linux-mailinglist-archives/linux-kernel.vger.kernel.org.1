Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356492D97AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438633AbgLNLv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:51:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:38874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730736AbgLNLv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:51:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54A6AAC10;
        Mon, 14 Dec 2020 11:50:47 +0000 (UTC)
Date:   Mon, 14 Dec 2020 12:50:47 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/mm for v5.11
Message-ID: <20201214115047.GE26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

just a single robustification fix this time around.

Pls pull,
thx.

---

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v5.11

for you to fetch changes up to 1fcd009102ee02e217f2e7635ab65517d785da8e:

  x86/mm/ident_map: Check for errors from ident_pud_init() (2020-10-28 14:48:30 +0100)

----------------------------------------------------------------
- A single improvement to check ident_pud_init()'s return value (Arvind Sankar)

----------------------------------------------------------------
Arvind Sankar (1):
      x86/mm/ident_map: Check for errors from ident_pud_init()

 arch/x86/mm/ident_map.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
