Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E861A2237B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 11:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGQJFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 05:05:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:64984 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgGQJFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:05:00 -0400
IronPort-SDR: xoHGptk/QKHNv73gbTeQzFeleWKobYv7tG7crfjG+9GrffhAb0nl4Qv4cYfOz20I/DI82j5c7u
 ObSG+Mw+gwQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148719468"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="148719468"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:04:49 -0700
IronPort-SDR: Ozvr0O97Z8JSQJ2Hs4sMfWq8HOfXPthRhQ35SbQjkRuPWl355oAO3BhvEYdwtyf1o3SrHbZpxp
 Mu7PDwfaQGSA==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460786106"
Received: from enaessen-mobl1.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.251.86.9])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:04:44 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v4 3/5] MAINTAINERS: Add maintainers for Keem Bay SoC
Date:   Fri, 17 Jul 2020 10:04:12 +0100
Message-Id: <20200717090414.313530-4-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717090414.313530-1-daniele.alessandrelli@linux.intel.com>
References: <20200717090414.313530-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add maintainers for the new Intel Movidius SoC code-named Keem Bay.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4a43a9e7fbc..3babb333b556 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1954,6 +1954,12 @@ F:	drivers/irqchip/irq-ixp4xx.c
 F:	include/linux/irqchip/irq-ixp4xx.h
 F:	include/linux/platform_data/timer-ixp4xx.h
 
+ARM/INTEL KEEMBAY ARCHITECTURE
+M:	Paul J. Murphy <paul.j.murphy@intel.com>
+M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/intel,keembay.yaml
+
 ARM/INTEL RESEARCH IMOTE/STARGATE 2 MACHINE SUPPORT
 M:	Jonathan Cameron <jic23@cam.ac.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.26.2

