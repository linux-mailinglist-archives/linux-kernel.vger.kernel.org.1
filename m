Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527D02447EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 12:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgHNK0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 06:26:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:54340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgHNK0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:26:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE8F5ACB5;
        Fri, 14 Aug 2020 10:26:55 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     amit.pundir@linaro.org, hch@lst.de, linux-kernel@vger.kernel.org
Cc:     rientjes@google.com, jeremy.linton@arm.com,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v4 0/2] dma-pool fixes
Date:   Fri, 14 Aug 2020 12:26:22 +0200
Message-Id: <20200814102625.25599-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have an explanation to Amir's issue, we can re-spin this
series.

---
Changes since v3:
 - Do not use memblock_start_of_DRAM()

Changes since v2:
 - Go back to v1's behavior for patch #2

Changes since v1:
 - Make cma_in_zone() more strict, GFP_KERNEL doesn't default to true
   now

 - Check if phys_addr_ok() exists prior calling it

Christoph Hellwig (1):
  dma-pool: fix coherent pool allocations for IOMMU mappings

Nicolas Saenz Julienne (1):
  dma-pool: Only allocate from CMA when in same memory zone

 drivers/iommu/dma-iommu.c   |   4 +-
 include/linux/dma-direct.h  |   3 -
 include/linux/dma-mapping.h |   5 +-
 kernel/dma/direct.c         |  13 +++-
 kernel/dma/pool.c           | 145 +++++++++++++++++++-----------------
 5 files changed, 92 insertions(+), 78 deletions(-)

-- 
2.28.0

