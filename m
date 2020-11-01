Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B082A226C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 00:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgKAXvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 18:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgKAXvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 18:51:38 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB90C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 15:51:37 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id j62so8212799qtd.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjQD2FJt/p1aXqCjeUIaEOa7xOIXTB8pAOJ6QQztop8=;
        b=b1Id3H4jkhJ3xK1NoPl7aIn+eWY5FW2UZyv10J19sCuNBkM7CaQX1T8mFon4+EzffP
         5IFO21rfJf/tyN9NLTsNb9uCoLEOz6uITP0BTLp93Ar0QmYUlJjB9ClOBeeMgN/ro+Dh
         m5Ag7mRzr1kpUArwtuxqOQQqG+EwDuNjyZj+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjQD2FJt/p1aXqCjeUIaEOa7xOIXTB8pAOJ6QQztop8=;
        b=WPh6MRELX9as8ukMZRjUc0aajVM0cLduCxh6++07V8kbd89sji8yPio4Nz1FZ6sYfz
         caVH8+WiWc5gFEzLrzqtLhzQC9dSGENO3XLHogafSjaG0AQTwwzSTYxcnkSMfuTbX9BY
         ZZD7fqYDynNWiRJgdVpoRbGInbkjQ1vXPgFhnVr6mBUdUSX5Gv+Or8PPGcnpCZ+Afcq7
         b66tLyO307rTFV6sQsQgFLKdb8zwQgnX5rh3d7FM4GUpAeJebgrM1bk37j9tKZHpW82h
         FufUz43A3x3VQG19Sx/aMYn7nQjRrq2NLex/AhxPtAKnr+uifNTj13IQdz1wFKqzS2Zw
         uMFw==
X-Gm-Message-State: AOAM531vCSHV5JEzHtoiVBqdD/ez9G5LidKPjWDitJlUdh9Sluxf3vGL
        b5WrjXISwI2N9rlOM6NU8jQY3T6y1Ao0G8aIUTA=
X-Google-Smtp-Source: ABdhPJwiVHw/di++bwpzmmsiMvSgsPlnOQMUoMnFTazlwfgRtckY5/nFThGgOIM+IhkIj0ohaNX4vWjC2HAKvYpiuOs=
X-Received: by 2002:ac8:5854:: with SMTP id h20mr12007972qth.176.1604274695580;
 Sun, 01 Nov 2020 15:51:35 -0800 (PST)
MIME-Version: 1.0
References: <20201101150622.2288203-1-trix@redhat.com>
In-Reply-To: <20201101150622.2288203-1-trix@redhat.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Sun, 1 Nov 2020 23:51:23 +0000
Message-ID: <CACPK8XeCJpbh+F4EzfmGJRt2JJHPjKGK2dyqF9BV_NUFYgc=nw@mail.gmail.com>
Subject: Re: [PATCH] soc: aspeed: remove unneeded semicolon
To:     trix@redhat.com
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Nov 2020 at 15:06, <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.

Thanks Tom. I will add this to the aspeed soc tree.

>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/soc/aspeed/aspeed-socinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
> index 26db42ef6aae..20a1d4aeb051 100644
> --- a/drivers/soc/aspeed/aspeed-socinfo.c
> +++ b/drivers/soc/aspeed/aspeed-socinfo.c
> @@ -51,7 +51,7 @@ static const char *siliconid_to_rev(u32 siliconid)
>                 return "A1";
>         case 3:
>                 return "A2";
> -       };
> +       }
>
>         return "??";
>  }
> --
> 2.18.1
>
