Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9092ED43B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbhAGQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGQZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:25:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35A13224D3;
        Thu,  7 Jan 2021 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610036689;
        bh=LXyHjXJQXFpphlsfzHKNJClU7qoI2uIq8c0hjWF5md0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AKdQQVU3ncSGA8q6ZqQZO9CxYZ8rxjM9R5Sj4IcOfIiEbSFEO9auLoadcbmlLh+mA
         cY68ovTGqfd1Iw68yYSs6Yj3gq5rlSUjIUtIy5QB2K7FJcCEtybvtZxv/fHS1KEOLg
         jYSoNSz6WRqk1/lf1TaW3y7zL2NvR9MPuq0MfuaShHt8lUVKLlh5ozPP5dEoNyRkxV
         bllf6wn29n9YpAuIhJYCBjVxuUS3lEY6otk2vaJd5u1hTBe5U44tXyxRFAHh976KFe
         6WjH1twatE3RmQgl17oDD9r0ZiHmDPLI9wfR1Z9SSbe/+n+JyoOQi6mxp665YNeVba
         IThNL8i96WedQ==
Received: by mail-lf1-f46.google.com with SMTP id o19so15968478lfo.1;
        Thu, 07 Jan 2021 08:24:49 -0800 (PST)
X-Gm-Message-State: AOAM5312zCuOe64ocZZKbWmtuqSqlT0TOSJTI8tpmPMUTZsGuz9y4Lpc
        gZuGdchd6Fsvw5TYCrG07hSct1jTcnLuQ8GFz0w=
X-Google-Smtp-Source: ABdhPJwBSy8wbYbmWqtAQq2EbbZ/Rlr/HwjJEF3jtIc7VmU55T++xsgfMq1glkhbMSK4HbObvoEBTMmbyVSixqmj4yA=
X-Received: by 2002:a2e:8118:: with SMTP id d24mr4169763ljg.105.1610036687551;
 Thu, 07 Jan 2021 08:24:47 -0800 (PST)
MIME-Version: 1.0
References: <ae3672c0-84d1-7ee5-1858-33d119544906@infradead.org>
 <20210106100449.237875-1-standby24x7@gmail.com> <9de77ea7-c7cd-6235-30f3-50e12fa2d8fe@infradead.org>
In-Reply-To: <9de77ea7-c7cd-6235-30f3-50e12fa2d8fe@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 8 Jan 2021 00:24:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQp6EuodAfFjtZZCdBT-nq87RJtuVjco9PkvF1PyimWGQ@mail.gmail.com>
Message-ID: <CAJF2gTQp6EuodAfFjtZZCdBT-nq87RJtuVjco9PkvF1PyimWGQ@mail.gmail.com>
Subject: Re: [PATCH/v2] csky: Fix typos in Kconfig
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masanari Iida <standby24x7@gmail.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx, looks good to me.


On Thu, Jan 7, 2021 at 12:23 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/6/21 2:04 AM, Masanari Iida wrote:
> > This patch fixes some spelling typos in Kconfig.
> >
> > Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> > ---
> >  arch/csky/Kconfig | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > index 7f1721101ea0..e6ddca10e3ee 100644
> > --- a/arch/csky/Kconfig
> > +++ b/arch/csky/Kconfig
> > @@ -243,9 +243,9 @@ menuconfig HAVE_TCM
> >       bool "Tightly-Coupled/Sram Memory"
> >       select GENERIC_ALLOCATOR
> >       help
> > -       The implementation are not only used by TCM (Tightly-Coupled Meory)
> > -       but also used by sram on SOC bus. It follow existed linux tcm
> > -       software interface, so that old tcm application codes could be
> > +       The implementation is not only used by TCM (Tightly-Coupled Memory)
> > +       but also used by SRAM on SOC bus. It follows the existing Linux TCM
> > +       software interface, so that old TCM application codes could be
> >         re-used directly.
> >
> >  if HAVE_TCM
> >
>
> LGTM. Thanks.
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
> --
> ~Randy



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
