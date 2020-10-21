Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C262946F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 05:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440121AbgJUDaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 23:30:22 -0400
Received: from ozlabs.ru ([107.174.27.60]:41862 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440112AbgJUDaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 23:30:19 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 1DC2CAE800C0;
        Tue, 20 Oct 2020 23:19:55 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel 0/2] powerpc/dma: Fallback to dma_ops when persistent memory present
Date:   Wed, 21 Oct 2020 14:20:24 +1100
Message-Id: <20201021032026.45030-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows mixing direct DMA (to/from RAM) and
IOMMU (to/from apersistent memory) on the PPC64/pseries
platform. This was supposed to be a single patch but
unexpected move of direct DMA functions happened.

This is based on sha1
7cf726a59435 Linus Torvalds "Merge tag 'linux-kselftest-kunit-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  Revert "dma-mapping: move large parts of <linux/dma-direct.h> to
    kernel/dma"
  powerpc/dma: Fallback to dma_ops when persistent memory present

 include/linux/dma-direct.h             | 106 ++++++++++++++++++++++
 kernel/dma/direct.h                    | 119 -------------------------
 arch/powerpc/kernel/dma-iommu.c        |  68 +++++++++++++-
 arch/powerpc/platforms/pseries/iommu.c |  41 +++++++--
 kernel/dma/direct.c                    |   2 +-
 kernel/dma/mapping.c                   |   2 +-
 6 files changed, 207 insertions(+), 131 deletions(-)
 delete mode 100644 kernel/dma/direct.h

-- 
2.17.1

