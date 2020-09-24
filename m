Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44216276561
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 02:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgIXAqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 20:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIXAqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 20:46:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B093DC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 17:46:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gx22so2104969ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 17:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRg8bdIf5EpG+3h++Ew0iu9r6E0witVaxm9lrud8jnM=;
        b=Jm4qQfsFbsCSvqsbWq7VzfNoNGVob5/4BshRZEiIMaLEiUAXQkk+Y3gcARpDMXU77J
         RNaw2tpVInTue7BsyBCtZUkwt1eYCijqBRs3vrwEJYWjEAwHJ8jLeLp72F/ENGNnzE/G
         EKLslOPjHX6mp2Z2Qnz3aMgbngWhizN8kdzLcINc5IUUtx9RxOv0ebO8UbHBC6gSmDIu
         FMCxqDS4rALBmlhRBAReUsXiYxckjsgN9L9hJAj6XCsRyzlTxLl/Flt+z8WTU64FZVbm
         sP3KAo4BFVXnMvrmr7UNX6TFr6Ec+XsfqaoZ3kZpDC57gQ1BxVuKxSN63q3jyaZxfJpd
         B6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRg8bdIf5EpG+3h++Ew0iu9r6E0witVaxm9lrud8jnM=;
        b=kTSzWAH03EDj/GKEYbRF4sws8HX/OAaqb5uahjwXpUVsNubE3jIZq6ecu4mxHkgy+Y
         S8Y+46QUpUajGxc9zkD3hyO8AxeN+g4VNsRjlgGjbDkehNHzbreyac1N9XKt88pHlQ0L
         qTLdwoC6Ei84yyOZZV8jLItDu4vkrbwY3q/R7vvyde+ehRR1ZVWbALQFYCEO1ym6qMC/
         wJ5fTXHhKR3tYLyjcVzQ3P2ED2MvGWhtTJ2iGxzgnnnI4ptN1OrFGgzwF2OdaJUN/lk2
         18miNwrwK8tDvzf3CJaQF+cGrlRqks3WPoG8zkBpJe8c+frH+ymsnvEqQR4NVMVztQ7l
         O+VA==
X-Gm-Message-State: AOAM533diZ/ddY+tm5KSC3aW8eMFIngHoDqZSy7Pf/xVvN6LKOp2WT7o
        RoP6DK2fMEhOjfym4Luwva9vnSBz5+ZFs93/QIJHMQ==
X-Google-Smtp-Source: ABdhPJzzIXGNXnvZht8wsxEFTZoPCFI82VwWeUCzB6ZEDBf5qTi4KSqQ4F0OnePwzJ5/m1L4tVXPR+clKCQEE2r6v2g=
X-Received: by 2002:a17:906:f6c9:: with SMTP id jo9mr2116692ejb.233.1600908371207;
 Wed, 23 Sep 2020 17:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org> <20200923232923.3142503-3-keescook@chromium.org>
In-Reply-To: <20200923232923.3142503-3-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 24 Sep 2020 02:45:45 +0200
Message-ID: <CAG48ez1BXWdWA5zPzOD21bQ4RsHQ6bSDWR8soTkkNphJ=zdHWw@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86: Enable seccomp architecture tracking
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
> Provide seccomp internals with the details to calculate which syscall
> table the running kernel is expecting to deal with. This allows for
> efficient architecture pinning and paves the way for constant-action
> bitmaps.
[...]
> diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
[...]
> +#ifdef CONFIG_X86_64
[...]
> +#else /* !CONFIG_X86_64 */
> +# define SECCOMP_ARCH                                  AUDIT_ARCH_I386
> +#endif

If we are on a 32-bit kernel, performing architecture number checks in
the kernel is completely pointless, because we know that there is only
a single architecture identifier under which syscalls can happen.

While this patch is useful for enabling the bitmap logic in the
following patches, I think it adds unnecessary overhead in the context
of the previous patch.
