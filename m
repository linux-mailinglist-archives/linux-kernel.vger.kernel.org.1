Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C51F7BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 18:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFLQrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 12:47:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:59046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgFLQrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:47:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D502AAC7;
        Fri, 12 Jun 2020 16:47:28 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 3/5] configs: Enable support for reset controllers on RPi4
Date:   Fri, 12 Jun 2020 18:46:31 +0200
Message-Id: <20200612164632.25648-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612164632.25648-1-nsaenzjulienne@suse.de>
References: <20200612164632.25648-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required in order to access the reset controller used to
initialize the board's xHCI chip.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 configs/rpi_4_32b_defconfig | 1 +
 configs/rpi_4_defconfig     | 1 +
 configs/rpi_arm64_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/rpi_4_32b_defconfig b/configs/rpi_4_32b_defconfig
index b0797373b5..00c8d963ab 100644
--- a/configs/rpi_4_32b_defconfig
+++ b/configs/rpi_4_32b_defconfig
@@ -35,6 +35,7 @@ CONFIG_DM_PCI=y
 CONFIG_PCI_BRCMSTB=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
+CONFIG_DM_RESET=y
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
 CONFIG_USB=y
 CONFIG_DM_USB=y
diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
index 932b768164..c73eccb61c 100644
--- a/configs/rpi_4_defconfig
+++ b/configs/rpi_4_defconfig
@@ -35,6 +35,7 @@ CONFIG_DM_PCI=y
 CONFIG_PCI_BRCMSTB=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
+CONFIG_DM_RESET=y
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
 CONFIG_USB=y
 CONFIG_DM_USB=y
diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 855afcf1cf..800b51e6f5 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -32,6 +32,7 @@ CONFIG_DM_PCI=y
 CONFIG_PCI_BRCMSTB=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
+CONFIG_DM_RESET=y
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
 CONFIG_USB=y
 CONFIG_DM_USB=y
-- 
2.26.2

