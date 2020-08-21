Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A284A24D03A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgHUIBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 04:01:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50086 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgHUIBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:01:39 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k91yk-00049C-VL; Fri, 21 Aug 2020 18:00:52 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 18:00:50 +1000
Date:   Fri, 21 Aug 2020 18:00:50 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Gilad Ben-Yossef <gilad@benyossef.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccree - fix runtime PM imbalance on error
Message-ID: <20200821080050.GO25143@gondor.apana.org.au>
References: <20200815032755.6646-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815032755.6646-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 11:27:55AM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter
> even when it returns an error code. However, users of cc_pm_get(),
> a direct wrapper of pm_runtime_get_sync(), assume that PM usage
> counter will not change on error. Thus a pairing decrement is needed
> on the error handling path to keep the counter balanced.
> 
> Fixes: 8c7849a30255c ("crypto: ccree - simplify Runtime PM handling")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/crypto/ccree/cc_pm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Your patch didn't make it to the list or patchwork.  Please resubmit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
