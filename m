Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382641EE991
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbgFDRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 13:39:51 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:39614 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730106AbgFDRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:39:51 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F142340033;
        Thu,  4 Jun 2020 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1591292391; bh=tWJlApZxqBzjb/+xC+Wsb7tJswMq+Z5yDSEHjqk8DOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvI9B+FN/mD2zSjKM4netyet9+KJ31lGrXFlLbNnbVtOalJbAB/Aa/doYSau5DRD2
         PmvEgB1cVZ0bcx1d4xESUxmfx39JmSeZ0qyR5dE1PSDqRKkbk/61GXlw2NrWn89yRB
         91Cp4IqDUz8mCqSu3iFEKFB6Bitv+/8l0RvpDdUe5CLX7+Y4+5pBfzY5+6cpnDyusg
         GT+0wsTi+BGglnILKtPMYcrwAhR+rX7MzHUVIOtLSZp/7IGiLUFSKsDMLt+LcrQhwB
         AQInEcB3A+q1ITm/4STsOPN35bm5z4K9csaAf9x+FPvozcEbXZo2y3YRuzSVpsdaHq
         Y4WdC4ChTEQhg==
Received: from paltsev-e7480.internal.synopsys.com (ru20-e7250.internal.synopsys.com [10.225.49.234])
        by mailhost.synopsys.com (Postfix) with ESMTP id 36888A0061;
        Thu,  4 Jun 2020 17:39:49 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 1/4] ARC: allow to override default mcpu compiler flag
Date:   Thu,  4 Jun 2020 20:39:24 +0300
Message-Id: <20200604173927.23127-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200604173927.23127-1-Eugeniy.Paltsev@synopsys.com>
References: <20200604173927.23127-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel builds set their own default -mcpu for a given ISA build.
But that gets in the way of "custom" -mcpu flags from propagating
into kernel build.

This will also be used in next patches for HSDK-4xD board support which
uses a different -mcpu to effect dual issue scheduling.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig  |  9 +++++++++
 arch/arc/Makefile | 21 +++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index ff306246d0f8..7034c217708f 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -377,6 +377,15 @@ config ARC_HAS_SWAPE
 	bool "Insn: SWAPE (endian-swap)"
 	default y
 
+config ARC_TUNE_MCPU
+	string "Override default -mcpu compiler flag"
+	default ""
+	help
+	  Override default -mcpu=xxx compiler flag (which is set depending on
+	  the ISA version) with the specified value.
+	  NOTE: If specified flag isn't supported by current compiler the
+	  ISA default value will be used as a fallback.
+
 if ISA_ARCV2
 
 config ARC_USE_UNALIGNED_MEM_ACCESS
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 20e9ab6cc521..2b66e8264174 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -10,8 +10,25 @@ CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
 endif
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
-cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
-cflags-$(CONFIG_ISA_ARCV2)	+= -mcpu=hs38
+
+tune-mcpu-def-$(CONFIG_ISA_ARCOMPACT)	:= -mA7
+tune-mcpu-def-$(CONFIG_ISA_ARCV2)	:= -mcpu=hs38
+
+ifeq ($(CONFIG_ARC_TUNE_MCPU),"")
+cflags-y				+= $(tune-mcpu-def-y)
+else
+tune-mcpu				:= $(shell echo $(CONFIG_ARC_TUNE_MCPU))
+tune-mcpu-ok 				:= $(call cc-option-yn, $(tune-mcpu))
+ifeq ($(tune-mcpu-ok),y)
+cflags-y				+= $(tune-mcpu)
+else
+# The flag provided by 'CONFIG_ARC_TUNE_MCPU' option isn't known by this compiler
+# (probably the compiler is too old). Use ISA default mcpu flag instead as a safe option.
+$(warning ** WARNING ** CONFIG_ARC_TUNE_MCPU flag '$(tune-mcpu)' is unknown, fallback to '$(tune-mcpu-def-y)')
+cflags-y				+= $(tune-mcpu-def-y)
+endif
+endif
+
 
 ifdef CONFIG_ARC_CURR_IN_REG
 # For a global register defintion, make sure it gets passed to every file
-- 
2.21.3

