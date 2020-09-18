Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EFC2701AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIRQNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRQNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:13:20 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84F442075E;
        Fri, 18 Sep 2020 16:13:19 +0000 (UTC)
Date:   Fri, 18 Sep 2020 17:13:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.9-rc6
Message-ID: <20200918161314.GA9698@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit e0328feda79d9681b3e3245e6e180295550c8ee9:

  arm64/module: set trampoline section flags regardless of CONFIG_DYNAMIC_FTRACE (2020-09-02 08:35:33 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 75df529bec9110dad43ab30e2d9490242529e8b8:

  arm64: paravirt: Initialize steal time when cpu is online (2020-09-17 18:12:18 +0100)

----------------------------------------------------------------
- Allow CPUs affected by erratum 1418040 to come online late (previously
  we only fixed the other case - CPUs not affected by the erratum coming
  up late).

- Fix branch offset in BPF JIT.

- Defer the stolen time initialisation to the CPU online time from the
  CPU starting time to avoid a (sleep-able) memory allocation in an
  atomic context.

----------------------------------------------------------------
Andrew Jones (1):
      arm64: paravirt: Initialize steal time when cpu is online

Ilias Apalodimas (1):
      arm64: bpf: Fix branch offset in JIT

Marc Zyngier (1):
      arm64: Allow CPUs unffected by ARM erratum 1418040 to come in late

 arch/arm64/kernel/cpu_errata.c |  8 ++++++--
 arch/arm64/kernel/paravirt.c   | 26 ++++++++++++++-----------
 arch/arm64/net/bpf_jit_comp.c  | 43 ++++++++++++++++++++++++++++++------------
 include/linux/cpuhotplug.h     |  1 -
 4 files changed, 52 insertions(+), 26 deletions(-)

-- 
Catalin
