Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EA82E88BD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbhABWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 17:01:20 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37250 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbhABWBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:01:19 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kvowe-0000Ty-AW; Sun, 03 Jan 2021 09:00:21 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 Jan 2021 09:00:20 +1100
Date:   Sun, 3 Jan 2021 09:00:20 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vic Wu <vic.wu@mediatek.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: mediatek - remove obsolete driver
Message-ID: <20210102220020.GA12767@gondor.apana.org.au>
References: <20201207075842.30090-1-vic.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207075842.30090-1-vic.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:58:42PM +0800, Vic Wu wrote:
> The crypto mediatek driver has been replaced by the inside-secure
> driver now. Remove this driver to avoid having duplicate drivers.
> 
> Signed-off-by: Vic Wu <vic.wu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/crypto/Kconfig                 |   15 -
>  drivers/crypto/Makefile                |    1 -
>  drivers/crypto/mediatek/Makefile       |    3 -
>  drivers/crypto/mediatek/mtk-aes.c      | 1271 ----------------------
>  drivers/crypto/mediatek/mtk-platform.c |  586 ----------
>  drivers/crypto/mediatek/mtk-platform.h |  231 ----
>  drivers/crypto/mediatek/mtk-regs.h     |  190 ----
>  drivers/crypto/mediatek/mtk-sha.c      | 1352 ------------------------
>  8 files changed, 3649 deletions(-)
>  delete mode 100644 drivers/crypto/mediatek/Makefile
>  delete mode 100644 drivers/crypto/mediatek/mtk-aes.c
>  delete mode 100644 drivers/crypto/mediatek/mtk-platform.c
>  delete mode 100644 drivers/crypto/mediatek/mtk-platform.h
>  delete mode 100644 drivers/crypto/mediatek/mtk-regs.h
>  delete mode 100644 drivers/crypto/mediatek/mtk-sha.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
