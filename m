Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70A2ED025
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbhAGMmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:42:32 -0500
Received: from foss.arm.com ([217.140.110.172]:59986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbhAGMle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:41:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1387E153B;
        Thu,  7 Jan 2021 04:39:47 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFA1C3F719;
        Thu,  7 Jan 2021 04:39:45 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 24/26] dts: bindings: coresight: ETM system register access only units
Date:   Thu,  7 Jan 2021 12:38:57 +0000
Message-Id: <20210107123859.674252-25-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210107123859.674252-1-suzuki.poulose@arm.com>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
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

