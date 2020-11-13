Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461812B1B41
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKMMjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMMjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:39:40 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D558B20797;
        Fri, 13 Nov 2020 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605271180;
        bh=ikmfEDTViAEk1ywI4O+oD0ccvMKTIqnG0uCL6gP5YSA=;
        h=Date:From:To:Cc:Subject:From;
        b=zo9MBXLWweAIpUqE8eGE0Sx+EbMnX9LkpnmoGtU1dNE4KURIrRm8TFVIsYHXrJBgP
         F8V55fr7KqE99U21thVrxEWFUmevXpJGYL3jdQVhCoMcaKmZbTnp60qx1W6YZYaWwB
         Q7Fhj4dCnqGILAWINAsRPhRaBkbzqV0QLEOKIlng=
Date:   Fri, 13 Nov 2020 12:39:35 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        peterz@infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: GIT PULL] arm64 fixes for -rc4
Message-ID: <20201113123934.GA22014@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please can you pull these arm64 fixes for -rc4? It's all fairly simple
and there's a summary in the tag; Paul has reviewed the trivial RCU change.

The main issue remaining at this stage is the ongoing irqtracing problem
[1]. People are working on it, but no patches yet.

Cheers,

Will

[1] https://lore.kernel.org/r/20201103171153.GA46833@C02TD0UTHF1T.local

--->8


The following changes since commit 108aa503657ee2fe8aa071dc620d96372c252ecd:

  arm64: kexec_file: try more regions if loading segments fails (2020-11-05 21:48:05 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 23c216416056148136bdaf0cdd18caf4904bb6e1:

  arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX Silver (2020-11-13 09:47:08 +0000)

----------------------------------------------------------------
arm64 fixes for -rc4

- Spectre/Meltdown safelisting for some Qualcomm KRYO cores

- Fix RCU splat when failing to online a CPU due to a feature mismatch

- Fix a recently introduced sparse warning in kexec()

- Fix handling of CPU erratum 1418040 for late CPUs

- Ensure hot-added memory falls within linear-mapped region

----------------------------------------------------------------
Anshuman Khandual (1):
      arm64/mm: Validate hotplug range before creating linear mapping

Konrad Dybcio (4):
      arm64: Add MIDR value for KRYO2XX gold/silver CPU cores
      arm64: kpti: Add KRYO2XX gold/silver CPU cores to kpti safelist
      arm64: proton-pack: Add KRYO2XX silver CPUs to spectre-v2 safe-list
      arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX Silver

Will Deacon (4):
      arm64: errata: Fix handling of 1418040 with late CPU onlining
      arm64: kexec_file: Fix sparse warning
      arm64: psci: Avoid printing in cpu_psci_cpu_die()
      arm64: smp: Tell RCU about CPUs that fail to come online

 arch/arm64/include/asm/cpufeature.h |  2 ++
 arch/arm64/include/asm/cputype.h    |  4 ++++
 arch/arm64/kernel/cpu_errata.c      |  2 ++
 arch/arm64/kernel/cpufeature.c      |  2 ++
 arch/arm64/kernel/kexec_image.c     |  2 +-
 arch/arm64/kernel/process.c         |  5 ++---
 arch/arm64/kernel/proton-pack.c     |  1 +
 arch/arm64/kernel/psci.c            |  5 +----
 arch/arm64/kernel/smp.c             |  1 +
 arch/arm64/mm/mmu.c                 | 17 +++++++++++++++++
 kernel/rcu/tree.c                   |  2 +-
 11 files changed, 34 insertions(+), 9 deletions(-)
