Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9E2534CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHZQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 12:25:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:48816 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgHZQZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:25:07 -0400
IronPort-SDR: wLhH3GsXiLtM7Dw7g97tZklVrXAbRPAwjMpjFPFK52RUdi6ROcmJ8nlUiZxqXToloh+LRta72T
 3GvNFPXWhs/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="155587351"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="155587351"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:25:07 -0700
IronPort-SDR: +3f48vnnlEN1VnODYJrN7hfk1C1uh8Szfi7MIvyRHcQK2JghMgJz6jDS9Zy1s1Yt7FeHh8I+59
 t5rqnwoY+eHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="295426562"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2020 09:24:37 -0700
From:   richard.gong@linux.intel.com
To:     catalin.marinas@arm.com, will@kernel.org, dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCH] arm64: defconfig: include Intel Diamond Mesa platform
Date:   Wed, 26 Aug 2020 11:43:02 -0500
Message-Id: <1598460182-21589-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Include Intel Diamond Mesa SoC platform to the arm64 defconfig so that we
build the Diamond Mesa in the standard arm64 defconfig.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5828b42..8f59626 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -35,6 +35,7 @@ CONFIG_ARCH_BCM2835=y
 CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_BRCMSTB=y
+CONFIG_ARCH_DIAMONDMESA=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_K3=y
 CONFIG_ARCH_LAYERSCAPE=y
-- 
2.7.4

