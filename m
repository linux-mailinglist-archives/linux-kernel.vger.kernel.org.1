Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5229B2F255E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbhALBRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbhALBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:17:54 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3766C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 17:17:13 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id o195so235691vka.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 17:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwodCnoTd5iinruqOw9v+f7fNpo6ey4C5JTJngxT1fY=;
        b=NiFUb+xlR9l77SRPdvYOWbB+wKmzPy04rjqd1eqSjfyWmn8PkNdC42su/XLVRMg/N+
         kd4+AN2SkcxRt6K+etxF5VgdXH60d7zlaMToJ+FlJw4++zixKZC2LCxWydUYArKXyLne
         qdkShVaz/2EuMAt6sd8D4fKV7SypnJ6epppT1nvRmCUr09M/mkD25cYDMEzNrzWj4J8R
         IB1P+dgvAsWd3+jO7WrXBvv+cPcwdB8ANVHTH4TVZWT1HPYiDsooda0FeaTn1aa/ZZ1z
         RzRyTJIsB+RmTFxMko6KTI+d/qcXIbI8ANxK9FwkW6Ez34AGeVkn0cWQQqWL87egs46y
         bmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwodCnoTd5iinruqOw9v+f7fNpo6ey4C5JTJngxT1fY=;
        b=igzM2+4/uOY8Bv2pzJc7hBX5QjZZwmv3qAK5ifo8Am4gcayv6/vEOIK3IoeqS5Ahyu
         sq08nEb8PLwBguUB8qTXNjoX+U4SILf/lEEzmBrlqxdQ4gJ5bJG+fBDiNXIj3SYrYWZz
         y7G8uweHTCwADhcqKCVN/8KKuL4hECC0Bo4xOi7dKxyZnrGbmpl1jAlklLL/ukOadlB7
         wi/NKjY3E8GrSIfP3YPow6TX6nQ7Lz7qK7rGUar7wq72ujsqGnRQsF5FJaDBzzh9QHiJ
         dlXROLdjhJbLDC+GIAY7k4mEnBadtrQheFmUtutNzh3D9MOgWdAAU8CU+/k+baCvBDaC
         OiJA==
X-Gm-Message-State: AOAM5324fnQ791OU3OzY9jJqevTBZhxEM/Mo+1NZOZ1382U4FBotx5D6
        uHcTQVr1JQYpPViAmrzui9gLHzGTTrI=
X-Google-Smtp-Source: ABdhPJwzQKPu2npJr8CsBq8OdTPY04Hdce0DgZGEDsjyCUquMs+Q+MtDcQMP1zcjZGtc0UCQscnKOQ==
X-Received: by 2002:a1f:8d92:: with SMTP id p140mr2139785vkd.19.1610414232226;
        Mon, 11 Jan 2021 17:17:12 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id i11sm235968vki.26.2021.01.11.17.17.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 17:17:11 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id e15so611626vsa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 17:17:11 -0800 (PST)
X-Received: by 2002:a67:6995:: with SMTP id e143mr356433vsc.51.1610414230636;
 Mon, 11 Jan 2021 17:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com> <20210112005823.GB3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210112005823.GB3579531@ZenIV.linux.org.uk>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 11 Jan 2021 20:16:35 -0500
X-Gmail-Original-Message-ID: <CA+FuTScKa+1WMLywzNTraCxkHAshix6v4Fxf3kh5ZENirsicMA@mail.gmail.com>
Message-ID: <CA+FuTScKa+1WMLywzNTraCxkHAshix6v4Fxf3kh5ZENirsicMA@mail.gmail.com>
Subject: Re: [PATCH 0/6] fs: deduplicate compat logic
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 7:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jan 11, 2021 at 07:30:11PM -0500, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > Use in_compat_syscall() to differentiate compat handling exactly
> > where needed, including in nested function calls. Then remove
> > duplicated code in callers.
>
> IMO it's a bad idea.  Use of in_compat_syscall() is hard to avoid
> in some cases, but let's not use it without a good reason.  It
> makes the code harder to reason about.

In the specific cases of select, poll and epoll, this removes quite a
bit of duplicate code that may diverge over time. Indeed, for select
already has. Reduction of duplication may also make subsequent changes
more feasible. We discussed avoiding in epoll an unnecessary
ktime_get_ts64 in select_estimate_accuracy, which requires plumbing a
variable through these intermediate helpers.

I also personally find the code simpler to understand without the
various near duplicates. The change exposes their differences
more clearly. select is the best example of this.

The last two patches I added based on earlier comments. Perhaps
the helper in 5 adds more churn than it's worth.
