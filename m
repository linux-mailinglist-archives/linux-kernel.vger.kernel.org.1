Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9428B2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbgJLKuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:50:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:58862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387766AbgJLKuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:50:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD0F0ACED;
        Mon, 12 Oct 2020 10:50:13 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:50:09 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/fpu updates for v5.10
Message-ID: <20201012105009.GH25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two clearcpuid= improvements.

Thx.

---

The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.10

for you to fetch changes up to 1ef5423a55c2ac6f1361811efe75b6e46d1023ed:

  x86/fpu: Handle FPU-related and clearcpuid command line arguments earlier (2020-09-22 00:24:27 +0200)

----------------------------------------------------------------
* Allow clearcpuid= to accept multiple bits, by Arvind Sankar.

* Move clearcpuid= parameter handling earlier in the boot, away from the
FPU init code and to a generic location, by Mike Hommey.

----------------------------------------------------------------
Arvind Sankar (1):
      x86/fpu: Allow multiple bits in clearcpuid= parameter

Mike Hommey (1):
      x86/fpu: Handle FPU-related and clearcpuid command line arguments earlier

 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/x86/kernel/cpu/common.c                    | 55 +++++++++++++++++++++++++
 arch/x86/kernel/fpu/init.c                      | 41 ------------------
 3 files changed, 56 insertions(+), 42 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
