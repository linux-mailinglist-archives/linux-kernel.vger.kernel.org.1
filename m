Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FB5277797
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgIXRTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbgIXRTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:19:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C023C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 10:19:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so2293536pfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dA2zxHfO7uy8Ufgykgnn+hx3XJoAizz/URpCj3/0/1w=;
        b=jI1AzPsORD6qnu1/Wh4koJdDYvChTU7Fo4egmV8hQ/+Z/aWNK/2koBeyzRt0MNgFff
         YRGG7GNh4fEikfZf/aPyGjovy7zIam9l50FRsIvJ++iQKa1Fxno5Pv1lgbwvudR/Xylb
         pYzFAp1NPhSETcxpgcds3IeGFC2X01LLEWB+NJIEXuADkFdfgu/LIL1LxTPx+Px3QiUJ
         IMcP9NxT4oNHF4nab1XLLVQ3h4BuuvXHYzCEFxr25vWucwwga8+1VkdWKMyOWDLF3Ryw
         a47ix0CWMX6CrrQz5RsDV0UN9ivXTO7R0bbl4KHy0D6YkL6BIoMlsKSX1qxnyGVueGJR
         IThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dA2zxHfO7uy8Ufgykgnn+hx3XJoAizz/URpCj3/0/1w=;
        b=NFm36NugSEa9ElbYCOpsAGpwjZj75oGVWuj3EbMR1vxtxmsAmYMRf5hm6W1itJAuk1
         6PhJP4ass8tTKQPkJL36p31wvO6jY/Mk/3zr1pPROw56mYvsS/yYIgK3k7m/+DRFah0b
         MoYFZPVcTOmclH8NeqW2v0yMKER+hFvwInddSROHpbiHAjV3GrAnapPO5WzUZDgxj2pu
         kqN6e1+X1me2sVqZzKycl/3uNflroN/0njgxtbixMjAXHlldgvH4O2eZpTMovqPghVlP
         anvZDywJjrHu8nQs+Vl0Bh0v1I5tV+Ea+Jkv1fT55VJaMJr39sx6nSb+2tiYgtBX5psh
         K76w==
X-Gm-Message-State: AOAM531ofSNzNpyWiG2Dij0XH/+cBR80Y41EPRHMfBx+ItlH9CmV6siz
        Z7ekDBg4AQf6Wae8PkUTzyNJWlBgtRw6Lj01z7vdEQ==
X-Google-Smtp-Source: ABdhPJxQgxTw4Y4KyPc/U4Nw8Wn++DdiH31qXswsQxthOCUrQ+97QMRFY6Yc6+djXVbztzE9XMZV5R9seGuH+REHJZo=
X-Received: by 2002:a62:5586:0:b029:13e:d13d:a108 with SMTP id
 j128-20020a6255860000b029013ed13da108mr137887pfb.36.1600967959929; Thu, 24
 Sep 2020 10:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com> <20200917214545.199463-1-ndesaulniers@google.com>
In-Reply-To: <20200917214545.199463-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 24 Sep 2020 10:19:08 -0700
Message-ID: <CAKwvOdnziDJbRAP77K+V885SCuORfV4SmHDnSLUxhUGSSLMq_Q@mail.gmail.com>
Subject: Re: [PATCH v3] nfs: remove incorrect fallthrough label
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello maintainers,
Would you mind please picking up this patch?  KernelCI has been
erroring for over a week without it.

On Thu, Sep 17, 2020 at 2:45 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> There is no case after the default from which to fallthrough to. Clang
> will error in this case (unhelpfully without context, see link below)
> and GCC will with -Wswitch-unreachable.
>
> The previous commit should have just replaced the comment with a break
> statement.
>
> If we consider implicit fallthrough to be a design mistake of C, then
> all case statements should be terminated with one of the following
> statements:
> * break
> * continue
> * return
> * fallthrough
> * goto
> * (call of function with __attribute__(__noreturn__))
>
> Fixes: 2a1390c95a69 ("nfs: Convert to use the preferred fallthrough macro")
> Link: https://bugs.llvm.org/show_bug.cgi?id=47539
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v3:
> * update the commit message as per Joe.
> * collect tags.
>
> Changes v2:
> * add break rather than no terminating statement as per Joe.
> * add Joe's suggested by tag.
> * add blurb about acceptable terminal statements.
>
>  fs/nfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index d20326ee0475..eb2401079b04 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -889,7 +889,7 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
>                 default:
>                         if (rpcauth_get_gssinfo(flavor, &info) != 0)
>                                 continue;
> -                       fallthrough;
> +                       break;
>                 }
>                 dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
>                 ctx->selected_flavor = flavor;
> --
> 2.28.0.681.g6f77f65b4e-goog
>


-- 
Thanks,
~Nick Desaulniers
