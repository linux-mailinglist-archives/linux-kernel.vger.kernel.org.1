Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B82A26D61A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIQINP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:13:15 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54836 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgIQINE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:13:04 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kIp26-0005pJ-1V; Thu, 17 Sep 2020 18:12:47 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 17 Sep 2020 18:12:46 +1000
Date:   Thu, 17 Sep 2020 18:12:46 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: initialize ChaCha20 constants with correct
 endianness
Message-ID: <20200917081245.GA5673@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916045013.142179-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> On big endian CPUs, the ChaCha20-based CRNG is using the wrong
> endianness for the ChaCha20 constants.
> 
> This doesn't matter cryptographically, but technically it means it's not
> ChaCha20 anymore.  Fix it to always use the standard constants.
> 
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> drivers/char/random.c   | 4 ++--
> include/crypto/chacha.h | 9 +++++++--
> 2 files changed, 9 insertions(+), 4 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
