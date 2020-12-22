Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF62DEACC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgLRVHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:07:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:16592 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgLRVHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:07:54 -0500
IronPort-SDR: 7VL/waLeBo6JyMtqCCspLNk05Wdahvl6X7S5tOIayybABsOAAikU9tU44HS3eYHtGYuN0RBbwc
 DKkrv6FFnIRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="237075274"
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="237075274"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 13:06:43 -0800
IronPort-SDR: qqbYdG60+DF5x09WZY9tS/bYLpt+wIFxGHEolQEKmOGsYYhngLJTaa6jhe71r6o/1C8wHB8lZ8
 xkXDG3k+zlxA==
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="370785959"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.154])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Dec 2020 13:06:43 -0800
From:   Megha Dey <megha.dey@intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ravi.v.shankar@intel.com, tim.c.chen@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, megha.dey@intel.com,
        wajdi.k.feghali@intel.com, greg.b.tucker@intel.com,
        robert.a.kasten@intel.com, rajendrakumar.chinnaiyan@intel.com,
        tomasz.kantecki@intel.com, ryan.d.saffores@intel.com,
        ilya.albrekht@intel.com, kyung.min.park@intel.com,
        tony.luck@intel.com, ira.weiny@intel.com
Subject: [RFC V1 6/7] crypto: aesni - fix coding style for if/else block
Date:   Fri, 18 Dec 2020 13:11:03 -0800
Message-Id: <1608325864-4033-7-git-send-email-megha.dey@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608325864-4033-1-git-send-email-megha.dey@intel.com>
References: <1608325864-4033-1-git-send-email-megha.dey@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The if else block in aesni_init does not follow required coding
conventions. If other conditionals are added to the block, it
becomes very difficult to parse. Use the correct coding style
instead.

Signed-off-by: Megha Dey <megha.dey@intel.com>
---
 arch/x86/crypto/aesni-intel_glue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index f45059e..9e56cdf 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1117,8 +1117,7 @@ static int __init aesni_init(void)
 	if (boot_cpu_has(X86_FEATURE_AVX2)) {
 		pr_info("AVX2 version of gcm_enc/dec engaged.\n");
 		aesni_gcm_tfm = &aesni_gcm_tfm_avx_gen4;
-	} else
-	if (boot_cpu_has(X86_FEATURE_AVX)) {
+	} else if (boot_cpu_has(X86_FEATURE_AVX)) {
 		pr_info("AVX version of gcm_enc/dec engaged.\n");
 		aesni_gcm_tfm = &aesni_gcm_tfm_avx_gen2;
 	} else {
-- 
2.7.4

