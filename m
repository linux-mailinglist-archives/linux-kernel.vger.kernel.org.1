Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF6325F323
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 08:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgIGGWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 02:22:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50704 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgIGGWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:22:54 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kFAY5-0002SB-0Y; Mon, 07 Sep 2020 16:22:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 07 Sep 2020 16:22:40 +1000
Date:   Mon, 7 Sep 2020 16:22:40 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Keerthy <j-keerthy@ti.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: sa2ul - Select CRYPTO_AUTHENC
Message-ID: <20200907062240.GA15899@gondor.apana.org.au>
References: <202009071150.Sk8aGITA%lkp@intel.com>
 <20200907045857.GA11307@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907045857.GA11307@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend with new subject.
 
---8<---
The sa2ul driver uses crypto_authenc_extractkeys and therefore
must select CRYPTO_AUTHENC.

Fixes: 7694b6ca649f ("crypto: sa2ul - Add crypto driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index aa3a4ed07a66..c2950127def6 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -873,6 +873,7 @@ config CRYPTO_DEV_SA2UL
 	select CRYPTO_AES
 	select CRYPTO_AES_ARM64
 	select CRYPTO_ALGAPI
+	select CRYPTO_AUTHENC
 	select HW_RANDOM
 	select SG_SPLIT
 	help
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
