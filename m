Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43F128A281
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbgJJW53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:57:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:48204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732223AbgJJTn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:43:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 502E5ACA3;
        Sat, 10 Oct 2020 15:12:44 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-mm@kvack.org
Subject: [PATCH v2 0/5] arm64: Default to 32-bit wide ZONE_DMA
Date:   Sat, 10 Oct 2020 17:12:30 +0200
Message-Id: <20201010151235.20585-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I realized this morning after reading Ard's patch fixing the same issue
in ACPI that we can move the zone_dma_bits initialization later in the
init process. This permits the use of OF to parse dma-ranges in the
system. Something we though we couldn't do on previous iterations of
this.

The series sits on top of Ard's patch "arm64: mm: set ZONE_DMA size
based on early IORT scan."

--- Original cover letter

Using two distinct DMA zones turned out to be problematic. Here's an
attempt go back to a saner default.

I tested this on both a RPi4 and QEMU.

---

Changes since v1:
 - Parse dma-ranges instead of using machine compatible string

Nicolas Saenz Julienne (5):
  arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
  of/address: Introduce of_dma_lower_bus_limit()
  dma-direct: Turn zone_dma_bits default value into a define
  arm64: mm: Dynamically resize zone_dma_bits based on system's
    constraints
  mm: Update DMA zones description

 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/mm/init.c               | 12 ++++-------
 drivers/of/address.c               | 34 ++++++++++++++++++++++++++++++
 include/linux/dma-direct.h         |  3 +++
 include/linux/mmzone.h             |  5 +++--
 include/linux/of.h                 |  7 ++++++
 kernel/dma/direct.c                |  2 +-
 7 files changed, 53 insertions(+), 11 deletions(-)

-- 
2.28.0

