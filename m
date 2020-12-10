Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7942D5373
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 06:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbgLJFr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 00:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgLJFr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 00:47:58 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486C5C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 21:47:18 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id g1so4013173ilk.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 21:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAOFbwBxnt71rDXSDKJIjaxYEB5+WM5T14++nLnfyUo=;
        b=iYqZ5EY4/ditEBlw0RKETn0N/f602mEOMq94MlxLcmuw+egLzIbLzwOV90bVIBtN64
         tyriFN9C53QPknEVi8r8GObzAKTIved8yU+7dlGcikEzFRW4x+Liw3rb+CBO5XOE6LsE
         FcYTQbwhJOj8ITxHYF61Tx7+w+NDCCGKBWnIImSAcDzhOFS2CUx+ctL4kukP59Nexldx
         KzYMxJSxZ+xyd6jEkFykcEL5Nhdr//yWUhz4aswgebHjcGq7AR/kwfkejDRYxakuIt8m
         yVsLMKKfub7TftukQP2E54OtjIZjM201+IAbFfHvYs/KIRszJLeNuVtKZbYXBYmPnjoT
         RxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAOFbwBxnt71rDXSDKJIjaxYEB5+WM5T14++nLnfyUo=;
        b=qnAm/HzBQnaimJk6BKq5nF926PBIz3vs5uDd+3facAOF9TbqOviQ0WkeODB9EFAH4M
         GqaZtgrl5qIiAwuwg9t7YN4d82sYEjUZK+EQKeWhu+XLEbZFJtWPiFOEs67mGFr7PnBY
         /81FD3P2WTNWHYaF8Y3F63IpA4FXCYeIN4/bh/esIRo4SIVU0H5jxr0KyXcFP12ehwrG
         9r+W1LsHQlgGHEaV6nRAsTKwtgii8Y1fR30Nbaxp1uW4sG/BYxtZC7qOJgHSp8QygGid
         6UNhubSvxxjpFc5u0pNnAAJp+aOEMwDdp25S3Kqv5U/Fmr4PWmM6tAxQQwlfY5FwFRe1
         Y1ug==
X-Gm-Message-State: AOAM5330zd/j0aK0BqUpSJAcEgzaNCsrry28K7T68GL0WQrMixz/KD7E
        /o1laf0yrrD0e483tkQuJwOFKkW2CoYgOcaQ5S+69yGgmiM=
X-Google-Smtp-Source: ABdhPJw4ax8k9YkGwPbZWMCYQlZz7TN9R8/hwwmp1kYatapBwQm8lMegOfMfuR6YQF5h8G0AlmZy6EXyC6vKfTpRbwU=
X-Received: by 2002:a92:512:: with SMTP id q18mr7720551ile.147.1607579237393;
 Wed, 09 Dec 2020 21:47:17 -0800 (PST)
MIME-Version: 1.0
References: <1607519814-86271-1-git-send-email-milan.lakhani@codethink.co.uk>
In-Reply-To: <1607519814-86271-1-git-send-email-milan.lakhani@codethink.co.uk>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 10 Dec 2020 06:47:13 +0100
Message-ID: <CAKXUXMzTpOT3MJLkmjR_Hpak8K5a7GQ-vTtNp0GbNarD6NG1FA@mail.gmail.com>
Subject: Re: [linux-safety] [PATCH] kernel: trace: Remove deadstore in trace_uprobe.c
To:     Milan Lakhani <milan.lakhani@codethink.co.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 2:17 PM Milan Lakhani
<milan.lakhani@codethink.co.uk> wrote:
>
> In trace_uprobe.c, trace_uprobe_create assigns ret to 0 but then never
> uses this value.
>

Milan, the patch makes sense, but I fear you did not run
./scripts/get_maintainers.pl because you did not include any specific
maintainer as recipient.

The patch subject could be: remove unneeded initialization (instead of
the very generic "dead store" term).

It is also interesting to see who added this initialization; was it
unneeded since the existence of this function, did it become obsolete
at some point in time due to refactoring?

Run ./scripts/get_maintainers.pl  and please CC: me; then you will get
your Reviewed-by: tag.

Lukas

> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
> ---
>  kernel/trace/trace_uprobe.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 3cf7128..c7c7070 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -541,7 +541,6 @@ static int trace_uprobe_create(int argc, const char **argv)
>         bool is_return = false;
>         int i, ret;
>
> -       ret = 0;
>         ref_ctr_offset = 0;
>
>         switch (argv[0][0]) {
> --
> 2.7.4
>
