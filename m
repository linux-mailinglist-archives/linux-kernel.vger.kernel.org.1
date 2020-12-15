Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5352DAAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgLOKKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgLOKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:10:10 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06027C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:09:29 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id h4so13597477qkk.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFXoGhP33Z2M+MhFYkiIX03ainL8Vg+7xHv22X3m6As=;
        b=l6ZST4+2Om881OA76+doSDEegDBXsgmQzFKU3jIWkNLbcAfxxZXy+eBoPXhUrmv5q8
         lLp95Ih8Ukds9mkI+60a8sWLS5G4sldp5+95jJtxyvw11sGIL075WGeRV/EHzUKog1z9
         b6cuA8RHJWnCQjt+mN9LhTuA2st0kWU0/lDmWw9BsKUmy4vgUEzK+JD9hIcfwyu+j91z
         YKKCbydUyTKKswqwx9WQRGXwwJvDtK98sZ8q48dxUaBfWnaVTfMlaw2et+KSzD4iUBHM
         hxuEJB2kd6CdD2FYfQ+WUNxAcJSwoZnkkOD07AjZfavEA7bPQ2BsBEqttZxAScKcULJZ
         cOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFXoGhP33Z2M+MhFYkiIX03ainL8Vg+7xHv22X3m6As=;
        b=sZeTee+0QwT+09GgWhDzuHiip8YryTjT8J/C3atsGAIuNnuvEWOW9lW32HRWMxVccz
         LBAiyNBneIctjD3WdouB5C0oYMT1DFkpqOG5LbPwiWGjAoHrumlrl5MHV04zy7Btyvtb
         n4ozQJ8L6uUB3VcN5egXWwLv2fvt7B3LnI24Xy5GFzxLlmfGgWGvNUuAiYwkzJ9Fmpi8
         j6TpNXpIVooBrvKp+7Si9utwTNFOmFev53KuKx+L+8Q3bMPG9iESRbEe2GMZQVUtDn5j
         47fGSXTMSQKWBd9EArsqUU80KIPrVrZTJCjHQpcwJkBA7oqWiCaFG7Qs74OALgqyOHWd
         JJVQ==
X-Gm-Message-State: AOAM531GJpH3of7hR71s1VtVsFpmcIhADiyklUVJgDR32dbKb3LwHwrQ
        DM7ROQId1J2XP0Ruql19/20GAK+W/WtxFauLIt5NLg==
X-Google-Smtp-Source: ABdhPJxGRDn6odzvgqZ4+O0zDko/8Ht2aWnT4kFyzwruF1B8at/WUTExCMI0nPRahusDqGUGZTY2JnAio6lsHrtpsXo=
X-Received: by 2002:a37:56c6:: with SMTP id k189mr36569594qkb.501.1608026968905;
 Tue, 15 Dec 2020 02:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20201210023638.GP52960@mit.edu> <00000000000024030c05b61412e6@google.com>
 <CACT4Y+bkaVq1RzONGuPJxu-pSyCSRrEs7xV0sa2n0oLNkicHQQ@mail.gmail.com>
 <20201210182821.GS52960@mit.edu> <CACT4Y+bqDdidJpYimvzY5UkrXzw7JuefHndOM0+c6Y8e56vBjQ@mail.gmail.com>
 <20201214203608.GJ575698@mit.edu>
In-Reply-To: <20201214203608.GJ575698@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Dec 2020 11:09:17 +0100
Message-ID: <CACT4Y+Yz+zahS-7OjcYvn9a1RWsW4XJ7-_HWPcd4PR8mrMSajg@mail.gmail.com>
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 9:36 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> (Dropping off-topic lists)
>
> On Mon, Dec 14, 2020 at 03:37:37PM +0100, Dmitry Vyukov wrote:
> > > It's going to make everyone else's tags who pull from ext4.git messy,
> > > though, with gobs of tags that probably won't be of use to them.  It
> > > does avoid the need to use git fetch --tags --force, and I guess
> > > people are used to the need to GC tags with the linux-repo.
>
> (I had meant to say linux-next repo above.)
>
> > syzbot is now prepared and won't fail next time, nor on other similar
> > trees. Which is good.
> > So it's really up to you.
>
> I'm curious --- are you having to do anything special in terms of
> deleting old tags to keep the size of the repo under control?  Git
> will keep a tag around indefinitely, so if you have huge numbers of
> next-YYYYMMDD tags in your repo, the size will grow without bound.
> Are you doing anything to automatically garbage collect tags to preven
> this from being a problem?
>
> (I am not pulling linux-next every day; only when I need to debug a
> bug reported against the -next tree, so I just manually delete the
> tags as necessary.  So I'm curious what folks who are following
> linux-next are doing, and whether they have something specific for
> linux-next tags, or whether they have a more general solution.)
>
> Cheers,
>
>                                         - Ted


syzbot does not do anything special here, it just polls/fetches always.

Here are sizes of checkouts that it has now, these also include
in-tree builds, that may explain larger differences. They don't look
too bad.

2.8G upstream-bpf-kasan-gce/kernel
3.1G upstream-bpf-next-kasan-gce/kernel
5.1G upstream-gce-leak/kernel
6.3G upstream-kasan-gce/kernel
6.3G upstream-kasan-gce-386/kernel
6.3G upstream-kasan-gce-root/kernel
6.3G upstream-kasan-gce-selinux-root/kernel
9.3G upstream-kasan-gce-smack-root/kernel
2.8G upstream-kmsan-gce/kernel
2.8G upstream-kmsan-gce-386/kernel
2.9G upstream-linux-next-kasan-gce-root/kernel
6.3G upstream-net-kasan-gce/kernel
2.7G upstream-net-this-kasan-gce/kernel
5.5G android-414-kasan-gce-root/kernel
6.5G android-44-kasan-gce/kernel
6.5G android-44-kasan-gce-386/kernel
6.0G android-49-kasan-gce/kernel
6.0G android-49-kasan-gce-386/kernel
6.1G android-49-kasan-gce-root/kernel

And the one is used for all patch testing on random trees is 5.2G, it has:

kernel$ git remote -v | wc -l
60
kernel$ git tag -l  | wc -l
7544
