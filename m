Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366941AB8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437264AbgDPGxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 02:53:08 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41474 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436923AbgDPGwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:52:16 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jOyNK-0005Jq-CU; Thu, 16 Apr 2020 16:51:51 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2020 16:51:50 +1000
Date:   Thu, 16 Apr 2020 16:51:50 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepak Saxena <dsaxena@plexity.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Mackall <mpm@selenic.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] hwrng: omap - Delete an error message in
 of_get_omap_rng_device_details()
Message-ID: <20200416065150.GG7901@gondor.apana.org.au>
References: <eae7170c-4371-4865-7b85-589c0ed2b5b6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eae7170c-4371-4865-7b85-589c0ed2b5b6@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 04:56:57PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 4 Apr 2020 16:45:57 +0200
> 
> The function “platform_get_irq” can log an error already.
> Thus omit a redundant message for the exception handling in the
> calling function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/char/hw_random/omap-rng.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
