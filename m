Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51E7281CE2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJBUYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbgJBUYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601670240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1BtRx1BSPtmWbCbhAW/KtfQIVoEEo/4AK+T/10zLCAU=;
        b=RQPEvWsRv/Xfy1+bBf0qcEzyKAG7FxeO2LzYBGEL/iLrDlvEgBhDFQ6Z68arj6UiVpAbI+
        diq6yB4mlaskexifQK0IKCOQnR+dI6QTb4yu1zO8G36MCBhlnssax7PkovebVF1CdOgR0F
        zXfQV/i1JoXXCEqYufjMtb0pmG88sks=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-30OjzX1nNoWtaJwnjMoE2Q-1; Fri, 02 Oct 2020 16:23:58 -0400
X-MC-Unique: 30OjzX1nNoWtaJwnjMoE2Q-1
Received: by mail-ot1-f70.google.com with SMTP id s3so1097310otp.18
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 13:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BtRx1BSPtmWbCbhAW/KtfQIVoEEo/4AK+T/10zLCAU=;
        b=WOUoN6kDMX31xU1UMMbYZV1z0/rq6vaH8OpHaxrXMEC646KpcapT2rPTZgefRUIe/P
         s2/3odkVudx9JtqvWtX1vjuXvZ7qWPMDNXrtlSYIhDlPV33Y3BAXzMGuUfDfnkFp4zaU
         w2q+3xmrVjwGAkzY1rslyaxgS9t1/u3AZ5Ed/PufYaGIlxzUjEP9Ac4AnKxKzXSZMBT/
         dfuBdHoRMximcSsWNGFVl0tb2+1IdLs9zvYERCek641p9PawOn9m8kk3Vm1F42CuPHZl
         7ZDmeFApz15B6YwAewxFvjn73ZHiMiALH4vjsDJ9My7nnnzUhNftvQ1ZZrlb+C3wNbtS
         jb1g==
X-Gm-Message-State: AOAM530L2a+BmTHJUc6+oiDXKFjZjuvSOR2s5tCkzYqtuCibiR0r0I1i
        xd+CjnT54pf9TP0SSfoM9EjbtYY/WagB/VaN7zyq1KlHp/o84g6Wp6vudv7ov0upQfqIj8zVlGf
        qRctMWDi8gg5wVpYPG47NXCMZM2c0n/dQ4asCpCYI
X-Received: by 2002:a9d:6c4f:: with SMTP id g15mr2998952otq.277.1601670237881;
        Fri, 02 Oct 2020 13:23:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1gWWCddrZxrj9sNrhg+fkQWj8i0BYmrOGqgsFgdmOfXtbeSMXzBC4l59z6AWV2YwQgZ+1j0OdmCfede0NrJ0=
X-Received: by 2002:a9d:6c4f:: with SMTP id g15mr2998935otq.277.1601670237639;
 Fri, 02 Oct 2020 13:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201002174001.3012643-1-jarod@redhat.com> <20201002174001.3012643-7-jarod@redhat.com>
 <20201002121317.474c95f0@hermes.local>
In-Reply-To: <20201002121317.474c95f0@hermes.local>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Fri, 2 Oct 2020 16:23:46 -0400
Message-ID: <CAKfmpSc3-j2GtQtdskEb8BQvB6q_zJPcZc2GhG8t+M3yFxS4MQ@mail.gmail.com>
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

On Fri, Oct 2, 2020 at 3:13 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri,  2 Oct 2020 13:40:01 -0400
> Jarod Wilson <jarod@redhat.com> wrote:
>
> > By default, enable retaining all user-facing API that includes the use of
> > master and slave, but add a Kconfig knob that allows those that wish to
> > remove it entirely do so in one shot.
> >
> > Cc: Jay Vosburgh <j.vosburgh@gmail.com>
> > Cc: Veaceslav Falico <vfalico@gmail.com>
> > Cc: Andy Gospodarek <andy@greyhouse.net>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Thomas Davis <tadavis@lbl.gov>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Jarod Wilson <jarod@redhat.com>
> > ---
> >  drivers/net/Kconfig                   | 12 ++++++++++++
> >  drivers/net/bonding/bond_main.c       |  4 ++--
> >  drivers/net/bonding/bond_options.c    |  4 ++--
> >  drivers/net/bonding/bond_procfs.c     |  8 ++++++++
> >  drivers/net/bonding/bond_sysfs.c      | 14 ++++++++++----
> >  drivers/net/bonding/bond_sysfs_port.c |  6 ++++--
> >  6 files changed, 38 insertions(+), 10 deletions(-)
> >
>
> This is problematic. You are printing both old and new values.
> Also every distribution will have to enable it.
>
> This looks like too much of change to users.

I'd had a bit of feedback that people would rather see both, and be
able to toggle off the old ones, rather than only having one or the
other, depending on the toggle, so I thought I'd give this a try. I
kind of liked the one or the other route, but I see the problems with
that too.

For simplicity, I'm kind of liking the idea of just not updating the
proc and sysfs interfaces, have a toggle entirely disable them, and
work on enhancing userspace to only use netlink, but ... it's going to
be a while before any such work makes its way to any already shipping
distros. I don't have a satisfying answer here.

-- 
Jarod Wilson
jarod@redhat.com

