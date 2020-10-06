Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62328515C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgJFSIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 14:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgJFSIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 14:08:24 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3168206F7;
        Tue,  6 Oct 2020 18:08:22 +0000 (UTC)
Date:   Tue, 6 Oct 2020 19:08:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix for 5.9
Message-ID: <20201006180818.GA25842@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit a509a66a9d0d4f4e304d58fad38c078d0336c445:

  arm64: permit ACPI core to map kernel memory used for table overrides (2020-09-30 22:27:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 39e4716caa598a07a98598b2e7cd03055ce25fb9:

  crypto: arm64: Use x16 with indirect branch to bti_c (2020-10-06 18:14:47 +0100)

----------------------------------------------------------------
Fix a kernel panic in the AES crypto code caused by a BR tail call not
matching the target BTI instruction (when branch target identification
is enabled).

----------------------------------------------------------------
Jeremy Linton (1):
      crypto: arm64: Use x16 with indirect branch to bti_c

 arch/arm64/crypto/aes-neonbs-core.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Catalin
