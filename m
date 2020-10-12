Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0128B4A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgJLMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388334AbgJLMbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:31:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81EC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 05:31:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e18so18964122wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvIZCy8+uyG7PlFqYpqlAdUF/vTk3X+HzF3V0T1VljQ=;
        b=CqyWnOKRUBw/Boxzc/3KtKSNAH6ni3OI/OFYvkdZluHArK5KZwePxrUUlxyYaLFSBD
         vCjQsVLLNHxs4L5K9N+J0DE1oYycFmVIyXG+DVnE4sfzmNGwRTtLoOtWBtyInpmquJ59
         IpyFj0YmyWVa0ZM9dP3oaCFjnqX1B8Lr1Df8k2afgovNm3+dcYmFK9xdLoF5Qhwx0Xcg
         Y+7SKm3sm9Mmkxk+asWaYAE9srvIKntsbamoUhgF066LAchmlrLae9MiFXpEy6M7jYwS
         qkFa2iUz8SWKFor3BtFIoWuIE9MJqo4pJ1TETNZnj+Df1hG0ZENJbBLvaSauiIb2OnrM
         rfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvIZCy8+uyG7PlFqYpqlAdUF/vTk3X+HzF3V0T1VljQ=;
        b=AQ3DQSbtef1tMw3nNZ+z8AbKDrseLsKgGxSJNk+vnp0yoPsI+A/pmOA+uAqsL8SIdQ
         QZFo1P2eCq68dg0ZacsdVI6Iw9sol2mJpBriL4SWXkvSsmKcOD7W4CTU+DEEhaQi6ajO
         0tZcc6rddavV8h2iCwAULvBc9iwS8nHUTkec4GptGsItKx6kz1VR3pbEHmwkmsTYB7zH
         SZpBUEAgdVIlk8//J5LodAFC4R7Fi1tKNmUrWdH5qEG6Zwr94IM4K7odly9rfFwda97h
         29wvDZ+B2Ok3eYzUbJw2vrQWDQtjyePTE1ymXwOIfnFKncAaLx6AxyNKqQHdQNUZv2SL
         WKLw==
X-Gm-Message-State: AOAM533e6k8SaYTgeeUoDSjO59fVOlrOpV8awMwoS+b0GLxugnFwvvGo
        OQ8hjUcj3KgTxa+lxWxHIO+zOw4FSDY62w==
X-Google-Smtp-Source: ABdhPJyXrQMqvFC6DcpILZj94c1CmBX8YBtmQtfWHr/g3npQmL7PmVc15eqRA2+Qfrn+J6C8S5sWqQ==
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr30672263wrg.191.1602505868361;
        Mon, 12 Oct 2020 05:31:08 -0700 (PDT)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id b25sm20408235wmj.21.2020.10.12.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 05:31:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH next] iommu: intel: make DMAR_TABLE select IOMMU_API
Date:   Mon, 12 Oct 2020 14:31:05 +0200
Message-Id: <20201012123105.32652-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units
with no supported address widths") dmar.c needs struct iommu_device to
be defined. We need to unconditionally select IOMMU_API when DMAR_TABLE
is selected. This fixes the following build error when IOMMU_API is not
selected:

drivers/iommu/intel/dmar.c: In function ‘free_iommu’:
drivers/iommu/intel/dmar.c:1139:41: error: ‘struct iommu_device’ has no member named ‘ops’
 1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {
                                                ^

Fixes: c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units with no supported address widths")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iommu/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 5337ee1584b0..f814b7585ba8 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Intel IOMMU support
 config DMAR_TABLE
+	select IOMMU_API
 	bool
 
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64)
 	select DMA_OPS
-	select IOMMU_API
 	select IOMMU_IOVA
 	select NEED_DMA_MAP_STATE
 	select DMAR_TABLE
-- 
2.28.0

