Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234531DED3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgEVQ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 12:28:21 -0400
Received: from foss.arm.com ([217.140.110.172]:39026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbgEVQ2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:28:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D9D055D;
        Fri, 22 May 2020 09:28:20 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B12B93F305;
        Fri, 22 May 2020 09:28:19 -0700 (PDT)
Date:   Fri, 22 May 2020 17:28:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.7-rc7
Message-ID: <20200522162815.GA20565@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit d51c214541c5154dda3037289ee895ea3ded5ebd:

  arm64: fix the flush_icache_range arguments in machine_kexec (2020-05-11 12:02:14 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 8cfb347ad0cffdbfc69c82506fb3be9429563211:

  arm64: Add get_user() type annotation on the !access_ok() path (2020-05-22 16:59:49 +0100)

----------------------------------------------------------------
- Bring the PTRACE_SYSEMU semantics in line with the man page.
- Annotate variable assignment in get_user() with the type to avoid
  sparse warnings.

----------------------------------------------------------------
Al Viro (1):
      arm64: Add get_user() type annotation on the !access_ok() path

Keno Fischer (1):
      arm64: Fix PTRACE_SYSEMU semantics

 arch/arm64/include/asm/uaccess.h | 2 +-
 arch/arm64/kernel/ptrace.c       | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
Catalin
