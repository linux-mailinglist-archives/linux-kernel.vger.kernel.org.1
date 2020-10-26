Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B787729928F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786130AbgJZQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:35:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36033 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786122AbgJZQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:35:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id c5so7156619qtw.3;
        Mon, 26 Oct 2020 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ERc0BB3m56dqHl5HJ2w8Pcruz+ZjG3J2VixGsoMlKiE=;
        b=H59SXVYZzuvc8pz6mMLluvoPUBaQ+n6VGpDxxsXjRPth9mNlPH8qSJm+TxeBmyMVSn
         cJ8U6ATe5IeU/Jyv8UiZTzTqBgR1vkf57EGlrsVmnsTaVuk1U0GccRmhKfFmuTxSOS47
         uuLbRBGhNTqY9yxLV39aLqpdVDT4hVOsJ9lDZktw6asztD1Wj10JvL3j8qfcJzlSrksR
         GEgIWW5k+RQUT1A1u65xRkj5gdNRlKB1Ugi3L3+D2FGdLH8s2rtfqWjXUGGAMj6TH/NM
         3TXo6S5jO+IxdViq51ec2mG34STdSdD8qLwXmaZ/IU2DrjOTiPkXIEkX/N8UfaEYc6Lk
         YFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ERc0BB3m56dqHl5HJ2w8Pcruz+ZjG3J2VixGsoMlKiE=;
        b=XTQkzqQ704u+WuG6rSkX4R0Xx+uc+18ljegLwly0wgFMWH9oBz4ycv8ZkQyRQoRqDp
         QTjiw2mE4d/B7eQb+/Hv/rmtKQFg9YNhSa/ZrJfpD7aIIJu0L7DsLeAaBdAK5gVXuHDD
         DPnNuP63TCkIeQFHhJlyXdCMmgjd5BrrV6moDSBi4+IonTVHZP6kntCcGDcjixB67WnR
         GKJRKCa9IiqVRC2oI8p/WFt0z7nNspCAkUUinVWGYbjfytHJViE6t7FUQSgGxDZzZXFu
         xeJgoDsPPVz0OEUBngP/RxivhEJMI5HOnFsczcNe//iKrHQtsuN+/5l9QNpCF8KbXFbm
         a6+g==
X-Gm-Message-State: AOAM530XDKdebSbAuf309jpLeJiDO1eC/Y4NEQ3paRs8jwYUda2Bc1hx
        gU/uQfrw0J17aenLQzkK+H8=
X-Google-Smtp-Source: ABdhPJzGh3bYL0DZPOM7nCweseTlpQ0R3vUaoZZUzIaHC2NbvYVVG44B41GrTTnPZKxMqDvlQAKyXA==
X-Received: by 2002:ac8:5a10:: with SMTP id n16mr17525630qta.164.1603730127393;
        Mon, 26 Oct 2020 09:35:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z66sm6815852qkb.50.2020.10.26.09.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:35:26 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 26 Oct 2020 12:35:24 -0400
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <treding@nvidia.com>,
        Timo Alho <talho@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: fix strncpy()/strncat() confusion
Message-ID: <20201026163524.GA1491649@rani.riverdale.lan>
References: <20201026161026.3707545-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026161026.3707545-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:10:19PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The way that bpmp_populate_debugfs_inband() uses strncpy()
> and strncat() makes no sense since the size argument for
> the first is insufficient to contain the trailing '/'
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
>  drivers/firmware/tegra/bpmp-debugfs.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
> index c1bbba9ee93a..9ec20ddc9a6b 100644
> --- a/drivers/firmware/tegra/bpmp-debugfs.c
> +++ b/drivers/firmware/tegra/bpmp-debugfs.c
> @@ -412,16 +412,12 @@ static int bpmp_populate_debugfs_inband(struct tegra_bpmp *bpmp,
>  				goto out;
>  			}
>  
> -			len = strlen(ppath) + strlen(name) + 1;
> +			len = snprintf("%s%s/", pathlen, ppath, name);

Didn't you get any warnings with this? It should be
			len = snprintf(pathbuf, pathlen, "%s%s/", ppath, name);
right?

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
> -- 
> 2.27.0
> 
