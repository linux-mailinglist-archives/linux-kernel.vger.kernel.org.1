Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512812F24C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405171AbhALAZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404230AbhALAFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:05:16 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 16:04:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o13so670048lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 16:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XS9x4tfe1NBdhR5zesiN+CGaWhvZlzcF27NwBDw1wRc=;
        b=BwuL7yZDyqnpbChB/UKU5UXidDWpM3L+UCh8vme2kp6gTLToZsZm1L1RfZcYNQGazl
         DFFfgj4uolkUm4miyvKJI6qqjg6Z/Ki+44uqk4vu4c5RPyuUiNAvdVru3mNlE8qEz6PM
         TaWeQMdrvQH6MprIAZ7kh3zKiLuSUNKE32ZBoUFtJQljg/EtDbgtGsdmEJUAY0L3Fnvv
         JEfjbD2zpD8dscnUTTaBP2NWfr398kEhY98XyiLXGdb74Q+Nab1+nFXUJqe4j/RNxyUM
         E3tR6xYDgRI4TTtAwI+h1FH2FT97l6Zggb1QX8Csql6ftmNXBO+Xs8tSuIsSOmwo2tVT
         cmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XS9x4tfe1NBdhR5zesiN+CGaWhvZlzcF27NwBDw1wRc=;
        b=ICAShJ7d1/aj6hy/C2ql6PUrB+qpxC1iBzvi8WpCPA+4uGMlHYQQNvBmRNQMGzr9ut
         h+WaVI61nmxh67TxYoqlIByKtHl0uzI+OHGIXYjV5v+1bOS/Vle+pNYMMty4Cu8OtpPX
         zMMgPY+WBUzyaOCNawV7zMXZfS8pgEYeanxlLlDR4pJ//LXD+uxENHRicoXKWieWJMfP
         C/bcvJzteZbOyeLryVacqCGT4d9dBHKHG/z5cUE0SQv/xr6wRGvFzJZnMQYtZEDCtk0A
         INmbT4ywXsZFgmEcY0yUBKVRkQ5FXhQU9DU/t2h8ubOie8fK+jPj/Aj0iJhKuEfnNK4o
         W76w==
X-Gm-Message-State: AOAM530nM/aCZhFS85ALAYE3Z83XG7MQw0Hly2av9v2UfqckwlDfZr0B
        N6Z8hWjuk0rU/+VoznfZodcBdSGBY4Cj3nJLPg6qJw==
X-Google-Smtp-Source: ABdhPJz14xwXYhwbbFhkre/rPYl8XJ3OSRRH0dml61aMapQmWaL6oyMIRX6e5N36iBQqwJMMrVjceYW8T5GSc0X5O+I=
X-Received: by 2002:a19:716:: with SMTP id 22mr890888lfh.390.1610409874106;
 Mon, 11 Jan 2021 16:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20200916041908.66649-1-ebiggers@kernel.org> <20201007035021.GB912@sol.localdomain>
 <20201026163343.GA858@sol.localdomain> <X7gQXgoXHHEr6HXC@sol.localdomain> <X/NkrKpaIBTjQzbv@sol.localdomain>
In-Reply-To: <X/NkrKpaIBTjQzbv@sol.localdomain>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 12 Jan 2021 01:04:07 +0100
Message-ID: <CAG48ez3iicHcf1WoVh6LhV4pxo-rOh2FkrtmqQUcSS69NyiKxw@mail.gmail.com>
Subject: Re: [PATCH] random: fix the RNDRESEEDCRNG ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 7:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
> On Fri, Nov 20, 2020 at 10:52:14AM -0800, Eric Biggers wrote:
> > On Mon, Oct 26, 2020 at 09:33:43AM -0700, Eric Biggers wrote:
> > > On Tue, Oct 06, 2020 at 08:50:21PM -0700, Eric Biggers wrote:
> > > > On Tue, Sep 15, 2020 at 09:19:08PM -0700, Eric Biggers wrote:
> > > > > From: Eric Biggers <ebiggers@google.com>
> > > > >
> > > > > The RNDRESEEDCRNG ioctl reseeds the primary_crng from itself, which
> > > > > doesn't make sense.  Reseed it from the input_pool instead.
> > > > >
> > > > > Fixes: d848e5f8e1eb ("random: add new ioctl RNDRESEEDCRNG")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > >
> > > > Ping?
> > >
> > > Ping.
> >
> > Ping.
>
> Ping.

You may want to resend to akpm with a note that the maintainer is unresponsive.
