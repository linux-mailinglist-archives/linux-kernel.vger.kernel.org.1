Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3ED1C968E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 18:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgEGQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 12:31:14 -0400
Received: from foss.arm.com ([217.140.110.172]:35348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgEGQbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:31:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C07111FB;
        Thu,  7 May 2020 09:31:13 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E19BF3F71F;
        Thu,  7 May 2020 09:31:12 -0700 (PDT)
Date:   Thu, 7 May 2020 17:31:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.7-rc5
Message-ID: <20200507163108.GA17399@gaia>
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

The following changes since commit 1578e5d03112e3e9d37e1c4d95b6dfb734c73955:

  arm64: vdso: Add -fasynchronous-unwind-tables to cflags (2020-04-30 18:35:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 027d0c7101f50cf03aeea9eebf484afd4920c8d3:

  arm64: hugetlb: avoid potential NULL dereference (2020-05-07 09:24:15 +0100)

----------------------------------------------------------------
- Avoid potential NULL dereference in huge_pte_alloc() on pmd_alloc()
  failure

----------------------------------------------------------------
Mark Rutland (1):
      arm64: hugetlb: avoid potential NULL dereference

 arch/arm64/mm/hugetlbpage.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
Catalin
