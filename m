Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4795928B3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbgJLL2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLL2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:28:54 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D1C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:28:54 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id c10so612032oon.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XBDGrLSwB/6Y+76sReBKVonEBADxfEIwAHgLXgJVMM=;
        b=WNwNfCC2ACvhv6Pa/bsQsYh4kkbVFDdT5MQQONrFzL2gwX2MnK1rrG1hTLm2LOiffa
         SQNwSmdAuo7yfROtUrQKfzrgiyTB/OedKABr7BcetNgeA9/21HUAr5fvxqxBIF9BdvGF
         vTgCZRXUVz3zUO6A0eUpkN4bYxvqxZa4c4JKHwV2amoJLfuMy48tIJ1PLvPi2Fec8av0
         3IPFllGnuCE8yt8J8sDzBxSGKNyTU0x4sgH0xJCnIkGjwklwaZ//LqiA76vGJudwFaUK
         uPBFzsKZlcfkVQg7JnhB0Mpt6tT0RpU1t0YIMdzjrtYA5y2vzpw3cSpDZEg4VJnRNf6e
         PeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XBDGrLSwB/6Y+76sReBKVonEBADxfEIwAHgLXgJVMM=;
        b=hRfc7wxWo+nk/egs3/rNQdskjRzMkK9S380X+muQ5yH3zsQCMLiwouVqJWX95C9+mu
         IHD1Y40rrcAmHEkvScn/LtITB/ycyJ/YfY0vc6ZqzFugtHpT+EesWfjRK71MgnBEgwcf
         KHwX2UCNLA1vSVwzn0GcVBaIzc/fTDU+Rxap2RD9JtbSOcbFWHqC+GkbIV5Z+VKVR39T
         bypTes5wtlhvcfqEXA+qKazp3Y2Cny18PTf+DwZo0Hp2PeK9/RwvAIG5iicGF/6QNeCS
         LWHFN5qz+s9434OllkDm7qVHLR2DN+zmY1yKMhFUSr7eG489dyWOOwNq8yojCENslwB+
         W7qg==
X-Gm-Message-State: AOAM531GTifwLRmHhuhcCKC6s4FFb8O/wtDcF2B3YLxqepePzgRgcFCx
        56asgQWGXtxjsc64MXltUYBrBC1GIqH1UBhNU+E28w==
X-Google-Smtp-Source: ABdhPJxsRy1faO20CsKmVxozicKRHXjn1dAMVKdnEGKL74LeSp9bzA6YqEnp2aHZxDujgJpSWMrKE9d4pcir8ovYK6w=
X-Received: by 2002:a4a:db6f:: with SMTP id o15mr18181579ood.36.1602502133520;
 Mon, 12 Oct 2020 04:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201012105420.5945-1-sjpark@amazon.com>
In-Reply-To: <20201012105420.5945-1-sjpark@amazon.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 12 Oct 2020 13:28:42 +0200
Message-ID: <CANpmjNP3oZZsOkE4sP---sXoa-K8yBB9fBXc8JzqQNXs2MwKUg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Update Kconfig parts for KUNIT's
 module support
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 at 12:54, 'SeongJae Park' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> If 'CONFIG_KUNIT=m', letting kunit tests that do not support loadable
> module build depends on 'KUNIT' instead of 'KUNIT=y' result in compile
> errors.  This commit updates the document for this.
>
> Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  Documentation/dev-tools/kunit/start.rst | 2 +-
>  Documentation/dev-tools/kunit/usage.rst | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index d23385e3e159..454f307813ea 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -197,7 +197,7 @@ Now add the following to ``drivers/misc/Kconfig``:
>
>         config MISC_EXAMPLE_TEST
>                 bool "Test for my example"
> -               depends on MISC_EXAMPLE && KUNIT
> +               depends on MISC_EXAMPLE && KUNIT=y
>
>  and the following to ``drivers/misc/Makefile``:
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 3c3fe8b5fecc..410380fc7fb4 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -556,6 +556,11 @@ Once the kernel is built and installed, a simple
>
>  ...will run the tests.
>
> +.. note::
> +   Note that you should make your test depends on ``KUNIT=y`` in Kcofig if the
> +   test does not support module build.  Otherwise, it will trigger compile
> +   errors if ``CONFIG_KUNIT`` is ``m``.

s/Kcofig/Kconfig/

>  Writing new tests for other architectures
>  -----------------------------------------
>
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20201012105420.5945-1-sjpark%40amazon.com.
