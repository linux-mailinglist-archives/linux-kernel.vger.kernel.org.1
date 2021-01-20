Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB62FD48E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391056AbhATPuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731685AbhATPmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:42:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 525D2233A1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611157293;
        bh=U5pHl/bDl13XXoNt00xkmb1grpKCo0LHMfGTYPyuPiA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hbwaDSo5qcMBsQgSCL4f/ZZwNDG0NPAR/eJlHtzC9OknwAO2zQTaUje7cYWEOyD+7
         Fdu2hMWQQY0S+arZX4ROrfJw/C6QRr7HzDsd548qQuyY5rpI+r1Hy5rpBkxEpVdcKj
         sApGGQJLC+MpWUVAOLQL0frz5+z+0R+bXl4GLoM4yMIlZKBuE2UmWdAJRaxzltWCIV
         kcCZEoL2iNT5JRIcGuiDOUYV7KkqgZGeQhdy8g9B9Pq0LYtExrITCg8i+EOyiaD+GE
         eMtUnmIQrpdTDlo+D7+hh6fWWWhP3oWzneNz1+d0//qsn7wniL7VY6QvIuzwqjwi5C
         2YRSe0Sc/GEhw==
Received: by mail-ot1-f47.google.com with SMTP id 34so12918068otd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:41:33 -0800 (PST)
X-Gm-Message-State: AOAM531jPuR+QdhtnItTZb4WM54yfQfojlRThflH7w2vt+NPw8xBgVJ3
        MRAVfpJz2yAkQ0FycmlTpU48c/BdZ5dMUKD2IOM=
X-Google-Smtp-Source: ABdhPJw7r6/+HRYvhMB+K+WeJcCiADNCuffoxluoSpAlo3xz6YSw2gE2LG/LXFQjhrnqRvOG7l8Z+efglKcrkgAF0Io=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr7429505otq.305.1611157292731;
 Wed, 20 Jan 2021 07:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20210120150555.1610132-1-arnd@kernel.org> <20210120162904.1a1588bf@xps13>
In-Reply-To: <20210120162904.1a1588bf@xps13>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 20 Jan 2021 16:41:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3imz7hiir0iJbAN4v-SVbjQPPiieoV0PJ5UKgj4DaTuA@mail.gmail.com>
Message-ID: <CAK8P3a3imz7hiir0iJbAN4v-SVbjQPPiieoV0PJ5UKgj4DaTuA@mail.gmail.com>
Subject: Re: [PATCH] nand: raw: remove tango driver
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 4:29 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Arnd,
>
> Arnd Bergmann <arnd@kernel.org> wrote on Wed, 20 Jan 2021 16:05:26
> +0100:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The tango platform is getting removed, so the driver is no
> > longer needed.
> >
> > Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > Cc: Mans Rullgard <mans@mansr.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I didn't know. I'll just fix the title when applying to something like
>
>         mtd: rawnand: tango: Remove the driver
>
> If you don't mind.

Sure, please do.

If you like, you can also add a pointer to the platform removal

Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/

which I had added to some of the other submissions, but forgot here.

       Arnd
