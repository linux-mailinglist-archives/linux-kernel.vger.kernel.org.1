Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95A2F9DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389870AbhARLJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:09:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389234AbhARLH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:07:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B05E22B39
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610968036;
        bh=B/17V8ik89vtsXGIR5+vI5O++z0spXLfDzc6QxMu1fw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aTncI8ZU9DRrKPERRayj9QYLytI0Kh+XAzNNCPDY6hqs/y7KuJuqxqeCdOcn8KWwc
         5kdM3q49VqwsdsSkm/vEWzFMrM5Whjsk9/kmfhr281dFmQjO4IbeN+fJ/IbZvicFYb
         3bSyhppvNYV9ry/FEBGh8NN7Y1duwazKrnAi6jAbDWvf+GcAhaPxBWmXl1oKAgaUmJ
         iIiWmCyw0ZE2C3TAqiAFD/EmORNKiRUWakTeZ5j7tTC6E9/QRxTiO+FJ9ZgPQ+tFKQ
         9G7Ggh11IX1tRv2WvdXIjH9Il5uij+2ckkAzdclt4F8PYSXT6MHzoNXZe1IAQfWzhH
         Ky2X/UAZ1Qm6Q==
Received: by mail-oo1-f45.google.com with SMTP id p72so3993196oop.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:07:16 -0800 (PST)
X-Gm-Message-State: AOAM530vlr2hU9tCJKuEFjIzrnX8NFFuNARJRxbbV2PlUTfWXjVNV6f4
        8wrS8d8oL0fcq/+Qrb2QYItntmvpwbx92VjFSPY=
X-Google-Smtp-Source: ABdhPJwFPZPGTu+Qjt9R5//bzwsGU6Uluiu6wFnMEUYHL4qzZzXqr90zENIoo/pr0j/FCN9aMvSZ7HQR7ov/ZjCCIL8=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr16559894ooj.15.1610968035764;
 Mon, 18 Jan 2021 03:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20210118105557.186614-1-adrian.ratiu@collabora.com> <20210118105557.186614-2-adrian.ratiu@collabora.com>
In-Reply-To: <20210118105557.186614-2-adrian.ratiu@collabora.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Jan 2021 12:06:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3dDgbppAB3Bm2iJA7LOqRvHZew1_e-yE1R=9mS4W4xjQ@mail.gmail.com>
Message-ID: <CAK8P3a3dDgbppAB3Bm2iJA7LOqRvHZew1_e-yE1R=9mS4W4xjQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 1/2] arm: lib: xor-neon: remove unnecessary GCC
 < 4.6 warning
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Collabora kernel ML <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:56 AM Adrian Ratiu
<adrian.ratiu@collabora.com> wrote:
>
> From: Nathan Chancellor <natechancellor@gmail.com>
>
> Drop warning because kernel now requires GCC >= v4.9 after
> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9")
> and clarify that -ftree-vectorize now always needs enabling
> for GCC by directly testing the presence of CONFIG_CC_IS_GCC.
>
> Another reason to remove the warning is that Clang exposes
> itself as GCC < 4.6 so it triggers the warning about GCC
> which doesn't make much sense and risks misleading users.
>
> As a side-note remark, -fttree-vectorize is on by default in
> Clang, but it currently does not work (see linked issues).
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/496
> Link: https://github.com/ClangBuiltLinux/linux/issues/503
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

Shouldn't there be a check for whatever minimum version of clang
produces optimized code now? As I understand it, the warning
was originally meant to complain about both old gcc and any
version of clang, while waiting for a new version of clang to
produce vectorized code.

Has that happened now?

       Arnd
