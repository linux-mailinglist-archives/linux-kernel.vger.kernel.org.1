Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E749F300C66
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbhAVTW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbhAVTIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:08:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF0423AC1;
        Fri, 22 Jan 2021 19:07:23 +0000 (UTC)
Date:   Fri, 22 Jan 2021 19:07:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.11-rc5
Message-ID: <20210122190719.GA29705@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 3a57a643a851dbb1c4a1819394ca009e3bfa4813:

  arm64: selftests: Fix spelling of 'Mismatch' (2021-01-15 10:05:27 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 75bd4bff300b3c5252d4a0e7a959569c62d1dbae:

  arm64: kprobes: Fix Uexpected kernel BRK exception at EL1 (2021-01-22 16:05:29 +0000)

----------------------------------------------------------------
arm64 fixes:

- Correctly mask out bits 63:60 in a kernel tag check fault address
  (specified as unknown by the architecture). Previously they were just
  zeroed but for kernel pointers they need to be all ones.

- Fix a panic (unexpected kernel BRK exception) caused by kprobes being
  reentered due to an interrupt.

----------------------------------------------------------------
Andrey Konovalov (1):
      kasan, arm64: fix pointer tags in KASAN reports

Qais Yousef (1):
      arm64: kprobes: Fix Uexpected kernel BRK exception at EL1

 arch/arm64/kernel/probes/kprobes.c | 4 ++--
 arch/arm64/mm/fault.c              | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
Catalin
