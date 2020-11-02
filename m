Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E562A3125
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKBRPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKBRP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:15:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8935BC0617A6;
        Mon,  2 Nov 2020 09:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=kY8nxtxSx3r09CKBimdC1BarQSeukB+zCO2mlqb8faY=; b=tIixBm7W0Y1H8b5N42QUk5f3B/
        bL1aZRjqJB924clhDCkViGl9XyFgFec5O98RQlI1MhkEB6xiI8CkSe4mkGK2o8ah9hV2s9Z3Zkgn0
        stfnuEvc7of/dq7R8hLZpoWoPzBS89Pt6MxJ8sobm1lQaP6WfKncGWHsAEEfN3jRpp7ls6yE4PAvS
        5h6eCHqSyxVkCUgPJyyiGh9OJrRbhv8HFXspp1n45801jYDHd+RCL59vjZqJjRBSswEa+X7c2Da5c
        9ga87RESykW6w3ydH/GeluGqW5FCCBO0hCCiBVPN32FQyDfQI8H5LWhUT5BZ1iqQ/zFwmGIoKypPW
        91vLvnZA==;
Received: from [2601:1c0:6280:3f0::60d5]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZdQS-0005BM-Ms; Mon, 02 Nov 2020 17:15:25 +0000
Subject: Re: [PATCH] clk: imx: scu: Fix compile error with module build of
 clk-scu.o
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <208469.1604318525@turing-police>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6e5a8fdb-0a02-5eae-ca1f-37df8a454e34@infradead.org>
Date:   Mon, 2 Nov 2020 09:15:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <208469.1604318525@turing-police>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 4:02 AM, Valdis Klētnieks wrote:
> commit 77d8f3068c63ee0983f0b5ba3207d3f7cce11be4 (HEAD)
> Author: Dong Aisheng <aisheng.dong@nxp.com>
> Date:   Wed Jul 29 16:00:10 2020 +0800
> 
>     clk: imx: scu: add two cells binding support
> 
> This missed a #include, which results in some nasty errors when
> built as a module
> 
>   CC [M]  drivers/clk/imx/clk-scu.o
> In file included from ./include/linux/device.h:32,
>                  from ./include/linux/of_platform.h:9,
>                  from drivers/clk/imx/clk-scu.c:11:
> ./include/linux/device/driver.h:290:1: warning: data definition has no type or storage class
>  device_initcall(__driver##_init);
>  ^~~~~~~~~~~~~~~
> ./include/linux/platform_device.h:258:2: note: in expansion of macro 'builtin_driver'
>   builtin_driver(__platform_driver, platform_driver_register)
>   ^~~~~~~~~~~~~~
> drivers/clk/imx/clk-scu.c:545:1: note: in expansion of macro 'builtin_platform_driver'
>  builtin_platform_driver(imx_clk_scu_driver);
>  ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/device/driver.h:290:1: error: type defaults to 'int' in declaration of 'device_initcall' [-Werror=implicit-int]
>  device_initcall(__driver##_init);
>  ^~~~~~~~~~~~~~~
> ./include/linux/platform_device.h:258:2: note: in expansion of macro 'builtin_driver'
>   builtin_driver(__platform_driver, platform_driver_register)
>   ^~~~~~~~~~~~~~
> drivers/clk/imx/clk-scu.c:545:1: note: in expansion of macro 'builtin_platform_driver'
>  builtin_platform_driver(imx_clk_scu_driver);
>  ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/clk/imx/clk-scu.c:545:1: warning: parameter names (without types) in function declaration
> In file included from ./include/linux/device.h:32,
>                  from ./include/linux/of_platform.h:9,
>                  from drivers/clk/imx/clk-scu.c:11:
> drivers/clk/imx/clk-scu.c:545:25: warning: 'imx_clk_scu_driver_init' defined but not used [-Wunused-function]
>  builtin_platform_driver(imx_clk_scu_driver);
>                          ^~~~~~~~~~~~~~~~~~
> ./include/linux/device/driver.h:286:19: note: in definition of macro 'builtin_driver'
>  static int __init __driver##_init(void) \
>                    ^~~~~~~~
> drivers/clk/imx/clk-scu.c:545:1: note: in expansion of macro 'builtin_platform_driver'
>  builtin_platform_driver(imx_clk_scu_driver);
>  ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:283: drivers/clk/imx/clk-scu.o] Error 1
> 
> Fix by providing the include.


also
Reported-by: kernel test robot <lkp@intel.com>

However, this driver does not directly use <linux/module.h>.
platform_device.h #includes <linux/device.h>, which is where the
problem lies:

<linux/device.h> uses macros that are provided by <linux/module.h>
so <linux/device.h> should #include <linux/module.h>.

and that fixes this commit:

commit 4c002c978b7f2f2306d53de051c054504af920a9
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon Dec 9 20:33:03 2019 +0100

    device.h: move 'struct driver' stuff out to device/driver.h

> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index 229a290ca5b6..15d382f6f9f8 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -8,6 +8,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
> +#include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> 
> 


-- 
~Randy

