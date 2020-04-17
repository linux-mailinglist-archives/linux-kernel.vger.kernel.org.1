Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FFE1AE317
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgDQREJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:04:09 -0400
Received: from foss.arm.com ([217.140.110.172]:54086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgDQREI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:04:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 339C2C14;
        Fri, 17 Apr 2020 10:04:08 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AC873F6C4;
        Fri, 17 Apr 2020 10:04:07 -0700 (PDT)
Date:   Fri, 17 Apr 2020 18:04:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.7-rc2
Message-ID: <20200417170403.GA15479@gaia>
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

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to c9a4ef66450145a356a626c833d3d7b1668b3ded:

  arm64: Delete the space separator in __emit_inst (2020-04-15 13:07:12 +0100)

----------------------------------------------------------------
- Remove vdso code trying to free unallocated pages.

- Delete the space separator in the __emit_inst macro as it breaks the
  clang integrated assembler.

----------------------------------------------------------------
Fangrui Song (1):
      arm64: Delete the space separator in __emit_inst

Mark Rutland (1):
      arm64: vdso: don't free unallocated pages

 arch/arm64/include/asm/sysreg.h |  4 +++-
 arch/arm64/kernel/vdso.c        | 13 +------------
 2 files changed, 4 insertions(+), 13 deletions(-)

-- 
Catalin
