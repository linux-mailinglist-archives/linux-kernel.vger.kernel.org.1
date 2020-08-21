Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29D224D028
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgHUH6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:58:35 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50034 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgHUH6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:58:31 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k91wQ-000447-Bb; Fri, 21 Aug 2020 17:58:27 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 17:58:26 +1000
Date:   Fri, 21 Aug 2020 17:58:26 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     ira.weiny@intel.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Cyrpto: Clean up kmap() use
Message-ID: <20200821075826.GM25143@gondor.apana.org.au>
References: <20200811004015.2800392-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811004015.2800392-1-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 05:40:13PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> While going through kmap() users the following 2 issues were found via code
> inspection.
> 
> Ira Weiny (2):
>   crypto/ux500: Fix kmap() bug
>   crypto: Remove unused async iterators
> 
>  crypto/ahash.c                        | 41 +++------------------------
>  drivers/crypto/ux500/hash/hash_core.c | 30 ++++++++++++--------
>  include/crypto/internal/hash.h        | 13 ---------
>  3 files changed, 22 insertions(+), 62 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
