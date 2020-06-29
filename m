Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E757220CBB5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 04:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgF2CQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 22:16:42 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58328 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgF2CQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:16:42 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jpjLP-0001Kz-SD; Mon, 29 Jun 2020 12:16:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 29 Jun 2020 12:16:27 +1000
Date:   Mon, 29 Jun 2020 12:16:27 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.8
Message-ID: <20200629021627.GA13792@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
 <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
 <20200115150812.mo2eycc53lbsgvue@gondor.apana.org.au>
 <20200213033231.xjwt6uf54nu26qm5@gondor.apana.org.au>
 <20200408061513.GA23636@gondor.apana.org.au>
 <20200611040544.GA27603@gondor.apana.org.au>
 <20200621082303.GA30729@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621082303.GA30729@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This push fixes two race conditions, one in padata and one in
af_alg.

The following changes since commit 819966c06b759022e9932f328284314d9272b9f3:

  crypto: drbg - always try to free Jitter RNG instance (2020-06-15 17:38:54 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to e04ec0de61c1eb9693179093e83ab8ca68a30d08:

  padata: upgrade smp_mb__after_atomic to smp_mb in padata_do_serial (2020-06-18 17:09:54 +1000)

----------------------------------------------------------------
Daniel Jordan (1):
      padata: upgrade smp_mb__after_atomic to smp_mb in padata_do_serial

Herbert Xu (1):
      crypto: af_alg - fix use-after-free in af_alg_accept() due to bh_lock_sock()

 crypto/af_alg.c         | 26 +++++++++++---------------
 crypto/algif_aead.c     |  9 +++------
 crypto/algif_hash.c     |  9 +++------
 crypto/algif_skcipher.c |  9 +++------
 include/crypto/if_alg.h |  4 ++--
 kernel/padata.c         |  4 ++--
 6 files changed, 24 insertions(+), 37 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
