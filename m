Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1EE2659C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 08:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKG7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 02:59:04 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59010 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgIKG7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:59:02 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGd1D-0007x1-0E; Fri, 11 Sep 2020 16:58:48 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 16:58:46 +1000
Date:   Fri, 11 Sep 2020 16:58:46 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     krzk@kernel.org, vz@mleia.com, k.konieczny@samsung.com,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: s5p-sss: remove redundant null check
Message-ID: <20200911065846.GH32150@gondor.apana.org.au>
References: <20200903083738.85345-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903083738.85345-1-vulab@iscas.ac.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 08:37:38AM +0000, Xu Wang wrote:
> Because clk_disable_unprepare already checked NULL clock
> parameter, so the additional checks are unnecessary, just remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/crypto/s5p-sss.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
