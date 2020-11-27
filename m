Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DFE2C6ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgK0Rpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgK0Rpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:45:55 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA034C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:45:54 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k14so6430922wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1n5fsmwMkl7ENwlZX1rRTU8284GTmLIy0zxBDKHXo0=;
        b=09wjDsifbXW+/YC0VP3hGLmLIcPmyhYb06Uid2dlH3XzlzEVy/rUkwcpr9uveX1s2z
         jHtHhaUTbul354EJYSjswxwuyFqJyV5wM47dbmyUgSXPTVfSn/uOdQbBgVj9ykJbYQsd
         t55lFw/kdh73LP9Kf+dfriRme7zbCel4+s066odxxum9wuTvwxDB00GssHUP06LyJYfi
         iJ7l+k8oIUWv2F37XoaHVwcTFk5W0qlielEXOpzcINBzmjzkzELtadK9Gwa2wb8LtYx6
         OoE+bRlBk6QHK2S27KKbd0KsqsuGUeJPElqupG+hDQK1+/2xH+UGb9PqZdKdEEURaQbL
         XMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1n5fsmwMkl7ENwlZX1rRTU8284GTmLIy0zxBDKHXo0=;
        b=bNb33tWAokUQWe8z8TmQ2mDNaRm0am6IsWna2Nr8R3qe4AsLnoBLETbZaPh0lQftAW
         /yttjzxy+18d2H32UDW9POCX3VrDZ7eibYhuckZ+ylISF5/ojeY/eDNkSfazZ4lw677B
         nLEG7KfvIBK2R8wvHnQjXgXNAyV0p3iBHQu2aj/Yy/n/3NHhB3MVBbkhpS/sTujiVUDV
         /VDoS857FGnmBVzYHnEIZGwZDlAkTNzgqBD7U4EO8eSXNfSf65xx4Z+swTaBedTvTR0x
         DnXPXUwIz7QwFX+fAl4xbzfjLX+Q2N/VaMxeOSwJCVNipKMEZm/DnuGZWBRvbOwEr4e9
         xqxQ==
X-Gm-Message-State: AOAM531YlnC/lXOhZND7m46vW8V623aCBN0PwRGerzYw+F3MXiUsbqnh
        7ehrRCMI5P2Ct9dTw5r9+rFFk+7rBrz3WDqiTPiXCg==
X-Google-Smtp-Source: ABdhPJymjuej0Gg9fZCAlXp+Sik4Nh8LQvnq9a+DNJEu81ppTAKtX58BVmfBcSnxf6k4C4NweEPIrvJUzm05Et2hZes=
X-Received: by 2002:a5d:5482:: with SMTP id h2mr12033763wrv.18.1606499153001;
 Fri, 27 Nov 2020 09:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20201124101952.7909-1-bp@alien8.de> <20201124174647.GI4009@zn.tnic>
In-Reply-To: <20201124174647.GI4009@zn.tnic>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 27 Nov 2020 09:45:39 -0800
Message-ID: <CALCETrXXuUmM6LPj36h2KLw5zuKUPnmrACcOq2-8XfXzWXQt7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v0 00/19] x86/insn: Add an insn_decode() API
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 9:46 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Nov 24, 2020 at 11:19:33AM +0100, Borislav Petkov wrote:
> > In any case, at least the case where I give it
> >
> > 0x48 0xcf 0x48 0x83
> >
> > and say that buf size is 4, should return an error because the second
> > insn is incomplete. So I need to go look at that now.
>
> Ok, got it:
>
> ./arch/x86/tools/insn_sanity: Success: decoded and checked 10000 random instructions with 0 errors (seed:0x826fdf9c)
> insn buffer:
> 0x48 0xcf 0x48 0x83 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90
> supplied buf size: 15, ret 0
> supplied buf size: 2, ret 0
> supplied buf size: 3, ret 0
> supplied buf size: 4, ret 0
> supplied buf size: 1, ret -22
>
> the current decoder simply decodes the *first* insn in the buffer it
> encounters and that's it.
>
> When you give it a buffer of size smaller than the first instruction:
>
> supplied buf size: 1, ret -22
>
> while the first insn is 2 bytes long:
>
> 0x48 0xcf (IRETQ)
>
> then it signals an error.
>
> Andy, does that work for your use cases?

Is -22 (-EINVAL) the same error it returns if you pass in garbage?
How hard would it be to teach it to return a different error code when
the buffer is too small?

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Andy Lutomirski
AMA Capital Management, LLC
