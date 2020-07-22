Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8955229E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 19:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbgGVRVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 13:21:16 -0400
Received: from foss.arm.com ([217.140.110.172]:60068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbgGVRVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:21:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7478ED6E;
        Wed, 22 Jul 2020 10:21:11 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 50F6F3F66F;
        Wed, 22 Jul 2020 10:21:10 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RFC PATCH 14/14] dts: bindings: coresight: ETMv4.4 system register access only units
Date:   Wed, 22 Jul 2020 18:20:40 +0100
Message-Id: <20200722172040.1299289-15-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for ETMv4.4 and later with only system register
access.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index d711676b4a51..cfe47bdda728 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -34,9 +34,13 @@ its hardware characteristcs.
 					Program Flow Trace Macrocell:
 			"arm,coresight-etm3x", "arm,primecell";
 
-		- Embedded Trace Macrocell (version 4.x):
+		- Embedded Trace Macrocell (version 4.x), with memory mapped access.
 			"arm,coresight-etm4x", "arm,primecell";
 
+		- Embedded Trace Macrocell (version 4.4 and later) with system
+		  register access only.
+			"arm,coresight-etm-v4.4";
+
 		- Coresight programmable Replicator :
 			"arm,coresight-dynamic-replicator", "arm,primecell";
 
-- 
2.24.1

