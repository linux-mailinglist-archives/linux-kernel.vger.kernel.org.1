Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6CE2D98A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407879AbgLNNST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404263AbgLNNST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:18:19 -0500
Date:   Mon, 14 Dec 2020 15:17:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607951858;
        bh=mYAoGe6rJEj3V88cDWAq9WS6LBoh+Vq4t7f40loaYuk=;
        h=From:To:Cc:Subject:From;
        b=FnTyUcfqYMlhxhz6mTLo29HFEGSGiTWBbc4dUmQDXefsHQ8zofdYpq3xd4tV4mtHx
         ovxqr+7XgGSIZt+ACLo60Yg9V5ya2YEO8pOtXqANc1KmvBRUD9yBxNBE7tbBrQfDYy
         7I4QQLUIuGjMIGkzT775YkX22Q+ljH7pMN+CSWC7WaDPR1RBPzs6YMRDcniDFTWts/
         HAlBMUoZgbtXb8VJ07DdmX2oKSNk79gilBFXjiYrWSy1j50P1bTUTblsvNU8HEuc+q
         z8CHZfNkxy4ApzZMbr9zyCT3M/Iu4RnpTbne4/iP6PIWe5CedSGy5caSIpOoOyJ+PX
         Km2IZ0dqrb+8w==
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Faiyaz Mohammed <faiyazm@codeaurora.org>, vinmenon@codeaurora.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: debug enhancements
Message-ID: <20201214131731.GA247200@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git/ tags/memblock-v5.11-rc1

for you to fetch changes up to 5bdba520c1b318578caffd325515b35d187f8a0e:

  mm: memblock: drop __init from memblock functions to make it inline (2020-11-17 17:38:25 +0200)

----------------------------------------------------------------
memblock: debug enhancements

Improve tracking of early memory allocations when memblock debug is
enabled:

* Add memblock_dbg() to memblock_phys_alloc_range() to get details about
  its usage
* Make memblock allocator wrappers actually inline to track their callers
  in memblock debug messages

----------------------------------------------------------------
Faiyaz Mohammed (2):
      mm: memblock: add more debug logs
      mm: memblock: drop __init from memblock functions to make it inline

 include/linux/memblock.h | 18 +++++++++---------
 mm/memblock.c            |  3 +++
 2 files changed, 12 insertions(+), 9 deletions(-)

-- 
Sincerely yours,
Mike.
