Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC9282675
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 21:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgJCTvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 15:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbgJCTvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 15:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601754659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAp1KAvQfJwJpulsfJOEBZJdr1SrMe1RU/k5kqvU5YU=;
        b=YmgAeTFaoICzYi0fZ7Zx+NK6zsTZ9xuCwW5qsTf5d9NXnQoCwQIJEhGFW3v0FlYSPGK2GP
        PPMK4oU2zc/EuJtz8wPUjsVX84QyV6ijIOhtcviOqds191Qr1fHpK7d+fBi6J1BYmxkgF6
        M9LBhOQp8z1E5rbv5HfZyQiHiSpvGl0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-EcCVmebkNou1skgMMq3y2g-1; Sat, 03 Oct 2020 15:50:57 -0400
X-MC-Unique: EcCVmebkNou1skgMMq3y2g-1
Received: by mail-ot1-f72.google.com with SMTP id e6so370387otl.13
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 12:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAp1KAvQfJwJpulsfJOEBZJdr1SrMe1RU/k5kqvU5YU=;
        b=RkRU0Anqnu0J+EVzJR44nDx1wRmJ6PnMuXW4b0yGn/VUErqnFgeq7lTmW1Zb7e+CaU
         RPphdNE1MtOWGFL4PFYbx15fy02MqtRYrt2l8Dj8tfV9Taptf6vcYwqHw91F0gJyxrJY
         fYMc7CrB1YsQdEb/Hn9aglZ70OlS8yFM/WrTTkdD27YPnp6FUAeytlkxMvZeej8eIRm9
         WF22+ETHGnOwbFffTZrO7yVlYobuDwYUnZZqoVwVXjjlcI3V99rROg12fmLDgwwIV2C9
         mlabaiGayp09gE3hgCI1KwNmmU/YmKgBL8MfXx4ZD8fe+rvCuqC1bVpAp+v9FevyTlcI
         c+lg==
X-Gm-Message-State: AOAM533UBKWeGKoQmwzFHUOTePKggUY3IhNdkqNSu5PNGpbLBUTngeLe
        lvylOCpcOYzlSIIPrcRdxAFHWjXM96DJKobt8GInWzT8vwBEg6RkF5DZ4NIUVfFDF9b9i1XYewz
        COG1PUeRwA/8/e3wrX0lTuZBUYBmILelSBKnJCN2z
X-Received: by 2002:aca:4e06:: with SMTP id c6mr2755118oib.120.1601754656551;
        Sat, 03 Oct 2020 12:50:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5PCrp4JFoSMI5lqXT2fmT6QXGsaWju6ZYuSNeLrSt6Cby+9/vV3qAnIAB4agessrMlqwV+kNUjkgDoMS2+84=
X-Received: by 2002:aca:4e06:: with SMTP id c6mr2755108oib.120.1601754656363;
 Sat, 03 Oct 2020 12:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201002174001.3012643-1-jarod@redhat.com> <20201002174001.3012643-7-jarod@redhat.com>
 <20201002121317.474c95f0@hermes.local> <CAKfmpSc3-j2GtQtdskEb8BQvB6q_zJPcZc2GhG8t+M3yFxS4MQ@mail.gmail.com>
 <20201002154222.3adfe408@hermes.local>
In-Reply-To: <20201002154222.3adfe408@hermes.local>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Sat, 3 Oct 2020 15:50:45 -0400
Message-ID: <CAKfmpSffg=mfVmy_06L3J28qe1ns6k_=SbSS7GvEJweUXLYmhg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/6] bonding: make Kconfig toggle to disable
 legacy interfaces
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 6:42 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri, 2 Oct 2020 16:23:46 -0400
> Jarod Wilson <jarod@redhat.com> wrote:
>
> > On Fri, Oct 2, 2020 at 3:13 PM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > On Fri,  2 Oct 2020 13:40:01 -0400
> > > Jarod Wilson <jarod@redhat.com> wrote:
> > >
> > > > By default, enable retaining all user-facing API that includes the use of
> > > > master and slave, but add a Kconfig knob that allows those that wish to
> > > > remove it entirely do so in one shot.
...
> > > This is problematic. You are printing both old and new values.
> > > Also every distribution will have to enable it.
> > >
> > > This looks like too much of change to users.
> >
> > I'd had a bit of feedback that people would rather see both, and be
> > able to toggle off the old ones, rather than only having one or the
> > other, depending on the toggle, so I thought I'd give this a try. I
> > kind of liked the one or the other route, but I see the problems with
> > that too.
> >
> > For simplicity, I'm kind of liking the idea of just not updating the
> > proc and sysfs interfaces, have a toggle entirely disable them, and
> > work on enhancing userspace to only use netlink, but ... it's going to
> > be a while before any such work makes its way to any already shipping
> > distros. I don't have a satisfying answer here.
> >
>
> I like the idea of having bonding proc and sysf apis optional.

I do too, but I'd see it more as something only userspace developers
would care about for a while, as an easy way to make absolutely
certain their code/distro is no longer reliant on them and only uses
netlink, not as something any normal user really has any reason to do.

-- 
Jarod Wilson
jarod@redhat.com

