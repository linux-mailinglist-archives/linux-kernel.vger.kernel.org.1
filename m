Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9FB2E88C6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbhABWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 17:05:19 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37284 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbhABWFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:05:19 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kvp0a-0000ZI-Uo; Sun, 03 Jan 2021 09:04:26 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 Jan 2021 09:04:24 +1100
Date:   Sun, 3 Jan 2021 09:04:24 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Jamie Iles <jamie@jamieiles.com>,
        "David S. Miller" <davem@davemloft.net>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] crypto: Remove PicoXcell driver
Message-ID: <20210102220424.GF12767@gondor.apana.org.au>
References: <20201210200315.2965567-1-robh@kernel.org>
 <20201210200315.2965567-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210200315.2965567-4-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 02:03:14PM -0600, Rob Herring wrote:
> PicoXcell has had nothing but treewide cleanups for at least the last 8
> years and no signs of activity. The most recent activity is a yocto vendor
> kernel based on v3.0 in 2015.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This can go in via crypto tree.
> 
>  drivers/crypto/Kconfig                 |   18 -
>  drivers/crypto/Makefile                |    1 -
>  drivers/crypto/picoxcell_crypto.c      | 1806 ------------------------
>  drivers/crypto/picoxcell_crypto_regs.h |  115 --
>  4 files changed, 1940 deletions(-)
>  delete mode 100644 drivers/crypto/picoxcell_crypto.c
>  delete mode 100644 drivers/crypto/picoxcell_crypto_regs.h

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
