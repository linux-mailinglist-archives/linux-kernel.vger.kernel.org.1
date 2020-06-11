Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513EB1F5FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 04:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFKCN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 22:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKCN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:13:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE938C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 19:13:27 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id x1so4789845ejd.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSclIs7n5vpOSvxh2OrnHeX+5b5kOfOtKGtkOgLl0/Y=;
        b=v8+6EYjaTY6Fw2wnUUu6UJNua3V+Lp53KEHLNac2TEyYj9A2BadRkPLnSl/9YGGSyY
         T+OtnVMqO3xg/6L/4Nz08Mjb8nZo6NBSLdJSDqdfsJfSBLSCJh8KebIiyYCwV/s5cM9p
         N4Xs60MSyKAQ/KYjoC7hCG5yphEFesouJle1fShaDIcorlZn0iBB3bbrrytdHDbAELFC
         UYcuflCA6Bvrd9rGKshvhPFITNVjLQFiijsQMxQ7HyFPN9KDpI8QFlufe6imer80UQPr
         4owye83ciH2aTw1fRvOmHgKrDhXFOgRLnp8gb82hFc5C85ZqJeNOSAiMFX+2AEbsAjdn
         lRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSclIs7n5vpOSvxh2OrnHeX+5b5kOfOtKGtkOgLl0/Y=;
        b=WHt5aucTT0/ChXwBJ9j5jdo+mWTxXHI64u+k79mvLg4rldAphk+PwolFhERt4VPh2X
         IcYs/SyyYeWMDQjhlQSypV94zxEx9TQ77VHQKjkF0S/iZ4whFDKU7903nOB9/YKDPFv6
         /91iXtsCPQDYI2fC9CweuCkq4M5ZKE/WJxPrQNUl0LaCyl3fTjp/ZgwxVp3bqBV4FuTo
         wMytk2jQKoQuKQiNuQF0H2p7rhb9kUOsYbAhzLN8sq29a51G8UgsYzJuk5h+qEzHTpjz
         Ydph8vkofHZLgcumBa/Ot4gSkeQZGrLcCjq/1vjC8w99Xqir6HpsFb1xZXTUvGzswYpb
         B/1g==
X-Gm-Message-State: AOAM533Cl0Zvkl0prUA4p9Bav6nDOe8YaMxBTmGIySzmgLpC8FhJkShm
        UPG3LqbdvjXiCTH5aCPTZ9RYuDhPJDYRzRZv5Rq/
X-Google-Smtp-Source: ABdhPJyoOh4d1o3ex77cQD0moZLEf9Ht3wehb6wOgCo5liChTu7jBmv/acKYI4ooL1J0tjr7yhg8ntLwvLjO71Zudho=
X-Received: by 2002:a17:906:19d3:: with SMTP id h19mr6064005ejd.106.1591841606286;
 Wed, 10 Jun 2020 19:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200610215713.5319-1-trix@redhat.com> <20200610215713.5319-2-trix@redhat.com>
In-Reply-To: <20200610215713.5319-2-trix@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Jun 2020 22:13:15 -0400
Message-ID: <CAHC9VhTd0HSv6Yk8NxJeC=U7wPb0AtRturAGYLfxg8B13h0FOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix double free
To:     trix@redhat.com
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, jeffv@google.com,
        rgb@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 5:57 PM <trix@redhat.com> wrote:
> From: Tom Rix <trix@redhat.com>
>
> Clang's static analysis tool reports these double free memory errors.
>
> security/selinux/ss/services.c:2987:4: warning: Attempt to free released memory [unix.Malloc]
>                         kfree(bnames[i]);
>                         ^~~~~~~~~~~~~~~~
> security/selinux/ss/services.c:2990:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(bvalues);
>         ^~~~~~~~~~~~~~
>
> So improve the security_get_bools error handling by freeing these variables
> and setting their return pointers to NULL and the return len to 0
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  security/selinux/ss/services.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks Tom for the patch and Stephen for the review.

I've marked this for stable and merged it into selinux/stable-5.8.
Considering we are just a few days away from the close of the merge
window and -rc1, I'll probably hold off until next to send this up to
Linus.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 313919bd42f8..ef0afd878bfc 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2888,8 +2888,12 @@ int security_get_bools(struct selinux_state *state,
>         if (*names) {
>                 for (i = 0; i < *len; i++)
>                         kfree((*names)[i]);
> +               kfree(*names);
>         }
>         kfree(*values);
> +       *len = 0;
> +       *names = NULL;
> +       *values = NULL;
>         goto out;
>  }
>
> --
> 2.18.1

-- 
paul moore
www.paul-moore.com
