Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658FD2F6D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbhANVTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbhANVTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:19:54 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659C5C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:19:14 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id p13so8133376ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TceHTcF0McnZIgHI+8wxLqiISbHwn8gweswvaIc4bME=;
        b=XbFX0KzGGnVD48DEJuWeKWfkf89wTxMXb4xz9YRUmIrBxYqVMl9MHYgoNMQkWBNi5j
         mhOKtO/24GuCbiPb5GHJyM0o/+dDN5cp70czhChGtKx3RK168n/3DpyiJJ5HDekgoF72
         gW4ofr1nqKIYdpQVa7P4p+1hdIz625cC0uLBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TceHTcF0McnZIgHI+8wxLqiISbHwn8gweswvaIc4bME=;
        b=OwWdJpVqZ2A6D/f0d1VJKEaJOX6UdcrCqedXfvMCJcXZZ+hVcPMNv1GoBY7XRFGmYU
         eFZxYuyQXLUqg+t/40d3vljhW/V0IPVZL2SEBReCeEsDLfso42/J8PDtKG23TMxA5Kx3
         VO2gngq/NiVD4RkrVKNgZxdcagnS2u0hT37FmUcwEwHAbnm3q1UBI15GAZANuLfTCUcW
         daTA06LwjU0WC+q/WEwjhrKNTfjM0lz5u8GJ+BwLMBbJyEZN1u7qaMpc3clGZ4LO73iN
         JA6geB0BWJtAtFdeLFCJN3vGhRvnGRPyu+gQZXUu4huDRanAy+eH4FHSB62UKH80ZN+c
         Qzrw==
X-Gm-Message-State: AOAM533MQGxggCFuTNQ5jegA3XH/ugOsILCpm38iOL5fn+sqxrGzd3S3
        hStglQ2E5ViojJfIMHOEVOA1mr7JHK/0HA==
X-Google-Smtp-Source: ABdhPJzQ6+l8YN200Kau88Nz/P+buNYMRvJ95kweMVZfen6woIBIrr6vIZUFlJ9nT3dqR9cjfEp1Sg==
X-Received: by 2002:a05:651c:1034:: with SMTP id w20mr3689503ljm.367.1610659152595;
        Thu, 14 Jan 2021 13:19:12 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f29sm664727lfj.47.2021.01.14.13.19.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 13:19:10 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id u11so8058102ljo.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:19:10 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr3904170ljj.465.1610659149726;
 Thu, 14 Jan 2021 13:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org> <161055398865.21762.12236232732054213928.b4-ty@arm.com>
 <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
 <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com>
 <20210113214436.GL1551@shell.armlinux.org.uk> <CAHk-=wjqGRXUp6KOdx-eHYEotGvY=a5tSY1mF-BkAcX2YAuBYw@mail.gmail.com>
 <CAMj1kXFaDNRbDvr43VLEHFRHHS0sGGcF=iTfES4sxPg-rZ34NA@mail.gmail.com>
 <CAHk-=wjHTpG+gMx9vqrZgo8Uw0NqA2kNjS87o63Zv3=WG2K3zA@mail.gmail.com> <fd3f26b7a70d3b90f1368c55532e463ef2fb9fa4.camel@perches.com>
In-Reply-To: <fd3f26b7a70d3b90f1368c55532e463ef2fb9fa4.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jan 2021 13:18:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjgvt1Ei72BTrEH5fgfqykVH-AYt56-7yBT8Lcprj7bEg@mail.gmail.com>
Message-ID: <CAHk-=wjgvt1Ei72BTrEH5fgfqykVH-AYt56-7yBT8Lcprj7bEg@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Joe Perches <joe@perches.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:52 AM Joe Perches <joe@perches.com> wrote:
>
> Given the upgrade requirement, and how clang version requirements
> constantly change, how much more difficult would it be for others
> to use gcc 7.1 or higher now instead of later?

What was the argument for jumping all the way to gcc-7.1?

I do think we want to have real reasons we can point to, rather than a
"just because".

            Linus
