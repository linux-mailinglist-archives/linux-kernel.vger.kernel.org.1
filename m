Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821232D9227
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 05:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438501AbgLNEBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 23:01:00 -0500
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:36303 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgLNEAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 23:00:42 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 14 Dec
 2020 11:59:56 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.56.37) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 14 Dec
 2020 11:59:54 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <TimGuo-oc@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>,
        <CobeChen@zhaoxin.com>, <SilviaZhao@zhaoxin.com>
Subject: [PATCH] crypto: x86/crc32c-intel - Don't match some Zhaoxin CPUs
Date:   Mon, 14 Dec 2020 11:59:52 +0800
Message-ID: <1607918392-19171-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.56.37]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver crc32c-intel match CPUs supporting X86_FEATURE_XMM4_2.
On platforms with Zhaoxin CPUs supporting this X86 feature, when
crc32c-intel and crc32c-generic are both registered, system will
use crc32c-intel because its .cra_priority is greater than
crc32c-generic.

When doing lmbench3 Create and Delete file test on partitions with
ext4 enabling metadata checksum, found using crc32c-generic driver
could get about 20% performance gain than using the driver crc32c-intel
on some Zhaoxin CPUs.

This case expect to use crc32c-generic driver for these Zhaoxin CPUs
to get performance gain, so remove these Zhaoxin CPUs support from
crc32c-intel.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/crypto/crc32c-intel_glue.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index feccb52..2cbbdde 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -215,6 +215,12 @@ static struct shash_alg alg = {
 };
 
 static const struct x86_cpu_id crc32c_cpu_id[] = {
+	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 0x6, X86_FEATURE_XMM4_2, 1),
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(ZHAOXIN, 0x7, 0x1b, X86_FEATURE_XMM4_2, 1),
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(ZHAOXIN, 0x7, 0x3b, X86_FEATURE_XMM4_2, 1),
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 0x6, X86_FEATURE_XMM4_2, 1),
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(CENTAUR, 0x7, 0x1b, X86_FEATURE_XMM4_2, 1),
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(CENTAUR, 0x7, 0x3b, X86_FEATURE_XMM4_2, 1),
 	X86_MATCH_FEATURE(X86_FEATURE_XMM4_2, NULL),
 	{}
 };
@@ -222,7 +228,9 @@ MODULE_DEVICE_TABLE(x86cpu, crc32c_cpu_id);
 
 static int __init crc32c_intel_mod_init(void)
 {
-	if (!x86_match_cpu(crc32c_cpu_id))
+	const struct x86_cpu_id *m = x86_match_cpu(crc32c_cpu_id);
+
+	if (!m || m->driver_data)
 		return -ENODEV;
 #ifdef CONFIG_X86_64
 	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
-- 
2.7.4

