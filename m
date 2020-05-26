Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE11C1DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 21:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgEAT34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 15:29:56 -0400
Received: from foss.arm.com ([217.140.110.172]:45424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgEAT34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 15:29:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA06D1FB;
        Fri,  1 May 2020 12:29:55 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18B1E3F305;
        Fri,  1 May 2020 12:29:54 -0700 (PDT)
Date:   Fri, 1 May 2020 20:29:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.7-rc4
Message-ID: <20200501192950.GA25365@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 1578e5d03112e3e9d37e1c4d95b6dfb734c73955:

  arm64: vdso: Add -fasynchronous-unwind-tables to cflags (2020-04-30 18:35:32 +0100)

----------------------------------------------------------------
- Add -fasynchronous-unwind-tables to the vDSO CFLAGS.

----------------------------------------------------------------
Vincenzo Frascino (1):
      arm64: vdso: Add -fasynchronous-unwind-tables to cflags

 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Catalin
