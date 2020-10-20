Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8918E286E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgJHF61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:58:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41258 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgJHF61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:58:27 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kQOwT-0006fQ-Q9; Thu, 08 Oct 2020 16:58:18 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Oct 2020 16:58:18 +1100
Date:   Thu, 8 Oct 2020 16:58:18 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] lib/mpi: Remove unused scalar_copied
Message-ID: <20201008055818.GB9813@gondor.apana.org.au>
References: <20200928182438.GA11739@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928182438.GA11739@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 01:24:38PM -0500, Gustavo A. R. Silva wrote:
> 
> I'm reporting the following bug detected by Coverity:
> 
> The _scalar_copied_ variable is set to 0 at
> 
> lib/mpi/ec.c:1255:
> 1255                 int scalar_copied = 0;
> 
> and it is never updated before reaching the code below:
> 
> lib/mpi/ec.c:1317
> 1317                 if (scalar_copied)                                                         
> 1318                         mpi_free(scalar);
> 
> This code was introduced by commit d58bb7e55a8a ("lib/mpi: Introduce ec
> implementation to MPI library")
> 
> Any ideas on what's the right solution for this?

I think it should be removed.

---8<---
The scalar_copied variable is not as the scalar is never copied
in that block.  This patch removes it.

Fixes: d58bb7e55a8a ("lib/mpi: Introduce ec implementation to...")
Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/mpi/ec.c b/lib/mpi/ec.c
index c21470122dfc..40f5908e57a4 100644
--- a/lib/mpi/ec.c
+++ b/lib/mpi/ec.c
@@ -1252,7 +1252,6 @@ void mpi_ec_mul_point(MPI_POINT result,
 		MPI_POINT q1, q2, prd, sum;
 		unsigned long sw;
 		mpi_size_t rsize;
-		int scalar_copied = 0;
 
 		/* Compute scalar point multiplication with Montgomery Ladder.
 		 * Note that we don't use Y-coordinate in the points at all.
@@ -1314,8 +1313,6 @@ void mpi_ec_mul_point(MPI_POINT result,
 		point_free(&p2);
 		point_free(&p1_);
 		point_free(&p2_);
-		if (scalar_copied)
-			mpi_free(scalar);
 		return;
 	}
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
