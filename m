Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C68298CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775086AbgJZM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:26:30 -0400
Received: from newton.telenet-ops.be ([195.130.132.45]:38006 "EHLO
        newton.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775080AbgJZM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:26:29 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by newton.telenet-ops.be (Postfix) with ESMTPS id 4CKYwc4KBlzMqwWK
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 13:26:24 +0100 (CET)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id kcSQ2300G4C55Sk06cSQG8; Mon, 26 Oct 2020 13:26:24 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kX1Zv-000IKK-VM; Mon, 26 Oct 2020 13:26:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kX1Zv-00CyYL-5i; Mon, 26 Oct 2020 13:26:23 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Enable KUnit tests
Date:   Mon, 26 Oct 2020 13:26:22 +0100
Message-Id: <20201026122622.3092658-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable KUnit and all KUnit tests for modular builds, so they are
available when needed, just like non-KUnit tests.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued for v5.11.

 arch/m68k/configs/amiga_defconfig    | 5 +++++
 arch/m68k/configs/apollo_defconfig   | 5 +++++
 arch/m68k/configs/atari_defconfig    | 5 +++++
 arch/m68k/configs/bvme6000_defconfig | 5 +++++
 arch/m68k/configs/hp300_defconfig    | 5 +++++
 arch/m68k/configs/mac_defconfig      | 5 +++++
 arch/m68k/configs/multi_defconfig    | 5 +++++
 arch/m68k/configs/mvme147_defconfig  | 5 +++++
 arch/m68k/configs/mvme16x_defconfig  | 5 +++++
 arch/m68k/configs/q40_defconfig      | 5 +++++
 arch/m68k/configs/sun3_defconfig     | 5 +++++
 arch/m68k/configs/sun3x_defconfig    | 5 +++++
 12 files changed, 60 insertions(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 8fc77002f074c30b..19b40b6bc4b7f4d9 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -626,6 +626,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -652,6 +654,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index f84cd9b20b9dcea3..07516abe04898d3d 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -582,6 +582,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -608,6 +610,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index fd89ad1e50a001cb..5e9ebd8590527801 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -611,6 +611,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -637,6 +639,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index b5b6f25dbff36a02..fc9a94aa7d6b1b70 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -575,6 +575,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -601,6 +603,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 016f6708b8511f23..260f1206c81030fa 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -584,6 +584,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -610,6 +612,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 2e03fd20b79c459c..f6d50b3fe8c207d4 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -607,6 +607,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -633,6 +635,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 50c087e9e3fe6937..fbe000ca0003f9ea 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -693,6 +693,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -719,6 +721,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 884b413dbbeab4d1..25ca836a5701fe0a 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -574,6 +574,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -600,6 +602,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 45cccbb5f068eb92..5794e43a2acb0543 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -575,6 +575,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -601,6 +603,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 4b66b5b185bc1b52..dbfb18938e11e219 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -593,6 +593,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -619,6 +621,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 243f5d5dfa44175b..e6afbeee7c4abc38 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -576,6 +576,8 @@ CONFIG_STRING_SELFTEST=m
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -602,6 +604,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 2553db10a7e9b08b..5340507a9fff26b1 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -576,6 +576,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
+CONFIG_KUNIT=m
+CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
@@ -602,6 +604,9 @@ CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
 CONFIG_TEST_FIRMWARE=m
 CONFIG_TEST_SYSCTL=m
+CONFIG_BITFIELD_KUNIT=m
+CONFIG_LINEAR_RANGES_TEST=m
+CONFIG_BITS_TEST=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
-- 
2.25.1

