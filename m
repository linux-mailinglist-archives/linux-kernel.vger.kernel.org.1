Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E254E2A97D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgKFOq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:46:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgKFOqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:46:55 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8622151B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604674015;
        bh=XLMTTC2awluKxedLZISCKHbkm9xxvmnFXJZX4qOXmO4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=seymZ1Zt/wxhBysHJmHQcL/EDAIeaqe9y5cWypfEtdYsNSDNXDWce+jI47J4DW+gB
         R7tqfEB3WfJxNr7kQiIGTRjAE+LC0/ETMUYNhfvmnhFY0bZR3KZ0HXrhuxe+AogWxN
         IBzYldfjPaYMQFKYP7kPCKW/+e4TVz6kTGXqX7KM=
Received: by mail-wm1-f52.google.com with SMTP id h62so1567711wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 06:46:54 -0800 (PST)
X-Gm-Message-State: AOAM5338jCMDNVl2yfl5qeqkViio90MhWBnBnD2uDngxMvBY4F5Sxlqs
        qqPuCoeLSaW59T371VoJMA3UgEUGxAwAY8r6v1U=
X-Google-Smtp-Source: ABdhPJxluRfkoGw+7yKjOxgY55CAPQ2wZrfY/51FKfV8mad50nwDywDUEUH2tKvT7MaL8Bu8hzMB2roRmIXlzf5GHAo=
X-Received: by 2002:a05:600c:256:: with SMTP id 22mr2845332wmj.120.1604674013090;
 Fri, 06 Nov 2020 06:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com> <20201106051436.2384842-2-adrian.ratiu@collabora.com>
In-Reply-To: <20201106051436.2384842-2-adrian.ratiu@collabora.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 6 Nov 2020 15:46:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0kXkoeAbNiPH5-7-73V2nAsnCMkQSrPZq4ysVYNyE-WQ@mail.gmail.com>
Message-ID: <CAK8P3a0kXkoeAbNiPH5-7-73V2nAsnCMkQSrPZq4ysVYNyE-WQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 6:14 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> From: Nathan Chancellor <natechancellor@gmail.com>
>
> Drop warning because kernel now requires GCC >= v4.9 after
> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9").
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  arch/arm/lib/xor-neon.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index b99dd8e1c93f..e1e76186ec23 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -19,15 +19,8 @@ MODULE_LICENSE("GPL");
>   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
>   * NEON instructions.
>   */
> -#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> +#ifdef CONFIG_CC_IS_GCC
>  #pragma GCC optimize "tree-vectorize"
> -#else
> -/*
> - * While older versions of GCC do not generate incorrect code, they fail to
> - * recognize the parallel nature of these functions, and emit plain ARM code,
> - * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
> - */
> -#warning This code requires at least version 4.6 of GCC
>  #endif

I think we still need the #else path, otherwise we don't warn about
clang being broken here.

If it is intentional that we now silently build this code with clang
without it working as intended, that should be mentioned in the
changelog.

      Arnd
