Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D77303AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404218AbhAZKqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732248AbhAZCIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:08:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0022230FE;
        Tue, 26 Jan 2021 02:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611626889;
        bh=myj+A9VM6f2bAOWnRAgm+Vl6nSMM98u6ZKVu4g545vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vd9a5u+ESOGW1wViN/4prjqqmljIAtvuwVgYRob7YicKRMKDUHGkRmy84TH3dJUzC
         ShQ6Y+r0/gtvRbNnSzEuglRp+W5BUloYXWqmRjrSTsCaHuIXuE5yJFiLQub04ygJbK
         5MgOqij2J7z+D2iWQjbu53JGOVdIijqQ8trgIkdObW5Zr5m/Dwmt5NunSNlGaagPXL
         b03O2cekx8WeDbwbk6g1/xJi3EQXjjxubQYt+fAUConCRnnX3jfizrbvLZgC3jWgAy
         GaeS9wpKDlfajx1EclBQY4cmoUnxNpMrBPMrJNXWIklkFGqB3/f5TByUVZz7O22fSn
         gQ2r2YAzyOcpw==
Received: by mail-ej1-f45.google.com with SMTP id rv9so20859237ejb.13;
        Mon, 25 Jan 2021 18:08:08 -0800 (PST)
X-Gm-Message-State: AOAM530IdAciNhc+baM+ZB2BFm/e0irVvRjdkexK/+qPvBkvmmDTUBKG
        JiZV7O2zaBUcxZ6lhDxJo9KFU1eXQv5zJHWmpg==
X-Google-Smtp-Source: ABdhPJwbdF3MPMIUyvRTELo48XzJqGqsuV5xSwsBfgj3RBHvX7JDL2cW/GFbySlGFItUC8583zXJe25SrWJar+st75U=
X-Received: by 2002:a17:906:a94:: with SMTP id y20mr1953030ejf.525.1611626887236;
 Mon, 25 Jan 2021 18:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20210126015159.23923-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20210126015159.23923-1-chris.packham@alliedtelesis.co.nz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Jan 2021 20:07:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+7zTqHCWTFR+FUtt5qs4+7yd4Un9c3tc9NkTc-NuM=gA@mail.gmail.com>
Message-ID: <CAL_Jsq+7zTqHCWTFR+FUtt5qs4+7yd4Un9c3tc9NkTc-NuM=gA@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Check against '/chosen' in early_init_dt_scan_chosen
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Qi Zheng <arch0.zheng@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 8:02 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> of_scan_flat_dt() passes the name of the visited node to the iterator.
> In the case of '/chosen' this includes the leading '/'. Update
> early_init_dt_scan_chosen() to expect this.
>
> Fixes: 7536c7e03e74 ("of/fdt: Remove redundant kbasename function call")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/of/fdt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index feb0f2d67fc5..861aedf0bb7c 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1043,7 +1043,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>         pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
>
>         if (depth != 1 || !data ||
> -           (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
> +           (strcmp(uname, "chosen") != 0 &&
> +            strcmp(uname, "chosen@0") != 0 &&
> +            strcmp(uname, "/chosen") != 0 &&
> +            strcmp(uname, "/chosen@0") != 0))

2 out of 4 of those are wrong.

>                 return 0;
>
>         early_init_dt_check_for_initrd(node);
> --
> 2.30.0
>
