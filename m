Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58A8228744
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgGURZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 13:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgGURZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:25:37 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC18D2068F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595352337;
        bh=RKV0BW+9C8tbyA2otgwhYFbwcP7+9Ge72XqOAPbxQ8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jAPq9v3BGHemfkujTIuG3ZqyDILVFZKDieQ9PnauZyxdybPri0Rk7zvR5TaW+x6lu
         b9lQuEB76XCTQHcF0W10LhSheHFqSZHYw7sbNFwuh4YhROQorjgEmoqxLkTwzwB3/a
         fhSXhZN+b1UnlENBla7DuCUmsj37/gLzp4m+2RvM=
Received: by mail-wr1-f45.google.com with SMTP id b6so21956082wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:25:36 -0700 (PDT)
X-Gm-Message-State: AOAM532/L/9k2pFL7ORjDSHtMbjFz3pejQhevPhX4/p4lv+qhS/ySFl1
        q8Yb3VYzSQVoa8esxZSI1NH8Q7Boe2r3ybzolHia/A==
X-Google-Smtp-Source: ABdhPJxhK47OGKg5u9wulGLbiutPzOKjaFb1WaziXlqqFghfIN1JaY+AIUojD2fdQbL4Ey8ktxLwrw3b08ACtiFgUv8=
X-Received: by 2002:adf:e482:: with SMTP id i2mr26959033wrm.75.1595352335661;
 Tue, 21 Jul 2020 10:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk>
 <8987E376-6B13-4798-BDBA-616A457447CF@amacapital.net> <20200721070709.GB11432@lst.de>
 <CALCETrXWZBXZuCeRYvYY8AWG51e_P3bOeNeqc8zXPLOTDTHY0g@mail.gmail.com> <20200721143412.GA8099@lst.de>
In-Reply-To: <20200721143412.GA8099@lst.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 21 Jul 2020 10:25:24 -0700
X-Gmail-Original-Message-ID: <CALCETrWMQpKe7jqw2t39yn4HgGhGTSEFGK6MPR4wPs=tBBhjbg@mail.gmail.com>
Message-ID: <CALCETrWMQpKe7jqw2t39yn4HgGhGTSEFGK6MPR4wPs=tBBhjbg@mail.gmail.com>
Subject: Re: io_uring vs in_compat_syscall()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 7:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 21, 2020 at 07:31:02AM -0700, Andy Lutomirski wrote:
> > > What do you mean with "properly wired up".  Do you really want to spread
> > > ->compat_foo methods everywhere, including read and write?  I found
> > > in_compat_syscall() a lot small and easier to maintain than all the
> > > separate compat cruft.
> >
> > I was imagining using a flag.  Some of the net code uses
> > MSG_CMSG_COMPAT for this purpose.
>
> Killing that nightmarish monster is what actually got me into looking
> io_uring and starting this thread.

I agree that MSG_CMSG_COMPAT is nasty, but I think the concept is
sound -- rather than tracking whether we're compat by using a
different function or a per-thread variable, actually explicitly
tracking the mode seems sensible.

If we're going to play in_compat_syscall() games, let's please make
io_uring_enter() return -EINVAL if in_compat_syscall() != ctx->compat.

--Andy
