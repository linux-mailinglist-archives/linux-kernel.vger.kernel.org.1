Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D32C5FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 06:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392524AbgK0F5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:57:35 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33338 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392514AbgK0F5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:57:35 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kiWkp-0000gM-Kk; Fri, 27 Nov 2020 16:57:12 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Nov 2020 16:57:11 +1100
Date:   Fri, 27 Nov 2020 16:57:11 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     arnd@arndb.de, davem@davemloft.net, jernej.skrabec@siol.net,
        mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 6/7] crypto: sun4i-ss: enabled stats via debugfs
Message-ID: <20201127055711.GA29694@gondor.apana.org.au>
References: <20201116135345.11834-1-clabbe@baylibre.com>
 <20201116135345.11834-7-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116135345.11834-7-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 01:53:44PM +0000, Corentin Labbe wrote:
>
> +#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
> +	/* Ignore error of debugfs */
> +	ss->dbgfs_dir = debugfs_create_dir("sun4i-ss", NULL);
> +	ss->dbgfs_stats = debugfs_create_file("stats", 0444, ss->dbgfs_dir, ss,
> +					      &sun4i_ss_debugfs_fops);
> +#endif

Since you didn't use ifdefs in the struct, there is no need to
use ifdefs here either.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
