Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62E234138
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 10:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgGaI2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 04:28:47 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39996 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730934AbgGaI2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:28:47 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1QPA-0002bE-7M; Fri, 31 Jul 2020 18:28:41 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 18:28:40 +1000
Date:   Fri, 31 Jul 2020 18:28:40 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 0/4] crypto: hisilicon/zip - misc bugfix
Message-ID: <20200731082840.GA32511@gondor.apana.org.au>
References: <1595657210-3964-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595657210-3964-1-git-send-email-shenyang39@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 02:06:46PM +0800, Yang Shen wrote:
> This patchset fix some bug:
> patch 1:clear the debug registers when remove driver
> patch 2:intercept invalid input when using decompress
> patch 3:replace the return value '-EBUSY' with '-EAGAIN' when
>     device is busy
> patch 4:initialize the 'curr_qm_qp_num' when probe device
> 
> This patchset depends on:
> https://patchwork.kernel.org/cover/11684785/
> 
> Hao Fang (1):
>   crypto: hisilicon/zip - fix the uncleared debug registers
> 
> Sihang Chen (1):
>   crypto: hisilicon/zip - fix the uninitalized 'curr_qm_qp_num'
> 
> Yang Shen (1):
>   crypto: hisilicon/zip - fix the return value when device is busy
> 
> Zhou Wang (1):
>   crypto: hisilicon/zip - fix zero length input in GZIP decompress
> 
>  drivers/crypto/hisilicon/zip/zip_crypto.c | 25 +++++++++++++++++++------
>  drivers/crypto/hisilicon/zip/zip_main.c   | 19 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 6 deletions(-)

This patch series doesn't apply against cryptodev.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
