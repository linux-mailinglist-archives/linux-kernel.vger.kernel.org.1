Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B312C167E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgKWUYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:24:15 -0500
Received: from foss.arm.com ([217.140.110.172]:41508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbgKWUYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:24:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B486A143D;
        Mon, 23 Nov 2020 12:24:11 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0D483F71F;
        Mon, 23 Nov 2020 12:24:09 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v7 1/3] dt-bindings: arm: remove optional properties for SCMI Regulators
Date:   Mon, 23 Nov 2020 20:23:34 +0000
Message-Id: <20201123202336.46701-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123202336.46701-1-cristian.marussi@arm.com>
References: <20201123202336.46701-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove optional properties bindings descriptions for SCMI Regulators.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/devicetree/bindings/arm/arm,scmi.txt | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 6e011ca97079..b5ce5b39bb9c 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -71,20 +71,11 @@ It does not support any current operation.
 SCMI Regulators are grouped under a 'regulators' node which in turn is a child
 of the SCMI Voltage protocol node inside the desired SCMI instance node.
 
-This binding uses the common regulator binding[6] but, due to SCMI abstractions,
-supports only a subset of its properties as specified below amongst Optional
-properties.
+This binding uses the common regulator binding[6].
 
 Required properties:
  - reg : shall identify an existent SCMI Voltage Domain.
 
-Optional properties:
- - regulator-name
- - regulator-min-microvolt / regulator-max-microvolt
- - regulator-always-on / regulator-boot-on
- - regulator-max-step-microvolt
- - regulator-coupled-with / regulator-coupled-max-spread
-
 Sensor bindings for the sensors based on SCMI Message Protocol
 --------------------------------------------------------------
 SCMI provides an API to access the various sensors on the SoC.
-- 
2.17.1

