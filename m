Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BBD29FDFE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 07:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgJ3Gth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 02:49:37 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60484 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgJ3Gth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 02:49:37 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kYOE1-0004rF-EK; Fri, 30 Oct 2020 17:49:26 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Oct 2020 17:49:25 +1100
Date:   Fri, 30 Oct 2020 17:49:25 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 1/1] crypto: hisilicon: Fix doc warnings in sgl.c and qm.c
Message-ID: <20201030064925.GD25453@gondor.apana.org.au>
References: <20201009081938.1526-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009081938.1526-1-shiju.jose@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:19:38AM +0100, Shiju Jose wrote:
> Fix following warnings caused by mismatch between
> function parameters and function comments.
> 
> drivers/crypto/hisilicon/sgl.c:256: warning: Excess function parameter 'hw_sgl_dma' description in 'hisi_acc_sg_buf_unmap'
> drivers/crypto/hisilicon/sgl.c:256: warning: Excess function parameter 'pool' description in 'hisi_acc_sg_buf_unmap'
> drivers/crypto/hisilicon/qm.c:1849: warning: Function parameter or member 'qp' not described in 'qm_drain_qp'
> drivers/crypto/hisilicon/qm.c:2420: warning: Function parameter or member 'qm' not described in 'hisi_qm_set_vft'
> drivers/crypto/hisilicon/qm.c:2420: warning: Function parameter or member 'fun_num' not described in 'hisi_qm_set_vft'
> drivers/crypto/hisilicon/qm.c:2420: warning: Function parameter or member 'base' not described in 'hisi_qm_set_vft'
> drivers/crypto/hisilicon/qm.c:2420: warning: Function parameter or member 'number' not described in 'hisi_qm_set_vft'
> drivers/crypto/hisilicon/qm.c:2620: warning: Function parameter or member 'qm' not described in 'qm_clear_queues'
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/crypto/hisilicon/qm.c  | 13 +++++++++++++
>  drivers/crypto/hisilicon/sgl.c |  2 --
>  2 files changed, 13 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
