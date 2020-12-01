Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130242CA495
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391502AbgLANzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387582AbgLANzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:55:10 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADCBC0613CF;
        Tue,  1 Dec 2020 05:54:30 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b10so1160922pfo.4;
        Tue, 01 Dec 2020 05:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3UAgW/rkBNziCZ6rRQDK5RVWKNzfgVh7XKmFvq++igY=;
        b=XVz/+eMZ7+U+u59YhL9Lk2qMehk5zU3Xgd0Zs3kn2FHBINpfBhvo5cci+AyVQ/MftJ
         Ru9A6KVkX0uP1l4fJCu8skI57cd0zKhEUOgxo0OjW1SihxmAYEssYmQhnLhI6Mu4CdQM
         dud7DoQNi8nvl1A2PqbSXyEBiiflnhrGagk0thEKqabtqQYW8nBWe/h234cbD4LpkPlJ
         SKs94uBxO/scbtmoEfMOomC5iCzmJjUyAnUq2aFfT7Lra5l9OV9rTlDEOx0Ox/F82eEN
         IoUutwVwkS36cLcRJBG96i2XuhvQOPbgcFx/S3BOHguFCYqfjFf0UEYS+A+w/xJMBGVU
         iQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3UAgW/rkBNziCZ6rRQDK5RVWKNzfgVh7XKmFvq++igY=;
        b=KGjqSpn0GqWu+pRinfyPMmurUS8NOc99wjKsTLzZalu+7+FyRCnKmVBMIFl2jLr6p2
         +0FlVaPOKH09OMlO4eS8J3r+uBJuebxf9NZnuzZX1I30kSclmPwIzwxoWIKzbdca0yTk
         4c9S7lzF4OMi0KWkgR5Enpxr5/5/aK0jLz2BDAa7PWCXF9Pw6yjxHi2UUDgK9MUfejfo
         hl7ZMZsoSlw2X5SpbdD7acEXMdIlpzd/tFkWeOGiqSqYC5H6JRbyYdGuiLHEQhAY2+Us
         hMc29/vCp2QhqzarnGsStfClgSUDAAik4BVujRIrGx+27RMsl5vc0DdjD3edJa0xayEz
         uDSw==
X-Gm-Message-State: AOAM5308KAYwIJfk8X+Q5mm4lUe9Np9pzLa8+/ZLgHO+EiVevThL7Zl0
        aO/HeO4Z9ytp1k0io5Q4100br6050pdqUKbONkY=
X-Google-Smtp-Source: ABdhPJw23wO0rnMRc9OfyObw3voM2v34q68ukOE/HLTRDTOB6f58uXf9wpfXnwIu2wpr2LCpY7FY23ykU+vYLTv8kFo=
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id
 66-20020a6204450000b029019c162bbbefmr1327591pfe.40.1606830869803; Tue, 01 Dec
 2020 05:54:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606827507.git.agx@sigxcpu.org>
In-Reply-To: <cover.1606827507.git.agx@sigxcpu.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Dec 2020 15:55:18 +0200
Message-ID: <CAHp75Vfws_WMDxxpCpB1zSgbWucYx7-qeev6=mKE+znXSSPWSA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] usb: typec: tps6598x: Export some power supply properties
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 2:59 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
> This allows downstream supplies and userspace to detect whether external =
power
> is supplied.
>
> The Librem 5 has the tp65982 in front of bq25980 charge controller.  Sinc=
e that
> is capable of sinking and sourcing power the online property helps to dec=
ide
> what to do. It also makes upower happy.
>
> There will be follow up patches providing more properties but these need =
some
> more time to cook and i wanted to check if this is the right way to go?

From my perspective the patches are okay (after addressing one more
comment), FWIW
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> changes from v3
>   - As per review comments from Andy Shevchenko
>     https://lore.kernel.org/linux-usb/CAHp75VeLZtm85Y=3D3QMkPGb332wn05-zr=
-_mrrwXvnqLhazR1Gg@mail.gmail.com/
>     - Use positive conditionals
>   - Add reviewed by from Heikki Krogerus
>     https://lore.kernel.org/linux-usb/20201130102720.GA2911464@kuha.fi.in=
tel.com/T/#u
>     https://lore.kernel.org/linux-usb/20201130102942.GB2911464@kuha.fi.in=
tel.com/T/#u
>   - Fix typc vs typec typo in commit message
>
> changes from v2
>   - As per kernel test robot
>     https://lore.kernel.org/linux-usb/202011271005.zJVawX74-lkp@intel.com=
/
>     - Flip USB_ROLE_SWITCH and REGMAP_I2C from 'depends on' to 'select'
>       This matches tcpm and avoids a config symbol recursion which went
>       unnoticed on my arm64 build but trips up x86_64.
>
> changes from v1
>   - As per review comments from Heikki Krogerus
>     https://lore.kernel.org/linux-usb/20201126123552.GP1008337@kuha.fi.in=
tel.com/
>     - select POWER_SUPPLY
>     - use POWER_SUPPLY_USB_TYPE_PD when a PD contract got negotiated
>
> To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,Greg Kroah-Hartman =
<gregkh@linuxfoundation.org>,linux-usb@vger.kernel.org,linux-kernel@vger.ke=
rnel.org,Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Guido G=C3=BCnther (2):
>   usb: typec: tps6598x: Select USB_ROLE_SWITCH and REGMAP_I2C
>   usb: typec: tps6598x: Export some power supply properties
>
>  drivers/usb/typec/Kconfig    |   5 +-
>  drivers/usb/typec/tps6598x.c | 105 +++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+), 2 deletions(-)
>
> --
> 2.29.2
>


--=20
With Best Regards,
Andy Shevchenko
