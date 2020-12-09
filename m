Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA74C2D4CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbgLIVe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbgLIVe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:34:57 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FBAC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 13:34:17 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id w135so2682474ybg.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 13:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WoBbCW1j0xXBMJt/PT/2gTRPKTDTWPngtH0+ZXt3d6c=;
        b=RwoRHgTy+IuZ6UWgisfK9RVBoQr1osv+GkgdBadEFRg7/Q+XNonWDvgCNCtYa3V2V8
         v0v9DgbyfjusCfAG6DLmY06TjbkZiNwuUYSJtD4NtLOycTapfhuQs6rnNVqw/NuA0cxE
         oqkwx5ceKPOnkpM1W0NWSefUhW89pEwHVqR+Tyi6w/zfACeRkTrQwn6UbAEaNz9nQMiQ
         5/O1qyf5atirDnGT5QYhDXmCbdLvXC2t2poZwxFZbb5YMGltS3pHrKJB1pE+HDte7J3t
         SCzbkN6Yy3FPwCHGD/gHRFTEbG2kNM9M0VKjXu4nBihI6BwJfBu7E17pG4NXSFoBteTk
         JkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WoBbCW1j0xXBMJt/PT/2gTRPKTDTWPngtH0+ZXt3d6c=;
        b=Y2WusuOyARrvtr1lg0hiFGHYJ0Cenr7xYiJkothjK5XIqHA80f+OC4tMninwva5kaq
         Cg5q20bym6hML6GjYkD4sBfDSO7pC0rHfzzJSj0t+ppZkMlhnLSm+4huLSBS4jUXo3Rv
         GWd5jbExZbhBI5v7FJPFl+f0qfUyxTWY1zJ77BfvumKdL74cp/KQvaC5vOg1LonMjVhS
         yEYp+uR/vzw2rpthM9heuMXqEbDAth9lykR83ba4/Z2WoBo+z+5vMXs5UN1RWeJ7HaUj
         WhLYz3HlykvFdNSUfU0wQDTEYj+kaEWG1vwKbm+LtCUZ8EcOPlil5olysyLKvSxWrz+g
         xOkQ==
X-Gm-Message-State: AOAM531s97NelP4ctGDmULIkSXDCDLgzGNdaWTA7qKq8MR07S8Tw7dp6
        iU8WA5cuI5HA+s24Eyq1stYbGGuAhMjvxq0zIaIPcw==
X-Google-Smtp-Source: ABdhPJwuapOrBFJ9X7Jy0LnnrbSGVSx0sVQ5aZeHVIo3eraDHa2ESu3HF6TKTzB4RAZmXwejsYnjUIRDCFT5PTJ0LTk=
X-Received: by 2002:a25:3ac3:: with SMTP id h186mr6095641yba.155.1607549656265;
 Wed, 09 Dec 2020 13:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20200429165347.48909-1-rminnich@google.com> <2124367.HovnAMPojK@sven-edge>
 <CAP6exYJ7QR+Y7Vsumecx_3rUC4cNY4xJj4e6759S8US6FX7ADg@mail.gmail.com>
 <2560223.mvXUDI8C0e@ripper> <CAP6exYK75zwqhtrMykMqPepPfq=S95UEByy61D136aPKCBBSRQ@mail.gmail.com>
In-Reply-To: <CAP6exYK75zwqhtrMykMqPepPfq=S95UEByy61D136aPKCBBSRQ@mail.gmail.com>
From:   Ron Minnich <rminnich@google.com>
Date:   Wed, 9 Dec 2020 13:34:05 -0800
Message-ID: <CAPAv03O2-hgx=-5bKcBy9hdK4apb9wzeO3nbLNT_ZJuJgTQWhw@mail.gmail.com>
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one or
 more colons
To:     ron minnich <rminnich@gmail.com>
Cc:     Sven Eckelmann <sven@narfation.org>, linux-mtd@lists.infradead.org,
        John Audia <graysky@archlinux.us>,
        Adrian Schmutzler <freifunk@adrianschmutzler.de>,
        jstefek@datto.com, Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Ian Goegebuer <goegebuer@google.com>

On Mon, Dec 7, 2020 at 7:24 AM ron minnich <rminnich@gmail.com> wrote:
>
> I pinged the person again. Hope to hear today. Sorry for delay.
>
> On Sun, Dec 6, 2020 at 11:52 PM Sven Eckelmann <sven@narfation.org> wrote:
> >
> > On Friday, 27 November 2020 19:54:30 CET ron minnich wrote:
> > > Thanks, Sven, for your patience, I will indeed try to test this next week.
> >
> > Any test results?
> >
> > Kind regards,
> >         Sven
