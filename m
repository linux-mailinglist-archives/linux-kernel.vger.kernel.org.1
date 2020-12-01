Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44E2CAD0E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390862AbgLAUK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgLAUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:10:57 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAA5C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:10:16 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id e23so1841467pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tl7NwbCgPB4FUQziRcqAk5bwi9HxMdhHj333bo2TW/M=;
        b=MNqqTk+8wQFzYwHDIulSC0n0tpuXsS4zGpNUpp301624jzL/9+PsDGtaaaNW2AuMQo
         hvEXWv2j/J1rgvntkFh37d7nx4nBjCoWRtgU6s3b3mw1eJVCdLRKUHbByJbdYN3Szid5
         2gn7jq7wNLxOd6WaMsugKlMP9pZkhQ29rR4SmfOU0AwFtVEWa5DH7xv9j3lGpwRTRJeJ
         E4zCKTiA4HBVAlTfZMML+8L4p/h1INeaUsVGALltQ5J1R2CbkfhbuUxND0SCju18LLay
         vCDAvEEKE6/1ND/wQ7MidfcxC7x/Exf0daMu38OzJ/UzegmheFEbcO2P3DECNu6/b0Nz
         ERCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tl7NwbCgPB4FUQziRcqAk5bwi9HxMdhHj333bo2TW/M=;
        b=prZOFgsgcb8c9mBS9Tnn4SnmdRZ8qbgj91wCqCz97bgpaJqRPMxNJj7XIzZQSPtwfX
         jYfPIhUDR6gynDul29Zt5Amkbovv7O/b2UXHcfYQBCqaiF0VUz2MQ5CUYGF/243Lp8mS
         e+/u6ENPpBOY/rxAm0KY5L/E2iP+XghakxGWwwtAFc+xN3zCyQ3xjj2dNC6560uAOhp9
         Qo0CGGRoh9JU+MYJDEcJiJjJofWvRtpvGFWdVnRIVE67OBhV0AlLAfwNHth2502XM/me
         UBoNWa1BoUfC4wnnciZJHxv2jdIOM+GhBM1jwwNCgUuzPiQmXAGACk2fBZfatWJm2JZX
         c58A==
X-Gm-Message-State: AOAM531AocCUUta7tTDpmSRTdQ4AK9bEplyDgutKHwD7r+D/r9HNM1kD
        3snqpuS4PGkW42LcMgDOJI4PUn84R89rZPtt8QA6/A==
X-Google-Smtp-Source: ABdhPJye7nF810RrUIWwzBhcGCeBxTWvT8Mt1zXFoOR/zxFhAr+Msh+GI3GZYWqeCuWuT1zkuuBc54fKh9BANFQUdcA=
X-Received: by 2002:a63:a902:: with SMTP id u2mr3776969pge.263.1606853416126;
 Tue, 01 Dec 2020 12:10:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYt0qHxUty2qt7_9_YTOZamdtknhddbsi5gc3PDy0PvZ5A@mail.gmail.com>
 <X79NpRIqAHEp2Lym@kroah.com> <CAKwvOdmfEY6fnNFUUzLvN9bKyeTt7OMc-Uvx=YqTuMR2BuD5XA@mail.gmail.com>
 <X8X8y4j9Ip+C5DwS@kroah.com>
In-Reply-To: <X8X8y4j9Ip+C5DwS@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Dec 2020 12:10:04 -0800
Message-ID: <CAKwvOdkYWBsL-QXcfPztsCTzyAHLiSodzDznDxOz1MPkktWS1w@mail.gmail.com>
Subject: Re: [stable 4.9] PANIC: double fault, error_code: 0x0 - clang boot
 failed on x86_64
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 12:19 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 30, 2020 at 12:12:39PM -0800, Nick Desaulniers wrote:
> > On Wed, Nov 25, 2020 at 10:38 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > Is the mainline 4.9 tree supposed to work with clang?  I didn't think
> > > that upstream effort started until 4.19 or so.
> >
> > (For historical records, separate from the initial bug report that
> > started this thread)
> >
> > I consider 785f11aa595b ("kbuild: Add better clang cross build
> > support") to be the starting point of a renewed effort to upstream
> > clang support. 785f11aa595b landed in v4.12-rc1.  I think most patches
> > landed between there and 4.15 (would have been my guess).  From there,
> > support was backported to 4.14, 4.9, and 4.4 for x86_64 and aarch64.
> > We still have CI coverage of those branches+arches with Clang today.
> > Pixel 2 shipped with 4.4+clang, Pixel 3 and 3a with 4.9+clang, Pixel 4
> > and 4a with 4.14+clang.  CrOS has also shipped clang built kernels
> > since 4.4+.
>
> Thanks for the info.  Naresh, does this help explain why maybe testing
> these kernel branches with clang might not be the best thing to do?

On the contrary, I think it's very much worthwhile to test these
branches with Clang.  Particularly since CrOS is shipping x86_64
devices built with Clang since 4.4.y.  This looks like a problem
that's potentially been fixed but the fix not yet identified and
backported.  It would be good for us to identify and fix the issue
before it becomes a problem for CrOS.

Though, it looks like CrOS just skipped 4.9...? Looking at:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+refs
I don't see a chromeos-4.9 branch.

That said, I still find such reports helpful to track.
-- 
Thanks,
~Nick Desaulniers
