Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912F52BB37D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgKTSew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:34:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730424AbgKTSev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:34:51 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E02C22D0A;
        Fri, 20 Nov 2020 18:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897290;
        bh=+vUeX/ODVGeH2ceLxKyWnUiY7tYDqAiJFm/x0jwd3Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJB3esgjJfWhQ7xtgZb2EKa5qGrkSH8aphL3l0JdeBc/68KLtPvBRCP5PIvmlgF/z
         f2+0grxiD5H6CgbgelFZGxZMm/IUE9rgpaA/ToMlmsB8CqDySa1Qs9yS/KAYQSI/pa
         PtmBsn8jDY8LVZEV84seoO4aRncetUM+snNNEp64=
Date:   Fri, 20 Nov 2020 12:34:56 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 075/141] crypto: ccree - Fix fall-through warnings for Clang
Message-ID: <7c424191001cafdc7abd060790ecfcccdf3dd3ae.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements instead of
letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/ccree/cc_cipher.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index dafa6577a845..cdfee501fbd9 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -97,6 +97,7 @@ static int validate_keys_sizes(struct cc_cipher_ctx *ctx_p, u32 size)
 	case S_DIN_to_SM4:
 		if (size == SM4_KEY_SIZE)
 			return 0;
+		break;
 	default:
 		break;
 	}
@@ -139,9 +140,11 @@ static int validate_data_size(struct cc_cipher_ctx *ctx_p,
 		case DRV_CIPHER_CBC:
 			if (IS_ALIGNED(size, SM4_BLOCK_SIZE))
 				return 0;
+			break;
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

