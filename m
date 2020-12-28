Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958272E30F0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgL0LdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 06:33:11 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59562 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgL0LdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 06:33:10 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1ktUHd-0000dj-W4; Sun, 27 Dec 2020 22:32:23 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Dec 2020 22:32:21 +1100
Date:   Sun, 27 Dec 2020 22:32:21 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.11
Message-ID: <20201227113221.GA28744@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20200830223304.GA16882@gondor.apana.org.au>
 <20201026011159.GA2428@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026011159.GA2428@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This push fixes a number of autobuild failures due to missing
Kconfig dependencies.

The following changes since commit 93cebeb1c21a65b92636aaa278a32fbc0415ec67:

  crypto: qat - add capability detection logic in qat_4xxx (2020-12-11 21:54:16 +1100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to c0e583ab2016de8dedfb73934d4c4e8ff5bd896c:

  crypto: qat - add CRYPTO_AES to Kconfig dependencies (2020-12-23 18:45:23 +1100)

----------------------------------------------------------------
Daniele Alessandrelli (1):
      crypto: keembay - Add dependency on HAS_IOMEM

Geert Uytterhoeven (1):
      crypto: keembay - CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 should depend on ARCH_KEEMBAY

Marco Chiappero (1):
      crypto: qat - add CRYPTO_AES to Kconfig dependencies

 drivers/crypto/keembay/Kconfig | 5 +++--
 drivers/crypto/qat/Kconfig     | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
