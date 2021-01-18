Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804A32F9912
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbhARFOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:14:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60454 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730651AbhARFOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:14:02 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l1Mqn-000539-4K; Mon, 18 Jan 2021 16:13:14 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 18 Jan 2021 16:13:13 +1100
Date:   Mon, 18 Jan 2021 16:13:13 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.11
Message-ID: <20210118051312.GA26120@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20200830223304.GA16882@gondor.apana.org.au>
 <20201026011159.GA2428@gondor.apana.org.au>
 <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108035450.GA6191@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This push fixes a Kconfig dependency issue with omap-sham and a
divide by zero in xor on some platforms.

The following changes since commit 0aa171e9b267ce7c52d3a3df7bc9c1fc0203dec5:

  crypto: ecdh - avoid buffer overflow in ecdh_set_secret() (2021-01-03 08:35:35 +1100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to 382811940303f7cd01d0f3dcdf432dfd89c5a98e:

  crypto: omap-sham - Fix link error without crypto-engine (2021-01-08 15:37:55 +1100)

----------------------------------------------------------------
Arnd Bergmann (1):
      crypto: omap-sham - Fix link error without crypto-engine

Kirill Tkhai (1):
      crypto: xor - Fix divide error in do_xor_speed()

 crypto/xor.c           | 2 ++
 drivers/crypto/Kconfig | 1 +
 2 files changed, 3 insertions(+)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
