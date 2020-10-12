Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EFD28B37B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbgJLLMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:12:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387810AbgJLLL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:11:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CBF5ACA3;
        Mon, 12 Oct 2020 11:11:58 +0000 (UTC)
Date:   Mon, 12 Oct 2020 13:11:54 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core updates for v5.10
Message-ID: <20201012111154.GL25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single fix making the error message when the opcode bytes
at rIP cannot be accessed during an oops, more precise.

Thx.

---
The following changes since commit a1b8638ba1320e6684aa98233c15255eb803fac7:

  Linux 5.9-rc7 (2020-09-27 14:38:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.10

for you to fetch changes up to 238c91115cd05c71447ea071624a4c9fe661f970:

  x86/dumpstack: Fix misleading instruction pointer error message (2020-10-02 11:33:55 +0200)

----------------------------------------------------------------
* Correct the "Bad RIP value" error message to be more precise, by Mark
Mossberg.

----------------------------------------------------------------
Mark Mossberg (1):
      x86/dumpstack: Fix misleading instruction pointer error message

 arch/x86/kernel/dumpstack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
