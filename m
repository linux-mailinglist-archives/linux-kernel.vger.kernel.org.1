Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED2F2FAB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394383AbhARUfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388530AbhARUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:35:29 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4773AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 12:34:49 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u21so19614194lja.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 12:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/gRDfD8YrbS3XwFv+1aIqhbdQ3uhWKzz+1gnqOggXc=;
        b=bt+FYJOGP9ZQRnSTHuwQLcEHZRbKmiPtmHbNsgK244Ouf8inj+gEKeqwbkLMxBsORz
         9XqHiL4j09NQl2Hbu7Zqohe8R4Mcab9BZ0x5QNfz6nqunlYqEM100bLwpChO1ztnC/8t
         YuMK5vRxoxly7Ufn/H5ahy9EptvTtBt/Xd6mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/gRDfD8YrbS3XwFv+1aIqhbdQ3uhWKzz+1gnqOggXc=;
        b=JHh69bdFeV1E5Kn0BErQ/2mUKt1oXKCqVzzKCYRnOFi+kt69hu3uegSOBNmXmCq8/a
         LthkAOJ0k5r8VR0sUQ2EIdxdTj7kagjmIz7uzybEw1hn/NXSulUD+JyiFD+lF7ffSQfl
         NJlChq7t+LDSDPTWHkNssRsRnLpmY7aW8QXCLGeUgCjwMufnvUTbiuECxSA/24984oI/
         A3SbMiqFc7t+8CThGBqf/ISpNZ1EaqK4OBzEYC/y9Bpqz2jIw07tDRGOkt4uCUQkdKUD
         /1HDmqT17uOmVOX3q7hrKqe92vESuRPeGNtHqa76Tv+XiLZKrDkf6ccYKCdNrBBLSPqM
         kEaA==
X-Gm-Message-State: AOAM5300hBq9sicWuRXTevAx1cqRphcytLZ4GHMwlxwNad4oSATo81Oh
        36C/2MVt8wrswF6DVj5etpkXQN1Z1HwGnQ==
X-Google-Smtp-Source: ABdhPJxdE8pgZhM0W6AXMN7yAL4gpmuJrjl0yHRQhPU6BoGdnHwBNAIRjwQGayj3EArRrOTWOKsi0A==
X-Received: by 2002:a2e:b5a4:: with SMTP id f4mr511212ljn.407.1611002087290;
        Mon, 18 Jan 2021 12:34:47 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 192sm2009043lfa.219.2021.01.18.12.34.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 12:34:46 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 23so25888017lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 12:34:46 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr336671lfd.201.1611002085703;
 Mon, 18 Jan 2021 12:34:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610722473.git.gladkov.alexey@gmail.com>
 <116c7669744404364651e3b380db2d82bb23f983.1610722473.git.gladkov.alexey@gmail.com>
 <CAHk-=wjsg0Lgf1Mh2UiJE4sqBDDo0VhFVBUbhed47ot2CQQwfQ@mail.gmail.com> <20210118194551.h2hrwof7b3q5vgoi@example.org>
In-Reply-To: <20210118194551.h2hrwof7b3q5vgoi@example.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jan 2021 12:34:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNpc5BS2BfZhdDqofJx1G=uasBa2Q1eY4cr8O59Rev2A@mail.gmail.com>
Message-ID: <CAHk-=wiNpc5BS2BfZhdDqofJx1G=uasBa2Q1eY4cr8O59Rev2A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/8] Use refcount_t for ucounts reference counting
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:46 AM Alexey Gladkov
<gladkov.alexey@gmail.com> wrote:
>
> Sorry about that. I thought that this code is not needed when switching
> from int to refcount_t. I was wrong.

Well, you _may_ be right. I personally didn't check how the return
value is used.

I only reacted to "it certainly _may_ be used, and there is absolutely
no comment anywhere about why it wouldn't matter".

                 Linus
