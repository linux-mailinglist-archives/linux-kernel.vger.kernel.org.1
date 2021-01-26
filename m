Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191C3303C36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404976AbhAZLz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392571AbhAZLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611662027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=tf6SOP1+uSuFzlR74PmLs+Qb9Jg6cZLWh14S6+CIZes=;
        b=MhkV411IRAlYwWWABWXrSaKKYvTCqAsKHZjXfEB7WWPrWljBWI4AFJhu4VES4w5UxHZCCQ
        eWlM9XvZyTjpkRbGGGZ0plB/N7q8q5jaTpVk8dpgYpoOdhUWli5cIDaEgFkBDUoUcYZoZV
        mds9aMP5+whLl9ktPQDB2u9U7bwjsrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-GJ2V3kJMNZOg9DuCyXGLxQ-1; Tue, 26 Jan 2021 06:53:46 -0500
X-MC-Unique: GJ2V3kJMNZOg9DuCyXGLxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A71C5180A096;
        Tue, 26 Jan 2021 11:53:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7095710016F7;
        Tue, 26 Jan 2021 11:53:40 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        jsnitsel@redhat.com, thomas.lendacky@amd.com, robin.murphy@arm.com,
        bhe@redhat.com, hch@infradead.org, baolu.lu@linux.intel.com
Subject: [PATCH v3 0/2] iommu: fix the failure of deferred attach for iommu attach device
Date:   Tue, 26 Jan 2021 19:53:35 +0800
Message-Id: <20210126115337.20068-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Changes since v2:
[1] remove the underscores for the variable "__deferred_attach", and change
its name to iommu_deferred_attach_enabled [Suggested by Christoph Hellwig]
[2] remove the "do_" from the iommu_do_deferred_attach(), and change its
name to iommu_deferred_attach()
[3] remove the "extern" from the definition of iommu_deferred_attach() in
include/linux/iommu.h

Lianbo Jiang (2):
  dma-iommu: use static-key to minimize the impact in the fast-path
  iommu: use the __iommu_attach_device() directly for deferred attach

 drivers/iommu/dma-iommu.c | 29 +++++++++++------------------
 drivers/iommu/iommu.c     | 10 ++++++++++
 include/linux/iommu.h     |  1 +
 3 files changed, 22 insertions(+), 18 deletions(-)

-- 
2.17.1

