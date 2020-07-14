Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5621F196
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 14:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgGNMkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 08:40:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbgGNMkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:40:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9615AC49;
        Tue, 14 Jul 2020 12:40:01 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     hch@lst.de, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/4] dma-pool: Fix atomic pool selection
Date:   Tue, 14 Jul 2020 14:39:24 +0200
Message-Id: <20200714123928.8581-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my attempt at fixing one of the regressions we've seen[1] after
the introduction of per-zone atomic pools.

This combined with "dma-pool: Do not allocate pool memory from CMA"[2]
should fix the boot issues on Jeremy's RPi4 setup.

[1] https://lkml.org/lkml/2020/7/2/974
[2] https://lkml.org/lkml/2020/7/8/1108

---

Changes since v1:
 - Rebase into linus' master

Nicolas Saenz Julienne (4):
  dma-direct: Provide function to check physical memory area validity
  dma-pool: Get rid of dma_in_atomic_pool()
  dma-pool: Introduce dma_guess_pool()
  dma-pool: Make sure atomic pool suits device

 include/linux/dma-direct.h |  1 +
 kernel/dma/direct.c        |  2 +-
 kernel/dma/pool.c          | 80 +++++++++++++++++++++++++-------------
 3 files changed, 56 insertions(+), 27 deletions(-)

-- 
2.27.0

