Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B760D2DEE3C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 11:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgLSKrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 05:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLSKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 05:47:24 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCC9C0617B0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 02:46:44 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 23so12008975lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqAwl5/BK7mKW8hy+rXPleawKGWEfxh8nem4l7u+e6Q=;
        b=inY2jM40JgO+Yy60zspBzWqHc1oj6B5SejBurxU2sjpvyM7/2AgkZ/a3/Qu0GkF78A
         U+ivBbMyIh8LIQQB82USjfCafFljwznrlYBW/7oRJHKATVaYcUaih5+n1CVFAZLKB+Bn
         FkjVUHn5gv/nCK4ruUYzkVRL0CvFzQ11Sd/jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqAwl5/BK7mKW8hy+rXPleawKGWEfxh8nem4l7u+e6Q=;
        b=bZ+QVJXDz1tUNGVj8Q6r9Fvk5Du6XAWdaQ1Beo4PhdSZiLstrkeVs3OsZFDgSBMjhx
         /iM0v2NOjblbOhGPkubR+X9Sg1r7e7ByDkoR6neNlC313a8IKpaOoEBSIbB+UDi30S5t
         qso8RHPB/EIBwucelEB3DvR3QcZVMQ6tEaznHqYaKZQKWpv4K65IeU+U733nAvIpUaZK
         skbkjcN3uhiQ919KGeRxU7iWCP2zYV22Gj1+EqxwSksTnaBxaJACTq4atKJiZRvMdt8l
         sUDFzYdQ8AZF4DLH5TQDmmIrHmzmJH8JpQs4q9o8FIH8A/pK1SIR+ntzTcULxn2rbuIU
         QSUA==
X-Gm-Message-State: AOAM530aD0UrCZCj6Dt0WmJUXfU7s5axDSWVYhwAVa/3G0w1UCW2VprW
        UsxPDZPRqwvgT83fub1rnmAG/iTAS996H+3cHmqOx0aK+0iQkKlSX5g=
X-Google-Smtp-Source: ABdhPJylwaoMYEVUDsKcbZcqrhLHToc9DzJeTxx4ntyzWqPKD5fr5i15L5QR4cR1q84Od8xOEG0B9Ml/ccaD31MFbUA=
X-Received: by 2002:a05:6512:6cd:: with SMTP id u13mr3042997lff.288.1608374801370;
 Sat, 19 Dec 2020 02:46:41 -0800 (PST)
MIME-Version: 1.0
References: <fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de>
 <aa9be27f0d247db1b25da55901b975d78537db3d.camel@gmx.de> <CAM4kBBJYZzbXAixrKvy9MeO2eUsVVi8=iUBUc+pbSMXudy7hkw@mail.gmail.com>
 <6946d6e798866276f0d635f219cdd4ad05156351.camel@gmx.de>
In-Reply-To: <6946d6e798866276f0d635f219cdd4ad05156351.camel@gmx.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Sat, 19 Dec 2020 11:46:29 +0100
Message-ID: <CAM4kBBJZDqZfk+w5Wv4Ye7JythQ-Sr5-==zxeq8M5WCnHpFtEA@mail.gmail.com>
Subject: Re: [patch] zswap: fix zswap_frontswap_load() vs zsmalloc::map/unmap()
 might_sleep() splat
To:     Mike Galbraith <efault@gmx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Dec 2020, 11:27 Mike Galbraith, <efault@gmx.de> wrote:
>
> On Sat, 2020-12-19 at 11:20 +0100, Vitaly Wool wrote:
> > Hi Mike,
> >
> > On Sat, Dec 19, 2020 at 11:12 AM Mike Galbraith <efault@gmx.de> wrote:
> > >
> > > (mailer partially munged formatting? resend)
> > >
> > > mm/zswap: fix zswap_frontswap_load() vs zsmalloc::map/unmap() might_sleep() splat
> > >
> > > zsmalloc map/unmap methods use preemption disabling bit spinlocks.  Take the
> > > mutex outside of pool map/unmap methods in zswap_frontswap_load() as is done
> > > in zswap_frontswap_store().
> >
> > oh wait... So is zsmalloc taking a spin lock in its map callback and
> > releasing it only in unmap? In this case, I would rather keep zswap as
> > is, mark zsmalloc as RT unsafe and have zsmalloc maintainer fix it.
>
> The kernel that generated that splat was NOT an RT kernel, it was plain
> master.today with a PREEMPT config.


I see, thanks. I don't think it makes things better for zsmalloc
though. From what I can see, the offending code is this:

>        /* From now on, migration cannot move the object */
>        pin_tag(handle);

Bit spinlock is taken in pin_tag(). I find the comment above somewhat
misleading, why is it necessary to take a spinlock to prevent
migration? I would guess an atomic flag should normally be enough.

zswap is not broken here, it is zsmalloc that needs to be fixed.

Best regards,
   Vitaly
