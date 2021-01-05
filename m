Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1272EB17B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 18:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbhAERgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 12:36:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbhAERgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 12:36:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DD1222D06
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609868140;
        bh=WJj65c70Fo6RiETeJlm3veLV50ClFqP7ZGhCY7KmnsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m8xEpN0zZD3RkUkF73a4HoHQJsKA8vaW+Xi1j336p1VpZX3txYQ2yCxdHWXEmMcHh
         yJo2k5lW3W1ve5wcuQNxZ/IzrRmP4/D/m6lmeVWUY6+Ty8rMOtfOS89kQipmz1ogkI
         FJpE7gZMNUIFqJQk7tUibGKSrNRcsvUr82399QUKMKq2diyuCU22xRMm5O48HJ6lt8
         UN4X6ePQt3tKyM5oGmxvh16wC2d3+lNx1oU7HPX2PkLDLPk5jEHaNWLdBF5p7BXeQR
         h7l/U+3VA33OjVsRzU2uvDLaTFam52/iFp9TorBuQiONG+RLMOIw5gSg5PWw5sjvGY
         PGuHVzdxpoq/w==
Received: by mail-wm1-f42.google.com with SMTP id 3so298047wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 09:35:40 -0800 (PST)
X-Gm-Message-State: AOAM530/825VD2ZvNO+XCQkYAtm2vOsN2iVo5UTTVKS5SIdklMeNLSik
        7C4yPvTat7MMBWvBdDf6DWvDsPWKCRXTXFMvxT1wOg==
X-Google-Smtp-Source: ABdhPJxxfRycNOnViOMnhGXvYcBTsqyqcuDcCy8iephpU1URIpId8jID/Awok5v1Y1XAmLIkyBKOM3Zb9fd+aX4AQ6c=
X-Received: by 2002:a1c:6741:: with SMTP id b62mr204910wmc.21.1609868139018;
 Tue, 05 Jan 2021 09:35:39 -0800 (PST)
MIME-Version: 1.0
References: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
 <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net> <9108ae60809f4fab846e610fe84f607f@AcuMS.aculab.com>
In-Reply-To: <9108ae60809f4fab846e610fe84f607f@AcuMS.aculab.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 5 Jan 2021 09:35:23 -0800
X-Gmail-Original-Message-ID: <CALCETrV_Ng4xjd1fanXZJ5=EFN4w2RYMK0EqsnKmMkSYbQhN0w@mail.gmail.com>
Message-ID: <CALCETrV_Ng4xjd1fanXZJ5=EFN4w2RYMK0EqsnKmMkSYbQhN0w@mail.gmail.com>
Subject: Re: in_compat_syscall() on x86
To:     David Laight <David.Laight@aculab.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 1:53 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Andy Lutomirski
> > Sent: 04 January 2021 23:04
> ...
> > >> The x32 system calls have their own system call table and it would be
> > >> trivial to set a flag like TS_COMPAT when looking up a system call from
> > >> that table.  I expect such a change would be purely in the noise.
> > >
> > > Certainly a write of 0/1/2 into a dirtied cache line of 'current'
> > > could easily cost absolutely nothing.
> > > Especially if current has already been read.
> > >
> > > I also wondered about resetting it to zero when an x32 system call
> > > exits (rather than entry to a 64bit one).
> > >
> > > For ia32 the flag is set (with |=) on every syscall entry.
> > > Even though I'm pretty sure it can only change during exec.
> >
> > It can change for every syscall. I have tests that do this.
>
> Do they still work?

They seem to.

> I don't think the ia32 flag is cleared anywhere.

It's hiding in arch_exit_to_user_mode_prepare().

--Andy
