Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1D24FC09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgHXKzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:55:06 -0400
Received: from 8bytes.org ([81.169.241.247]:39226 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgHXKyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:54:19 -0400
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de [79.242.187.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 4380AF3;
        Mon, 24 Aug 2020 12:54:17 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Alexander.Deucher@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Date:   Mon, 24 Aug 2020 12:54:13 +0200
Message-Id: <20200824105415.21000-1-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

Some IOMMUv2 capable devices do not work correctly when SME is
active, because their DMA mask does not include the encryption bit, so
that they can not DMA to encrypted memory directly.

The IOMMU can jump in here, but the AMD IOMMU driver puts IOMMUv2
capable devices into an identity mapped domain. Fix that by not
forcing an identity mapped domain on devices when SME is active and
forbid using their IOMMUv2 functionality.

Please review.

Thanks,

	Joerg

Joerg Roedel (2):
  iommu/amd: Do not force direct mapping when SME is active
  iommu/amd: Do not use IOMMUv2 functionality when SME is active

 drivers/iommu/amd/iommu.c    | 7 ++++++-
 drivers/iommu/amd/iommu_v2.c | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.28.0

