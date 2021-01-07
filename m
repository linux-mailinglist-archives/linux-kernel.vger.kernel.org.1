Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999712ECA74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 07:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbhAGGUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 01:20:40 -0500
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:46132 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAGGUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 01:20:40 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 7 Jan 2021
 14:19:22 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.56.37) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 7 Jan 2021
 14:19:19 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <tony.luck@intel.com>,
        <dave.hansen@intel.com>, <seanjc@google.com>,
        <fenghua.yu@intel.com>, <thomas.lendacky@amd.com>,
        <kyung.min.park@intel.com>, <kim.phillips@amd.com>,
        <mgross@linux.intel.com>, <peterz@infradead.org>,
        <krish.sadhukhan@oracle.com>, <liam.merwick@oracle.com>,
        <mlevitsk@redhat.com>, <reinette.chatre@intel.com>,
        <babu.moger@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <TimGuo-oc@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>,
        <CobeChen@zhaoxin.com>, <SilviaZhao@zhaoxin.com>
Subject: [PATCH v1 3/3] crypto: x86/crc32c-intel Exclude low performance CRC32C instruction CPUs
Date:   Thu, 7 Jan 2021 14:19:08 +0800
Message-ID: <1610000348-17316-4-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610000348-17316-1-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1610000348-17316-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.56.37]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Low performance CRC32C instruction CPUs expect to use the driver
crc32c-generic. So remove these CPUs support from crc32c-intel.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/crypto/crc32c-intel_glue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index feccb52..1b6d289 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -224,6 +224,11 @@ static int __init crc32c_intel_mod_init(void)
 {
 	if (!x86_match_cpu(crc32c_cpu_id))
 		return -ENODEV;
+
+	/* Don't merit use low performance CRC32C instruction */
+	if (boot_cpu_has(X86_FEATURE_CRC32C))
+		return -ENODEV;
+
 #ifdef CONFIG_X86_64
 	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
 		alg.update = crc32c_pcl_intel_update;
-- 
2.7.4

