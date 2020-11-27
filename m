Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B722C5FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 06:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392500AbgK0Ftq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:49:46 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33316 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389456AbgK0Ftp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:49:45 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kiWdY-0000ZR-ID; Fri, 27 Nov 2020 16:49:41 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Nov 2020 16:49:40 +1100
Date:   Fri, 27 Nov 2020 16:49:40 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] hwrng: ks-sa - Add dependency on IOMEM and OF
Message-ID: <20201127054940.GA29627@gondor.apana.org.au>
References: <202011132311.XmkAgWg0-lkp@intel.com>
 <20201127054844.GB23521@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127054844.GB23521@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resent with fixed Subject line.

---8<---
This patch adds a dependency for KEYSTONE on HAS_IOMEM and OF to
prevent COMPILE_TEST build failures.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index ab33a2e17cdf..9ff4fb3236f7 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -508,6 +508,7 @@ config HW_RANDOM_NPCM
 
 config HW_RANDOM_KEYSTONE
 	depends on ARCH_KEYSTONE || COMPILE_TEST
+	depends on HAS_IOMEM && OF
 	default HW_RANDOM
 	tristate "TI Keystone NETCP SA Hardware random number generator"
 	help
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
