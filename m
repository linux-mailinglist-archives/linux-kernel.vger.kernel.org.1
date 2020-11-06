Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CD92A9620
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgKFMUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgKFMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:19:59 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCEFC0613D4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 04:19:57 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h22so1152117wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 04:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wu0yuz1Rqywdt2lXVmkZwBU4v10ZmblZwj+lb/B5gns=;
        b=AuRaa9NKjvddCz+g+IJRpzzDT0yuon1mPZk/iACz6uSTGVJaz0qTESiPnTFJoscCOe
         dC8dAdzkCI5Ipkpep5GqWxcutifG9nYT5QehxhiaggAJtFGe12XpWVQ4fwZiDDVlxjCG
         IpzNm8BOYz5zR3eV/NtjcucMZZH1olctzfx3evPQxc5+Cw51l3PO24ke2hKe4SYlJJMV
         HfSIhu/0cubKXaT3t0sog2J8JPZ/pNhtkeV6hZdO+MKavjZzhQ0Jx+o/Ghk3J/OGVLSX
         HwhGZHCVqx5TfMg+7F7b/pkwuBv+vHaCcCI13q91RwJ3QEGT60eLMtYHGt7IMlB6wGpg
         72fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wu0yuz1Rqywdt2lXVmkZwBU4v10ZmblZwj+lb/B5gns=;
        b=eiT+bG7QpmYDB4xkneZaCZoHUn/dRHdTcLl4l/TdjiZVRxpT8CgbwP4CLIfNNS2jJU
         RfrSz+nfCQ6Pe08LDSJl5taDbrEIynw7jlT2SvyQtIzqWhcnQnlrKZjECgsG3bXtWYmW
         tV/nJK3fjCfjejuwxrzFwwNujZbg2YXakDvnufp0pt50yWzNUbJ37ORGb1X2rhBsM8sv
         KfzVguJlqqOkDBE3dIzi/7FDXGSXnaeXCSAToWBrm/bPZMBrPajQZ2iIYEYhZbc8NUMh
         064SweKZhnVEo2cFxa7xwlUjObOlENJE5x5cCi+3+rJkzIUOQQ4yhXf9saxpWXCWZ/+B
         rjiA==
X-Gm-Message-State: AOAM533wZzxhtnIwNnDc9HWdsoYbn0GA4NR/VUMrH/DTRRJl5g7iB8Hy
        rlehaQ8IlZbTY16Zxu6C8fMwEqeDvSsnN1FNcMqAcg==
X-Google-Smtp-Source: ABdhPJyyH6ginqB6su10N1e1YY6ro31XfgUroej4pOpV0frsYt4K7s0DBw+Zdgfhh4n1WLRCAiVrIz/RvyBlQ0KqQwo=
X-Received: by 2002:a1c:c906:: with SMTP id f6mr2300366wmb.9.1604665196366;
 Fri, 06 Nov 2020 04:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20201106172616.4a27b3b3@canb.auug.org.au> <20201106092149.GA2851373@elver.google.com>
In-Reply-To: <20201106092149.GA2851373@elver.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 6 Nov 2020 13:19:45 +0100
Message-ID: <CAG_fn=Vf7vX7r1kyqd3pqPZnNN9kKO6gtmum+E=X_PLmxG=Uqw@mail.gmail.com>
Subject: Re: [PATCH] kfence: Fix parameter description for kfence_object_start()
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 10:21 AM Marco Elver <elver@google.com> wrote:
>
> Describe parameter @addr correctly by delimiting with ':'.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  include/linux/kfence.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 98a97f9d43cd..76246889ecdb 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -125,7 +125,7 @@ size_t kfence_ksize(const void *addr);
>
>  /**
>   * kfence_object_start() - find the beginning of a KFENCE object
> - * @addr - address within a KFENCE-allocated object
> + * @addr: address within a KFENCE-allocated object
>   *
>   * Return: address of the beginning of the object.
>   *
> --
> 2.29.2.222.g5d2a92d10f8-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
