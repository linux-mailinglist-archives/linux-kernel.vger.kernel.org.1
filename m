Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A592F91A3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbhAQKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbhAQKJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:09:13 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D23C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 02:08:22 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c1so9340067qtc.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 02:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ioK4qHx2YTWpYesPohrsqPNhfkF57e72LO4x9w2kxs=;
        b=pRlLwPuKOQW+IQdabX3WcRe5U9xjrcZw9iFo+1yZ4llITI5/OFZvZQ9KpFTNd5BlVP
         d1XY77fzGSn/xUKA2EtmSh4bpXVXVeHokVFmf2VSIh1wwGdGkpihy4t+RLEsRwY4aNA3
         rMWhdoY6ORYoc16R8rYkoe3PeQZSZS1PqioOeX7vhRvgRZ7FZvfR4G4lscAUiEJcgzjG
         V7N+QOziTTSVxFA60k6Xhtcl7bZHzN7FlSEW8g0W1dEYG9nrg/RiaBD9mecGO+OI45DM
         dtvLaHye9319BQsLZpSL157AihJauYuKRUCOJ7agoDUDio9ItQ8Zpqw6eCZcKJu1r3nz
         EsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ioK4qHx2YTWpYesPohrsqPNhfkF57e72LO4x9w2kxs=;
        b=hJBHI0xBM1CyI+jIzJbuapaMs4yep1G34vXzfcXB43aNm63iJlqZVVqSk/N9snDNHZ
         zyHwpja/NmGF08qC1apO9UXKBZKAZPuS1C/IVyTwjhdIK/HfUD1ARn5oPPt54oYl5DaR
         fimYlz4UJ7cG8kNLm5zsBkNfEwSWVRQ0asnLBmuu3gfpf6ETuvOYnl74ytpUha/9M+XF
         GMgAqLUqhwgK0j6/30E9Kza37tU+S9SGIBDF5KyY5YmN9fxzF4QkD4iAmse5SMy5JCL9
         bzrAzoqtPXYrwqV483Q06JMhd120tZ5lmjxbVpqeFssd/gudUBhi2KhXNdCFWQax2ML0
         mTMg==
X-Gm-Message-State: AOAM533kguaUChH9tQ07exPwf/mv0Tm4E/T89vNSHuE432wh3DcdU5f5
        yr5mB2247gxslG70Zihstyx8kZkDETkn+9e3eOVmuqTrZ2d2TQ==
X-Google-Smtp-Source: ABdhPJya+0oJv2dMNGmE/RvUgTXD9/fJTMbxQ5YuoyOYDcv9dBOUoToFox452pU/oPQ+pZ+ylTiTnngxapysi22sLac=
X-Received: by 2002:aed:2827:: with SMTP id r36mr18555668qtd.337.1610878101536;
 Sun, 17 Jan 2021 02:08:21 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f6914405b49d9c9d@google.com> <20201123194230.f59c93eba3cf356c632eb1c0@linux-foundation.org>
 <20201124041417.GX4327@casper.infradead.org>
In-Reply-To: <20201124041417.GX4327@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 17 Jan 2021 11:08:09 +0100
Message-ID: <CACT4Y+ZXqLNbFVdvOrfUyStf9OWhbg4QREu50_D4U5hUb9En2A@mail.gmail.com>
Subject: Re: kernel BUG at include/linux/highmem.h:LINE!
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+dcb847a3e1e0ecd191ab@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 5:14 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Nov 23, 2020 at 07:42:30PM -0800, Andrew Morton wrote:
> > Matthew's series "Overhaul multi-page lookups for THP" chnages the
> > shmem code quite a bit, and in the area of truncate.  Matthew, could
> > you please fire up that reproducer?
>
> Almost certainly my fault.  I was trying to get the shmem truncate code
> in better shape before posting my series of fixes.  I'll send you a batch
> of four which fix problems noticed by Hugh.  There's at least one more
> to come.

#syz fix: mm: support THPs in zero_user_segments
