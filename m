Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149812EAE1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhAEPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:20:46 -0500
Received: from foss.arm.com ([217.140.110.172]:56048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbhAEPUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:20:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B9461FB;
        Tue,  5 Jan 2021 07:20:00 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CA8F3F70D;
        Tue,  5 Jan 2021 07:19:59 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] MAINTAINERS: Update ARM SCMI entry
Date:   Tue,  5 Jan 2021 15:19:45 +0000
Message-Id: <20210105151945.406093-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cristian is actively developing new features and more involved than me.
So add Cristian as a designated reviewer. Also add the newly added scmi
regulator driver to the list.

Cc: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..34e09b55f806 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17208,6 +17208,7 @@ F:	drivers/mfd/syscon.c
 
 SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI) Message Protocol drivers
 M:	Sudeep Holla <sudeep.holla@arm.com>
+R:	Cristian Marussi <cristian.marussi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/arm,sc[mp]i.txt
@@ -17215,6 +17216,7 @@ F:	drivers/clk/clk-sc[mp]i.c
 F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/firmware/arm_scpi.c
+F:	drivers/regulator/scmi-regulator.c
 F:	drivers/reset/reset-scmi.c
 F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
-- 
2.25.1

