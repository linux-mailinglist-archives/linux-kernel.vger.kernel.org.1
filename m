Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D39329A744
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895316AbgJ0JEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:04:20 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6571 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408355AbgJ0JET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:04:19 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f97e27e0000>; Tue, 27 Oct 2020 02:03:58 -0700
Received: from [10.26.45.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 09:04:17 +0000
Subject: Re: [PATCH] [v2] firmware: tegra: fix strncpy()/strncat() confusion
To:     Arnd Bergmann <arnd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Arvind Sankar <nivedita@alum.mit.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <treding@nvidia.com>,
        Timo Alho <talho@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201026164937.3722420-1-arnd@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5bcc7693-6e1b-224f-1f95-9b2745aec919@nvidia.com>
Date:   Tue, 27 Oct 2020 09:04:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026164937.3722420-1-arnd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603789438; bh=IaHQsl7SVg3HnXn+o8TqiYkqYO+dY6DhSsBVvpOQFho=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=bAgLctRMT+zqOyMdLgbmfQ0eti2FBHY3Cg+f715hV+cknF6Gj3Fum4PMmb14UUEGx
         a34p0YEHLzGcNDFiLdLjKwSSBAIpTbGcjo+byrki6yAzaYwjcDn115zoHoOKrd1yMM
         uYuIZTB2IAdwf6FoStoaXgsGilxF+xOZNTY7hPFjGd7rb6D1DquT08ev/Kc3Sk2ASy
         WQxuNGc7IOzCtI89byw26PPQc7vzadUX/020fg8QM7FaCPKmMwy0qase928lyozwC4
         KsEdXg5i7NP8AIi6Ve2Gdq0sB6kO62Tpu+h8hgy5dsEjfNnWDrg744P56qy58N93W0
         iCfvd3Bfr0pCw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/2020 16:49, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The way that bpmp_populate_debugfs_inband() uses strncpy()
> and strncat() makes no sense since the size argument for
> the first is insufficient to contain the trailing '/'

I don't believe that is the case, because there is a +1 for trailing '/'
and the if statement is checking if the len is equal to or greater than.
If it is equal then there is no room for the nul character and will
fail. So it should not overflow.

> and the second passes the length of the input rather than
> the output, which triggers a warning:
> 
> In function 'strncat',
>     inlined from 'bpmp_populate_debugfs_inband' at ../drivers/firmware/tegra/bpmp-debugfs.c:422:4:
> include/linux/string.h:289:30: warning: '__builtin_strncat' specified bound depends on the length of the source argument [-Wstringop-overflow=]
>   289 | #define __underlying_strncat __builtin_strncat
>       |                              ^
> include/linux/string.h:367:10: note: in expansion of macro '__underlying_strncat'
>   367 |   return __underlying_strncat(p, q, count);
>       |          ^~~~~~~~~~~~~~~~~~~~
> drivers/firmware/tegra/bpmp-debugfs.c: In function 'bpmp_populate_debugfs_inband':
> include/linux/string.h:288:29: note: length computed here
>   288 | #define __underlying_strlen __builtin_strlen
>       |                             ^
> include/linux/string.h:321:10: note: in expansion of macro '__underlying_strlen'
>   321 |   return __underlying_strlen(p);
> 
> Simplify this to use an snprintf() instead.
> 
> Fixes: 5e37b9c137ee ("firmware: tegra: Add support for in-band debug")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: Use the correct arguments for snprintf(), as pointed out by Arvind Sankar
> ---
>  drivers/firmware/tegra/bpmp-debugfs.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
> index c1bbba9ee93a..440d99c63638 100644
> --- a/drivers/firmware/tegra/bpmp-debugfs.c 
> +++ b/drivers/firmware/tegra/bpmp-debugfs.c
> @@ -412,16 +412,12 @@ static int bpmp_populate_debugfs_inband(struct tegra_bpmp *bpmp,
>  				goto out;
>  			}
>  
> -			len = strlen(ppath) + strlen(name) + 1;
> +			len = snprintf(pathbuf, pathlen, "%s%s/", ppath, name);
>  			if (len >= pathlen) {
>  				err = -EINVAL;
>  				goto out;
>  			}
>  
> -			strncpy(pathbuf, ppath, pathlen);
> -			strncat(pathbuf, name, strlen(name));
> -			strcat(pathbuf, "/");
> -
>  			err = bpmp_populate_debugfs_inband(bpmp, dentry,
>  							   pathbuf);
>  			if (err < 0)
> 

However, this is indeed much better and so thanks for the simplification.

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
