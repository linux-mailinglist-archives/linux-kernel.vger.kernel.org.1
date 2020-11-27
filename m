Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360E02C69A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbgK0QmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbgK0QmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:42:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700C9C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:41:58 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so7069254wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESkSp6C7mvKV6tnu0bv0a5NUd9H7UZA/j9+KxBk62a8=;
        b=jQ8QYtZGE95X+kQNlT31arGz3fYSGvIwxc8CIQGHUAFqEsxjgCe3vvJrRkP5zcoBFd
         kyw+1PRtr/v1Vnaw3uyD+fyAim2cfgkJDD5Q3S0vbKD9lObKqNzb5ybH/JvOzGAGkiei
         EIiVoJbv/O7eYs/rJVz+0K/a9SqrRGH8KrGbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESkSp6C7mvKV6tnu0bv0a5NUd9H7UZA/j9+KxBk62a8=;
        b=GvC5SSy3SCQfUK8YJJaXXNgJxznDSSmoXFoal/8GROiVNcqRT8z2RRHIqwHnGUPTw/
         A8ba2r5TWp2LmPbTPqyj+SFT9F774fyd7N53QGvA9mKRMEgOqyJr8Ufl/savse8BqYBL
         C50+YeawDQQFc5DMJmR6sIqWkoa0bEWAXQldiBane3YRDkgPVVfboEefkn57NcuMVzLU
         kGiICw4vOcxl6CUKmRMu/+q75a4qKgxDkx7xca+wcYawE/94VhGR6k/zwGQCDCMDn68S
         PtH+eDSQhqjxw8t+XNzv7ciZznlKGCrCXm2YuSNUklDBYRpZ9wyU5SDN1JNU2l4nXwYK
         jdbw==
X-Gm-Message-State: AOAM530kegtTMDCd6nfTqMNFdfXOxxs9DCbmk+faYFb6I9lKFHL5VfxB
        b1z5MKFDLZWUFRBqARr/6zvKhQ==
X-Google-Smtp-Source: ABdhPJy6H3y4sUz3l7M4JNsS6NM9YkD0oMXLhvCp0ba6p25GYS5KJlvCz2mFh2Zqh4wJSE93buN0qg==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr10199588wmc.172.1606495316997;
        Fri, 27 Nov 2020 08:41:56 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q12sm14859078wrx.86.2020.11.27.08.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:41:56 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v7 00/17] follow_pfn and other iomap races
Date:   Fri, 27 Nov 2020 17:41:14 +0100
Message-Id: <20201127164131.2244124-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Another update of my patch series to clamp down a bunch of races and gaps
around follow_pfn and other access to iomem mmaps. Previous version:

v1: https://lore.kernel.org/dri-devel/20201007164426.1812530-1-daniel.vetter@ffwll.ch/
v2: https://lore.kernel.org/dri-devel/20201009075934.3509076-1-daniel.vetter@ffwll.ch
v3: https://lore.kernel.org/dri-devel/20201021085655.1192025-1-daniel.vetter@ffwll.ch/
v4: https://lore.kernel.org/dri-devel/20201026105818.2585306-1-daniel.vetter@ffwll.ch/
v5: https://lore.kernel.org/dri-devel/20201030100815.2269-1-daniel.vetter@ffwll.ch/
v6: https://lore.kernel.org/dri-devel/20201119144146.1045202-1-daniel.vetter@ffwll.ch/

And the discussion that sparked this journey:

https://lore.kernel.org/dri-devel/20201007164426.1812530-1-daniel.vetter@ffwll.ch/

I think the first 12 patches are ready for landing. The parts starting
with "mm: Add unsafe_follow_pfn" probably need more baking time.

Andrew, can you please pick these up, or do you prefer I do a topic branch
and send them to Linus directly in the next merge window?

Changes in v7:
- more acks/reviews
- reordered with the ready pieces at the front
- simplified the new follow_pfn function as Jason suggested

Changes in v6:
- Tested v4l userptr as Tomasz suggested. No boom observed
- Added RFC for locking down follow_pfn, per discussion with Christoph and
  Jason.
- Explain why pup_fast is safe in relevant patches, there was a bit a
  confusion when discussing v5.
- Fix up the resource patch, with CONFIG_IO_STRICT_DEVMEM it crashed on
  boot due to an unintended change (reported by John)

