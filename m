Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFB82811A4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbgJBLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:54:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49132 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBLyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:54:32 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kOJdk-0005Ot-HK; Fri, 02 Oct 2020 21:54:21 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Oct 2020 21:54:20 +1000
Date:   Fri, 2 Oct 2020 21:54:20 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: mediatek - simplify the return expression
 of mtk_dfe_dse_reset()
Message-ID: <20201002115420.GD1205@gondor.apana.org.au>
References: <20200921131009.91191-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921131009.91191-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:10:09PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/crypto/mediatek/mtk-platform.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
