Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E22A275DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgIWQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbgIWQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600879460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2j6Fm6nZvhmyN1zo1zafnqKixalVtqNXbTg3j/rh4Zk=;
        b=QPF2PT2extM+t9YRZ9ft8jhit4fSQYeFF0P7Q005rRhKoQli0Bmilzxb3yPfu5Eq3GRj4t
        alszHVvIW5qFVhXqdGrUQqEDrKMaY7qccH1BLHJX8evt5ZZ6RKX0ReL02a72TZSkrhqPmX
        THKEeZN+ql8tRj+7rwMT+DtXC/SkBLg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-vUl1nTmCO16r5jfz2yoa1w-1; Wed, 23 Sep 2020 12:44:18 -0400
X-MC-Unique: vUl1nTmCO16r5jfz2yoa1w-1
Received: by mail-oo1-f71.google.com with SMTP id y136so95513ooa.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2j6Fm6nZvhmyN1zo1zafnqKixalVtqNXbTg3j/rh4Zk=;
        b=MeijPPMSDdAm4+QkSffM66mtRm8JsL3tGzjwzs7U24b8a1FTg8TQBqhVDFTO6dXKZc
         em8IxMsrcBv4iC5V2+ZwVw/DDxkGiSMC2yCF3RUOsiyM0lWiYRzFgxazL8d06yi2TyaR
         GPHu+tEcIX+r/3kjbApvNYlcJAsXjsPMwWhyPzKXTRwcby5sz1plVOtufO4TrdTCmbz9
         JkLX5a97z+1pPE4U0NRLPXM8dZts/a5TKUE8sy0tS4Yofokeldf/d2ewG9bXR8/Q3JAJ
         EMAwe2DjDHPtylU+o8nRNtKNoxVuFOY/ycWFoSxDCmk9hwPWQ5WY4R49K7xIiKwO5oLC
         MrGA==
X-Gm-Message-State: AOAM530ciZsc/nal805yjEbsoHDwrgwKANfifhPmZwa7vy1W5QuajZtl
        7JojV/aZzO8mAzZ2BQB4P1LtU85c17Mwgm5v0nheQ82ei+xC+TG+Y5oZ6rUOmGkgmj9VzgTcVfp
        uwG2EmZkaAV+ai1YN3jV5yxExJ6K96teV+Q2SxRFF
X-Received: by 2002:a9d:7489:: with SMTP id t9mr363892otk.277.1600879457295;
        Wed, 23 Sep 2020 09:44:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKN4qCaYCxQwm1BZbD9hN2mC1HRwBr8Y/pHUyS8GZwhG1jgaYjM6zF5fg1cbrLzg78w6O94EDO7PNmqgMQFpU=
X-Received: by 2002:a9d:7489:: with SMTP id t9mr363876otk.277.1600879456946;
 Wed, 23 Sep 2020 09:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200922133731.33478-1-jarod@redhat.com> <20200922133731.33478-5-jarod@redhat.com>
 <20200922162459.3f0cf0a8@hermes.lan> <17374.1600818427@famine> <20200922170119.079fe32f@hermes.lan>
In-Reply-To: <20200922170119.079fe32f@hermes.lan>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Wed, 23 Sep 2020 12:44:06 -0400
Message-ID: <CAKfmpSdSube9ZPYKZTs+z4e2GjZjCsPOv2wWTzoRQQLtG2Q7NA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] bonding: make Kconfig toggle to disable
 legacy interfaces
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 8:01 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 22 Sep 2020 16:47:07 -0700
> Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> > Stephen Hemminger <stephen@networkplumber.org> wrote:
> >
> > >On Tue, 22 Sep 2020 09:37:30 -0400
> > >Jarod Wilson <jarod@redhat.com> wrote:
> > >
> > >> By default, enable retaining all user-facing API that includes the use of
> > >> master and slave, but add a Kconfig knob that allows those that wish to
> > >> remove it entirely do so in one shot.
> > >>
> > >> Cc: Jay Vosburgh <j.vosburgh@gmail.com>
> > >> Cc: Veaceslav Falico <vfalico@gmail.com>
> > >> Cc: Andy Gospodarek <andy@greyhouse.net>
> > >> Cc: "David S. Miller" <davem@davemloft.net>
> > >> Cc: Jakub Kicinski <kuba@kernel.org>
> > >> Cc: Thomas Davis <tadavis@lbl.gov>
> > >> Cc: netdev@vger.kernel.org
> > >> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> > >
> > >Why not just have a config option to remove all the /proc and sysfs options
> > >in bonding (and bridging) and only use netlink? New tools should be only able
> > >to use netlink only.
> >
> >       I agree that new tooling should be netlink, but what value is
> > provided by such an option that distros are unlikely to enable, and
> > enabling will break the UAPI?

Do you mean the initial proposed option, or what Stephen is
suggesting? I think Red Hat actually will consider the former, the
latter is less likely in the immediate future, since so many people
still rely on the output of /proc/net/bonding/* for an overall view of
their bonds' health and status. I don't know how close we are to
having something comparable that could be spit out with a single
invocation of something like 'ip' that would only be using netlink.
It's entirely possible there's something akin to 'ip link bondX
overview' already that outputs something similar, and I'm just not
aware of it, but something like that would definitely need to exist
and be well-documented for Red Hat to remove the procfs bits, I think.

> > >Then you might convince maintainers to update documentation as well.
> > >Last I checked there were still references to ifenslave.
> >
> >       Distros still include ifenslave, but it's now a shell script
> > that uses sysfs.  I see it used in scripts from time to time.
>
> Some bleeding edge distros have already dropped ifenslave and even ifconfig.
> The Enterprise ones never will.
>
> The one motivation would be for the embedded folks which are always looking
> to trim out the fat. Although not sure if the minimal versions of commands
> in busybox are pure netlink yet.

Yeah, the bonding documentation is still filled with references to
ifenslave. I believe Red Hat still includes it, though it's
"deprecated" in documentation in favor of using ip. Similar with
ifconfig. I could see them both getting dropped in a future major
release of Red Hat Enterprise Linux, but they're definitely still here
for at least the life of RHEL8.

-- 
Jarod Wilson
jarod@redhat.com