Changes in v5:
- Tomasz found some issues in the media patches
- Polish suggested by Christoph for the unsafe_follow_pfn patch

Changes in v4:
- Drop the s390 patch, that was very stand-alone and now queued up to land
  through s390 trees.
- Comment polish per Dan's review.

Changes in v3:
- Bunch of polish all over, no functional changes aside from one barrier
  in the resource code, for consistency.
- A few more r-b tags.

Changes in v2:
- tons of small polish&fixes all over, thanks to all the reviewers who
  spotted issues
- I managed to test at least the generic_access_phys and pci mmap revoke
  stuff with a few gdb sessions using our i915 debug tools (hence now also
  the drm/i915 patch to properly request all the pci bar regions)
- reworked approach for the pci mmap revoke: Infrastructure moved into
  kernel/resource.c, address_space mapping is now set up at open time for
  everyone (which required some sysfs changes). Does indeed look a lot
  cleaner and a lot less invasive than I feared at first.

Coments and review on the remaining bits very much welcome, especially
from the kvm and vfio side.

Cheers, Daniel

Daniel Vetter (17):
  drm/exynos: Stop using frame_vector helpers
  drm/exynos: Use FOLL_LONGTERM for g2d cmdlists
  misc/habana: Stop using frame_vector helpers
  misc/habana: Use FOLL_LONGTERM for userptr
  mm/frame-vector: Use FOLL_LONGTERM
  media: videobuf2: Move frame_vector into media subsystem
  mm: Close race in generic_access_phys
  PCI: Obey iomem restrictions for procfs mmap
  /dev/mem: Only set filp->f_mapping
  resource: Move devmem revoke code to resource framework
  sysfs: Support zapping of binary attr mmaps
  PCI: Revoke mappings like devmem
  mm: Add unsafe_follow_pfn
  media/videobuf1|2: Mark follow_pfn usage as unsafe
  vfio/type1: Mark follow_pfn as unsafe
  kvm: pass kvm argument to follow_pfn callsites
  mm: add mmu_notifier argument to follow_pfn

 arch/powerpc/kvm/book3s_64_mmu_hv.c           |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c        |   2 +-
 arch/powerpc/kvm/e500_mmu_host.c              |   2 +-
 arch/x86/kvm/mmu/mmu.c                        |   8 +-
 drivers/char/mem.c                            |  86 +-------------
 drivers/gpu/drm/exynos/Kconfig                |   1 -
 drivers/gpu/drm/exynos/exynos_drm_g2d.c       |  48 ++++----
 drivers/media/common/videobuf2/Kconfig        |   1 -
 drivers/media/common/videobuf2/Makefile       |   1 +
 .../media/common/videobuf2}/frame_vector.c    |  57 ++++-----
 .../media/common/videobuf2/videobuf2-memops.c |   3 +-
 drivers/media/platform/omap/Kconfig           |   1 -
 drivers/media/v4l2-core/videobuf-dma-contig.c |   2 +-
 drivers/misc/habanalabs/Kconfig               |   1 -
 drivers/misc/habanalabs/common/habanalabs.h   |   6 +-
 drivers/misc/habanalabs/common/memory.c       |  52 +++-----
 drivers/pci/pci-sysfs.c                       |   4 +
 drivers/pci/proc.c                            |   6 +
 drivers/vfio/vfio_iommu_type1.c               |   4 +-
 fs/sysfs/file.c                               |  11 ++
 include/linux/ioport.h                        |   6 +-
 include/linux/kvm_host.h                      |   9 +-
 include/linux/mm.h                            |  50 +-------
 include/linux/sysfs.h                         |   2 +
 include/media/frame_vector.h                  |  47 ++++++++
 include/media/videobuf2-core.h                |   1 +
 kernel/resource.c                             |  98 ++++++++++++++-
 mm/Kconfig                                    |   3 -
 mm/Makefile                                   |   1 -
 mm/memory.c                                   | 112 +++++++++++++++---
 mm/nommu.c                                    |  16 ++-
 security/Kconfig                              |  13 ++
 virt/kvm/kvm_main.c                           |  56 +++++----
 33 files changed, 413 insertions(+), 299 deletions(-)
 rename {mm => drivers/media/common/videobuf2}/frame_vector.c (84%)
 create mode 100644 include/media/frame_vector.h

-- 
2.29.2

