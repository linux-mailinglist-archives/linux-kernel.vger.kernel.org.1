Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412DA202CC5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgFUUnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 16:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgFUUnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 16:43:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF96C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 13:43:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so6612850pls.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=PvZljGHNreo2tyXJVvsTBccc3LskiWVWOyP0n6ravmE=;
        b=a5FmRKW2nzxF4C5QCSMWyxbMtHd06V1ej3ANmTPXZdyDxWXpV+nqYGzuaoZ3QjNE0G
         6zKlRnuKU/8T42WFDfCTuILMSh+2dHrjnCuXcdl8GPjzXndyCX6ZVxGMUldRaE3jwY1H
         uYjnXMhUQNToXjfQsELyHV7MYban3XTH0ewBWy9ww8hvCnibv7CZfH7xB9c7tQSoFp5J
         jSF7RRc6oH8ytBy+5Tsw6Hy4X+82zx32FF79dfb7oo59/vfB7DA6AaqtnSg328QtBHHD
         v0M5R+GMYYj0DKfqjzGlzRNklq94g2ypEiXzajJ1dAvqKRhkLaFRMSltmuCZort0Hx0Y
         h6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=PvZljGHNreo2tyXJVvsTBccc3LskiWVWOyP0n6ravmE=;
        b=JVAjGFIkOcIzGF77swK7v7jjirdvOxbCUvY9KZh7JfHHcvcqetqlyI4TI7zg8TbrD7
         /gsxDdO1x5oBCz70XjyPYdWLgaShvpcMPVBy92ID64TpvzE5TqEbbrV/TosCaI+OHM+u
         9HiEm885tqZ4dBGmLBZGWB9JRYG9HI/buoP3e/03WdBQBeGYLqYpIrS/ca0je9PEcZo6
         KTbYdBHnmIIzt8AalAcyAiLqH9WeDeiTLW7VjB32TVWovJcMPWviwVMURi5xLmM9vBH/
         cyhIbs+VHEGwNCn7mJJb4uPS/KcH9d0xXMWvq9S6B0kwPjIEHjVilIY21Vyw1Xug5eth
         PwtA==
X-Gm-Message-State: AOAM53094xFNUUak1SvKwyrLmaHcG9Eg8gLatOhMte/1GOW9TUPuBc0U
        VIz8VE3KCwxgnNLVPzbO9P3kTA==
X-Google-Smtp-Source: ABdhPJyCL0CNvvbYHinbrYnOBjYsY6VcZ2Orf4uq60Hlk3Wki6onOsZa9dNQ8m1/zeVbJhVgC0z6fw==
X-Received: by 2002:a17:902:a511:: with SMTP id s17mr16615698plq.37.1592772183174;
        Sun, 21 Jun 2020 13:43:03 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f6sm12610020pfe.174.2020.06.21.13.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 13:43:02 -0700 (PDT)
Date:   Sun, 21 Jun 2020 13:43:02 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] dma-pool: warn when coherent pool is depleted
Message-ID: <alpine.DEB.2.22.394.2006211335530.195301@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a DMA coherent pool is depleted, allocation failures may or may not
get reported in the kernel log depending on the allocator.

The admin does have a workaround, however, by using coherent_pool= on the
kernel command line.

Provide some guidance on the failure and a recommended minimum size for
the pools (double the size).

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -239,12 +239,16 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
 	}
 
 	val = gen_pool_alloc(pool, size);
-	if (val) {
+	if (likely(val)) {
 		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
 
 		*ret_page = pfn_to_page(__phys_to_pfn(phys));
 		ptr = (void *)val;
 		memset(ptr, 0, size);
+	} else {
+		WARN_ONCE(1, "DMA coherent pool depleted, increase size "
+			     "(recommended min coherent_pool=%zuK)\n",
+			  gen_pool_size(pool) >> 9);
 	}
 	if (gen_pool_avail(pool) < atomic_pool_size)
 		schedule_work(&atomic_pool_work);
