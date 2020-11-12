Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04332B05F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgKLNGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgKLNGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:06:32 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB9E21D91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605186391;
        bh=sKoFwkNK0FZfJvRgRurVolmIWZI8/vuPH3IAnJnsf0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OG3UFp0+apI0eNZMt4xX27afroH5VgZCXT7+PzPFtk3paCm8DQwMim5RTHrB1ITsv
         holj4X9ZDS3saCWCz7EI01IoHjqqdmv6BdT1f4/e+j6I7frPZIAdo4orBkSBEO7AkH
         AryoopGmuEqrMPycyMdab3JIIAZN8v3G9IoZyOjM=
Received: by mail-ot1-f43.google.com with SMTP id a15so5495962otf.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:06:31 -0800 (PST)
X-Gm-Message-State: AOAM530FTrTe0LIO4S7NaP1X8rsNyisgkx9NdOIr9mrDGLur0qLzgchV
        dX3FrbJyofrpAHPUagIsraa00MLPRJWUUrXQI7Y=
X-Google-Smtp-Source: ABdhPJwYEUVjhsnzuRbZwrZo7wG6QaCpLnAHOXROlS+33fxNHzhKYzFDnFhpEExJSlMQMBB6Vb5vmoBd003mE9XQQN4=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr19755766oth.251.1605186390831;
 Thu, 12 Nov 2020 05:06:30 -0800 (PST)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <20201107001056.225807-1-jiancai@google.com>
 <CAMj1kXEAhyTfFZg4_+wTZ5+obQpAzFknC4vR1bNrRG6GpW4D0Q@mail.gmail.com>
In-Reply-To: <CAMj1kXEAhyTfFZg4_+wTZ5+obQpAzFknC4vR1bNrRG6GpW4D0Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 12 Nov 2020 14:06:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Bf8EibVRG36fKg70wTiuvNC7P2XBygTinZWbM6VzU9Q@mail.gmail.com>
Message-ID: <CAK8P3a3Bf8EibVRG36fKg70wTiuvNC7P2XBygTinZWbM6VzU9Q@mail.gmail.com>
Subject: Re: [PATCH v2] Make iwmmxt.S support Clang's integrated assembler
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jian Cai <jiancai@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 9:42 AM Ard Biesheuvel <ardb@kernel.org> wrote:

> Although I must admit I am still on the fence when it comes to the
> policy around rewriting perfectly valid code like this to accommodate
> a toolchain that nobody is likely to use to build the code in
> question.
>
> Perhaps we should at least add some rationale to the commit log why
> Clang's integrated assembler is something we should care about?

This is one of the last bits of kernel code that could be compiled but
not assembled with clang. Once all of it works with IAS, we no longer
need to special-case 32-bit Arm in Kbuild, or turn off CONFIG_IWMMXT
when build-testing.

      Arnd
