Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BA41D45C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgEOGVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 02:21:36 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34350 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgEOGVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:21:35 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jZTiX-0007Uq-9X; Fri, 15 May 2020 16:21:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 May 2020 16:21:09 +1000
Date:   Fri, 15 May 2020 16:21:09 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: constify struct debugfs_reg32
Message-ID: <20200515062109.GB22330@gondor.apana.org.au>
References: <20200508223502.7258-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508223502.7258-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 12:34:58AM +0200, Rikard Falkeborn wrote:
> A small series constifying struct debugfs_reg32 where it can be made
> const. There's no dependency between the patches.
> 
> Rikard Falkeborn (4):
>   crypto: ccree - constify struct debugfs_reg32
>   crypto: hisilicon/hpre - constify struct debugfs_reg32
>   crypto: hisilicon/zip - constify struct debugfs_reg32
>   crypto: hisilicon/sec2 - constify sec_dfx_regs
> 
>  drivers/crypto/ccree/cc_debugfs.c         | 4 ++--
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 4 ++--
>  drivers/crypto/hisilicon/sec2/sec_main.c  | 2 +-
>  drivers/crypto/hisilicon/zip/zip_main.c   | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
