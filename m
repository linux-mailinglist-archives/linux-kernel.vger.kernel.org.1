Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C014821F61E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGNP1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 11:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNP1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:27:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7714C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:27:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k15so11967494lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCyLOhQV57mz1Tz9y5V98kqwmWTue4420M9y+zk47sY=;
        b=JrWgTBRdBX1cUe5aCb73+TsaK4ECM13FS6SYZxjTTs/VcET75Za3d/5OpAFolMLiG2
         rmM293nxQKfX4PiAjnofjoAJ6qAZh+dcMJ5TZE8IAzVTRLCvzUlr0FPZQ4Ha2hKtav0P
         Hy7ruQElpq2zZYq8uOxErUU6Ocv4g8NOdw6hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCyLOhQV57mz1Tz9y5V98kqwmWTue4420M9y+zk47sY=;
        b=WizdoWNSRMJ421eUGh0fLK7a1QQKCZmE2FauMsZQGds0pMm+6Bjp2Ll+JnTBMzXMFz
         UydDUu0y+7gASEJI4TX5u5WT1XdpDYu13/Ry/hU87FLEhXvwxrVWqaihZrg5k707w2pI
         FT0WjFQU4pqmL+niAEnYD9Pbi5xTqfd9AMDihS6X0gtYpP+uBV3BDFYTuFo8FsY9Smno
         0Zajvb/Z1CGdmczYAH2NKQnBqu8R6CisorjqTSydUtJNWWPPZgOPW1KdWulm9gDBKc2z
         u4kH0WoPFdqP4g5W6k0GZjZkvhhZbhO61zKeTZVMCpRhtov0HYQtP9ic+oMWbhHu3FRV
         8H/A==
X-Gm-Message-State: AOAM533TUO1+mnaxM3iVjK5MU3DXezsRQsmIl4/78q5jn26ARMpTa3jR
        Dz8SK7xtMKIC3RmKzndhFhFbkGGjvh8=
X-Google-Smtp-Source: ABdhPJwUsT0rISi8kkqrZhumLak18XUvVEYl7eUCsAQMfrhhb02bmIV5UjQn7hX0UzgzE32XgvAI7g==
X-Received: by 2002:ac2:5c09:: with SMTP id r9mr2508857lfp.176.1594740452658;
        Tue, 14 Jul 2020 08:27:32 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m25sm4715009ljj.128.2020.07.14.08.27.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:27:31 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id x9so13295628ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:27:30 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr2701790ljj.312.1594740450439;
 Tue, 14 Jul 2020 08:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-5-hch@lst.de>
In-Reply-To: <20200714105505.935079-5-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 08:27:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpYFEPMfYmNR-9SuPaeC432sC7nmZrismRHQEiR2GM4g@mail.gmail.com>
Message-ID: <CAHk-=wgpYFEPMfYmNR-9SuPaeC432sC7nmZrismRHQEiR2GM4g@mail.gmail.com>
Subject: Re: [PATCH 4/6] uaccess: remove segment_eq
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ack, just with a note:

On Tue, Jul 14, 2020 at 4:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -33,7 +33,7 @@ static inline void set_fs(mm_segment_t fs)
>         set_thread_flag(TIF_FSCHECK);
>  }
>
> -#define segment_eq(a, b)       ((a).seg == (b).seg)
> +#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
>  #define user_addr_max() (current->thread.addr_limit.seg)

This "uaccess_kernel()" interface is a better model anyway, because at
least on x86 (and from a quick glance at others), we might avoid the
exact equality comparison, and instead do simpler/better things.

On x86-64, for example, checking whether the limit has the high bit
set is not only more flexible and correct, it's much cheaper too.

Of course, trying to get rid of all this means that it doesn't matter
so much, but it would probably have been good to do this part years
ago regardless.

                  Linus
