Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35E1F630F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 09:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgFKH4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 03:56:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34358 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFKH4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:56:22 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjI4F-0005j4-Oz; Thu, 11 Jun 2020 17:56:08 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2020 17:56:07 +1000
Date:   Thu, 11 Jun 2020 17:56:07 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iov_iter: Move unnecessary inclusion of crypto/hash.h
Message-ID: <20200611075607.GA555@gondor.apana.org.au>
References: <20200611074332.GA12274@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611074332.GA12274@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 05:43:32PM +1000, Herbert Xu wrote:
>
> Finally the prototype of the function has been changed to avoid
> the unnecessary use of a void pointer.

OK that doesn't quite work.  Let me respin without it and instead
add some missing inclusions of crypto/hash.h in files that were
wrongly relying on uio.h to include it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
