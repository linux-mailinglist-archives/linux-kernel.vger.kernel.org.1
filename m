Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA222AA27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgGWH5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 03:57:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34716 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgGWH5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:57:16 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jyW6H-0005w1-NE; Thu, 23 Jul 2020 17:57:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Jul 2020 17:57:09 +1000
Date:   Thu, 23 Jul 2020 17:57:09 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] padata cleanups
Message-ID: <20200723075709.GC14246@gondor.apana.org.au>
References: <20200714201356.889176-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714201356.889176-1-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 04:13:50PM -0400, Daniel Jordan wrote:
> These cleanups save ~5% of the padata text/data and make it a little
> easier to use and develop going forward.
> 
> In particular, they pave the way to extend padata's multithreading support to
> VFIO, a work-in-progress version of which can be found here:
> 
>     https://oss.oracle.com/git/gitweb.cgi?p=linux-dmjordan.git;a=shortlog;h=refs/heads/padata-mt-wip-v0.5
> 
> Based on v5.8-rc5.  As always, feedback is welcome.
> 
> Daniel
> 
> Daniel Jordan (6):
>   padata: remove start function
>   padata: remove stop function
>   padata: inline single call of pd_setup_cpumasks()
>   padata: remove effective cpumasks from the instance
>   padata: fold padata_alloc_possible() into padata_alloc()
>   padata: remove padata_parallel_queue
> 
>  Documentation/core-api/padata.rst |  18 +--
>  crypto/pcrypt.c                   |  17 +--
>  include/linux/padata.h            |  21 +---
>  kernel/padata.c                   | 177 ++++++------------------------
>  4 files changed, 46 insertions(+), 187 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
