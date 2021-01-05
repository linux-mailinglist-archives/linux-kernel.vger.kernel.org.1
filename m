Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4712EB4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbhAEVXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAEVXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:23:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CFAC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:23:08 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h205so1837907lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6F2SvwcbZK373069SLZrBu7NJM8ozvNHQfYRWPsEck=;
        b=hy/vjE5SaF6czegqQX0MrOdpl+GiZWj39LeytRwKYyCkOFal4ic4IbYkUtq+SvTuIy
         JcNrCHKwdMIPWI5xADxwiT9gF5DL9Qh8Xp336ph68n11Co1yoy2k31xJFHMjTT5r4tfp
         1T1axkDAsnXFFj/XkHJx8TYBK90ovvBzeWomY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6F2SvwcbZK373069SLZrBu7NJM8ozvNHQfYRWPsEck=;
        b=SNmmfGSgdyBMbPNInyXrjNXQmRzrGEjRsCgXBH36ycASwdTScRRy/b/S5RG9a40VJC
         J7qN3cMU4GzIgfeSEZisH3GET1JiBINvElVi2TRXzI+m6UOt6EKMUt2ARpnk9K0nkL5I
         JGQsr6XeYMEITf+xilpzCKMIqjmwRm+m7hxxFPz8pe/xxhfK5P6AfFUvcPd86MjRvxyD
         O2UpTgMNzSqDxzDMR+OiHXXfF5Hhu8onCwhBx+USI3jMHLj/JOYXPAEouY6mNFGECO6e
         3umaButQXg+QSPVTrD6QALRFOe+krbZnSCd9DCc2qnMP1rotXBh/O42drtOc0VbDtZow
         1yFA==
X-Gm-Message-State: AOAM5333deX8OrqoxDep6UYg7uRq1lCtNMu6quZwKfMBrjA6UBhY/DXG
        3sq4W7ghXEXxPN0c5ihkY42qo+UnyYXDbA==
X-Google-Smtp-Source: ABdhPJwCttLo2GCTzeCfFavJ50d6xkybM+HaR7UhD6KDSMO62HJr4ah3PmOGdiARBhTbazr9Aq4Ebw==
X-Received: by 2002:a05:6512:786:: with SMTP id x6mr453883lfr.643.1609881786543;
        Tue, 05 Jan 2021 13:23:06 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o19sm36237lfd.250.2021.01.05.13.23.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 13:23:05 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id s26so1795103lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:23:05 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr461400lfr.487.1609881785021;
 Tue, 05 Jan 2021 13:23:05 -0800 (PST)
MIME-Version: 1.0
References: <000000000000886dbd05b7ffa8db@google.com> <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org>
 <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com>
 <alpine.LSU.2.11.2101041839440.3466@eggly.anvils> <CAHk-=wi36CBggdRfdggACvf2hG+djM9kKnorrwsByN6uDvPExA@mail.gmail.com>
 <CAHk-=wh=5kDGukMs2sVZ8uHZJX4VL13oD5+xMAR4HvuY6QckLg@mail.gmail.com> <alpine.LSU.2.11.2101051235500.5906@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2101051235500.5906@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Jan 2021 13:22:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGHdRRmZtrcUt6g6hmATkmueNVLNnSHSBoUp-v-Qy5sw@mail.gmail.com>
Message-ID: <CAHk-=wiGHdRRmZtrcUt6g6hmATkmueNVLNnSHSBoUp-v-Qy5sw@mail.gmail.com>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 1:13 PM Hugh Dickins <hughd@google.com> wrote:
>
> I was going to raise a question, whether you should now revert
> 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and BUG_ON(PageWriteback)"):
> which would not have gone in like that if c2407cf7d22d were already in.

Honestly, even if it wasn't for that PageTail issue, I think
073861ed77b6 is just the right thing to do anyway. It just feels _so_
much safer to not have the possibility of that page wait thing
following while the page is possibly then being free'd and re-used at
the same time.

So I think the only reason to revert that commit would be if we were
to find that it's a huge performance problem to raise the page
refcount temporarily. Which I think is very unlikely (since we already
dirty the page structure due to the page flags modification - although
they are far enough apart that it might be a different cacheline).

                   Linus
