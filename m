Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6C22AB68B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgKILTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKILTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:19:33 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3DBC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:19:33 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id m188so7856739ybf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kc0eZrwE84e3glq3XH8q7UFVZGb6mvovyfHQ9zc586o=;
        b=Xkg4nzXS/Qbdsu7JGP8Xre4Wws/wijgFIP4t7SKuwnHu6oszbKhwoyFTV/vbsEVY20
         Gf7RCSted+Omw4wMwJDOUnGSiX1vvEo/sWnoWVIyF7+kGm7VtdNJ7EGdFb8dr8/48K/a
         dPCI9iplbV8FyuMZdvc9HmQ5PcFC7/zpcklUxJ32Afqmduw09xxsgOoUrwCPABglnL0W
         Ao7Gs6jYm741g98IwpRn4w102P0Yu5iD8oH5mYs3ET+5rGZS4FxGf7aRl5DkJck6ctel
         Aq1igmb+wnvJMUhZLzRlnpRHL11dzrFR/Ia6bLaj+bnDHAGYR93j7+GMc5jE/zGunmjX
         V5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kc0eZrwE84e3glq3XH8q7UFVZGb6mvovyfHQ9zc586o=;
        b=WAhi5fEnthAzQ56C54T5tWb0A95QDr5MATRzqXqbQshbuHH5v1SPte9ed7ap1iPqQr
         Es5hoCzG58wAuE41BvySdEFDR1Ad+xqwXtwmRwGJSrZsoYNTQdS6KdwDILkeif1rfOSV
         wRwe3Gz76uLCK6TZ+yaHpklPVAody0GX8b27op5GYdi19MNaUBOcQ2bPY6OVE8v4vNnG
         rEYibrcbFEX2xMtySi7fuNys0KnOxAnDxZyGYc/bEFafanO4JZtSS9mjWXP9KRgMYydC
         da9HDW3aoPYvPw4X3WdTw1ZYlZIyCCx1FKRPEZLVvm8p2wMOWXfGCmxYEsY1x7gQjzx+
         vgFA==
X-Gm-Message-State: AOAM532CgAb8K7QjsUcAA3bu7jbX+F/wTbMiDXkfW9ePKnrfVNSs8lrh
        bYjwpC83Lp2YJo3+V7kOSrmE/bEDfLQyHeU2htw=
X-Google-Smtp-Source: ABdhPJxxtoj/4Z4JonykkQ7UQj1JQPv61v52M+4eVT+btNDTlN8Y57buG8erq4w0kdwxCxkXeyuCz5C3ZjyJFa3exvc=
X-Received: by 2002:a25:209:: with SMTP id 9mr2725325ybc.127.1604920772501;
 Mon, 09 Nov 2020 03:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
 <20201108082317.GA40741@kroah.com> <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
 <20201109103703.GA1310551@kroah.com> <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 9 Nov 2020 11:18:56 +0000
Message-ID: <CADVatmNmoBFipoELoyuJ4EUB=KjjO+_9ahm830+04Xi3T77jqQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix build failure
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aisheng,

On Mon, Nov 9, 2020 at 10:57 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> Hi Greg,
>
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, November 9, 2020 6:37 PM
> > Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix build
> > failure
> >
> > On Mon, Nov 09, 2020 at 10:14:46AM +0000, Sudip Mukherjee wrote:
> > > Hi Greg,
> > >
> > > On Sun, Nov 8, 2020 at 8:23 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, Nov 07, 2020 at 10:47:27PM +0000, Sudip Mukherjee wrote:
> > > > > When CONFIG_MXC_CLK_SCU is configured as 'm' the build fails as it
> > > > > is unable to find device_is_bound(). The error being:
> > > > > ERROR: modpost: "device_is_bound" [drivers/clk/imx/clk-imx-scu.ko]
> > > > >       undefined!
> > > > >
> > > > > Export the symbol so that the module finds it.
> > > > >

<snip>

> >
> > probe() should never call this function as it makes no sense at all at that point in
> > time.  The driver should be fixed.
>
> Would you suggest if any other API we can use to allow the driver to know whether
> another device has been probed?
>
> For imx scu driver in question, it has a special requirement that it depends on scu power domain
> driver. However, there're a huge number (200+) of power domains for each device clock, we can't define
> them all in DT for a single clock controller node.
>
> That's why we wanted to use device_is_bound() before to check if scu power domain is ready or not to
> support defer probe.

iiuc, you are waiting for "fsl,scu-pd" to be registered.
I think you might be able to use bus_for_each_dev() to check if the
device has registered with the bus or not. It will be on the bus only
after bind was successful. The bus will be "platform_bus_type".
But I am sure Greg can give you better suggestion than this. :)


-- 
Regards
Sudip
