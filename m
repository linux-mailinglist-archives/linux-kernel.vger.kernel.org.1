Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7932EB884
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbhAFDmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAFDmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:42:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB16C06134D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:41:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v1so873622pjr.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U3TpLfW+vImhvH0nGRTRbZCkU/q6uvDGxQ/ffdS/DVM=;
        b=akatZ9qvuVqvk7jTIGmhjfDVt/R+fkDe7KGtuV2FiL0W9X0lfcwuxwQ5SDHkDWvo/Y
         OU4FPQJAhXwq03c8Ys0HNgl+IupiV5k8xFok85r5ImLAz1DYG9c87lF8ePniw4ZUVnDj
         udHjYJ0V3gqIMjH0S4jHAYa5kPGyqU1QS8adQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U3TpLfW+vImhvH0nGRTRbZCkU/q6uvDGxQ/ffdS/DVM=;
        b=e9x6uqf7Nb1vGMQINyCRHWQKaTxYHBTnKujCXInhLpPLumEPKKzu+IHN+W2agXrlGt
         PWge/+58rLqkxkQ6ajtOGgPF3d1OYgUnzqC8UCCZXJfh7VzWjclkdRz7pPQyRbJsibbn
         Zhae1WE2D6eVhnW6LBCehVMARavY6T1zT/dPdmdrPNMpQOIfwxy0u7zFaFF13hPWvWwr
         7qqJnV8sGb6LJH+6hwg4jK/X2SjUGhBjeUCpE4Pzy8vc/1HEBP6Cn8dExflB3NVbCoj+
         /+lgPuj62mHbkxni/RdyGX5GQzv5FGHtQJGPO3SbSItNiQW0/4Mevwp45Wa8RdYUjQUg
         6DAw==
X-Gm-Message-State: AOAM530cB5PYfL835eL+9+DtHKJCZ5nyyclyTpq/wUJM/pFllaeeiZ42
        QIBPEDMA7aAQqCBB9SiNw7JSJA==
X-Google-Smtp-Source: ABdhPJzMVJXWuHdnqMMSkgz9jt5n+Akn+pP0QJigxunJGEBd/ODEkJmP1Ra/LRA2SYqMSUv/fxQHkA==
X-Received: by 2002:a17:90a:4582:: with SMTP id v2mr1714522pjg.58.1609904492458;
        Tue, 05 Jan 2021 19:41:32 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id v10sm544816pjr.47.2021.01.05.19.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 19:41:31 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     robh+dt@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, joro@8bytes.org, will@kernel.org,
        frowand.list@gmail.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Cc:     grant.likely@arm.com, xypron.glpk@gmx.de, treding@nvidia.com,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, saravanak@google.com,
        rafael.j.wysocki@intel.com, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, tfiga@chromium.org,
        drinkcat@chromium.org, Claire Chang <tientzu@chromium.org>
Subject: [RFC PATCH v3 0/6] Restricted DMA
Date:   Wed,  6 Jan 2021 11:41:18 +0800
Message-Id: <20210106034124.30560-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements mitigations for lack of DMA access control on
systems without an IOMMU, which could result in the DMA accessing the
system memory at unexpected times and/or unexpected addresses, possibly
leading to data leakage or corruption.

For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
not behind an IOMMU. As PCI-e, by design, gives the device full access to
system memory, a vulnerability in the Wi-Fi firmware could easily escalate
to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
full chain of exploits; [2], [3]).

To mitigate the security concerns, we introduce restricted DMA. Restricted
DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
specially allocated region and does memory allocation from the same region.
The feature on its own provides a basic level of protection against the DMA
overwriting buffer contents at unexpected times. However, to protect
against general data leakage and system memory corruption, the system needs
to provide a way to restrict the DMA to a predefined memory region (this is
usually done at firmware level, e.g. in ATF on some ARM platforms).

[1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
[1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
[2] https://blade.tencent.com/en/advisories/qualpwn/
[3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/

Claire Chang (6):
  swiotlb: Add io_tlb_mem struct
  swiotlb: Add restricted DMA pool
  swiotlb: Use restricted DMA pool if available
  swiotlb: Add restricted DMA alloc/free support.
  dt-bindings: of: Add restricted DMA pool
  of: Add plumbing for restricted DMA pool

 .../reserved-memory/reserved-memory.txt       |  24 +
 arch/powerpc/platforms/pseries/svm.c          |   4 +-
 drivers/iommu/dma-iommu.c                     |  12 +-
 drivers/of/address.c                          |  21 +
 drivers/of/device.c                           |   4 +
 drivers/of/of_private.h                       |   5 +
 drivers/xen/swiotlb-xen.c                     |   4 +-
 include/linux/device.h                        |   4 +
 include/linux/swiotlb.h                       |  61 +-
 kernel/dma/Kconfig                            |   1 +
 kernel/dma/direct.c                           |  20 +-
 kernel/dma/direct.h                           |  10 +-
 kernel/dma/swiotlb.c                          | 576 +++++++++++-------
 13 files changed, 514 insertions(+), 232 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

v3: 
  Using only one reserved memory region for both streaming DMA and memory
  allocation.

v2:
  Building on top of swiotlb.
  https://lore.kernel.org/patchwork/cover/1280705/

v1:
  Using dma_map_ops.
  https://lore.kernel.org/patchwork/cover/1271660/
