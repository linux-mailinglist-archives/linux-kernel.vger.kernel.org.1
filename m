Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AF627AAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgI1Jli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgI1Jlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:41:37 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F905C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:41:37 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d15so458442lfq.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZVCu7z7Qfdh80dtpYoTWOuZ7uDL7n6GoxXa+kbtypQ=;
        b=ekuNYsG22huxHceVTvJlifPNoInqCCtf1OsuK8Z3cYs2SGNmiw0ZWmlvAYNIAWbubZ
         7aqEBM0E3MjkUWAoFeMFtJO2bMwrQ+Dzd3OM7NjooJzdN4baATTykcxO4dgN8rx1P/1d
         cl8/Er9Au7d9Vd+o/0HRygZ+7Is7GnryNuNeMPm4TA/WdQoWOYp/t5UNkbk3wjeYwNHn
         IG5W1IqrvpPF3v953WNic/t1//Y+CVopiTUS26MDYvVC30KJHLLEPFLgvUI2yXwp95S4
         aXoqlkpPf929Q37tPbwqi1wCNojiqOP5+ptAJ3DtXzzUY+mmxHWuOVpDLFNK8m3uOE7p
         qT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZVCu7z7Qfdh80dtpYoTWOuZ7uDL7n6GoxXa+kbtypQ=;
        b=js3OieQYpbRtA9P7plm4yF3hee7rH5b52deXHOgiPFVXvGLMswLsCk5AV1VMSprqYS
         WCBs57hkh1kBucI23tMFr5ti4ssGwB5Bll4gqVckLpbHNy+oNdgIsl9nwWu69C5gaapv
         +BIvRTqGMgZukOh8XAYJfgDZmu4eGhS3mwdpQ62AHGALZKoA4HkhcvkrW4AmrDTl98V4
         6BsK/SzIupCes9vgh/hU6K5d3y3hPk8SHgQzsSVO6oJZ2ff0osXVqAtWeKDiSOTiY8YZ
         A3rBKlg0WNWiQXy6FZDbiAmSmUjV+LLv9VUfOIHH+NRo8LAErkgrBSskQVXgTrLhTz7s
         Jsjg==
X-Gm-Message-State: AOAM5301Du/VCSDcWr8ESVWQkXMaD+D/kraHyoP9USxL7n52PNukBwSH
        r+92Mabl3b3CnbXZt7F8XYjMwON+9xVBV1DreGS1JA==
X-Google-Smtp-Source: ABdhPJyJ+3HpnJ5ROQcBj1BJr6Uk0kh/FIsy2OY0Djcl+BzwAUTCIzLs9UnE4ppTj6Cqd1mIsVLbf80kq6Ia1PW5xNQ=
X-Received: by 2002:a19:520b:: with SMTP id m11mr161552lfb.502.1601286095157;
 Mon, 28 Sep 2020 02:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-5-arnd@arndb.de>
In-Reply-To: <20200907153701.2981205-5-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Sep 2020 11:41:24 +0200
Message-ID: <CACRpkdYkL2=gkBvbHO514rnppLdHgsXwi0==6Ovq43kSZqEvUQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] ARM: syscall: always store thread_info->syscall
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

help me out here because I feel vaguely stupid...

On Mon, Sep 7, 2020 at 5:38 PM Arnd Bergmann <arnd@arndb.de> wrote:

>  {
> +       if (IS_ENABLED(CONFIG_OABI_COMPAT))
> +               return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;

Where __NR_OABI_SYSCALL_BASE is
#define __NR_OABI_SYSCALL_BASE       0x900000

So you will end up with sycall number & FF6FFFFF
masking off bits 20 and 23.

I suppose this is based on this:

>         bics    r10, r10, #0xff000000
> +       str     r10, [tsk, #TI_SYSCALL]

OK we mask off bits 24-31 before we store this.

>         bic     scno, scno, #0xff000000         @ mask off SWI op-code
> +       str     scno, [tsk, #TI_SYSCALL]

And here too.

>         eor     scno, scno, #__NR_SYSCALL_BASE  @ check OS number

And then happens that which will ... I don't know really.
Exclusive or with 0x9000000 is not immediately intuitive
evident to me, I suppose it is for everyone else... :/

I need some idea how this numberspace is managed in order to
understand the code so I can review it, I guess it all makes perfect
sense but I need some background here.

Thanks,
Linus Walleij
