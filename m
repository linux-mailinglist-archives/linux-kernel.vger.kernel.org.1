Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F08D1EBB24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 14:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFBMB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 08:01:58 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56324 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgFBMB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:01:58 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jg5bf-0006l1-BW; Tue, 02 Jun 2020 22:01:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Jun 2020 22:01:23 +1000
Date:   Tue, 2 Jun 2020 22:01:23 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] crypto: inside-secure - use PCI_IRQ_MSI_TYPES
 where appropriate
Message-ID: <20200602120123.GA14329@gondor.apana.org.au>
References: <20200602092019.31878-1-piotr.stankiewicz@intel.com>
 <159109756912.870467.7291427996953916910@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159109756912.870467.7291427996953916910@kwain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 01:32:49PM +0200, Antoine Tenart wrote:
> 
> Quoting Piotr Stankiewicz (2020-06-02 11:20:19)
> > Seeing as there is shorthand available to use when asking for any type
> > of interrupt, or any type of message signalled interrupt, leverage it.
> > 
> > Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Reviewed-by: Antoine Tenart <antoine.tenart@bootlin.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
