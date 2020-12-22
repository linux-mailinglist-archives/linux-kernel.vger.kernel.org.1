Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644342DEAC7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgLRVHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:07:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:16596 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgLRVHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:07:41 -0500
IronPort-SDR: 53Ldtc7gzAPtwyrCRc31d7QyK6SOl+4Dh1A3X5cxeBluJzbtzbjx7kuOJ+pUxMIkGgmcO9nupi
 H/0kL+k021DQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="237075270"
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="237075270"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 13:06:42 -0800
IronPort-SDR: SLjTefUzJ0wkJaAv3c9251DYYwgRC9DSf3VPK3NKzbao6zbDSKNxot3XcMRFqMPNh4ylxcevEc
 BHVz78131V0w==
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="370785952"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.154])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Dec 2020 13:06:42 -0800
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
Subject: [RFC V1 4/7] crypto: tcrypt - Add speed test for optimized GHASH computations
Date:   Fri, 18 Dec 2020 13:11:01 -0800
Message-Id: <1608325864-4033-5-git-send-email-megha.dey@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608325864-4033-1-git-send-email-megha.dey@intel.com>
References: <1608325864-4033-1-git-send-email-megha.dey@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyung Min Park <kyung.min.park@intel.com>

Add speed test for optimized GHASH computations with vectorized
instructions. Introduce a new test suite to calculate the speed
for this algorithm.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Megha Dey <megha.dey@intel.com>
---
 crypto/tcrypt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index a647bb2..6e2d74c6 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -2595,6 +2595,11 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 				    generic_hash_speed_template, num_mb);
 		if (mode > 400 && mode < 500) break;
 		fallthrough;
+	case 428:
+		klen = 16;
+		test_ahash_speed("ghash", sec, generic_hash_speed_template);
+		if (mode > 400 && mode < 500) break;
+		fallthrough;
 	case 499:
 		break;
 
-- 
2.7.4

