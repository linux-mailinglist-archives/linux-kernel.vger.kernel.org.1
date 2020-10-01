Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AD2803B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbgJAQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:17:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:57816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbgJAQR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:17:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E70FAF3B;
        Thu,  1 Oct 2020 16:17:54 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        robin.murphy@arm.com, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org
Cc:     will@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 0/4] arm64: Default to 32-bit wide ZONE_DMA
Date:   Thu,  1 Oct 2020 18:17:36 +0200
Message-Id: <20201001161740.29064-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using two distinct DMA zones turned out to be problematic. Here's an
attempt go back to a saner default.

I tested this on both a RPi4 and QEMU.

---

Nicolas Saenz Julienne (4):
  of/fdt: Update zone_dma_bits when running in bcm2711
  dma-direct: Turn zone_dma_bits default value into a define
  arm64: Default to 32-bit ZONE_DMA
  mm: Update DMA zones description with arm64 newer behavior

 arch/arm64/mm/init.c       | 12 ++++++++----
 drivers/of/fdt.c           | 10 ++++++++++
 include/linux/dma-direct.h |  1 +
 include/linux/mmzone.h     |  5 +++--
 kernel/dma/direct.c        |  2 +-
 5 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.28.0

