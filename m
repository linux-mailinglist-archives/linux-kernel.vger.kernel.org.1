Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F2C2E88B0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 22:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbhABVai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 16:30:38 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37142 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbhABVah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 16:30:37 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kvoSn-0000Bp-Qs; Sun, 03 Jan 2021 08:29:30 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 Jan 2021 08:29:29 +1100
Date:   Sun, 3 Jan 2021 08:29:29 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Meng Yu <yumeng18@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Prabhjot Khurana <prabhjot.khurana@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [PATCH v5 3/5] crypto: expose elliptic curve parameters as
 Crypto APIs
Message-ID: <20210102212929.GA1996@gondor.apana.org.au>
References: <1608790107-32617-1-git-send-email-yumeng18@huawei.com>
 <1608790107-32617-4-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608790107-32617-4-git-send-email-yumeng18@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 02:08:25PM +0800, Meng Yu wrote:
> Move elliptic curves definition to 'include/crypto/ecc_curve_defs.h',
> so all can use it,
> 
> Signed-off-by: Meng Yu <yumeng18@huawei.com>
> Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
> ---
>  crypto/ecc.c                    |  1 -
>  crypto/ecc.h                    | 37 +----------------
>  crypto/ecc_curve_defs.h         | 57 -------------------------
>  crypto/ecrdsa_defs.h            |  2 +-
>  include/crypto/ecc_curve_defs.h | 92 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 95 insertions(+), 94 deletions(-)
>  delete mode 100644 crypto/ecc_curve_defs.h
>  create mode 100644 include/crypto/ecc_curve_defs.h

This conflicts with

https://patchwork.kernel.org/project/linux-crypto/patch/20201217172101.381772-3-daniele.alessandrelli@linux.intel.com/

Please discuss with each other on how you would like to proceed.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
