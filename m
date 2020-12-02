Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491742CC6DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgLBTlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:41:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729325AbgLBTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606938002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4Melsy9FouRA7tpp5dgLYyf1tl5Ex/RlsncrB8JZuw=;
        b=NOxYX5LY606/6RPGpo3vATZ5JCMRyCflL3/Q3n3z1jwsUdMIq67OYSw81G7yMunTQDznu5
        V/ZaFQeFBo5qo8/asm/JKpHEA8f2zG4Ors/RbQgEzQSJPzYbJDRoCx/+Bv2SmG6UZlrggP
        cwiqNCGVALRFwbJETk+YY3UP4+j3pPU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-PvkugNaMNe-rV0nuQ1_53A-1; Wed, 02 Dec 2020 14:40:01 -0500
X-MC-Unique: PvkugNaMNe-rV0nuQ1_53A-1
Received: by mail-oi1-f200.google.com with SMTP id e203so1581527oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:40:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4Melsy9FouRA7tpp5dgLYyf1tl5Ex/RlsncrB8JZuw=;
        b=GEI4vqcBWNdQs/j7jNMGKq11FEbIDHujM115EsmunzmFt+cvW4m1oMAg91xrXIJvSd
         ZRWc87Z+mX2AoRYrvrI7U26kiwn9tgc9iCrfwU56kVf95m8tHqfVGQwQ/KnrfS49w9OG
         JYeFFL7EZtJBSEoMopXsonoc2wQ8mXzZ4V6ftpj7XcashDaRykjsXo4P93PxANIAcPXW
         1/D4ZSYgfV/ZyXqheXHCWDCkK/UiDjPEe1njtU8CEFLkrFlOnHPJD9VCjlXrykVGOk6K
         98BFyK/v+Cj7g4RQxM/jcLTm0P0g9bjI+GRSw9QYu33CzLWQ08LHaStdPw9I/WbTCo91
         lycg==
X-Gm-Message-State: AOAM532EynS1m04Xz+ns/C7Gm5X932y03kjihhjS2OKglZcVjj/nBqRT
        W9NZhDtL1rtnlaJBEWiMgm9As+je+BZNwBauK5ryFhc8l4MElnKDP3hioswEdKoK4h5E7VlXfRq
        c0s9XHuyBKJND8WNXdd+KVKFISriDqZIKtGzR2SlG
X-Received: by 2002:aca:6255:: with SMTP id w82mr2658963oib.5.1606938000371;
        Wed, 02 Dec 2020 11:40:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOlSQMI5TPESzvcnQmnIH/U9UC+f0GqKimPWfRRvS7hiDpvoTOgDAUfPapidvwk2bAEB18yp+lk2/wrsXoPz4=
X-Received: by 2002:aca:6255:: with SMTP id w82mr2658954oib.5.1606938000111;
 Wed, 02 Dec 2020 11:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20201123031716.6179-1-jarod@redhat.com> <20201202173053.13800-1-jarod@redhat.com>
 <20201202095320.7768b5b3@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <CAKfmpSeGEpjVxw5J=tNBYc2bZEY-z7DbQeb2TcekbqkiBe7O6g@mail.gmail.com> <20201202112256.59a97b9c@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201202112256.59a97b9c@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Wed, 2 Dec 2020 14:39:49 -0500
Message-ID: <CAKfmpSfffy5Rq6LaRCVEguo0-ahZ+6dfj_M18WhJxKtmSybagw@mail.gmail.com>
Subject: Re: [PATCH net v2] bonding: fix feature flag setting at init time
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ivan Vecera <ivecera@redhat.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 2:23 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 2 Dec 2020 14:03:53 -0500 Jarod Wilson wrote:
> > On Wed, Dec 2, 2020 at 12:53 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > On Wed,  2 Dec 2020 12:30:53 -0500 Jarod Wilson wrote:
> > > > +     if (bond->dev->reg_state != NETREG_REGISTERED)
> > > > +             goto noreg;
> > > > +
> > > >       if (newval->value == BOND_MODE_ACTIVEBACKUP)
> > > >               bond->dev->wanted_features |= BOND_XFRM_FEATURES;
> > > >       else
> > > >               bond->dev->wanted_features &= ~BOND_XFRM_FEATURES;
> > > > -     netdev_change_features(bond->dev);
> > > > +     netdev_update_features(bond->dev);
> > > > +noreg:
> > >
> > > Why the goto?
> >
> > Seemed cleaner to prevent an extra level of indentation of the code
> > following the goto and before the label, but I'm not that attached to
> > it if it's not wanted for coding style reasons.
>
> Yes, please don't use gotos where a normal if statement is sufficient.
> If you must avoid the indentation move the code to a helper.
>
> Also - this patch did not apply to net, please make sure you're
> developing on the correct base.

Argh, I must have been working in net-next instead of net, apologies.
Okay, I'll clarify the description per what Jay pointed out and adjust
the code to not include a goto, then make it on the right branch.

-- 
Jarod Wilson
jarod@redhat.com

