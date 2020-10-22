Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE2E29628A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896818AbgJVQTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502777AbgJVQTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:19:54 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C63208B6;
        Thu, 22 Oct 2020 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603383593;
        bh=qIrOo2z31/taIsn/ACV6wfNDT0g2pckjugQNsIbulKw=;
        h=Date:From:To:Cc:Subject:From;
        b=088K+Ib28sFxX2tt63cpzdWUQhNtVVcgdX0Huit0Siy3D59z9sh7T+x76X3+toICl
         wr2mKX/okEfIr15DErTqbJ96KZErdVFy8Q/UWH61PyqJsj4FGEgPdnmHT8kEbv20eY
         AFCS2ajTvtP+IHgfQQTmWuez9vcGrImusIKjj5eo=
Date:   Thu, 22 Oct 2020 17:19:48 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] More arm64 updates for -rc1
Message-ID: <20201022161948.GA19780@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this small selection of arm64 fixes and updates for -rc1. Most
of these are fixes that came in during the merge window, with the exception
of the HAVE_MOVE_PMD mremap() speed-up which we discussed back in 2018 and
somehow forgot to enable upstream [1]. Anyway, usual summary in the tag.

Marc Zyngier managed to get his paws on a Falkor system and offered a
Tested-by on the Spectre-v2 mitigation patch, but it came in after I'd
applied the thing.

Please pull.

Thanks,

Will

[1] https://lore.kernel.org/kvmarm/20181108181201.88826-3-joelaf@google.com/

--->8

The following changes since commit d13027bb35e089bc1bb9f19c4976decf32a09b97:

  Revert "arm64: initialize per-cpu offsets earlier" (2020-10-09 11:24:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 66dd3474702aa98d5844367e1577cdad78ef7c65:

  arm64: proton-pack: Update comment to reflect new function name (2020-10-21 11:07:27 +0100)

----------------------------------------------------------------
More arm64 updates for 5.10

- Improve performance of Spectre-v2 mitigation on Falkor CPUs (if you're lucky
  enough to have one)

- Select HAVE_MOVE_PMD. This has been shown to improve mremap() performance,
  which is used heavily by the Android runtime GC, and it seems we forgot to
  enable this upstream back in 2018.

- Ensure linker flags are consistent between LLVM and BFD

- Fix stale comment in Spectre mitigation rework

- Fix broken copyright header

- Fix KASLR randomisation of the linear map

- Prevent arm64-specific prctl()s from compat tasks (return -EINVAL)

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: mm: use single quantity to represent the PA to VA translation

Kalesh Singh (1):
      arm64: mremap speedup - Enable HAVE_MOVE_PMD

Nick Desaulniers (1):
      arm64: link with -z norelro regardless of CONFIG_RELOCATABLE

Palmer Dabbelt (1):
      arm64: Fix a broken copyright header in gen_vdso_offsets.sh

Peter Collingbourne (1):
      arm64: reject prctl(PR_PAC_RESET_KEYS) on compat tasks

Stephen Boyd (1):
      arm64: proton-pack: Update comment to reflect new function name

Will Deacon (1):
      arm64: spectre-v2: Favour CPU-specific mitigation at EL2

 arch/arm64/Kconfig                         |  1 +
 arch/arm64/Makefile                        |  4 +--
 arch/arm64/include/asm/memory.h            |  5 ++--
 arch/arm64/include/asm/pgtable.h           |  4 +--
 arch/arm64/kernel/fpsimd.c                 |  4 +--
 arch/arm64/kernel/pointer_auth.c           |  4 +++
 arch/arm64/kernel/proton-pack.c            | 40 ++++++++++++++----------------
 arch/arm64/kernel/vdso/gen_vdso_offsets.sh |  2 +-
 arch/arm64/mm/init.c                       | 30 ++++++++--------------
 9 files changed, 43 insertions(+), 51 deletions(-)
