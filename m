Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3FE2FF93B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbhAVAIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbhAVAIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:08:17 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67149C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:07:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n2so7750896iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHvuFB1KCoODk+mj+wsDxFsayadGPjSCuZ+52mFNqc0=;
        b=DN4uwSyPYoat11U4NiQe3O12PWP13mshNGZwj3ahSU5PP5LnamyQpCpNnQUNle5+X1
         51Lv8QE9vadWLlt+Uh43gwjDaoR57l7bMZ9RHXQocKoMTuRxkftWqK0DDGLdK16pwyYe
         KouCylXP2Js9FW5+ix3fzP0jCUokPOS0Ygj1lsIjUvmDXSy78yENhQWoCGSk/8jzf1uw
         IxmaPIoSDCk1WXs0gpvpoqMMm9xX2Vau8O6WxUI0Vi+Y1AcW5w90r6z7JcgMoUTiocpU
         X44l30FoOI8Tf+XJcz/dAAmVCvz8K3VjFn+h9Ayd0uw8mVJUxsmmw7plk/SYD+rEe0mX
         kJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHvuFB1KCoODk+mj+wsDxFsayadGPjSCuZ+52mFNqc0=;
        b=Gv4xa7gz1zylU/GQmc5mqXNdEZzESVEEQ/WqDseXsyA3DGjWmWMq5Twr6LTEDrwEtE
         O1Hk5AN5aNhsOTE0f4jhXpN1kXpMFMk6mgb+AxSrVKjDpn3mLIQD8F8i72KR/kpnH/LX
         eEO8RaCVMXUavjRhSuH3YbcrVXzN5s7Sa4sFpH5jrgWixRHpQFyoyXJKvS81iFT4sJ+v
         cPzyy4C8Zp5aHOswM858ZK1vh/qDfGemq6Uu2A1a29xahFgEtPeG/5JQAxU75OvzqOD9
         qKzCyJRZ4XW62yvrMMb05m89L2YgCjPHdSADDOIODg88gdVPJW08AHrMlY+ytYOm9ycv
         jF7Q==
X-Gm-Message-State: AOAM532mTuPbQbztZ89ktjwWMhF78vD7E3MjTkkGMjE3PfLKkE2cBeN3
        X8UJZUVoItzF+MnvuF/7e0lESyneE5VTnNGGy0xhYOcWT8ylxA==
X-Google-Smtp-Source: ABdhPJyvQc/gG6jdm0GvA119E8QNGFQnWR80EzlWqy5FMtqvtzVSf3iGTYFLaH0Nyd3Fz113aHJpVGvXKiI/Wzjp6qo=
X-Received: by 2002:a6b:8f58:: with SMTP id r85mr1552830iod.132.1611274056746;
 Thu, 21 Jan 2021 16:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20210121223355.59780-1-paul.gortmaker@windriver.com> <20210121223355.59780-2-paul.gortmaker@windriver.com>
In-Reply-To: <20210121223355.59780-2-paul.gortmaker@windriver.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 21 Jan 2021 16:07:25 -0800
Message-ID: <CAAH8bW8KKXnMqs-NEeB90emUz6o2Q1FLutYEAmG3cAwv0rwEhg@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib: add "all" and "none" as valid ranges to bitmap_parselist()
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 2:34 PM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> The use of "all" was originally RCU specific - I'd pushed it down to
> being used for any CPU lists -- then Yuri suggested pushing it down
> further to be used by any bitmap, which is done here.
>
> As a trivial one line extension, we also accept the inverse "none"
> as a valid alias.
>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  Documentation/admin-guide/kernel-parameters.rst | 11 +++++++++++
>  lib/bitmap.c                                    |  9 +++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index 682ab28b5c94..5e080080b058 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -68,7 +68,18 @@ For example one can add to the command line following parameter:
>
>  where the final item represents CPUs 100,101,125,126,150,151,...
>
> +The following convenience aliases are also accepted and used:
>
> +        foo_cpus=all
> +
> +will provide an full/all-set cpu mask for the associated boot argument.
> +
> +        foo_cpus=none
> +
> +will provide an empty/cleared cpu mask for the associated boot argument.
> +
> +Note that "all" and "none" are not necessarily valid/sensible input values
> +for each available boot parameter expecting a CPU list.

My question from v1 is still there: what about the line like
"none,all", ok ",all,"
or similar? If it's not legal, it should be mentioned in the comment,
if it is legal,
the corresponding code should go to bitmap_parse_region(), just like for "N".

My personal preference is the latter option.

>  This document may not be entirely up to date and comprehensive. The command
>  "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 75006c4036e9..a1010646fbe5 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -627,6 +627,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
>   * From each group will be used only defined amount of bits.
>   * Syntax: range:used_size/group_size
>   * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
> + * Optionally the self-descriptive "all" or "none" can be used.
>   *
>   * Returns: 0 on success, -errno on invalid input strings. Error values:
>   *
> @@ -640,8 +641,16 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>         struct region r;
>         long ret;
>
> +       if (!strcmp(buf, "all")) {
> +               bitmap_fill(maskp, nmaskbits);
> +               return 0;
> +       }
> +
>         bitmap_zero(maskp, nmaskbits);
>
> +       if (!strcmp(buf, "none"))
> +               return 0;
> +
>         while (buf) {
>                 buf = bitmap_find_region(buf);
>                 if (buf == NULL)
> --
> 2.17.1
>
