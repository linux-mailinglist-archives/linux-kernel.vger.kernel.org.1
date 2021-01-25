Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27BE302C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbhAYUFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbhAYUEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:04:54 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E733C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:03:49 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id f3so3386129vkf.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJRMbTRRloC4ByjFwFGEnIOGZ/UkfA5A8mZRjnJ17NQ=;
        b=KjsttOonKeAC1qIfM6M/2H3LKc6ZeinA/67juLe8y0Zhmwu/kmO0BbX51cFKU8y2lr
         IJB36ukskFCo0d1Hr25DJ9sW9uRHZwlWSCreLp/bls94stg2IOx1RwCt32O2ryswSrO9
         TbabLdAVxiw88m87tHTeGEA+JrUVMYIp6vpJVN1f97WGeP7wNjBuUrSrf4nfDJ1Mh5n3
         sKEOOKD5zKcIcrNg7Zlk1ZLWCpebzhDIGj8kIAJvXxuIG50TR254zpqrimleT7YPtd11
         2vVEYFdStgUfjxCT8qvEQh0ZM1qltJVowUqXiPB/ulri3ehSImmwFfCDCUJK0DYAbltJ
         xogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJRMbTRRloC4ByjFwFGEnIOGZ/UkfA5A8mZRjnJ17NQ=;
        b=CIKexbF/l4KA+9n9Ju2hxtUXAyZsOg9oOeqjlFVqyx262coivt0NHsaujHovR0yiOy
         523XYsojDoeeyVT8K7/MaIF69iANxgM+6NU1Jr54ByRldnbF3W62fk4+0b2Xz1i3vVv7
         BkzVTyABrJjJrbaJk91f481GrrVCYcZEQB2IOHDaxi9yJg6hR5cp4HjgXrpzZYZegtvz
         jf5LWyVioM5JuK6wwNeIxPfgD39hMTiVEnenMt9GBUDOOwg6G4iKFjtKfx/BmtdwUqRS
         4K715qCVFjFcthc/208OBfMU0CilTmBXPF+LPXqt6RLpOT0X2cIis8qDcjP+o6qPYcLs
         vO9w==
X-Gm-Message-State: AOAM532bA6nHUBMsLVjd2X9xRhruZ6YIfgJOadK38aj6E25Evk34vOjX
        JcVmV7gIem0dOPCZL+IRxtk/tv8XPw+c8HQ3ctHDkA==
X-Google-Smtp-Source: ABdhPJwTVYqylFBXojPqUmOQz7yXE402U4BaXrEt38qZme8obE7vikcA5hv8M+5KAPkf2T9mTpu9mwBpsxvWk4eIU7o=
X-Received: by 2002:a05:6122:31a:: with SMTP id c26mr2284156vko.0.1611605027946;
 Mon, 25 Jan 2021 12:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20210125190925.3655829-1-samitolvanen@google.com>
 <CAHk-=wj0NKCw30deEEThF+9_F7JDobfO-VTJm64gqvp4zzsWfg@mail.gmail.com> <CAHk-=wi8mBdnj7QEO9yRzzoJDc+JqfKgy1gXU9iZL8=fF=YO8g@mail.gmail.com>
In-Reply-To: <CAHk-=wi8mBdnj7QEO9yRzzoJDc+JqfKgy1gXU9iZL8=fF=YO8g@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 25 Jan 2021 12:03:36 -0800
Message-ID: <CABCJKucWV3V10KRiHN+Oph-nffrBmo6Sc6+jAKJasQ8wFekRJw@mail.gmail.com>
Subject: Re: [PATCH] n_tty: fix redirected_tty_write checks after write_iter conversion
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:45 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jan 25, 2021 at 11:27 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Obvious ACK from me.
>
> Greg - if you have nothing else lined up in the tty tree, I can take
> this fix directly if it's easier.
>
> And Sami - how did you actually notice? Some lint-like tool, or is
> there something that actually broke from n_tty not handling a
> redirected tty right?

Neither, I noticed this because the conflicting function declarations
broke Clang's Control Flow Integrity checking.

Sami
