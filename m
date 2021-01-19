Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C92FB7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389802AbhASLca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:32:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730743AbhASLSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611054988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=prchNfDbXNCFUPpFnz6BKtCHGpSZan3ogM0IdWmrA6A=;
        b=gVwkiY3xY0jk77n1LGZUqEIJ+QEk43yzwCOg4hOLwzSFST3/GDrX8H7ww/O7Xpi+ZRne7q
        pAj1he2WSz5O2koKTWqQ15gozHSWK4eMh4a3ZeECS++J2g4NjlKnjolTe42WM1m+aGgXGj
        6C+vOkokZJbvUx6b1aoa0VcQOFPd9Tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-XNmkh8scP7mYNZInh_xJjA-1; Tue, 19 Jan 2021 06:16:24 -0500
X-MC-Unique: XNmkh8scP7mYNZInh_xJjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70610802B45;
        Tue, 19 Jan 2021 11:16:23 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ED0D36FA;
        Tue, 19 Jan 2021 11:16:19 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        jsnitsel@redhat.com, thomas.lendacky@amd.com, robin.murphy@arm.com,
        bhe@redhat.com
Subject: [PATCH 0/2 v2] iommu: fix the failure of deferred attach for iommu attach device
Date:   Tue, 19 Jan 2021 19:16:14 +0800
Message-Id: <20210119111616.12761-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to fix the failure of deferred attach for iommu attach
device, it includes the following two patches:

[1] [PATCH 1/2] dma-iommu: use static-key to minimize the impact in the fast-path
    This is a prepared patch for the second one, move out the is_kdump_kernel()
    check from iommu_dma_deferred_attach() to iommu_dma_init(), and use the
    static-key in the fast-path to minimize the impact in the normal case.

[2] [PATCH 2/2] iommu: use the __iommu_attach_device() directly for deferred attach
    Move the handling currently in iommu_dma_deferred_attach() into the
    iommu core code so that it can call the __iommu_attach_device()
    directly instead of the iommu_attach_device(). The external interface
    iommu_attach_device() is not suitable for handling this situation.

Changes since v1:
[1] use the __iommu_attach_device() directly for deferred attach
[2] use static-key to minimize the impact in the fast-path

Lianbo Jiang (2):
  dma-iommu: use static-key to minimize the impact in the fast-path
  iommu: use the __iommu_attach_device() directly for deferred attach

 drivers/iommu/dma-iommu.c | 29 +++++++++++------------------
 drivers/iommu/iommu.c     | 12 ++++++++++++
 include/linux/iommu.h     |  2 ++
 3 files changed, 25 insertions(+), 18 deletions(-)

-- 
2.17.1

