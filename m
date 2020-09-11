Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5932659C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 08:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgIKG6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 02:58:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58992 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgIKG6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:58:24 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGd0Y-0007uw-4p; Fri, 11 Sep 2020 16:58:07 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 16:58:06 +1000
Date:   Fri, 11 Sep 2020 16:58:06 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Atte Tommiska <atte.tommiska@xiphera.com>
Cc:     Matt Mackall <mpm@selenic.com>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] hwrng: add support for Xiphera XIP8001B
Message-ID: <20200911065806.GG32150@gondor.apana.org.au>
References: <20200902102817.32172-1-atte.tommiska@xiphera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902102817.32172-1-atte.tommiska@xiphera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 01:28:14PM +0300, Atte Tommiska wrote:
> This patchset introduces a linux driver for Xiphera's XIP8001B IP.
> The IP is an FPGA-based TRNG which can be used in various FPGA families.
> The IP is in use in multiple customer projects and in Xiphera's own products.
> 
> changes in v2: 
>   - fixed the 'make dt_binding_check' errors in the devicetree schema.
> 
> changes in v3: 
>   - added Rob's tags to the first and second patch
>   - fixed a typo in the subject line of the second patch
>   - removed a redundant line of code from the driver in the third patch
> 
> Atte Tommiska (3):
>   dt-bindings: vendor-prefixes: Add Xiphera vendor prefix
>   dt-bindings: rng: add bindings for Xiphera XIP8001B hwrng
>   hwrng: xiphera-trng: add support for XIP8001B hwrng
> 
>  .../bindings/rng/xiphera,xip8001b-trng.yaml   |  33 ++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  drivers/char/hw_random/Kconfig                |  10 ++
>  drivers/char/hw_random/Makefile               |   1 +
>  drivers/char/hw_random/xiphera-trng.c         | 150 ++++++++++++++++++
>  5 files changed, 196 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml
>  create mode 100644 drivers/char/hw_random/xiphera-trng.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
