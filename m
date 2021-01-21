Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175AE2FE598
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbhAUIws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:52:48 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:39102 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbhAUIvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:51:23 -0500
Received: by mail-ed1-f46.google.com with SMTP id b21so1483761edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yz6hsPQHJw9vP0UDQ81E3z6DsxAatSqY0B56w17zOO8=;
        b=WeqSPricFocNocvp5HSgtK3QAVPJoL1Ii4zyW3JcrNjE8x7LR95lTw5WSTIU88vNjb
         S7jzLQpUNcfhur6kHHpgU3ejbVuZfHHJEM3SywFxG9AdF3HZbT6crGWRaamar3UTwY5/
         /D8tWkgEKB4y9NdieVEk80Mb8J6fWtJFxJ+v2gsI3hcqS7gQNpd1f/xo5NMKtMIrQHCO
         gOTU2cCIVACfwDPaZyDVKQSDyIfiTHeEQjmL94wSPHfAXwN0hL+BWM1j5dc6yQLUWSqR
         zbxDHJEAnzSHKVfPkCwRT0Vwn/ctGD0i6JlSTKGEZpAXMDLseniMEbtQe0bDXtvZIRYy
         Chyw==
X-Gm-Message-State: AOAM532W05GzK+QCsQ1LMACWVhsUgQmllFLdScHBoXulANaOaof46IgD
        sdt6cMd3o4UzGdUyUeQuIEWs4KIkHxc=
X-Google-Smtp-Source: ABdhPJyamALEhte72Lbbo2HwiZ40lmudTYIrm24uM7+u9eMzWR7WiHwSNe10R5FanNPh9mTkDq/PHg==
X-Received: by 2002:a05:6402:14b:: with SMTP id s11mr9859555edu.214.1611219040931;
        Thu, 21 Jan 2021 00:50:40 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id p27sm1934245ejd.72.2021.01.21.00.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 00:50:40 -0800 (PST)
Subject: Re: tty splice branch (was "Re: Splicing to/from a tty")
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
References: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
 <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc>
 <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
 <CAHk-=wiw=+A3Lnru7cvTbEka0QTpt14QBA06C49n+SJ_WQ1VFw@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <ce1230bd-e310-9b2a-a1ed-1547bd7181e7@kernel.org>
Date:   Thu, 21 Jan 2021 09:50:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiw=+A3Lnru7cvTbEka0QTpt14QBA06C49n+SJ_WQ1VFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 01. 21, 2:18, Linus Torvalds wrote:
> On Tue, Jan 19, 2021 at 8:44 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I'll come back to this tomorrow and do the line-buffered icanon case
>> too (unless pull requests pile up), and then I'll be happy with the
>> tty changes, and I think I can submit this series for real to Greg.
> 
> Greg, I don't know how you want to handle this.
> 
> I have a branch with my tty splice patches at
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git tty-splice
> 
> and that now includes doing that "cookie continuation" thing even for
> the N_TTY icanon modes.
> 
> It passes my local tests, and I did try a few rather odd things. And
> Oliver tested an ealier version without that final commit on his load.
> But...

Hm, I would like to review this first. I noticed the changes only 
because a new branch appeared when I grabbed your tree and the branch 
has "tty" in its name.

So for example:

> @@ -1038,18 +1045,15 @@ static ssize_t tty_write(struct file *file, const char __user *buf,
>         if (tty->ops->write_room == NULL)
>                 tty_err(tty, "missing write_room method\n");
>         ld = tty_ldisc_ref_wait(tty);
> -       if (!ld)
> -               return hung_up_tty_write(file, buf, count, ppos);
> -       if (!ld->ops->write)
> +       if (!ld || !ld->ops->write)
>                 ret = -EIO;
>         else
> -               ret = do_tty_write(ld->ops->write, tty, file, buf, count);
> +               ret = do_tty_write(ld->ops->write, tty, file, from);
>         tty_ldisc_deref(ld);

if ld == NULL => crash here.

So can you send the patches to the list and Cc me too?

>         return ret;
>  }
thanks,
-- 
js
