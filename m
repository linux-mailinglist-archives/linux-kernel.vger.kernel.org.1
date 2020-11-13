Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD082B14F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 04:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgKMD5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 22:57:53 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33304 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgKMD5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 22:57:53 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kdQDF-0000IO-Q9; Fri, 13 Nov 2020 14:57:26 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Nov 2020 14:57:25 +1100
Date:   Fri, 13 Nov 2020 14:57:25 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Meng Yu <yumeng18@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] crypto: hisilicon/hpre - add 'CURVE25519'
 algorithm
Message-ID: <20201113035725.GA1025@gondor.apana.org.au>
References: <1604284265-1271-1-git-send-email-yumeng18@huawei.com>
 <1604284265-1271-6-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604284265-1271-6-git-send-email-yumeng18@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:31:05AM +0800, Meng Yu wrote:
> Enable 'CURVE25519' algorithm in 'Kunpeng 930'.
> 
> Signed-off-by: Meng Yu <yumeng18@huawei.com>
> Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre.h        |   2 +
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 387 +++++++++++++++++++++++++++-
>  2 files changed, 381 insertions(+), 8 deletions(-)

This is not sparse clean:

  CC [M]  drivers/crypto/hisilicon/sec2/sec_crypto.o
../drivers/crypto/hisilicon/hpre/hpre_crypto.c:2073:18: warning: invalid assignment: |=
../drivers/crypto/hisilicon/hpre/hpre_crypto.c:2073:18:    left side has type restricted __le32
../drivers/crypto/hisilicon/hpre/hpre_crypto.c:2073:18:    right side has type unsigned int
../drivers/crypto/hisilicon/hpre/hpre_crypto.c:2192:20: warning: restricted __le32 degrades to integer

Please fix and resubmit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
