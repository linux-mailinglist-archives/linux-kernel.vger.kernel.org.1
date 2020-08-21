Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3943924D021
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgHUH6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:58:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49998 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbgHUH5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:57:45 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k91vX-00040i-77; Fri, 21 Aug 2020 17:57:32 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 17:57:31 +1000
Date:   Fri, 21 Aug 2020 17:57:31 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     sumit.garg@linaro.org, jens.wiklander@linaro.org, mpm@selenic.com,
        arnd@arndb.de, ricardo@foundries.io, mike@foundries.io,
        gregkh@linuxfoundation.org, op-tee@lists.trustedfirmware.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] hwrng: optee: handle unlimited data rates
Message-ID: <20200821075731.GI25143@gondor.apana.org.au>
References: <20200806100010.20509-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806100010.20509-1-jorge@foundries.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 12:00:09PM +0200, Jorge Ramirez-Ortiz wrote:
> Data rates of MAX_UINT32 will schedule an unnecessary one jiffy
> timeout on the call to msleep. Avoid this scenario by using 0 as the
> unlimited data rate.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/char/hw_random/optee-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
