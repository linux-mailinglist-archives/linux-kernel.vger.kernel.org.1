Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CAC2F0A20
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbhAJWvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:51:12 -0500
Received: from foss.arm.com ([217.140.110.172]:39080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbhAJWu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:50:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09DFC1597;
        Sun, 10 Jan 2021 14:49:43 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 70F733F719;
        Sun, 10 Jan 2021 14:49:41 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v7 26/28] dts: bindings: coresight: ETM system register access only units
Date:   Sun, 10 Jan 2021 22:48:48 +0000
Message-Id: <20210110224850.1880240-27-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for ETMs with system register accesses.

Cc: devicetree@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index d711676b4a51..7f9c1ca87487 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -34,9 +34,12 @@ its hardware characteristcs.
 					Program Flow Trace Macrocell:
 			"arm,coresight-etm3x", "arm,primecell";
 
-		- Embedded Trace Macrocell (version 4.x):
+		- Embedded Trace Macrocell (version 4.x), with memory mapped access.
 			"arm,coresight-etm4x", "arm,primecell";
 
+		- Embedded Trace Macrocell (version 4.x), with system register access only.
+			"arm,coresight-etm4x-sysreg";
+
 		- Coresight programmable Replicator :
 			"arm,coresight-dynamic-replicator", "arm,primecell";
 
-- 
2.24.1

