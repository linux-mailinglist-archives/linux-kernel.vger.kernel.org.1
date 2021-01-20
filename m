Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2692FC644
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbhATBII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:08:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbhATBIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:08:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3012A2310B;
        Wed, 20 Jan 2021 01:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611104839;
        bh=DDAmWp3PJJvGegLk/5bYpBsTWxMUiuCqlFOFLhwAaB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bw1CdxsgiyWNkkJg7+9zztoXJvGHevy8WJk8o3xPv4A1tENOgq5HZgeH523h9xuLw
         CGkaCzgcSGEDyV7l3JBE4Q7qRjrkaCmCzB+MoEeR5zZNhemyOAvIssgW1H/2p8dyub
         m5ikmj2PUar8OEVl4uw+OlcEXlWID9hcob0SR12tGsusiHzyD9rRGamh8dJDHWDdvc
         N0aRLzUCD9HpxSUxQOEsmEei/pztYO5qL69rWnKBOLhF5fq5jWitxs4g+4dS553j3Z
         ielWT9zKUZGqxO/g05EpFmRFqMlhjtEVqJfuhC5LLdTRQyb8yIbgfVR6gdvkRKzfwD
         Lvut1lM2PO5rQ==
Received: by mail-ej1-f44.google.com with SMTP id ke15so23510293ejc.12;
        Tue, 19 Jan 2021 17:07:19 -0800 (PST)
X-Gm-Message-State: AOAM531hNgeR/kwNCuK6tV+cxT14GSY/ZVl03emAqoplaYYv8XTDjiJr
        theQuAt0/QltecGxtP9FiCxwcWYozC7nWI2mWA==
X-Google-Smtp-Source: ABdhPJxfJGCbBJT7icJ9Nc5mrXaX3NSE9o40e2Pu6NCFojB0Mv6SpI5ROTj5bhtWUpizkfF/MISHiC+dNrBSDEs/uUk=
X-Received: by 2002:a17:907:d01:: with SMTP id gn1mr4218134ejc.130.1611104837622;
 Tue, 19 Jan 2021 17:07:17 -0800 (PST)
MIME-Version: 1.0
References: <1611051980-3834-1-git-send-email-milan.lakhani@codethink.co.uk> <87y2gopjcx.fsf@meer.lwn.net>
In-Reply-To: <87y2gopjcx.fsf@meer.lwn.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Jan 2021 19:07:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+YW2K8YoLes8EAUy1WrFRzpYvtzvErOYbhw3zvZBoddQ@mail.gmail.com>
Message-ID: <CAL_Jsq+YW2K8YoLes8EAUy1WrFRzpYvtzvErOYbhw3zvZBoddQ@mail.gmail.com>
Subject: Re: [PATCH] docs: Change reference that was to removed file
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Milan Lakhani <milan.lakhani@codethink.co.uk>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        sudip.mukherjee@codethink.co.uk, linux-safety@lists.elisa.tech,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 6:01 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Milan Lakhani <milan.lakhani@codethink.co.uk> writes:
>
> [CC += Rob]
>
> > There were two references to
> > Documentation/devicetree/booting-without-of.rst for dtb format
> > information. This file has been removed, so I have changed the links to
> > Documentation/devicetree/usage-model.rst for this information, which
> > itself points to https://elinux.org/Device_Tree_Usage for an overview of
> > the device tree data format.
> >
> > Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
> > ---
> >  Documentation/arm/booting.rst                | 2 +-
> >  Documentation/translations/zh_CN/arm/Booting | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/arm/booting.rst b/Documentation/arm/booting.rst
> > index a226345..5392d01 100644
> > --- a/Documentation/arm/booting.rst
> > +++ b/Documentation/arm/booting.rst
> > @@ -128,7 +128,7 @@ it.  The recommended placement is in the first 16KiB of RAM.
> >
> >  The boot loader must load a device tree image (dtb) into system ram
> >  at a 64bit aligned address and initialize it with the boot data.  The
> > -dtb format is documented in Documentation/devicetree/booting-without-of.rst.
> > +dtb format is documented in Documentation/devicetree/usage-model.rst.
>
> Except that ... usage-model.rst doesn't actually document the DTB
> format.  Perhaps we should instead substitute a link that does what's
> promised here?

Yes, it's in the DT spec. I'd point to
'https://www.devicetree.org/specifications/' so it's always going to
show the latest. And that's the link we have elsewhere in the kernel.

usage-model.rst is also something needing updating...

Rob
