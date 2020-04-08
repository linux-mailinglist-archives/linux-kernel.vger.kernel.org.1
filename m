Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 557F41A2703
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 18:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgDHQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 12:19:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42502 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgDHQTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:19:09 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1jMDPu-000857-4A; Wed, 08 Apr 2020 16:19:06 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ysato@users.sourceforge.jp,
        dalias@libc.org, cascardo@canonical.com
Subject: [PATCH] arch: sh: configs: remove CONFIG_PCIEASPM_DEBUG
Date:   Wed,  8 Apr 2020 13:18:46 -0300
Message-Id: <20200408161846.30031-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option has been removed, so remove any leftover from defconfigs.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 arch/sh/configs/sdk7786_defconfig | 1 -
 arch/sh/configs/urquell_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 7fa116b436c3..3eaf5bbf5959 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -75,7 +75,6 @@ CONFIG_CMDLINE="console=ttySC1,115200 earlyprintk=sh-sci.1,115200 root=/dev/sda1
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCIEAER_INJECT=y
-CONFIG_PCIEASPM_DEBUG=y
 CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index cb2f56468fe0..c981d5b7e68c 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -33,7 +33,6 @@ CONFIG_KEXEC=y
 CONFIG_SECCOMP=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
-CONFIG_PCIEASPM_DEBUG=y
 CONFIG_PCI_DEBUG=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
-- 
2.20.1

