Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFA22A4108
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgKCKA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:00:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:41892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgKCKA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:00:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3456BABDE;
        Tue,  3 Nov 2020 10:00:25 +0000 (UTC)
Date:   Tue, 3 Nov 2020 11:00:12 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/seves fixes for v5.10-rc3
Message-ID: <20201103100012.GA7825@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of SEV-ES hardening fixes against a malicious
hypervisor.

Thx.

---

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.10_rc3

for you to fetch changes up to 2411cd82112397bfb9d8f0f19cd46c3d71e0ce67:

  x86/sev-es: Do not support MMIO to/from encrypted memory (2020-10-29 19:27:42 +0100)

----------------------------------------------------------------
A couple of changes to the SEV-ES code to perform more stringent
hypervisor checks before enabling encryption. (Joerg Roedel)

----------------------------------------------------------------
Joerg Roedel (5):
      x86/boot/compressed/64: Introduce sev_status
      x86/boot/compressed/64: Sanity-check CPUID results in the early #VC handler
      x86/boot/compressed/64: Check SEV encryption in 64-bit boot-path
      x86/head/64: Check SEV encryption before switching to kernel page-table
      x86/sev-es: Do not support MMIO to/from encrypted memory

 arch/x86/boot/compressed/ident_map_64.c |  1 +
 arch/x86/boot/compressed/mem_encrypt.S  | 20 +++++++-
 arch/x86/boot/compressed/misc.h         |  2 +
 arch/x86/kernel/head_64.S               | 16 ++++++
 arch/x86/kernel/sev-es-shared.c         | 26 ++++++++++
 arch/x86/kernel/sev-es.c                | 20 +++++---
 arch/x86/kernel/sev_verify_cbit.S       | 89 +++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt.c               |  1 +
 8 files changed, 167 insertions(+), 8 deletions(-)
 create mode 100644 arch/x86/kernel/sev_verify_cbit.S

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
