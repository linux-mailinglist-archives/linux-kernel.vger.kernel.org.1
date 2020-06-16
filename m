Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267BA1FBB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgFPQVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 12:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgFPQVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:21:54 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A049F208B3;
        Tue, 16 Jun 2020 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592324514;
        bh=NR6ahzTNv1ieUWE7AOaToTgXp6Hy0HbPS7DMknb6DaA=;
        h=From:To:Cc:Subject:Date:From;
        b=wqluUxciBtaOIKYINOaHBdwsYeI1hEKWJbiyMarlyVyYHW5uOeVD+OcuFss1I729f
         AUbzlEN4J2urdDIbNuuzJuW85Cz2RHTc2qYxnM7V1Qur2doEP+HvxkGjNYwGs6Psrt
         gnlEp7DQiYX+EfrqLnq/LYM318NnpAY84Z1Crico=
From:   Vinod Koul <vkoul@kernel.org>
To:     alsa-devel@alsa-project.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soundwire: Replace 'objs' by 'y'
Date:   Tue, 16 Jun 2020 21:51:40 +0530
Message-Id: <20200616162140.2563535-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`-objs` is designed for building host programs, change to `-y`,
more straightforward for device drivers.

See Documentation/kbuild/makefiles.rst

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index b5871612613b..7c53ffae9f50 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -4,22 +4,22 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o stream.o  \
+soundwire-bus-y := bus_type.o bus.o master.o slave.o mipi_disco.o stream.o  \
 			sysfs_slave.o sysfs_slave_dpn.o
 obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
 
 ifdef CONFIG_DEBUG_FS
-soundwire-bus-objs += debugfs.o
+soundwire-bus-y += debugfs.o
 endif
 
 #Cadence Objs
-soundwire-cadence-objs := cadence_master.o
+soundwire-cadence-y := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
 
 #Intel driver
-soundwire-intel-objs :=	intel.o intel_init.o
+soundwire-intel-y :=	intel.o intel_init.o
 obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 
 #Qualcomm driver
-soundwire-qcom-objs :=	qcom.o
+soundwire-qcom-y :=	qcom.o
 obj-$(CONFIG_SOUNDWIRE_QCOM) += soundwire-qcom.o
-- 
2.26.2

