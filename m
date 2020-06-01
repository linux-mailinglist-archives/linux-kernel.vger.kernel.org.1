Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F751E9B0C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 02:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgFAAqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 20:46:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:52794 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFAAqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 20:46:51 -0400
IronPort-SDR: G3m0QKjonjgTIYkhr72rNz7xw9ShYHtexhU8ix5Dcam6wgDjrnwPU/ksxIoy9+vqkdyfz6oYwz
 cQIHRMNe3ZIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 17:46:51 -0700
IronPort-SDR: 0Xs46V2hEIESIwGQjp2CNHkkG0YcMN5J2ulkkFrL9nKOZzgPRRvze8Kt2LuiKHz+CgJJzQZ2WW
 Bqk11Oj8xY7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,458,1583222400"; 
   d="scan'208";a="293005923"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 31 May 2020 17:46:49 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] iommu/vt-d: Two fixes for v5.8
Date:   Mon,  1 Jun 2020 08:42:55 +0800
Message-Id: <20200601004257.15591-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This encloses two fixes for v5.8.
- Make Intel SVM code 64-bit only
- Set U/S bit to make IOVA over first level compatible with 2nd level
  translations.

Best regards,
baolu

Lu Baolu (2):
  iommu/vt-d: Make Intel SVM code 64-bit only
  iommu/vt-d: Set U/S bit in first level page table by default

 drivers/iommu/Kconfig       | 2 +-
 drivers/iommu/intel-iommu.c | 5 ++---
 include/linux/intel-iommu.h | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

