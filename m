Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4893428B226
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgJLKWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:22:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729538AbgJLKWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:22:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63FB6ADF2;
        Mon, 12 Oct 2020 10:22:33 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:22:29 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc updates for v5.10
Message-ID: <20201012102229.GF25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some miscellaneous fixes.

Thx.

---

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.10

for you to fetch changes up to f94c91f7ba3ba7de2bc8aa31be28e1abb22f849e:

  x86/nmi: Fix nmi_handle() duration miscalculation (2020-10-01 14:42:08 +0200)

----------------------------------------------------------------
* Ratelimit the message about writes to unrecognized MSRs so that they
don't spam the console log, by Chris Down.

* Document how the /proc/cpuinfo machinery works for future reference,
by Kyung Min Park, Ricardo Neri and Dave Hansen.

* Correct the current NMI's duration calculation, by Libing Zhou.

----------------------------------------------------------------
Chris Down (2):
      x86/msr: Prevent userspace MSR access from dominating the console
      x86/msr: Make source of unrecognised MSR writes unambiguous

Kyung Min Park (1):
      Documentation/x86: Add documentation for /proc/cpuinfo feature flags

Libing Zhou (1):
      x86/nmi: Fix nmi_handle() duration miscalculation

 Documentation/x86/cpuinfo.rst | 155 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/x86/index.rst   |   1 +
 arch/x86/kernel/msr.c         |  18 ++++-
 arch/x86/kernel/nmi.c         |   5 +-
 4 files changed, 173 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/x86/cpuinfo.rst
-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
