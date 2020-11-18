Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D25E2B7541
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgKREIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 23:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKREIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:08:21 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D87AC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:08:21 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id j205so980350lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mp+Vroo0rgtt2LNJx7TBAoTI4+rINDo7kS1LVmSFjDQ=;
        b=iK2dIyEDzGJ4yMiRb4QI+7zcQfRBeZmHZ/zxc5NbkNTZEamHaEMKSW5PbWG8wv89rN
         471mrXhMwwYrmYYRGZdJsq8R9bRX7AoPW436lNbPK9iYpMqXVTC+hDVKsHdDM8BA1d6J
         l7+ULemfRlLfbrowddpVDAWmblTVYDIsqvyyF7XB6EszXFXq4M1oUj6Xo9kgdY+29mJ0
         4oI82JLCJKAPUUCVQFgkT7cRYsoKzxDJJQz1T+IJZXgrXdhgDKyv7DnCFj9/R0cR7hjV
         JrB3ANgRkpm6ekbNgQ04fDnoFvqn57MApjZg4buAHFrABqb3AbbKK2YCBvjPvBHc5ySn
         eVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mp+Vroo0rgtt2LNJx7TBAoTI4+rINDo7kS1LVmSFjDQ=;
        b=HzKJJ0+LUEqH3oNwqviGZllpcpHlLEZpTBydzx6puRCsgowPNw6pvbeojfCquEgUbG
         trd6q8jQP8p4NR00CCa5458n9P8rvs/MFVJHzFIqcZpBjsunlT20j7nPiYryVeK/+wgs
         TLMj+7Q6dFTsOP9/8SzCZhWjSTkbaRlytlrp6oc4A944RZoQ+35EPJAdfuMEQKLd6ObR
         gcS7Oci5A9iTarOawoYZ2qnIbR8gKStxzZsJ+ZalGYODwum3uVFFtZHEXnZEFGRlcna7
         S3ZBxZk3qaPu5UnZMfXw/6tSuy2oX2RAJLMnjurmL/32FjVTwxlCwgYw/kDrzcMIPXaS
         qoFQ==
X-Gm-Message-State: AOAM5327dltEMaUL/nSN6KRZ9lMSKfxpIbW24GgxZS2Tl22L5ulz5Moh
        zTWt1JKy0ZI4JGZrvJBb6MIiZqEPao8obWXkGZoHScjw
X-Google-Smtp-Source: ABdhPJyJ12zTjRjdNV9RLkcyaO/xkqjz2+D4EmD532bD6FIs7AfKO7QFEfFZh6sndLQIm2184VQqc4YmRXYKN25ToaQ=
X-Received: by 2002:ac2:4645:: with SMTP id s5mr3015256lfo.196.1605672499753;
 Tue, 17 Nov 2020 20:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20201110084245.3067324-1-luomeng12@huawei.com> <20201111183129.3c58ca0c381e30d05b1392c8@kernel.org>
In-Reply-To: <20201111183129.3c58ca0c381e30d05b1392c8@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 17 Nov 2020 20:08:08 -0800
Message-ID: <CAADnVQ+u0bxvAC+EpdGTsg023UtVAcXyUcV4kKWF+ia6ZxBJ5Q@mail.gmail.com>
Subject: Re: [PATCH] fail_function: remove a redundant mutex unlock
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Luo Meng <luomeng12@huawei.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@kernel.vger.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 1:31 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Luo,
>
> On Tue, 10 Nov 2020 16:42:45 +0800
> Luo Meng <luomeng12@huawei.com> wrote:
>
> > Fix a mutex_unlock() issue where before copy_from_user() is
> > not called mutex_locked.
>
> Oops, thank you for the fix.
>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Did anyone pick this up?
If not, please resend cc-ing bpf@vger so it can get into patchwork and
be processed by bpf maintainers.

Thanks!

> >
> > Fixes: 4b1a29a7f542 ("error-injection: Support fault injection framework")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Luo Meng <luomeng12@huawei.com>
> > ---
> >  kernel/fail_function.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> > index 63b349168da7..b0b1ad93fa95 100644
> > --- a/kernel/fail_function.c
> > +++ b/kernel/fail_function.c
> > @@ -253,7 +253,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
> >
> >       if (copy_from_user(buf, buffer, count)) {
> >               ret = -EFAULT;
> > -             goto out;
> > +             goto out_free;
> >       }
> >       buf[count] = '\0';
> >       sym = strstrip(buf);
> > @@ -307,8 +307,9 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
> >               ret = count;
> >       }
> >  out:
> > -     kfree(buf);
> >       mutex_unlock(&fei_lock);
> > +out_free:
> > +     kfree(buf);
> >       return ret;
> >  }
> >
> > --
> > 2.25.4
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
