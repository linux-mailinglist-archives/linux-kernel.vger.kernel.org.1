Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112E129151E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 02:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439958AbgJRANq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 20:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439950AbgJRANq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 20:13:46 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A402FC061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 17:13:45 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v6so8463274lfa.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxGkthbhuOicJJzYUAHjMjkOp7k2zTWOMFRCAnwQA1o=;
        b=SIiMEuHhWb/JI2XHUI3ytOG/T1lgKfGalFCYU4XjJy7kbVQpoJnmHks4O2StGkpTwY
         4JuguGBTT8R+rr+OVnZufPo0cty+s4jaM1FRw+y365EmNCZ4ClaIfGi/7WMYvRAz49Nu
         MTR+Z+wjn+DqwA5LUGleZ54vjoimkx6W3PnJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxGkthbhuOicJJzYUAHjMjkOp7k2zTWOMFRCAnwQA1o=;
        b=PkHcBziVpRBlSF6FLa3MpBzMdv3poa4ZwIX4Tc/XeNvfb2ClkbO++CafV6gzgQcCB4
         uJ3CHxDgqzqwST0lJcjen5oso48w5dj3cgROeEPQgH+TIT9uQl50zElIm/n1WS+572fD
         I8VRqhkxU6+EBugzhVW0Ur9mPWEaoNhM+x6n+LArt6yw8uMoo+xd9IRJh4NwTZXdbS9m
         25OnadGrNkCHOTVxTB7qs6h/PJtOBitem1f8jCn3awTqHOQfIjuFb2UKXSU+S2/Z/0aT
         51+/ZgVOrK2l7HsbqzTebhSyfterWaTkqDhtULkOt4IEWI9sh85i0jr1Fqw0YZ7yJ79v
         B0Eg==
X-Gm-Message-State: AOAM531+I7buVFkqqUbSkFIQAETcQw/FSnr+oxZLxdfA6W+SeiKsUSi6
        7pFvu26VEFOeEANIUYgdHiuyNBmZKxuAuw==
X-Google-Smtp-Source: ABdhPJxfAALL0Uj6Qz3bvdfIx68slcFJ8uw8olnQVslFuFPYfvwfsYh5PuS40dGH62vboVe56tidJw==
X-Received: by 2002:a19:c3cd:: with SMTP id t196mr3309453lff.501.1602980019973;
        Sat, 17 Oct 2020 17:13:39 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b3sm2592644ljj.34.2020.10.17.17.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 17:13:37 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id m16so7079461ljo.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 17:13:36 -0700 (PDT)
X-Received: by 2002:a2e:868b:: with SMTP id l11mr3911884lji.102.1602980016454;
 Sat, 17 Oct 2020 17:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201016123530.GA30444@duo.ucw.cz> <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net>
 <20201017100234.GA3797@amd> <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
 <20201017194758.GA9904@duo.ucw.cz>
In-Reply-To: <20201017194758.GA9904@duo.ucw.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Oct 2020 17:13:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikZkCGVkeuDUb6jvz7xyeO4RsH3zQU4bCCnP=MBrd95g@mail.gmail.com>
Message-ID: <CAHk-=wikZkCGVkeuDUb6jvz7xyeO4RsH3zQU4bCCnP=MBrd95g@mail.gmail.com>
Subject: Re: autofs: use __kernel_write() for the autofs pipe writing causes
 regression in -next was Re: 5.9.0-next-20201015: autofs oops in update-binfmts
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ian Kent <raven@themaw.net>, Ondrej Mosnacek <omosnace@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        autofs@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 12:48 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> But: you are the last one to sign it off, so I assume committed it to
> git, and you are the one to talk to about fixing it.

The thing is, the commit you point to - and the one I signed off on - is fine.

The buggy one is in linux-next, which breaks that whole "NULL means no
position" thing.

IOW, the real bug is in commit 4d03e3cc5982 ("fs: don't allow kernel
reads and writes without iter ops"), which does that bogus

        kiocb.ki_pos = *pos;

and no, I never signed off on that.

Get it? Stop confusing people. This bug does not exist in mainline,
and never will. Because I'm not pulling that buggy commit.

The commit you talk about IS NOT THE BUGGY ONE.

                 Linus
