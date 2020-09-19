Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA131270956
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 02:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgISAH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 20:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgISAH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 20:07:56 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDCD2311D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 00:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600474076;
        bh=IFhPMAJb6PNwWq9NoYxwMsTqQBwaA1aOWnx3onz4Ync=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k+lwYjdyq1o6wiXh6Tb/eb11uEUB56b9QlJW7D+aKDaltQAJszCNrbhS46GePFaCQ
         P2CvhEEkyPJ4pnprDaxH9BgkxF9H1SgFdfewKCAWbcU5xG5rROdMiqagCv7UKTJ36x
         IW3jt2GvCotT2/XLlDCmK2iwhKlutsiLRzcxfjPM=
Received: by mail-wm1-f51.google.com with SMTP id l15so7677429wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 17:07:56 -0700 (PDT)
X-Gm-Message-State: AOAM531jYfjW3ZoJUcfTtsYEOWXwszvTTiqlj5WiP+xu79QKmgw7Cl8B
        dI4usiwjaHaQc6Wc/vGDoFzDNBaiOpMhLz5cDfxo5A==
X-Google-Smtp-Source: ABdhPJyxJvy8kJbUo5EjCVaRsgPrLRUAsTOZIUfZiHvBOIkmUpUD9tpKTjKoKtxJmwxysAdPP4xoacf3j29g5eVGkGE=
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr17750393wmc.21.1600474074629;
 Fri, 18 Sep 2020 17:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000762dee05af9ccd01@google.com> <CALCETrVL=VGNXbWK1BB1LnsxaKOGRbEfCGUEx4jaCW9cF-54Ag@mail.gmail.com>
 <20200918235528.GB3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200918235528.GB3421308@ZenIV.linux.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 18 Sep 2020 17:07:43 -0700
X-Gmail-Original-Message-ID: <CALCETrVi=quLyPXzt-0ou-FF_OYMa7pE5N8_NchRaWtwLg3kNg@mail.gmail.com>
Message-ID: <CALCETrVi=quLyPXzt-0ou-FF_OYMa7pE5N8_NchRaWtwLg3kNg@mail.gmail.com>
Subject: Re: WARNING in ex_handler_uaccess
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Lutomirski <luto@kernel.org>,
        syzbot <syzbot+ea3a78a71705faf41d77@syzkaller.appspotmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 4:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Sep 18, 2020 at 04:31:33PM -0700, Andy Lutomirski wrote:
>
> > check_zeroed_user() looks buggy.  It does:
> >
> >        if (!user_access_begin(from, size))
> >                return -EFAULT;
> >
> >        unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> >
> > This is wrong if size < sizeof(unsigned long) -- you read outside the
> > area you verified using user_access_begin().
>
> Read the code immediately prior to that.  from will be word-aligned,
> and size will be extended accordingly.  If the area acceptable for
> user_access_begin() ends *NOT* on a word boundary, you have a problem
> and I would strongly recommend to seek professional help.
>
> All reads in that thing are word-aligned and word-sized.  So I very
> much doubt that your analysis is correct.

Maybe -ETOOTIRED, but I seriously question the math in here.  Suppose
from == (unsigned long *)1 and size == 1.  Then align is 1, and we do:

from -= align;
size += align;

So now from = 0 and size = 2.  Now we do user_access_begin(0, 2) and
then immediately read 4 or 8 bytes.  No good.


--Andy
