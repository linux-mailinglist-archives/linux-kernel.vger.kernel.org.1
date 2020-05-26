Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3185119E328
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 09:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgDDG66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 02:58:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgDDG66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 02:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=voGzMYCK0K8jfDayfIjKm5/csDG3aXXIjPWCZbs5YWs=; b=RCtDQvXi9hRS4RWqTM+DKzulYV
        DND9DzIW019ujjihMOutp26GgiewAis1IyZ2zxPRJay+I53hlVpxv2yvPkSv/ZpSQ4pi1nIxuYRFV
        SU4U/RKCDj0HZktj9u0AXC8qxWCAqn/jOWRX7RbRPnrxV/a8i8hA7/EAmRDDVwdLJjjV29rhLFXbf
        TuA+3G3WQ2MUSaAyRTx+Ow6LL/ugb15Y749wX3ekRywPmrHF/Kw3Aqm3LxXax56Xw2NSnb9nmmziH
        0dwHXnHcVh6fnhh5gYE+pg3GJWCPniRHS/buwLeBVEzFlopADFuD5bUR/P/ATt+1vVDDyB+C86gTa
        ohZohUcA==;
Received: from [2001:4bb8:180:7914:2ca6:9476:bbfa:a4d0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKclc-0001Yy-Tu; Sat, 04 Apr 2020 06:58:57 +0000
Date:   Sat, 4 Apr 2020 08:58:55 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping updates for 5.7
Message-ID: <20200404065855.GA656254@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.7

for you to fetch changes up to fd27a526bb381f43dded6db30b3b016468ab0e6c:

  ARM/dma-mapping: merge __dma_supported into arm_dma_supported (2020-03-20 11:43:21 +0100)

----------------------------------------------------------------
dma-mapping updates for 5.7

 - fix an integer overflow in the coherent pool (Kevin Grandemange)
 - provide support for in-place uncached remapping and use that
   for openrisc
 - fix the arm coherent allocator to take the bus limit into account

----------------------------------------------------------------
Christoph Hellwig (8):
      dma-direct: remove the cached_kernel_address hook
      dma-direct: consolidate the error handling in dma_direct_alloc_pages
      dma-direct: make uncached_kernel_address more general
      dma-direct: provide a arch_dma_clear_uncached hook
      openrisc: use the generic in-place uncached DMA allocator
      ARM/dma-mapping: remove get_coherent_dma_mask
      ARM/dma-mapping: take the bus limit into account in __dma_alloc
      ARM/dma-mapping: merge __dma_supported into arm_dma_supported

Kevin Grandemange (1):
      dma-coherent: fix integer overflow in the reserved-memory dma allocation

 arch/Kconfig                     | 15 +++++---
 arch/arm/include/asm/dma-iommu.h |  2 --
 arch/arm/mm/dma-mapping.c        | 76 ++++++++++------------------------------
 arch/microblaze/Kconfig          |  2 +-
 arch/microblaze/mm/consistent.c  |  9 +----
 arch/mips/Kconfig                |  3 +-
 arch/mips/mm/dma-noncoherent.c   |  7 +---
 arch/nios2/Kconfig               |  3 +-
 arch/nios2/mm/dma-mapping.c      | 12 +------
 arch/openrisc/Kconfig            |  2 ++
 arch/openrisc/kernel/dma.c       | 55 ++++++-----------------------
 arch/xtensa/Kconfig              |  2 +-
 arch/xtensa/kernel/pci-dma.c     | 12 ++-----
 include/linux/dma-noncoherent.h  |  4 +--
 kernel/dma/coherent.c            | 13 +++----
 kernel/dma/direct.c              | 25 +++++++------
 16 files changed, 76 insertions(+), 166 deletions(-)
