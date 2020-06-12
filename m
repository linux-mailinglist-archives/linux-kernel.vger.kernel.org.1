Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6321F741A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 08:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFLGrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 02:47:51 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38958 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgFLGrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:47:51 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjdTZ-0000oX-R3; Fri, 12 Jun 2020 16:47:43 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2020 16:47:41 +1000
Date:   Fri, 12 Jun 2020 16:47:41 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] crypto: caam - fix typos
Message-ID: <20200612064741.GC16987@gondor.apana.org.au>
References: <20200604103947.11276-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604103947.11276-1-xypron.glpk@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 12:39:47PM +0200, Heinrich Schuchardt wrote:
> Fix CAAM related typos.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> v2:
> 	fix additional typos as indicated by Horia
> 	replaces https://lkml.org/lkml/2020/6/3/1129
> ---
>  drivers/crypto/caam/Kconfig |  2 +-
>  drivers/crypto/caam/ctrl.c  | 18 +++++++++---------
>  drivers/crypto/caam/desc.h  |  4 ++--
>  drivers/crypto/caam/pdb.h   |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
