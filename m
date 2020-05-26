Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E27741A2D72
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 03:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDIBpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 21:45:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbgDIBpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 21:45:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9B416B59D0BA86C2FC1F;
        Thu,  9 Apr 2020 09:45:10 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 09:45:03 +0800
Subject: Re: [PATCH] crypto: hisilicon: add more dependencies
To:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Hongbo Yao <yaohongbo@huawei.com>
References: <20200408162718.4004527-1-arnd@arndb.de>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zaibo Xu <xuzaibo@huawei.com>, Hao Fang <fanghao11@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Mao Wenan <maowenan@huawei.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5E8E7E0D.4090702@hisilicon.com>
Date:   Thu, 9 Apr 2020 09:44:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200408162718.4004527-1-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/9 0:27, Arnd Bergmann wrote:
> The added dependencies must be applied recursively to
> other modules that select CRYPTO_DEV_HISI_QM, to avoid
> running into the same problem again:
> 
> WARNING: unmet direct dependencies detected for CRYPTO_DEV_HISI_QM
>   Depends on [m]: CRYPTO [=y] && CRYPTO_HW [=y] && (ARM64 [=y] || COMPILE_TEST [=y]) && PCI [=y] && PCI_MSI [=y] && (UACCE [=m] || UACCE [=m]=n)
>   Selected by [y]:
>   - CRYPTO_DEV_HISI_SEC2 [=y] && CRYPTO [=y] && CRYPTO_HW [=y] && PCI [=y] && PCI_MSI [=y] && (ARM64 [=y] || COMPILE_TEST [=y] && 64BIT [=y])
>   - CRYPTO_DEV_HISI_HPRE [=y] && CRYPTO [=y] && CRYPTO_HW [=y] && PCI [=y] && PCI_MSI [=y] && (ARM64 [=y] || COMPILE_TEST [=y] && 64BIT [=y])
> ld: drivers/crypto/hisilicon/qm.o: in function `hisi_qm_uninit': qm.c:(.text+0x23b8): undefined reference to `uacce_remove'
> 
> Fixes: 47c16b449921 ("crypto: hisilicon - qm depends on UACCE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/hisilicon/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> index 095850d01dcc..9c3004663fe8 100644
> --- a/drivers/crypto/hisilicon/Kconfig
> +++ b/drivers/crypto/hisilicon/Kconfig
> @@ -28,6 +28,7 @@ config CRYPTO_DEV_HISI_SEC2
>  	select CRYPTO_SHA512
>  	depends on PCI && PCI_MSI
>  	depends on ARM64 || (COMPILE_TEST && 64BIT)
> +	depends on UACCE || UACCE=n
>  	help
>  	  Support for HiSilicon SEC Engine of version 2 in crypto subsystem.
>  	  It provides AES, SM4, and 3DES algorithms with ECB
> @@ -59,6 +60,7 @@ config CRYPTO_DEV_HISI_HPRE
>  	tristate "Support for HISI HPRE accelerator"
>  	depends on PCI && PCI_MSI
>  	depends on ARM64 || (COMPILE_TEST && 64BIT)
> +	depends on UACCE || UACCE=n
>  	select CRYPTO_DEV_HISI_QM
>  	select CRYPTO_DH
>  	select CRYPTO_RSA
> 

Hi Arnd,

Seems we already have a fix: https://lkml.org/lkml/2020/3/30/173 with your reviewed-by :)

Best,
Zhou


