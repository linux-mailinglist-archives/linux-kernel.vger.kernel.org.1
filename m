Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A1B1C4092
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 18:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgEDQ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 12:56:20 -0400
Received: from foss.arm.com ([217.140.110.172]:49268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbgEDQ4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:56:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0917F113E;
        Mon,  4 May 2020 09:56:15 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC3F3F68F;
        Mon,  4 May 2020 09:56:13 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v2 3/3] arm64: dts: juno: add SCMI SystemPower Protocol support
Date:   Mon,  4 May 2020 17:55:40 +0100
Message-Id: <20200504165540.37188-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504165540.37188-1-cristian.marussi@arm.com>
References: <20200504165540.37188-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64: dts: juno: add SCMI SystemPower Protocol support

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index af451935146e..ffb429120a13 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -581,6 +581,10 @@
 				#power-domain-cells = <1>;
 			};
 
+			scmi_system: protocol@12 {
+				reg = <0x12>;
+			};
+
 			scmi_dvfs: protocol@13 {
 				reg = <0x13>;
 				#clock-cells = <1>;
-- 
2.17.1

