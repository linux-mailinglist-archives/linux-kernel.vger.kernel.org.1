Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3F25D39B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 10:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgIDI2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 04:28:23 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42684 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbgIDI2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:28:19 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kE74y-0001PS-Mt; Fri, 04 Sep 2020 18:28:17 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Sep 2020 18:28:16 +1000
Date:   Fri, 4 Sep 2020 18:28:16 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-crypto@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] crypto: use kfree_sensitive()
Message-ID: <20200904082816.GC1214@gondor.apana.org.au>
References: <20200827064402.7130-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827064402.7130-1-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 09:43:58AM +0300, Denis Efremov wrote:
> kfree_sensitive() is introduced in commit 453431a54934
> ("mm, treewide: rename kzfree() to kfree_sensitive()") and uses
> memzero_explicit() internally. Thus, we can switch to this API
> instead of open-coding memzero_explicit() && kfree().
> 
> Changes in v2:
>  - if (op->len) check removed
> 
> Denis Efremov (4):
>   crypto: inside-secure - use kfree_sensitive()
>   crypto: amlogic - use kfree_sensitive()
>   crypto: sun8i-ce - use kfree_sensitive()
>   crypto: sun8i-ss - use kfree_sensitive()
> 
>  .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c   | 15 +++------------
>  .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c   | 15 +++------------
>  drivers/crypto/amlogic/amlogic-gxl-cipher.c       | 10 ++--------
>  drivers/crypto/inside-secure/safexcel_hash.c      |  3 +--
>  4 files changed, 9 insertions(+), 34 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
