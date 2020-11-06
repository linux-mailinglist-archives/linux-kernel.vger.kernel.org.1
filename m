Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97C62A96E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgKFNUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgKFNUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:20:41 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FF8F20702;
        Fri,  6 Nov 2020 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604668840;
        bh=myDvYuDtefd9ds8nC6npnh0TAX0OgzT2U8EEQwYycF0=;
        h=Date:From:To:Cc:Subject:From;
        b=W0OAt4crdZ5Fyvu5oezPWtvC0MqQRmLchMiXdOb/oD2fOPFOqwaz7LSYFKbuyn3kX
         dNrvKvfR8vnm2cbrOHCkR15GFGOcurSw2cLWjPbweJkrOGbGrxgkiED4BPfoCr5sLS
         SIM9COlfM++zbVzCC7dGgZqY9mZEIGhU2b/piKls=
Date:   Fri, 6 Nov 2020 13:20:35 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20201106132035.GA10755@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the weekly batch of fixes for arm64. Not an awful lot here, but
there are still a few unresolved issues relating to CPU hotplug, RCU and
IRQ tracing that I hope to queue fixes for next week.

In the meantime, there's a summary for this lot in the tag.

Cheers,

Will

--->8

The following changes since commit ec9d78070de986ecf581ea204fd322af4d2477ec:

  arm64: Change .weak to SYM_FUNC_START_WEAK_PI for arch/arm64/lib/mem*.S (2020-10-30 08:32:31 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 108aa503657ee2fe8aa071dc620d96372c252ecd:

  arm64: kexec_file: try more regions if loading segments fails (2020-11-05 21:48:05 +0000)

----------------------------------------------------------------
arm64 fixes for -rc3

- Fix early use of kprobes

- Fix kernel placement in kexec_file_load()

- Bump maximum number of NUMA nodes

----------------------------------------------------------------
Benjamin Gwin (1):
      arm64: kexec_file: try more regions if loading segments fails

Jean-Philippe Brucker (1):
      arm64: kprobes: Use BRK instead of single-step when executing instructions out-of-line

Vanshidhar Konda (1):
      arm64: NUMA: Kconfig: Increase NODES_SHIFT to 4

 arch/arm64/Kconfig                      |  2 +-
 arch/arm64/include/asm/brk-imm.h        |  2 +
 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/include/asm/kprobes.h        |  2 +-
 arch/arm64/kernel/kexec_image.c         | 41 +++++++++++++++-----
 arch/arm64/kernel/machine_kexec_file.c  |  9 ++++-
 arch/arm64/kernel/probes/kprobes.c      | 69 +++++++++++----------------------
 7 files changed, 67 insertions(+), 59 deletions(-)
