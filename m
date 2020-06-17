Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DF1FC3DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 03:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgFQBwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 21:52:19 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:28804 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFQBwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:52:18 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 05H1q28Y015200
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:52:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 05H1q28Y015200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592358723;
        bh=gOutOJhSmQlsr80xF0eYyx9mawYN/OMZTxoCZcFjFmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oDgv2GajdFeii4IVs5n5DgOWqeWkAfxuEz2jZ6Y38/MP0PJYxCbQwPIfl8EsF8niO
         CfIkZViIx+5RjA3XEJNsCVghqYPBdJbTfH1CBeuYLWrmaNKLqrxYi4qB0Xf5c0B+JE
         hOoJSudnmZoZAJwtssJLqWLfMQEdzynMCwZBhRsZRAxq2s2/yI7BTsMx6Kwe1jc7Rz
         ClwjTasooicw4UtxANfKLixMZG25GfiEAIpDIzYKf1u7y9wrphAK4gJwup0lLsVee2
         j0JQrfihZZWM5hwvPh6UoWCfB/cj1YvkDV1lYLqS6SmkQ5DvnFjQHMEdAuqa2XzC+V
         xny9IjzIInCLg==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id b13so244450uav.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:52:03 -0700 (PDT)
X-Gm-Message-State: AOAM5318VSTkziHPZ2qecYBd54/8dE7A7ahPsnfp154TdbaoF2Y3GWBU
        NlizTJNY5khgtG1EKExjsrd4uxK7yWfIjPFdeUc=
X-Google-Smtp-Source: ABdhPJzeJtlp/QCzdGks/6crfp82QrV68OobORFcwhb6vAOC3RVqFY2TmgxK0oVWTShbYwf7NS7+UKPzc20YQzJHHEM=
X-Received: by 2002:a9f:3791:: with SMTP id q17mr4504203uaq.95.1592358722288;
 Tue, 16 Jun 2020 18:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200616125132.1586086-1-standby24x7@gmail.com>
In-Reply-To: <20200616125132.1586086-1-standby24x7@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 17 Jun 2020 10:51:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5537+Jy7c0uWSH1YcdkSopuyoWhfoSj7wqRuzjfDrcg@mail.gmail.com>
Message-ID: <CAK7LNAR5537+Jy7c0uWSH1YcdkSopuyoWhfoSj7wqRuzjfDrcg@mail.gmail.com>
Subject: Re: [PATCH] scripts: Fix typo in headers_install.sh
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 9:51 PM Masanari Iida <standby24x7@gmail.com> wrote:
>
> This patch fix a spelling typo in scripts/headers_install.sh
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>


Applied to linux-kbuild. Thanks.

(I fixed another typo in the commit description; "fix" -> "fixes")





> ---
>  scripts/headers_install.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> index 955cf3aedf21..224f51012b6e 100755
> --- a/scripts/headers_install.sh
> +++ b/scripts/headers_install.sh
> @@ -11,7 +11,7 @@ then
>         echo "asm/inline/volatile keywords."
>         echo
>         echo "INFILE: header file to operate on"
> -       echo "OUTFILE: output file which the processed header is writen to"
> +       echo "OUTFILE: output file which the processed header is written to"
>
>         exit 1
>  fi
> --
> 2.27.0.83.g0313f36c6ebe
>


-- 
Best Regards
Masahiro Yamada
