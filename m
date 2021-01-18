Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17222FAA09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393990AbhARTY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393947AbhARTXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:23:34 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD88AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:22:46 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v67so25646008lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nyXt2BwkLcSSRby7WCMrmE+WdBMXZvF9/GDTDgxsVY=;
        b=FgEuPeyIPamZN1Ti5cyla9+JQiWchG5usHW0nz7RiFfN4ZG12cH4uk+0GptG8B/IWA
         J+9VHvATxzV0qZoPxsaWt52OJ2WeDAZZ0Ey4l9G4Byauek/KmFoS0wtarV9C1U/vQhcp
         zDcDF/LIEdOs4AuBkR07AWCI6pKVrt2L/RMZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nyXt2BwkLcSSRby7WCMrmE+WdBMXZvF9/GDTDgxsVY=;
        b=F8xw6kksUExtgW5PdzkJ272f7ddslNjodE1ux9JvzoDxGVApB7w0XzNdBrsNeSf3fj
         +nM0VkJLJNqcODkTLqvczIFL7flra/DSewuPBsiRw/uX1Nb4Iq39eXlRFqXw5BjjX7tu
         h4A7Nkkm+obVuHs+0dsz1G4iGk97x/S7Qkq069fKMt4wjyEw1dD+MSVTcnwap8pJk9RP
         pikEIP6PA36GL6lP7tjscH5o8HJ2OYeIFpondl0sInicDyrnuMBocgE+woq7w8gewKpx
         Gc6I6A+0C0qSMwpaz20OEWZA+ELsh9afgNaMSvfDgSSEH5yAyPSwdAz1/Le50e2D5qSB
         Nojg==
X-Gm-Message-State: AOAM533ALieDZf13ElMfob6jHLHk+76QU0fwnsu9HRwoO2bqpmG2BJCF
        ze6DT0Y+uFr+fhEjH/Oe2SgNnxiRcfykFg==
X-Google-Smtp-Source: ABdhPJwTPovX3N8xjJfpGxTt5Yuf6rZWXlys2ji8P6NAYh8Y9NJrupB/VSeq6/FtBW3alP1L4+ddfg==
X-Received: by 2002:a05:6512:944:: with SMTP id u4mr256678lft.433.1610997764930;
        Mon, 18 Jan 2021 11:22:44 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c16sm1997626lft.264.2021.01.18.11.22.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 11:22:44 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id n8so10588085ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:22:44 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr234936lfu.253.1610997304440;
 Mon, 18 Jan 2021 11:15:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610722473.git.gladkov.alexey@gmail.com> <116c7669744404364651e3b380db2d82bb23f983.1610722473.git.gladkov.alexey@gmail.com>
In-Reply-To: <116c7669744404364651e3b380db2d82bb23f983.1610722473.git.gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jan 2021 11:14:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsg0Lgf1Mh2UiJE4sqBDDo0VhFVBUbhed47ot2CQQwfQ@mail.gmail.com>
Message-ID: <CAHk-=wjsg0Lgf1Mh2UiJE4sqBDDo0VhFVBUbhed47ot2CQQwfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/8] Use refcount_t for ucounts reference counting
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexey Gladkov <legion@kernel.org>,
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

On Fri, Jan 15, 2021 at 6:59 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> @@ -152,10 +153,7 @@ static struct ucounts *get_ucounts(struct user_namespace *ns, kuid_t uid)
>                         ucounts = new;
>                 }
>         }
> -       if (ucounts->count == INT_MAX)
> -               ucounts = NULL;
> -       else
> -               ucounts->count += 1;
> +       refcount_inc(&ucounts->count);
>         spin_unlock_irq(&ucounts_lock);
>         return ucounts;
>  }

This is wrong.

It used to return NULL when the count saturated.

Now it just silently saturates.

I'm not sure how many people care, but that NULL return ends up being
returned quite widely (through "inc_uncount()" and friends).

The fact that this has no commit message at all to explain what it is
doing and why is also a grounds for just NAK.

           Linus
