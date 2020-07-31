Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91A23412A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 10:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbgGaIY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 04:24:59 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39990 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731510AbgGaIY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:24:59 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1QL5-0002Vk-RN; Fri, 31 Jul 2020 18:24:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 18:24:27 +1000
Date:   Fri, 31 Jul 2020 18:24:27 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/17] crypto: sun8i-ce: move iv data to request
 context
Message-ID: <20200731082427.GA28326@gondor.apana.org.au>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
 <1595358391-34525-9-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595358391-34525-9-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 07:06:22PM +0000, Corentin Labbe wrote:
> Instead of storing IV data in the channel context, store them in the
> request context.
> Storing them in the channel structure was conceptualy wrong since they
> are per request related.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 27 +++++++++----------
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 10 ++++---
>  2 files changed, 19 insertions(+), 18 deletions(-)

This patch doesn't apply against cryptodev.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
