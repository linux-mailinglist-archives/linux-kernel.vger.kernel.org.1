Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C782C3F60
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgKYLzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKYLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:55:37 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F0C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:55:36 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so2656293ejm.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtF9uhcVrQP3QDnuS0hDi/I89xP+KgxXKgC2QUsSc3I=;
        b=Th7ufiS02Kp3jadBxt0qvgAquW5QXr9W7DuC6yWAl88az2Ty4xTCGBKGR8QX5waQNd
         YlHAkZEdtQFfHp3uwH8KlzKjNLrcZjZN8PlQVe80d/knxxtAldKsni3ZVqI/42RCa+W0
         5tH1905YRdj7kmSsWQfc3lNGJpE0xMFBkkBMXZ85dp5o5mTbA4JxXixP9mCafvS05aLL
         GWQIdGG/1jQz8EhiWt3nqvk4d/lMNJgqXEapOwevsGXu6XkXECm786kV9Jm7ZeN97eDw
         Ypf/4jMY4QkKAruSegHWydcSxlj8FC+ntY9RFVTPFN+DpaXpwzem/Tyb9MvFi+MaJq+t
         alWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtF9uhcVrQP3QDnuS0hDi/I89xP+KgxXKgC2QUsSc3I=;
        b=ZIxZAEzFFiBCGOhdRnp2rjrT0IIblLn+Z/3rmuXoILjLkiA3t0TQewoi0dn8wG1fS6
         JTZa9nmXnhXCnzZMm9FHat8Lx9o+6h/k/n1Hi5hgz8Gt3lERDi6ZuIuJVG0WLalPsMn+
         epwCzexY7dmeA8RF+0IimQM1uGQNNETPfD2RSGMQyNQqve37gP3LZPf/5Rz1MCu287GW
         tTgTk/MwqEG+vkFbX/5doMo0W1ygk+m6sK/ClLvT2FwmJ67bzvagnR9WNDQlgGSoDlGG
         4oWz3ymWSjExU6kNU1uKrJhSD5/o9DmY61tDFIL9eilKS0udHVHFEnh4JauMJjvUw/7P
         HwmQ==
X-Gm-Message-State: AOAM531iUtARDy/+jobyBT4o9PCUkdcacXMy5H+roEb7tR3cOa8Enh9P
        aWfCt2dXWWJ/E/ktzvrOTf/8VJI/J6dHgMNkDLUViRU5mRo/hg==
X-Google-Smtp-Source: ABdhPJxl/Lgvv0FpYS4ZrHrNkRSJa+N3NHge8VRnUbtoeKcZvbQ+k2MPhMVdzXK5ArF+liLsa9eIZokynvYv2Ex95cE=
X-Received: by 2002:a17:906:90c3:: with SMTP id v3mr2930100ejw.433.1606305335670;
 Wed, 25 Nov 2020 03:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20201113150604.426784-1-rui.silva@linaro.org>
In-Reply-To: <20201113150604.426784-1-rui.silva@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 25 Nov 2020 12:55:24 +0100
Message-ID: <CAHUa44Fw-9ukJpeaK0YA4WHf1FtP1UteOFf54Fefur4duN+5kQ@mail.gmail.com>
Subject: Re: [PATCH] optee: add writeback to valid memory type
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 4:06 PM Rui Miguel Silva <rui.silva@linaro.org> wrote:
>
> Only in smp systems the cache policy is setup as write alloc, in
> single cpu systems the cache policy is set as writeback and it is
> normal memory, so, it should pass the is_normal_memory check in the
> share memory registration.
>
> Add the right condition to make it work in no smp systems.
>
> Fixes: cdbcf83d29c1 ("tee: optee: check type of registered shared memory")
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>

Looks good, I'll pick up this.

Thanks,
Jens

>
> ---
>  drivers/tee/optee/call.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 20b6fd7383c5..c981757ba0d4 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -534,7 +534,8 @@ void optee_free_pages_list(void *list, size_t num_entries)
>  static bool is_normal_memory(pgprot_t p)
>  {
>  #if defined(CONFIG_ARM)
> -       return (pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC;
> +       return (((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC) ||
> +               ((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEBACK));
>  #elif defined(CONFIG_ARM64)
>         return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
>  #else
> --
> 2.29.2
>
