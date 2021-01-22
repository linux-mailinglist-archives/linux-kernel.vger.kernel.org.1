Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FCD2FFD42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbhAVHT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbhAVHTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:19:54 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:19:13 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e15so3456254qte.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5yLU65Fe3IuAHXx8cjCG5sZm4Fz5SXC5JXyvsBEXsg=;
        b=mJ9KZWmXo1+rdFPWsRnB33UJ77RdAJJMlNiPPprrIgA2jGORm1wfLwE2zLzSuPrF83
         1tB6FmCC3Lh/cJiixI9Qxx2ueS4R95F4dgZ++7STmzz01Df0EnBnRbY/7D6zWYzofS2W
         BLfKofxTepysqtyp7/xO6hGy06PV1ND0fu186moLfhmM431rludEySBq/wOzV8j9i/9X
         tlxisYwed1wmwanJNHbvnaHhjxUa6bTw5wa+NRKMNhXk4ItEVoyOsFF9d38+SvFIJT3c
         qoFEd8DmHBt3B/pw/zPA9uNFYXvIpH077ZZRWsdEcQ6VykS0c11FA2J9lFIFXjFblUq5
         UbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5yLU65Fe3IuAHXx8cjCG5sZm4Fz5SXC5JXyvsBEXsg=;
        b=hnrB4+vzSNH+KfHN21Nob/Jp0OuEgjfsh0yV9hvWSKt+4z65CR12xst36COtJMb3jv
         ACKM3gFeClcl++zOp4vWj4IlI01YEWvln9eNEJwIbdeMB1kI7Ff4jI7mmIMWgtkTj4fo
         aPwHaILw84ilk+PZ+XWLHMa4lnislMcxUlh7l/6MiFy9SaPKM0gXLy1Ljw8Uxy70Zlv6
         cOZZxoupm50OSuQa4vip2URTQBmVNyfPrNUf1bmn82DtWhyHbrM50C4DNQ1wYGAa8g7+
         H9XHED+hGB93Zsee8X5QlDkaFx1gzTbwCogkptgqUbMHMLCr9jwrG4uhglbZvVFIqH9m
         Dcig==
X-Gm-Message-State: AOAM530C2veIxVB38LN6oUamLx0vQMq0vkdXxAuvKvRM+4AEGEB2h9Qw
        0hl1Rf72abbS1J4qnihl+W9x13ZwkFS9B32bEN13L50EE2U=
X-Google-Smtp-Source: ABdhPJwFKcwLMIdBm0luLXtCynSiuUpiOr2gVe4vAfKQX5hVggrErKvLk+vbmlUp4WcR73ZLszWR+bOAEe4FzM5C+PI=
X-Received: by 2002:ac8:5c41:: with SMTP id j1mr3229991qtj.306.1611299952654;
 Thu, 21 Jan 2021 23:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20210108112626.8623-1-alexander.kapshuk@gmail.com>
In-Reply-To: <20210108112626.8623-1-alexander.kapshuk@gmail.com>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Fri, 22 Jan 2021 09:18:35 +0200
Message-ID: <CAJ1xhMVn3O-7VhYKCmjH4NNuyRModcLJkURow+g=67tghAUgAA@mail.gmail.com>
Subject: Re: [PATCH] ver_linux: Eliminate duplicate code in ldconfig
 processing logic
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 1:26 PM Alexander Kapshuk
<alexander.kapshuk@gmail.com> wrote:
>
> The code that acquires the version strings for libc and libcpp is
> identical, as is the printversion call. The only difference being the
> name of the library being printed.
>
> Refactor the code by unifying the bits that are common to both libraries.
>
> Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> ---
>  scripts/ver_linux | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/ver_linux b/scripts/ver_linux
> index 0968a3070eff..a92acc703f9b 100755
> --- a/scripts/ver_linux
> +++ b/scripts/ver_linux
> @@ -15,7 +15,7 @@ BEGIN {
>
>         vernum = "[0-9]+([.]?[0-9]+)+"
>         libc = "libc[.]so[.][0-9]+$"
> -       libcpp = "(libg|stdc)[+]+[.]so[.][0-9]+$"
> +       libcpp = "(libg|stdc)[+]+[.]so([.][0-9]+)+$"
>
>         printversion("GNU C", version("gcc -dumpversion"))
>         printversion("GNU Make", version("make --version"))
> @@ -37,12 +37,10 @@ BEGIN {
>         printversion("Bison", version("bison --version"))
>         printversion("Flex", version("flex --version"))
>
> -       while ("ldconfig -p 2>/dev/null" | getline > 0) {
> -               if ($NF ~ libc && !seen[ver = version("readlink " $NF)]++)
> -                       printversion("Linux C Library", ver)
> -               else if ($NF ~ libcpp && !seen[ver = version("readlink " $NF)]++)
> -                       printversion("Linux C++ Library", ver)
> -       }
> +       while ("ldconfig -p 2>/dev/null" | getline > 0)
> +               if ($NF ~ libc || $NF ~ libcpp)
> +                       if (!seen[ver = version("readlink " $NF)]++)
> +                               printversion("Linux C" ($NF ~ libcpp? "++" : "") " Library", ver)
>
>         printversion("Dynamic linker (ldd)", version("ldd --version"))
>         printversion("Procps", version("ps --version"))
> --
> 2.30.0
>

I'd appreciate getting some feedback on the patch in question at your
convenience.
