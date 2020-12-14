Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037C92D9755
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407700AbgLNLXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:23:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:38846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407371AbgLNLXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:23:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D30B0B72E;
        Mon, 14 Dec 2020 11:22:28 +0000 (UTC)
Date:   Mon, 14 Dec 2020 12:22:29 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode update for v5.11
Message-ID: <20201214112229.GC26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this one wins the award for most boring pull request ever. But that's a
good thing - this is how I like 'em and the microcode loader *should* be
boring. :-)

Pls pull,
thx.

---
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_update_for_v5.11

for you to fetch changes up to 880396c86a1f3663c22b74fef34353f05a1263ec:

  x86/microcode/amd: Remove unneeded break (2020-10-26 12:18:22 +0100)

----------------------------------------------------------------
- A single cleanup removing "break" after a return statement (Tom Rix)

----------------------------------------------------------------
Tom Rix (1):
      x86/microcode/amd: Remove unneeded break

 arch/x86/kernel/cpu/microcode/amd.c | 1 -
 1 file changed, 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
