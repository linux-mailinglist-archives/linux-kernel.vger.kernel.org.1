Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DCF1CBC35
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 03:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgEIBtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 21:49:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4359 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbgEIBtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 21:49:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ACEE65FB9EFAEC69915B;
        Sat,  9 May 2020 09:49:49 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 09:49:48 +0800
Subject: Re: [PATCH 3/4] crypto: hisilicon/zip - constify struct debugfs_reg32
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
References: <20200508223502.7258-1-rikard.falkeborn@gmail.com>
 <20200508223502.7258-4-rikard.falkeborn@gmail.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5EB60C26.8050205@hisilicon.com>
Date:   Sat, 9 May 2020 09:49:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200508223502.7258-4-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/9 6:35, Rikard Falkeborn wrote:
> hzip_dfx_regs is never changed and can be made const.
> 
> This allows the compiler to put it in the text section instead of the
> data section.
> 
> Before:
>    text    data     bss     dec     hex filename
>   15236    6160     480   21876    5574 drivers/crypto/hisilicon/zip/zip_main.o
> 
> After:
>    text    data     bss     dec     hex filename
>   15620    5776     480   21876    5574 drivers/crypto/hisilicon/zip/zip_main.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks for fixing this.

> ---
>  drivers/crypto/hisilicon/zip/zip_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
> index 37db11f96fab..6934a03d21e1 100644
> --- a/drivers/crypto/hisilicon/zip/zip_main.c
> +++ b/drivers/crypto/hisilicon/zip/zip_main.c
> @@ -165,7 +165,7 @@ static const u64 core_offsets[] = {
>  	[HZIP_DECOMP_CORE5] = 0x309000,
>  };
>  
> -static struct debugfs_reg32 hzip_dfx_regs[] = {
> +static const struct debugfs_reg32 hzip_dfx_regs[] = {
>  	{"HZIP_GET_BD_NUM                ",  0x00ull},
>  	{"HZIP_GET_RIGHT_BD              ",  0x04ull},
>  	{"HZIP_GET_ERROR_BD              ",  0x08ull},
> 
