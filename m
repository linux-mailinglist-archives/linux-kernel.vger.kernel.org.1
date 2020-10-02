Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8082817AA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbgJBQSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388111AbgJBQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:18:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DA2C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=40gMaLom1g01t7T6bw6QMfKhcbtju/SOFt3jOlAUCWU=; b=yw6DWb9STfjYSc+XvJ1P1RWiYs
        U42AzB4tWOXQenop3aTWY5QMUkXO7Q4jCHLkm/HMFkl1uCTDv0/ldWeOBhnoBNHsP5TPAFnuInMtS
        2LD70BW6Nq/bh6cYpfGtW3MVb7ZUZJNC+VGVDEXWasDGVNRvdr/k5ktaV6lGRY1NE9lyibr7aCBDf
        7XRmJADmEXE1sEP9kgGjw7ZgjH+VnJl0tAdnIW68GgjAnBiqMYkTFtCRvF/f2tjN1jcktV8r5KKy3
        WoTOTvW8P4OwRub7gOhSnbB+VX9AgyjIjXdvrNlSV9z6L5s8H5rlBX2/xFo+ew9D3KtX+1hOCee6j
        B8SmS2ig==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kONlQ-00020Q-DI; Fri, 02 Oct 2020 16:18:32 +0000
Subject: Re: [PATCH 1/1] mfd: sl28cpld: Depend on I2C
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201002083500.796843-1-lee.jones@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7f31606f-c2fa-6c49-4f8f-197010f6a759@infradead.org>
Date:   Fri, 2 Oct 2020 09:18:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201002083500.796843-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 1:35 AM, Lee Jones wrote:
> Fixes the following randconfig build error:
> 
>  ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
>  simple-mfd-i2c.c:(.text+0x48): undefined reference to `__devm_regmap_init_i2c'
>  ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_driver_init':
>  simple-mfd-i2c.c:(.init.text+0x14): undefined reference to `i2c_register_driver'
>  ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_driver_exit':
>  simple-mfd-i2c.c:(.exit.text+0xd): undefined reference to `i2c_del_driver'
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index bdf8cb962027b..8b99a13669bfc 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1188,6 +1188,7 @@ config MFD_SIMPLE_MFD_I2C
>  
>  config MFD_SL28CPLD
>  	tristate "Kontron sl28cpld Board Management Controller"
> +	depends on I2C
>  	select MFD_SIMPLE_MFD_I2C
>  	help
>  	  Say yes here to enable support for the Kontron sl28cpld board
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.
-- 
~Randy
