Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6DE219A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGIH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 03:56:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35042 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgGIH4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:56:40 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtRPm-0006fK-JG; Thu, 09 Jul 2020 17:56:19 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Jul 2020 17:56:18 +1000
Date:   Thu, 9 Jul 2020 17:56:18 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Meng Yu <yumeng18@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] crypto: hisilicon/hpre bugfix - misc fixes
Message-ID: <20200709075618.GA7724@gondor.apana.org.au>
References: <1593657079-31990-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593657079-31990-1-git-send-email-yumeng18@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 10:31:13AM +0800, Meng Yu wrote:
> Bugfix: crypto: hisilicon/hpre - modify the macros, add a switch in
> 	sriov_configure, unified debugfs interface, and disable
> 	hardware FLR.
> 
> Hui Tang (2):
>   crypto: hisilicon/hpre - HPRE_OVERTIME_THRHLD can be written by
>     debugfs
>   crypto: hisilicon/hpre - disable FLR triggered by hardware
> 
> Meng Yu (4):
>   crypto: hisilicon/hpre - Init the value of current_q of debugfs
>   crypto: hisilicon/hpre - Modify the Macro definition and format
>   crypto: hisilicon/hpre - Add a switch in sriov_configure
>   crypto: hisilicon/hpre - update debugfs interface parameters
> 
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 114 ++++++++++++++++--------------
>  1 file changed, 62 insertions(+), 52 deletions(-)

This doesn't apply against cryptodev.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
