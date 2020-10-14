Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A9A28E2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbgJNPHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:07:16 -0400
Received: from foss.arm.com ([217.140.110.172]:50936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731642AbgJNPHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:07:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7127913D5;
        Wed, 14 Oct 2020 08:07:08 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C04583F71F;
        Wed, 14 Oct 2020 08:07:06 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 08/11] [DEBUG] arm64: dts: juno: add example custom protocol support
Date:   Wed, 14 Oct 2020 16:05:42 +0100
Message-Id: <20201014150545.44807-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014150545.44807-1-cristian.marussi@arm.com>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an example custom protocol 0x99 support.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index dd20a5242c45..85a45a536bbf 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -598,6 +598,10 @@
 				reg = <0x15>;
 				#thermal-sensor-cells = <1>;
 			};
+
+			scmi_custom99: protocol@99 {
+				reg = <0x99>;
+			};
 		};
 	};
 
-- 
2.17.1

