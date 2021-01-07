Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FAC2EE6CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbhAGU0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbhAGU0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:26:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B937BC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 12:26:11 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m12so17649047lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 12:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxC7Pi19p8cz9ZZ2LryEFt22huH1dYLNt1Jl5fJ6l6U=;
        b=eL5ihb6BHCB6J0eXuVVxUcrFJ/2yM56DATzhrCXzYJYNCgH7Zbmjj+BWXd8Y9tQ88L
         Yp8zr1Vt7DyvZJP4MF5GlFLdB6/0PmE4fWpAj4wxGHunm8r5o9bGYelPbQspdDM8yoHq
         kteyqFopqXZfxcYN58vbnXUHk3ilVzusNJaKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxC7Pi19p8cz9ZZ2LryEFt22huH1dYLNt1Jl5fJ6l6U=;
        b=g2G8zfGsE267lpf3l0DGzAhwuVsxL66kEQmuvwOLkwGZFYeACBsRp97DFRkfIsovCl
         Dr+ylqu0KKE3GTFUrdNhnA68YoKCB/nO1tnOia2o+ut1hFQcEtHnUArEOBHw7rjO6JqD
         r3wPoJ4tuxEfLL2zDtTlAfTREj2Av4uWeRrKzPWF8YdF8ylt0Zu5Z69akpdnORj9xFEi
         WRt3FdGq4KjnLTvsL5aYiUURD5q1g9MO7UexSACgneUWFqtfK3dPl6CgAUbQIMt6ZbHy
         5c1F1y6w21MQdRDmKihHljNJgyrhYg7cOtClYMix8V3RqDWPJkqPpnqZOizkoLr1Y3+O
         Pazg==
X-Gm-Message-State: AOAM531v3XNHSsJoOlW439ZuSCmpRdTEASU5J0rUZg5A9B3x8Cha3wGR
        /d0hrgPAhxryoN2bd5f64blIOAagEW16Kg==
X-Google-Smtp-Source: ABdhPJy2dsXTa9aOYNDQqdaWQIrGAa6Nn6/GSji7c9MyLyEmho7P0zCxk+rFJSFM1XHFqHUzpydleg==
X-Received: by 2002:a05:6512:2009:: with SMTP id a9mr178717lfb.575.1610051170026;
        Thu, 07 Jan 2021 12:26:10 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2sm1385434lff.188.2021.01.07.12.26.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 12:26:09 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id h205so17667883lfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 12:26:08 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr70545ljj.465.1610051168427;
 Thu, 07 Jan 2021 12:26:08 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
In-Reply-To: <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 12:25:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1a+Hw4KhT=CokZ=w_XLadOr=bTKBgqX2bhG8ez7KgxQ@mail.gmail.com>
Message-ID: <CAHk-=wh1a+Hw4KhT=CokZ=w_XLadOr=bTKBgqX2bhG8ez7KgxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I still think the real fix is "Don't do that then", and just take the
> write lock.

The alternative, of course, is to just make sure the page table flush
is done inside the page table lock (and then we make COW do the copy
inside of it).

But this whole "we know UFFD breaks all rules, we'll add even more
crap to it" approach is horrendous.

               Linus
