Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B912203A85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 17:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgFVPSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 11:18:36 -0400
Received: from foss.arm.com ([217.140.110.172]:43206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729371AbgFVPSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:18:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E42611B3;
        Mon, 22 Jun 2020 08:18:33 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1D6E3F6CF;
        Mon, 22 Jun 2020 08:18:31 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v3 3/3] arm64: dts: juno: add SCMI SystemPower Protocol support
Date:   Mon, 22 Jun 2020 16:18:16 +0100
Message-Id: <20200622151816.15491-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622151816.15491-1-cristian.marussi@arm.com>
References: <20200622151816.15491-1-cristian.marussi@arm.com>
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
index dd20a5242c45..41e602ce71e2 100644
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

