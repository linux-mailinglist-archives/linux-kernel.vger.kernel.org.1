Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8161627E64B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgI3KNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:13:06 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42694 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgI3KNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:13:05 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kNZ6T-00048N-SI; Wed, 30 Sep 2020 20:12:55 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 30 Sep 2020 20:12:54 +1000
Date:   Wed, 30 Sep 2020 20:12:54 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Colin King <colin.king@canonical.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Waiman Long <longman@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lib/mpi: fix off-by-one check on index "no"
Message-ID: <20200930101253.GB25359@gondor.apana.org.au>
References: <20200929131828.155691-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929131828.155691-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 02:18:28PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an off-by-one range check on the upper limit of
> index "no".  Fix this by changing the > comparison to >=
> 
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: a8ea8bdd9df9 ("lib/mpi: Extend the MPI library")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  lib/mpi/mpiutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Could you resend this with a cc to linux-crypto?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
