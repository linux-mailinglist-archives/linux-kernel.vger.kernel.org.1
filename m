Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F73276ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgIXHdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgIXHdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:33:33 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5214BC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:33:33 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 60so2301855otw.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kiO+fgs6Ve5h4RCBGtQS8AkvVbCFKZKtQnQ6I4kNBkE=;
        b=WbI0mMqCP0hE8walnGfwhKZDWdBAz1/5/o52hFGk7GMEIoEy32qVsIwxX+lixs3lNl
         sayw1GABk7BUBphSajcXCMtyZp12zaOPiXNByZYLat2Amo2yQ/0+FNbt27xeP9Le9mCI
         QCaRgTsFcrjmZxf4PR8gKIfXP8AxBgXGCpbHineljgGHevuCvhW6obYV0yMLM9CwZR3w
         cuMnbfe7FEdYdZ/OfwH5p0wZUscENwDPXQ3hMaYOcbc8xUD0877qQgBJ5BPemCUeAR/h
         LLy10fNH84dZioQT+xn1AKEjh7Pc9t+aJNL13VrvP+McPr1eWXDGtXniT9H4MzZKjA36
         rpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kiO+fgs6Ve5h4RCBGtQS8AkvVbCFKZKtQnQ6I4kNBkE=;
        b=REK3hIufqRI+2eSrG79hSKNa5aqj2FEqkfQXPyM6uFVTpngPZgq4Br+cPa5HIeXKW5
         rTFweKlkii6driWztaEc7MRCutv19bmzrYAEQmBg7SeGnub40O7nxLLBZEkecFQJYSe9
         WPXK1aPQoEoxYIxDAjb66ID8ruj0RqodXhFIk4I5XP/uPmhppshNAmipMAxkGOAOIJqo
         AmFiKHaxidFI5lPHjIO0wjqDGXZX/QSe3qTcHEVuRpnGvXEQeaWr13Dp/KXGTVZWipTO
         wyqhQ17dkp2oTshtxAy8uLGl7R7KeuQruNaK2huTMYNYkxmWqd356yGqLieIzOPKwkRl
         pRVg==
X-Gm-Message-State: AOAM532HLaX3LGL8MeB4BYtT3dJA5EYwDo4WDlgWNGvj7yVmQoEjBMVh
        7Hyr1rg6oDmLMj1WA6+EBOI2p+ELeHLzzWGWPbdqHw==
X-Google-Smtp-Source: ABdhPJyhhLM+NVE/SSkz+8Z1J5JHAlIMZuwULdczWru3oqwHl0IiZf7KmK332/phJj26FSUgiC0IGvuYrza1lEpW0H0=
X-Received: by 2002:a9d:7c7:: with SMTP id 65mr2307574oto.268.1600932812723;
 Thu, 24 Sep 2020 00:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200917081356.2083345-1-liushixin2@huawei.com>
In-Reply-To: <20200917081356.2083345-1-liushixin2@huawei.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 24 Sep 2020 09:33:21 +0200
Message-ID: <CAHUa44GmCC0-WLjGJJN8-mWyHdRxS84+2hi1vUG1zKx3=t09RQ@mail.gmail.com>
Subject: Re: [PATCH -next] tee: optee: fix type warning of sizeof in pool_op_alloc()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 9:52 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> sizeof() when applied to a pointer typed expression should gives the
> size of the pointed data, even if the data is a pointer.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/tee/optee/shm_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> index d767eebf30bd..9fdc667b5df0 100644
> --- a/drivers/tee/optee/shm_pool.c
> +++ b/drivers/tee/optee/shm_pool.c
> @@ -31,7 +31,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>                 unsigned int nr_pages = 1 << order, i;
>                 struct page **pages;
>
> -               pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
> +               pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);

In this case we want an array of pointers as you also can see in the
type of "pages".

Thanks,
Jens

>                 if (!pages)
>                         return -ENOMEM;
>
> --
> 2.25.1
>
