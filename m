Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056382E35F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 11:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgL1KnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 05:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgL1KnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 05:43:20 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78992C061795
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 02:42:40 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id 9mid2400T4C55Sk06midRb; Mon, 28 Dec 2020 11:42:37 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ktpz3-000hB7-Cw; Mon, 28 Dec 2020 11:42:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ktpz2-005xiH-SJ; Mon, 28 Dec 2020 11:42:36 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v5.11-rc1
Date:   Mon, 28 Dec 2020 11:42:32 +0100
Message-Id: <20201228104232.1421134-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Enable modular build of netfilter nf_tables netdev REJECT support,
  - Enable modular build of the resource and cmdline API unit tests.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued for v5.12.

 arch/m68k/configs/amiga_defconfig    | 3 +++
 arch/m68k/configs/apollo_defconfig   | 3 +++
 arch/m68k/configs/atari_defconfig    | 3 +++
 arch/m68k/configs/bvme6000_defconfig | 3 +++
 arch/m68k/configs/hp300_defconfig    | 3 +++
 arch/m68k/configs/mac_defconfig      | 3 +++
 arch/m68k/configs/multi_defconfig    | 3 +++
 arch/m68k/configs/mvme147_defconfig  | 3 +++
 arch/m68k/configs/mvme16x_defconfig  | 3 +++
 arch/m68k/configs/q40_defconfig      | 3 +++
 arch/m68k/configs/sun3_defconfig     | 3 +++
 arch/m68k/configs/sun3x_defconfig    | 3 +++
 12 files changed, 36 insertions(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 19b40b6bc4b7f4d9..786656090c502956 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -128,6 +128,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -655,7 +656,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 07516abe04898d3d..9bb12be4a38e8a36 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -124,6 +124,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -611,7 +612,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index c61e5d015d1d0bcc..47b911cca9a39ad6 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -131,6 +131,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -644,7 +645,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index fc9a94aa7d6b1b70..819cc70b06d8663d 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -121,6 +121,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -604,7 +605,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 260f1206c81030fa..8f8d5968713bfe2d 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -123,6 +123,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -613,7 +614,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index f6d50b3fe8c207d4..bf15e6c1c939bb30 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -122,6 +122,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -636,7 +637,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index fbe000ca0003f9ea..5466d48fcd9d51c9 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -142,6 +142,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -722,7 +723,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 25ca836a5701fe0a..93c3059188389742 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -120,6 +120,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -603,7 +604,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 5794e43a2acb0543..cacd6c617f6951ee 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -121,6 +121,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -604,7 +605,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index dbfb18938e11e219..3ae421cb24a43986 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -122,6 +122,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -622,7 +623,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index e6afbeee7c4abc38..6da97e28c48ef66e 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -118,6 +118,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -605,7 +606,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 5340507a9fff26b1..f54481bb789aecb8 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -118,6 +118,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_DUP_NETDEV=m
 CONFIG_NFT_FWD_NETDEV=m
 CONFIG_NFT_FIB_NETDEV=m
+CONFIG_NFT_REJECT_NETDEV=m
 CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NETFILTER_XT_SET=m
@@ -605,7 +606,9 @@ CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
 CONFIG_BITFIELD_KUNIT=m
+CONFIG_RESOURCE_KUNIT_TEST=m
 CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_CMDLINE_KUNIT_TEST=m
 CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
-- 
2.25.1

