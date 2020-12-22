Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FBB2E0CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgLVQB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgLVQB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:01:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433AFC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 08:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=yykNsfBaPxMOZBrP4jnO9bz/8a3gTbpPD1bA3ocpIVA=; b=d6ucT97mlU3TE0F0TWJYB2Sjl4
        ZC7jUQkSD9K3LQ+9brv6d1cbAEm9RdhwPAbzgfye7f/f29lRXJ9yNJ51qjmaUM97nrgAJVEN/2Ysv
        o893hP1zABoA7j/uCfx7Vtu15jmau34pj2GuwX3zimXCjTkqgGGkp0FVe/uB7RuVgzaMtxMpOqZ00
        rIvAk4bRfQwOAtH1MKpNPR/TBgPC1wO7x0wIjCDVSALPhK7lqpUUKxWamI+fm02xGoY9IawjQxrxf
        i8dhPT+u7xmEyIayJWmdgf6JGdk/oElRqE/Jw8eoLefrFDMR0GHQdo0VXA+2qk2YzsK+U15k9SDiN
        9KVlJsaA==;
Received: from [2001:4bb8:180:8063:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krk65-0003Dg-9k; Tue, 22 Dec 2020 16:01:13 +0000
Date:   Tue, 22 Dec 2020 17:01:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping updates for 5.11
Message-ID: <20201222160112.GA3019603@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11

for you to fetch changes up to 7679325702c90aecd393cd7cde685576c14489c0:

  selftests/dma: add test application for DMA_MAP_BENCHMARK (2020-11-27 10:33:42 +0100)

----------------------------------------------------------------
dma-mapping updates for 5.11:

 - support for a partial IOMMU bypass (Alexey Kardashevskiy)
 - add a DMA API benchmark (Barry Song)
 - misc fixes (Tiezhu Yang, tangjianqiang)

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      dma-mapping: Allow mixing bypass and mapped DMA operation
      powerpc/dma: Fallback to dma_ops when persistent memory present

Barry Song (2):
      dma-mapping: add benchmark support for streaming DMA APIs
      selftests/dma: add test application for DMA_MAP_BENCHMARK

Tiezhu Yang (1):
      dma-pool: no need to check return value of debugfs_create functions

tangjianqiang (1):
      dma-contiguous: fix a typo error in a comment

 MAINTAINERS                                     |   6 +
 arch/powerpc/Kconfig                            |   1 +
 arch/powerpc/kernel/dma-iommu.c                 |  71 ++++-
 arch/powerpc/platforms/pseries/iommu.c          |  51 +++-
 include/linux/dma-map-ops.h                     |  14 +
 kernel/dma/Kconfig                              |  13 +
 kernel/dma/Makefile                             |   1 +
 kernel/dma/contiguous.c                         |   2 +-
 kernel/dma/map_benchmark.c                      | 361 ++++++++++++++++++++++++
 kernel/dma/mapping.c                            |  12 +-
 kernel/dma/pool.c                               |   3 -
 tools/testing/selftests/dma/Makefile            |   6 +
 tools/testing/selftests/dma/config              |   1 +
 tools/testing/selftests/dma/dma_map_benchmark.c | 123 ++++++++
 14 files changed, 645 insertions(+), 20 deletions(-)
 create mode 100644 kernel/dma/map_benchmark.c
 create mode 100644 tools/testing/selftests/dma/Makefile
 create mode 100644 tools/testing/selftests/dma/config
 create mode 100644 tools/testing/selftests/dma/dma_map_benchmark.c
