Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8650F1FEFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 12:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgFRKoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 06:44:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60910 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgFRKoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:44:24 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jls1j-00056x-Kf; Thu, 18 Jun 2020 20:44:12 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 18 Jun 2020 20:44:11 +1000
Date:   Thu, 18 Jun 2020 20:44:11 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Colin King <colin.king@canonical.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: caam/qi2: remove redundant assignment to ret
Message-ID: <20200618104411.GA10882@gondor.apana.org.au>
References: <20200611153934.928021-1-colin.king@canonical.com>
 <20200618075816.GI10091@gondor.apana.org.au>
 <5452e045-bd48-3b29-b364-bf123540ae21@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5452e045-bd48-3b29-b364-bf123540ae21@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:40:55PM +0300, Horia Geantă wrote:
> On 6/18/2020 10:58 AM, Herbert Xu wrote:
> > On Thu, Jun 11, 2020 at 04:39:34PM +0100, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The variable ret is being assigned a value that is never read, the
> >> error exit path via label 'unmap' returns -ENOMEM anyhow, so assigning
> >> ret with -ENOMEM is redundamt.
> >>
> >> Addresses-Coverity: ("Unused value")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  drivers/crypto/caam/caamalg_qi2.c | 2 --
> >>  1 file changed, 2 deletions(-)
> > 
> > Patch applied.  Thanks.
> > 
> Unfortunately I missed this patch, and it doesn't look correct.
> 
> Do I need to send a revert?

No please check again.  The patch is correct.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
